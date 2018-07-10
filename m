Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77BEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5005720A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5005720A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbeGJWmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:42:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732258AbeGJWmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:42:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A33B340363A8;
        Tue, 10 Jul 2018 22:41:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF8F0111E41A;
        Tue, 10 Jul 2018 22:41:29 +0000 (UTC)
Subject: [PATCH 00/32] VFS: Introduce filesystem context [ver #9]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Jul 2018 23:41:29 +0100
Message-ID: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 22:41:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 22:41:30 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Can you update your tree with this?

Here are a set of patches to create a filesystem context prior to setting
up a new mount, populating it with the parsed options/binary data, creating
the superblock and then effecting the mount.  This is also used for remount
since much of the parsing stuff is common in many filesystems.

This allows namespaces and other information to be conveyed through the
mount procedure.

This also allows Miklós Szeredi's idea of doing:

	fd = fsopen("nfs");
	write(fd, "option=val", ...);
	mfd = fsmount(fd, MS_NODEV);
	move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

that he presented at LSF-2017 to be implemented (see the relevant patches
in the series).

I didn't use netlink as that would make the core kernel depend on
CONFIG_NET and CONFIG_NETLINK and would introduce network namespacing
issues.

I've implemented filesystem context handling for procfs, nfs, mqueue,
cpuset, kernfs, sysfs, cgroup and afs filesystems.

Unconverted filesystems are handled by a legacy filesystem wrapper.

Significant changes:

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

Possible further developments:

 (*) Implement sb reconfiguration (for now it returns ENOANO).

 (*) Implement mount context support in more filesystems, ext4 being next
     on my list.

 (*) Move the walk-from-root stuff that nfs has to generic code so that you
     can do something akin to:

	mount /dev/sda1:/foo/bar /mnt

     See nfs_follow_remote_path() and mount_subtree().  This is slightly
     tricky in NFS as we have to prevent referral loops.

 (*) Work out how to get at the error message incurred by submounts
     encountered during nfs_follow_remote_path().

     Should the error message be moved to task_struct and made more
     general, perhaps retrieved with a prctl() function?

 (*) Clean up/consolidate the security functions.  Possibly add a
     validation hook to be called at the same time as the mount context
     validate op.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/tag/?h=mount-api-20180710-2

on branch:

	mount-context

David
---
Al Viro (2):
      vfs: syscall: Add open_tree(2) to reference or clone a mount
      teach move_mount(2) to work with OPEN_TREE_CLONE

David Howells (30):
      vfs: syscall: Add move_mount(2) to move mounts around
      vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled
      vfs: Introduce the basic header for the new mount API's filesystem context
      vfs: Add LSM hooks for the new mount API
      selinux: Implement the new mount API LSM hooks
      smack: Implement filesystem context security hooks
      apparmor: Implement security hooks for the new mount API
      tomoyo: Implement security hooks for the new mount API
      vfs: Require specification of size of mount data for internal mounts
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
      vfs: syscall: Add fsmount() to create a mount for a superblock
      vfs: syscall: Add fspick() to select a superblock for reconfiguration
      vfs: Implement logging through fs_context
      vfs: Add some logging to the core users of the fs_context log
      afs: Add fs_context support
      afs: Use fs_context to pass parameters over automount
      vfs: syscall: Add fsinfo() to query filesystem information
      afs: Add fsinfo support


 Documentation/filesystems/mount_api.txt   |  439 +++++++++++++++
 arch/arc/kernel/setup.c                   |    1 
 arch/arm/kernel/atags_parse.c             |    1 
 arch/ia64/kernel/perfmon.c                |    3 
 arch/powerpc/platforms/cell/spufs/inode.c |    6 
 arch/s390/hypfs/inode.c                   |    7 
 arch/sh/kernel/setup.c                    |    1 
 arch/sparc/kernel/setup_32.c              |    1 
 arch/sparc/kernel/setup_64.c              |    1 
 arch/x86/entry/syscalls/syscall_32.tbl    |    6 
 arch/x86/entry/syscalls/syscall_64.tbl    |    6 
 arch/x86/kernel/cpu/intel_rdt.h           |   15 
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c  |  149 +++--
 arch/x86/kernel/setup.c                   |    1 
 drivers/base/devtmpfs.c                   |    7 
 drivers/dax/super.c                       |    2 
 drivers/gpu/drm/drm_drv.c                 |    3 
 drivers/gpu/drm/i915/i915_gemfs.c         |    2 
 drivers/infiniband/hw/qib/qib_fs.c        |    7 
 drivers/misc/cxl/api.c                    |    3 
 drivers/misc/ibmasm/ibmasmfs.c            |   11 
 drivers/mtd/mtdsuper.c                    |   26 -
 drivers/oprofile/oprofilefs.c             |    8 
 drivers/scsi/cxlflash/ocxl_hw.c           |    2 
 drivers/usb/gadget/function/f_fs.c        |    7 
 drivers/usb/gadget/legacy/inode.c         |    7 
 drivers/virtio/virtio_balloon.c           |    2 
 drivers/xen/xenfs/super.c                 |    7 
 fs/9p/vfs_super.c                         |    2 
 fs/Makefile                               |    5 
 fs/adfs/super.c                           |    9 
 fs/affs/super.c                           |   13 
 fs/afs/internal.h                         |    9 
 fs/afs/mntpt.c                            |  147 ++---
 fs/afs/super.c                            |  536 +++++++++++-------
 fs/afs/volume.c                           |    4 
 fs/aio.c                                  |    3 
 fs/anon_inodes.c                          |    3 
 fs/autofs/autofs_i.h                      |    2 
 fs/autofs/init.c                          |    4 
 fs/autofs/inode.c                         |    3 
 fs/befs/linuxvfs.c                        |   11 
 fs/bfs/inode.c                            |    8 
 fs/binfmt_misc.c                          |    7 
 fs/block_dev.c                            |    2 
 fs/btrfs/super.c                          |   30 +
 fs/btrfs/tests/btrfs-tests.c              |    2 
 fs/ceph/super.c                           |    3 
 fs/cifs/cifs_dfs_ref.c                    |    3 
 fs/cifs/cifsfs.c                          |   18 -
 fs/coda/inode.c                           |   11 
 fs/configfs/mount.c                       |    7 
 fs/cramfs/inode.c                         |   17 -
 fs/debugfs/inode.c                        |   14 
 fs/devpts/inode.c                         |   10 
 fs/ecryptfs/main.c                        |    2 
 fs/efivarfs/super.c                       |    9 
 fs/efs/super.c                            |   14 
 fs/exofs/super.c                          |    7 
 fs/ext2/super.c                           |   14 
 fs/ext4/super.c                           |   16 -
 fs/f2fs/super.c                           |   13 
 fs/fat/inode.c                            |    3 
 fs/fat/namei_msdos.c                      |    8 
 fs/fat/namei_vfat.c                       |    8 
 fs/file_table.c                           |    9 
 fs/freevxfs/vxfs_super.c                  |   12 
 fs/fs_context.c                           |  721 ++++++++++++++++++++++++
 fs/fsopen.c                               |  335 +++++++++++
 fs/fuse/control.c                         |    9 
 fs/fuse/inode.c                           |   16 -
 fs/gfs2/ops_fstype.c                      |    6 
 fs/gfs2/super.c                           |    4 
 fs/hfs/super.c                            |   12 
 fs/hfsplus/super.c                        |   12 
 fs/hostfs/hostfs_kern.c                   |    7 
 fs/hpfs/super.c                           |   11 
 fs/hugetlbfs/inode.c                      |  339 +++++++----
 fs/internal.h                             |    6 
 fs/isofs/inode.c                          |   11 
 fs/jffs2/super.c                          |   10 
 fs/jfs/super.c                            |   11 
 fs/kernfs/mount.c                         |   88 +--
 fs/libfs.c                                |   19 +
 fs/minix/inode.c                          |   14 
 fs/namespace.c                            |  877 ++++++++++++++++++++++-------
 fs/nfs/internal.h                         |    4 
 fs/nfs/namespace.c                        |    3 
 fs/nfs/nfs4namespace.c                    |    3 
 fs/nfs/nfs4super.c                        |   27 -
 fs/nfs/super.c                            |   22 -
 fs/nfsd/nfsctl.c                          |    8 
 fs/nilfs2/super.c                         |   10 
 fs/nsfs.c                                 |    3 
 fs/ntfs/super.c                           |   13 
 fs/ocfs2/dlmfs/dlmfs.c                    |    5 
 fs/ocfs2/super.c                          |   14 
 fs/omfs/inode.c                           |    9 
 fs/openpromfs/inode.c                     |   11 
 fs/orangefs/orangefs-kernel.h             |    2 
 fs/orangefs/super.c                       |    5 
 fs/overlayfs/super.c                      |   11 
 fs/pipe.c                                 |    3 
 fs/pnode.c                                |    1 
 fs/proc/inode.c                           |   50 --
 fs/proc/internal.h                        |    6 
 fs/proc/root.c                            |  212 +++++--
 fs/pstore/inode.c                         |   10 
 fs/qnx4/inode.c                           |   14 
 fs/qnx6/inode.c                           |   14 
 fs/ramfs/inode.c                          |    6 
 fs/reiserfs/super.c                       |   14 
 fs/romfs/super.c                          |   13 
 fs/squashfs/super.c                       |   12 
 fs/statfs.c                               |  470 ++++++++++++++++
 fs/super.c                                |  394 ++++++++++---
 fs/sysfs/mount.c                          |   67 ++
 fs/sysv/inode.c                           |    3 
 fs/sysv/super.c                           |   16 -
 fs/tracefs/inode.c                        |   10 
 fs/ubifs/super.c                          |    5 
 fs/udf/super.c                            |   16 -
 fs/ufs/super.c                            |   11 
 fs/xfs/xfs_super.c                        |   10 
 include/linux/cgroup.h                    |    3 
 include/linux/debugfs.h                   |    8 
 include/linux/fs.h                        |   47 +-
 include/linux/fs_context.h                |  178 ++++++
 include/linux/fsinfo.h                    |   40 +
 include/linux/kernfs.h                    |   39 +
 include/linux/lsm_hooks.h                 |   88 +++
 include/linux/module.h                    |    6 
 include/linux/mount.h                     |   10 
 include/linux/mtd/super.h                 |    4 
 include/linux/ramfs.h                     |    4 
 include/linux/security.h                  |   74 ++
 include/linux/shmem_fs.h                  |    3 
 include/linux/syscalls.h                  |   11 
 include/uapi/linux/fcntl.h                |    2 
 include/uapi/linux/fs.h                   |   68 +-
 include/uapi/linux/fsinfo.h               |  237 ++++++++
 include/uapi/linux/mount.h                |   75 ++
 init/Kconfig                              |   10 
 init/do_mounts.c                          |    5 
 init/do_mounts_initrd.c                   |    1 
 ipc/mqueue.c                              |  120 +++-
 kernel/bpf/inode.c                        |    7 
 kernel/cgroup/cgroup-internal.h           |   49 +-
 kernel/cgroup/cgroup-v1.c                 |  302 +++++-----
 kernel/cgroup/cgroup.c                    |  226 ++++---
 kernel/cgroup/cpuset.c                    |   67 ++
 kernel/trace/trace.c                      |    7 
 mm/shmem.c                                |   10 
 mm/zsmalloc.c                             |    3 
 net/socket.c                              |    3 
 net/sunrpc/rpc_pipe.c                     |    7 
 samples/statx/Makefile                    |    5 
 samples/statx/test-fsinfo.c               |  539 ++++++++++++++++++
 security/apparmor/apparmorfs.c            |    8 
 security/apparmor/include/mount.h         |   11 
 security/apparmor/lsm.c                   |   84 +++
 security/apparmor/mount.c                 |   47 ++
 security/inode.c                          |    7 
 security/security.c                       |   70 ++
 security/selinux/hooks.c                  |  294 +++++++++-
 security/selinux/selinuxfs.c              |    8 
 security/smack/smack_lsm.c                |  344 ++++++++++-
 security/smack/smackfs.c                  |    9 
 security/tomoyo/common.h                  |    3 
 security/tomoyo/mount.c                   |   46 ++
 security/tomoyo/tomoyo.c                  |   19 +
 171 files changed, 7147 insertions(+), 1805 deletions(-)
 create mode 100644 Documentation/filesystems/mount_api.txt
 create mode 100644 fs/fs_context.c
 create mode 100644 fs/fsopen.c
 create mode 100644 include/linux/fs_context.h
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 include/uapi/linux/mount.h
 create mode 100644 samples/statx/test-fsinfo.c

