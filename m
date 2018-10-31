Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BD8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB2F20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB2F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeJaOae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:30:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53342 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJaOad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:30:33 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHj8d-0000vc-LB; Wed, 31 Oct 2018 05:33:55 +0000
Date:   Wed, 31 Oct 2018 05:33:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] mount API series
Message-ID: <20181031053355.GQ32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	mount API series from David Howells.  Last cycle's objections
had been of the "I'd do it differently" variety and with no such
differently done variants having ever materialized over several
cycles...

Conflicts: two trivial ones in
	drivers/infiniband/Kconfig (removal of select ANON_INODES)
	fs/f2fs/super.c (->remount signature change)
and a non-trivial one in fs/proc/inode.c - there we have
mainline adding
	/* procfs dentries and inodes don't require IO to create */
	s->s_shrink.seeks = 0;
to proc_fill_super() (in 4b85afbdacd2 "mm: zero-seek shrinkers")
while that series moves the sucker to fs/proc/root.c.  Resolved by
removing the old copy from fs/proc/inode.c and adding the same lines
into the new copy in fs/proc/root.c.
I'd put a variant of resolution into #proposed-merge.

David's cover letter follows; it's obviously over the top for commit
message of the merge.  Where to cut it is up to you...

=========================================================================

Here are a set of patches to create a filesystem context prior to setting
up a new mount, populating it with the parsed options/binary data, looking
up/creating the superblock, querying it and then effecting the mount.  This
is also used for remount since much of the parsing stuff is common in many
filesystems.

This allows namespaces and other information to be conveyed through the
mount procedure.  This is done with something like:

	fd = fsopen("nfs", 0);
	fsconfig(fd, FSCONFIG_SET_STRING, "option", "val", 0);
	fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
	struct fsinfo_statfs statfs;
	fsinfo(fd, NULL, NULL, &statfs, sizeof(statfs));
	mfd = fsmount(fd, MS_NODEV);
	move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

The new move_mount() syscall can also be used simply to move mounts around:

	move_mount(AT_FDCWD, "/mnt", AT_FDCWD, "/mnt2", 0);

And, in conjunction with the open_tree() syscall, can be used to clone
mounts:

	fd = open_tree(AT_FDCWD, "/mnt", AT_RECURSIVE | OPEN_TREE_CLONE);
	move_mount(mfd, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);

File descriptors can be used as mountpoint references:

	fd = open_tree(AT_FDCWD, "/mnt", 0);
	move_mount(mfd, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
	move_mount(mfd, "", AT_FDCWD, "/mnt3", MOVE_MOUNT_F_EMPTY_PATH);

which, in this example, will *move* the mount at /mnt to /mnt2 and thence
to /mnt3.

Superblocks can be picked and reconfigured:

	fd = fspick(AT_FDCWD, "/mnt", 0)
	fsconfig(fd, FSCONFIG_SET_STRING, "option", "other-val", 0);
	fsconfig(fd, FSCONFIG_SET_STRING, "option2", "true", 0);
	fsconfig(fd, FSCONFIG_SET_STRING, "option3", "1234", 0);
	fsconfig(fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);

Filesystem parameters and other attributes can also be queried from the fd
returned by fsopen() or fspick():

	fd = fspick(AT_FDCWD, "/mnt", 0)
	struct fsinfo_params params = {
		.request	= FSINFO_ATTR_PARAMETER,
		.Nth		= 1,
		.Mth		= 3,
	};
	char param_buf[4096];
	fsinfo(fd, NULL, &params, param_buf, sizeof(param_buf));

which will retrieve the 4th value of the 2nd parameter (0 being first) as a
printable string.

Parameters and attributes can also be queried by path or on an ordinary fd:

	struct fsinfo_params params = {
		.request	= FSINFO_ATTR_VOLUME_NAME,
	};
	char param_buf[4096];
	fsinfo(AT_FDCWD, "/etc/passwd", &params, param_buf,
	       sizeof(param_buf));

The details of a filesystem's parser can also be queried:

	fd = fsopen("ext4", 0);
	struct fsinfo_params params = {
		.request	= FSINFO_ATTR_PARAM_NAME,
		.Nth		= 1,
	};
	char param_buf[4096];
	fsinfo(fd, NULL, &params, param_buf, sizeof(param_buf));

which, in this instance, will retrieve the name of parameter #1.

I have implemented filesystem context handling for procfs, nfs, mqueue,
cpuset, kernfs, sysfs, cgroup and afs filesystems.  Unconverted filesystems
are handled by a legacy filesystem wrapper for the moment.

Note that I didn't use netlink as that would make the core kernel depend on
CONFIG_NET and CONFIG_NETLINK and would introduce network namespacing
issues.


====================
WHY DO WE WANT THIS?
====================

Firstly, there's a bunch of problems with the mount(2) syscall:

 (1) It's actually six or seven different interfaces rolled into one and
     weird combinations of flags make it do different things beyond the
     original specification of the syscall.

 (2) It produces a particularly large and diverse set of errors, which have
     to be mapped back to a small error code.  Yes, there's dmesg - if you
     have it configured - but you can't necessarily see that if you're
     doing a mount inside of a container.

 (3) It copies a PAGE_SIZE block of data for each of the type, device name
     and options.

 (4) The size of the buffers is PAGE_SIZE - and this is arch dependent.

 (5) You can't mount into another mount namespace.  I could, for example,
     build a container without having to be in that container's namespace
     if I can do it from outside.

 (6) It's not really geared for the specification of multiple sources, but
     some filesystems really want that - overlayfs, for example.

and some problems in the internal kernel API:

 (1) There's no defined way to supply namespace configuration for the
     superblock - so, for instance, I can't say that I want to create a
     superblock in a particular network namespace (on automount, say).

     NFS hacks around this by creating multiple shadow file_system_types
     with different ->mount() ops.

 (2) When calling mount internally, unless you have NFS-like hacks, you
     have to generate or otherwise provide text config data which then gets
     parsed, when some of the time you could bypass the parsing stage
     entirely.

 (3) The amount of data in the data buffer is not known, but the data
     buffer might be on a kernel stack somewhere, leading to the
     possibility of tripping the stack underrun guard.

and other issues too:

 (1) Superblock remount in some filesystems applies options on an as-parsed
     basis, so if there's a parse failure, a partial alteration with no
     rollback is effected.

 (2) Under some circumstances, the mount data may get copied multiple times
     so that it can have multiple parsers applied to it or because it has
     to be parsed multiple times - for instance, once to get the
     preliminary info required to access the on-disk superblock and then
     again to update the superblock record in the kernel.

I want to be able to add support for a bunch of things:

 (1) UID, GID and Project ID mapping/translation.  I want to be able to
     install a translation table of some sort on the superblock to
     translate source identifiers (which may be foreign numeric UIDs/GIDs,
     text names, GUIDs) into system identifiers.  This needs to be done
     before the superblock is published[*].

     Note that this may, for example, involve using the context and the
     superblock held therein to issue an RPC to a server to look up
     translations.

     [*] By "published" I mean made available through mount so that other
     	 userspace processes can access it by path.

     Maybe specifying a translation range element with something like:

	fsconfig(fd, fsconfig_translate_uid, "<srcuid> <nsuid> <count>", 0, 0);

     The translation information also needs to propagate over an automount
     in some circumstances.

 (2) Namespace configuration.  I want to be able to tell the superblock
     creation process what namespaces should be applied when it created (in
     particular the userns and netns) for containerisation purposes, e.g.:

	fsconfig(fd, FSCONFIG_SET_NAMESPACE, "user", 0, userns_fd);
	fsconfig(fd, FSCONFIG_SET_NAMESPACE, "net", 0, netns_fd);

 (3) Namespace propagation.  I want to have a properly defined mechanism
     for propagating namespace configuration over automounts within the
     kernel.  This will be particularly useful for network filesystems.

 (4) Pre-mount attribute query.  A chunk of the changes is actually the
     fsinfo() syscall to query attributes of the filesystem beyond what's
     available in statx() and statfs().  This will allow a created
     superblock to be queried before it is published.

 (5) Upcall for configuration.  I would like to be able to query
     configuration that's stored in userspace when an automount is made.
     For instance, to look up network parameters for NFS or to find a cache
     selector for fscache.

     The internal fs_context could be passed to the upcall process or the
     kernel could read a config file directly if named appropriately for the
     superblock, perhaps:

	[/etc/fscontext.d/afs/example.com/cell.cfg]
	realm = EXAMPLE.COM
	translation = uid,3000,4000,100
	fscache = tag=fred

 (6) Event notifications.  I want to be able to install a watch on a
     superblock before it is published to catch things like quota events
     and EIO.

 (7) Large and binary parameters.  There might be at some point a need to
     pass large/binary objects like Microsoft PACs around.  If I understand
     PACs correctly, you can obtain these from the Kerberos server and then
     pass them to the file server when you connect.

     Having it possible to pass large or binary objects as individual
     fsconfig calls make parsing these trivial.  OTOH, some or all of this
     can potentially be handled with the use of the keyrings interface - as
     the afs filesystem does for passing kerberos tokens around; it's just
     that that seems overkill for a parameter you may only need once.


===================
SIGNIFICANT CHANGES
===================

 ver #13:

 (*) Fix the default handling of the source parameter for a filesystem that
     doesn't support it (stash the string to fc->source).

 (*) Fix cgroup mounting.  This is slightly awkward as we can't call
     vfs_get_tree() from within the ->get_tree() op as the former drops
     s_umount before returning.

 (*) Fixes/cleanups from Eric Biederman, including:

     - Fix error handling in do_remount().

 (*) In sample programs, define syscall symbols (__NR_xxx) to -1 if not
     defined in the header files so that the samples compile, but fail
     gracefully with ENOSYS.

 ver #12:

 (*) Rebased on v4.19-rc3.

 (*) Added three new context purposes: mount for hidden root, reconfigure
     for unmount, reconfigure for emergency remount.

 (*) Added a parameter for the new purpose into vfs_dup_fs_context().

 (*) Moved the reconfiguration hook from struct super_operations to struct
     fs_context_operations so they can be handled through the legacy
     wrapper.  mount -o remount now goes through that.

 (*) Changed the parameter description in the following ways:

     - Nominated one master name for each parameter, held in a simple
       string pointer array.  This makes it easy to simply look up a name
       for that parameter for logging.

     - Added a table of additional names for parameters.  The name chosen
       can be used to influence the action of the parameter.

     - Noted which parameter is the source specifier, if there is one.

 (*) Use correct user_ns for a new pidns superblock.

 (*) Fix mqueue to not crash on mounting.

 (*) Make VFS sample programs dependent on X86 to avoid errors in
     autobuilders due to unset syscall IDs in other arches.

 (*) [Miklós] Fixed subtype handling.

 ver #11:

 (*) Fixed AppArmor.

 (*) Capitalised all the UAPI constants.

 (*) Explicitly numbered the FSCONFIG_* UAPI constants.

 (*) Removed all the places ANON_INODES is selected.

 (*) Fixed a bug whereby the context gets freed twice (which broke mounts of
     procfs).

 (*) Split fsinfo() off into its own patch series.

 ver #10:

 (*) Renamed "option" to "parameter" in a number of places.

 (*) Replaced the use of write() to drive the configuration with an fsconfig()
     syscall.  This also allows at-style paths and fds to be presented as typed
     object.

 (*) Routed the key=value parameter concept all the way through from the
     fsconfig() system call to the LSM and filesystem.

 (*) Added a parameter-description concept and helper functions to help
     interpret a parameter and possibly convert the value.

 (*) Made it possible to query the parameter description using the fsinfo()
     syscall.  Added a test-fs-query sample to dump the parameters used by a
     filesystem.

 ver #9:

 (*) Dropped the fd cookie stuff and the FMODE_*/O_* split stuff.

 (*) Al added an open_tree() system call to allow a mount tree to be picked
     referenced or cloned into an O_PATH-style fd.  This can then be used
     with sys_move_mount().  Dropped the O_CLONE_MOUNT and O_NON_RECURSIVE
     open() flags.

 (*) Brought error logging back in, though only in the fs_context and not
     in the task_struct.

 (*) Separated MS_REMOUNT|MS_BIND handling from MS_REMOUNT handling.

 (*) Used anon_inodes for the fd returned by fsopen() and fspick().  This
     requires making it unconditional.

 (*) Fixed lots of bugs.  Especial thanks to Al and Eric Biggers for
     finding them and providing patches.

 (*) Wrote manual pages, which I'll post separately.

 ver #8:

 (*) Changed the way fsmount() mounts into the namespace according to some
     of Al's ideas.

 (*) Put better typing on the fd cookie obtained from __fdget() & co..

 (*) Stored the fd cookie in struct nameidata rather than the dfd number.

 (*) Changed sys_fsmount() to return an O_PATH-style fd rather than
     actually mounting into the mount namespace.

 (*) Separated internal FMODE_* handling from O_* handling to free up
     certain O_* flag numbers.

 (*) Added two new open flags (O_CLONE_MOUNT and O_NON_RECURSIVE) for use
     with open(O_PATH) to copy a mount or mount-subtree to an O_PATH fd.

 (*) Added a new syscall, sys_move_mount(), to move a mount from an
     dfd+path source to a dfd+path destination.

 (*) Added a file->f_mode flag (FMODE_NEED_UNMOUNT) that indicates that the
     vfsmount attached to file->f_path needs 'unmounting' if set.

 (*) Made sys_move_mount() clear FMODE_NEED_UNMOUNT if successful.

	[!] This doesn't work quite right.

 (*) Added a new syscall, fsinfo(), to query information about a
     filesystem.  The idea being that this will, in future, work with the
     fd from fsopen() too and permit querying of the parameters and
     metadata before fsmount() is called.

 ver #7:

 (*) Undo an incorrect MS_* -> SB_* conversion.

 (*) Pass the mount data buffer size to all the mount-related functions that
     take the data pointer.  This fixes a problem where someone (say SELinux)
     tries to copy the mount data, assuming it to be a page in size, and
     overruns the buffer - thereby incurring an oops by hitting a guard page.

 (*) Made the AFS filesystem use them as an example.  This is a much easier to
     deal with than with NFS or Ext4 as there are very few mount options.

 ver #6:

 (*) Dropped the supplementary error string facility for the moment.

 (*) Dropped the NFS patches for the moment.

 (*) Dropped the reserved file descriptor argument from fsopen() and
     replaced it with three reserved pointers that must be NULL.

 ver #5:

 (*) Renamed sb_config -> fs_context and adjusted variable names.

 (*) Differentiated the flags in sb->s_flags (now named SB_*) from those
     passed to mount(2) (named MS_*).

 (*) Renamed __vfs_new_fs_context() to vfs_new_fs_context() and made the
     caller always provide a struct file_system_type pointer and the
     parameters required.

 (*) Got rid of vfs_submount_fc() in favour of passing
     FS_CONTEXT_FOR_SUBMOUNT to vfs_new_fs_context().  The purpose is now
     used more.

 (*) Call ->validate() on the remount path.

 (*) Got rid of the inode locking in sys_fsmount().

 (*) Call security_sb_mountpoint() in the mount(2) path.

 ver #4:

 (*) Split the sb_config patch up somewhat.

 (*) Made the supplementary error string facility something attached to the
     task_struct rather than the sb_config so that error messages can be
     obtained from NFS doing a mount-root-and-pathwalk inside the
     nfs_get_tree() operation.

     Further, made this managed and read by prctl rather than through the
     mount fd so that it's more generally available.

 ver #3:

 (*) Rebased on 4.12-rc1.

 (*) Split the NFS patch up somewhat.

 ver #2:

 (*) Removed the ->fill_super() from sb_config_operations and passed it in
     directly to functions that want to call it.  NFS now calls
     nfs_fill_super() directly rather than jumping through a pointer to it
     since there's only the one option at the moment.

 (*) Removed ->mnt_ns and ->sb from sb_config and moved ->pid_ns into
     proc_sb_config.

 (*) Renamed create_super -> get_tree.

 (*) Renamed struct mount_context to struct sb_config and amended various
     variable names.

 (*) sys_fsmount() acquired AT_* flags and MS_* flags (for MNT_* flags)
     arguments.

 ver #1:

 (*) Split the sb_config stuff out into its own header.

 (*) Support non-context aware filesystems through a special set of
     sb_config operations.

 (*) Stored the created superblock and root dentry into the sb_config after
     creation rather than directly into a vfsmount.  This allows some
     arguments to be removed to various NFS functions.

 (*) Added an explicit superblock-creation step.  This allows a created
     superblock to then be mounted multiple times.

 (*) Added a flag to say that the sb_config is degraded and cannot have
     another go at having a superblock creation whilst getting rid of the
     one that says it's already mounted.

=========================================================================

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount

for you to fetch changes up to 2dcc1f3b7dcb58e6108b5a45a9dcccd6ab5fec19:

  vfs: Fix error handling in do_remount() (2018-10-30 15:58:06 -0400)

----------------------------------------------------------------
Al Viro (1):
      vfs: syscall: Add open_tree(2) to reference or clone a mount

David Howells (40):
      vfs: Require specification of size of mount data for internal mounts
      vfs: syscall: Add move_mount(2) to move mounts around
      teach move_mount(2) to work with OPEN_TREE_CLONE
      vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled
      vfs: Introduce the basic header for the new mount API's filesystem context
      vfs: Introduce logging functions
      vfs: Add configuration parser helpers
      vfs: Add LSM hooks for the new mount API
      vfs: Put security flags into the fs_context struct
      selinux: Implement the new mount API LSM hooks
      smack: Implement filesystem context security hooks
      apparmor: Implement security hooks for the new mount API
      tomoyo: Implement security hooks for the new mount API
      vfs: Separate changing mount flags full remount
      vfs: Implement a filesystem superblock creation/configuration context
      vfs: Remove unused code after filesystem context changes
      procfs: Move proc_fill_super() to fs/proc/root.c
      proc: Add fs_context support to procfs
      ipc: Convert mqueue fs to fs_context
      cpuset: Use fs_context
      kernfs, sysfs, cgroup, intel_rdt: Support fs_context
      hugetlbfs: Convert to fs_context
      vfs: Remove kern_mount_data()
      vfs: Provide documentation for new mount API
      Make anon_inodes unconditional
      vfs: syscall: Add fsopen() to prepare for superblock creation
      vfs: Implement logging through fs_context
      vfs: Add some logging to the core users of the fs_context log
      vfs: syscall: Add fsconfig() for configuring and managing a context
      vfs: syscall: Add fsmount() to create a mount for a superblock
      vfs: syscall: Add fspick() to select a superblock for reconfiguration
      afs: Add fs_context support
      afs: Use fs_context to pass parameters over automount
      vfs: Add a sample program for the new mount API
      vfs: syscall: Add fsinfo() to query filesystem information
      afs: Add fsinfo support
      vfs: Allow fsinfo() to query what's in an fs_context
      vfs: Allow fsinfo() to be used to query an fs parameter description
      vfs: Implement parameter value retrieval with fsinfo()
      vfs: Fix error handling in do_remount()

 Documentation/filesystems/mount_api.txt   | 741 +++++++++++++++++++++++
 arch/arc/kernel/setup.c                   |   1 +
 arch/arm/kernel/atags_parse.c             |   1 +
 arch/arm/kvm/Kconfig                      |   1 -
 arch/arm64/kvm/Kconfig                    |   1 -
 arch/ia64/kernel/perfmon.c                |   3 +-
 arch/mips/kvm/Kconfig                     |   1 -
 arch/powerpc/kvm/Kconfig                  |   1 -
 arch/powerpc/platforms/cell/spufs/inode.c |   6 +-
 arch/s390/hypfs/inode.c                   |   7 +-
 arch/s390/kvm/Kconfig                     |   1 -
 arch/sh/kernel/setup.c                    |   1 +
 arch/sparc/kernel/setup_32.c              |   1 +
 arch/sparc/kernel/setup_64.c              |   1 +
 arch/x86/Kconfig                          |   1 -
 arch/x86/entry/syscalls/syscall_32.tbl    |   7 +
 arch/x86/entry/syscalls/syscall_64.tbl    |   7 +
 arch/x86/kernel/cpu/intel_rdt.h           |  15 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c  | 183 +++---
 arch/x86/kernel/setup.c                   |   1 +
 arch/x86/kvm/Kconfig                      |   1 -
 drivers/base/Kconfig                      |   1 -
 drivers/base/devtmpfs.c                   |   7 +-
 drivers/char/tpm/Kconfig                  |   1 -
 drivers/dax/super.c                       |   2 +-
 drivers/dma-buf/Kconfig                   |   1 -
 drivers/gpio/Kconfig                      |   1 -
 drivers/gpu/drm/drm_drv.c                 |   3 +-
 drivers/gpu/drm/i915/i915_gemfs.c         |   2 +-
 drivers/iio/Kconfig                       |   1 -
 drivers/infiniband/Kconfig                |   1 -
 drivers/infiniband/hw/qib/qib_fs.c        |   7 +-
 drivers/misc/cxl/api.c                    |   3 +-
 drivers/misc/ibmasm/ibmasmfs.c            |  11 +-
 drivers/mtd/mtdsuper.c                    |  26 +-
 drivers/oprofile/oprofilefs.c             |   8 +-
 drivers/scsi/cxlflash/ocxl_hw.c           |   2 +-
 drivers/staging/erofs/super.c             |  13 +-
 drivers/usb/gadget/function/f_fs.c        |   7 +-
 drivers/usb/gadget/legacy/inode.c         |   7 +-
 drivers/vfio/Kconfig                      |   1 -
 drivers/virtio/virtio_balloon.c           |   2 +-
 drivers/xen/xenfs/super.c                 |   7 +-
 fs/9p/vfs_super.c                         |   2 +-
 fs/Kconfig                                |   7 +
 fs/Makefile                               |   5 +-
 fs/adfs/super.c                           |   9 +-
 fs/affs/super.c                           |  13 +-
 fs/afs/internal.h                         |  10 +-
 fs/afs/mntpt.c                            | 147 ++---
 fs/afs/super.c                            | 634 +++++++++++++-------
 fs/afs/volume.c                           |   4 +-
 fs/aio.c                                  |   3 +-
 fs/anon_inodes.c                          |   3 +-
 fs/autofs/autofs_i.h                      |   2 +-
 fs/autofs/init.c                          |   4 +-
 fs/autofs/inode.c                         |   3 +-
 fs/befs/linuxvfs.c                        |  11 +-
 fs/bfs/inode.c                            |   8 +-
 fs/binfmt_misc.c                          |   7 +-
 fs/block_dev.c                            |   2 +-
 fs/btrfs/super.c                          |  30 +-
 fs/btrfs/tests/btrfs-tests.c              |   2 +-
 fs/ceph/super.c                           |   3 +-
 fs/cifs/cifs_dfs_ref.c                    |   3 +-
 fs/cifs/cifsfs.c                          |  18 +-
 fs/coda/inode.c                           |  11 +-
 fs/configfs/mount.c                       |   7 +-
 fs/cramfs/inode.c                         |  17 +-
 fs/debugfs/inode.c                        |  14 +-
 fs/devpts/inode.c                         |  10 +-
 fs/ecryptfs/main.c                        |   2 +-
 fs/efivarfs/super.c                       |   9 +-
 fs/efs/super.c                            |  14 +-
 fs/exofs/super.c                          |   7 +-
 fs/ext2/super.c                           |  14 +-
 fs/ext4/super.c                           |  16 +-
 fs/f2fs/super.c                           |  13 +-
 fs/fat/inode.c                            |   3 +-
 fs/fat/namei_msdos.c                      |   8 +-
 fs/fat/namei_vfat.c                       |   8 +-
 fs/file_table.c                           |   9 +-
 fs/filesystems.c                          |   4 +
 fs/freevxfs/vxfs_super.c                  |  12 +-
 fs/fs_context.c                           | 776 ++++++++++++++++++++++++
 fs/fs_parser.c                            | 555 +++++++++++++++++
 fs/fsopen.c                               | 568 ++++++++++++++++++
 fs/fuse/control.c                         |   9 +-
 fs/fuse/inode.c                           |  16 +-
 fs/gfs2/ops_fstype.c                      |   6 +-
 fs/gfs2/super.c                           |   4 +-
 fs/hfs/super.c                            |  12 +-
 fs/hfsplus/super.c                        |  12 +-
 fs/hostfs/hostfs_kern.c                   |   7 +-
 fs/hpfs/super.c                           |  11 +-
 fs/hugetlbfs/inode.c                      | 454 +++++++++-----
 fs/internal.h                             |  19 +-
 fs/isofs/inode.c                          |  11 +-
 fs/jffs2/super.c                          |  10 +-
 fs/jfs/super.c                            |  11 +-
 fs/kernfs/mount.c                         | 103 ++--
 fs/libfs.c                                |  20 +-
 fs/minix/inode.c                          |  14 +-
 fs/namei.c                                |   4 +-
 fs/namespace.c                            | 952 +++++++++++++++++++++++-------
 fs/nfs/internal.h                         |   4 +-
 fs/nfs/namespace.c                        |   3 +-
 fs/nfs/nfs4namespace.c                    |   3 +-
 fs/nfs/nfs4super.c                        |  27 +-
 fs/nfs/super.c                            |  22 +-
 fs/nfsd/nfsctl.c                          |   8 +-
 fs/nilfs2/super.c                         |  10 +-
 fs/notify/fanotify/Kconfig                |   1 -
 fs/notify/inotify/Kconfig                 |   1 -
 fs/nsfs.c                                 |   3 +-
 fs/ntfs/super.c                           |  13 +-
 fs/ocfs2/dlmfs/dlmfs.c                    |   5 +-
 fs/ocfs2/super.c                          |  14 +-
 fs/omfs/inode.c                           |   9 +-
 fs/openpromfs/inode.c                     |  11 +-
 fs/orangefs/orangefs-kernel.h             |   2 +-
 fs/orangefs/super.c                       |   5 +-
 fs/overlayfs/super.c                      |  11 +-
 fs/pipe.c                                 |   3 +-
 fs/pnode.c                                |   1 +
 fs/proc/inode.c                           |  49 +-
 fs/proc/internal.h                        |   5 +-
 fs/proc/root.c                            | 253 ++++++--
 fs/pstore/inode.c                         |  10 +-
 fs/qnx4/inode.c                           |  14 +-
 fs/qnx6/inode.c                           |  14 +-
 fs/ramfs/inode.c                          |   6 +-
 fs/reiserfs/super.c                       |  14 +-
 fs/romfs/super.c                          |  13 +-
 fs/squashfs/super.c                       |  12 +-
 fs/statfs.c                               | 587 ++++++++++++++++++
 fs/super.c                                | 486 +++++++++++----
 fs/sysfs/mount.c                          |  67 ++-
 fs/sysv/inode.c                           |   3 +-
 fs/sysv/super.c                           |  16 +-
 fs/tracefs/inode.c                        |  10 +-
 fs/ubifs/super.c                          |   5 +-
 fs/udf/super.c                            |  16 +-
 fs/ufs/super.c                            |  11 +-
 fs/xfs/xfs_super.c                        |  10 +-
 include/linux/cgroup.h                    |   3 +-
 include/linux/debugfs.h                   |   8 +-
 include/linux/errno.h                     |   1 +
 include/linux/fs.h                        |  47 +-
 include/linux/fs_context.h                | 215 +++++++
 include/linux/fs_parser.h                 | 119 ++++
 include/linux/fsinfo.h                    |  41 ++
 include/linux/kernfs.h                    |  43 +-
 include/linux/lsm_hooks.h                 |  84 ++-
 include/linux/module.h                    |   6 +
 include/linux/mount.h                     |  10 +-
 include/linux/mtd/super.h                 |   4 +-
 include/linux/ramfs.h                     |   4 +-
 include/linux/security.h                  |  70 ++-
 include/linux/shmem_fs.h                  |   3 +-
 include/linux/syscalls.h                  |  13 +
 include/uapi/linux/fcntl.h                |   2 +
 include/uapi/linux/fs.h                   |  56 +-
 include/uapi/linux/fsinfo.h               | 303 ++++++++++
 include/uapi/linux/mount.h                | 120 ++++
 init/Kconfig                              |  10 -
 init/do_mounts.c                          |   5 +-
 init/do_mounts_initrd.c                   |   1 +
 ipc/mqueue.c                              | 106 +++-
 ipc/namespace.c                           |   2 +-
 kernel/bpf/inode.c                        |   7 +-
 kernel/cgroup/cgroup-internal.h           |  50 +-
 kernel/cgroup/cgroup-v1.c                 | 413 ++++++++-----
 kernel/cgroup/cgroup.c                    | 291 ++++++---
 kernel/cgroup/cpuset.c                    |  85 ++-
 kernel/trace/trace.c                      |   7 +-
 mm/shmem.c                                |  10 +-
 mm/zsmalloc.c                             |   3 +-
 net/socket.c                              |   3 +-
 net/sunrpc/rpc_pipe.c                     |   7 +-
 samples/Kconfig                           |   9 +-
 samples/Makefile                          |   2 +-
 samples/statx/Makefile                    |   7 -
 samples/vfs/Makefile                      |  16 +
 samples/vfs/test-fs-query.c               | 145 +++++
 samples/vfs/test-fsinfo.c                 | 593 +++++++++++++++++++
 samples/vfs/test-fsmount.c                | 133 +++++
 samples/{statx => vfs}/test-statx.c       |   7 +-
 security/apparmor/apparmorfs.c            |   8 +-
 security/apparmor/include/mount.h         |  11 +-
 security/apparmor/lsm.c                   | 111 +++-
 security/apparmor/mount.c                 |  47 ++
 security/inode.c                          |   7 +-
 security/security.c                       |  64 +-
 security/selinux/hooks.c                  | 388 ++++++++----
 security/selinux/include/security.h       |  16 +-
 security/selinux/selinuxfs.c              |   8 +-
 security/smack/smack.h                    |  21 +-
 security/smack/smack_lsm.c                | 367 ++++++++++--
 security/smack/smackfs.c                  |   9 +-
 security/tomoyo/common.h                  |   3 +
 security/tomoyo/mount.c                   |  46 ++
 security/tomoyo/tomoyo.c                  |  19 +-
 203 files changed, 9699 insertions(+), 2025 deletions(-)
 create mode 100644 Documentation/filesystems/mount_api.txt
 create mode 100644 fs/fs_context.c
 create mode 100644 fs/fs_parser.c
 create mode 100644 fs/fsopen.c
 create mode 100644 include/linux/fs_context.h
 create mode 100644 include/linux/fs_parser.h
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 include/uapi/linux/mount.h
 delete mode 100644 samples/statx/Makefile
 create mode 100644 samples/vfs/Makefile
 create mode 100644 samples/vfs/test-fs-query.c
 create mode 100644 samples/vfs/test-fsinfo.c
 create mode 100644 samples/vfs/test-fsmount.c
 rename samples/{statx => vfs}/test-statx.c (98%)
