Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970057AbeEYAF3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:05:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965181AbeEYAFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:05:25 -0400
Subject: [PATCH 00/32] VFS: Introduce filesystem context [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:05:23 +0100
Message-ID: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Can you take a look at this please, in particular the last 6 patches?

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

Unconverted filesystems are handled by the legacy filesystem wrapper.

This post is mostly about the internal filesystem context and the special
kernel interface filesystems.  I've included the fsopen() and fsmount()
syscall implementations for reference, but I expect these to undergo some
reconsideration during LSF.  The last five patches relate to the AFS
conversion and are included as an example.

Significant changes:

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

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-context

David
---
David Howells (32):
      VFS: Suppress MS_* flag defs within the kernel unless explicitly enabled
      vfs: Provide documentation for new mount API
      VFS: Introduce the basic header for the new mount API's filesystem context
      VFS: Add LSM hooks for the new mount API
      selinux: Implement the new mount API LSM hooks
      smack: Implement filesystem context security hooks
      apparmor: Implement security hooks for the new mount API
      tomoyo: Implement security hooks for the new mount API
      VFS: Require specification of size of mount data for internal mounts
      VFS: Implement a filesystem superblock creation/configuration context
      VFS: Remove unused code after filesystem context changes
      procfs: Move proc_fill_super() to fs/proc/root.c
      proc: Add fs_context support to procfs
      ipc: Convert mqueue fs to fs_context
      cpuset: Use fs_context
      kernfs, sysfs, cgroup, intel_rdt: Support fs_context
      hugetlbfs: Convert to fs_context
      VFS: Remove kern_mount_data()
      VFS: Implement fsopen() to prepare for a mount
      vfs: Make close() unmount the attached mount if so flagged
      VFS: Implement fsmount() to effect a pre-configured mount
      vfs: Provide an fspick() system call
      VFS: Implement logging through fs_context
      vfs: Add some logging to the core users of the fs_context log
      afs: Add fs_context support
      afs: Use fs_context to pass parameters over automount
      vfs: Use a 'struct fd_cookie *' type for light fd handling
      vfs: Store the fd_cookie in nameidata, not the dfd int
      vfs: Don't mix FMODE_* flags with O_* flags
      vfs: Allow cloning of a mount tree with open(O_PATH|O_CLONE_MOUNT)
      [RFC] fs: Add a move_mount() system call
      [RFC] fsinfo: Add a system call to allow querying of filesystem information


 Documentation/filesystems/mounting.txt             |  458 +++++++++++++
 arch/arc/kernel/setup.c                            |    1 
 arch/arm/kernel/atags_parse.c                      |    1 
 arch/ia64/kernel/perfmon.c                         |    3 
 arch/powerpc/platforms/cell/spufs/inode.c          |    6 
 arch/s390/hypfs/inode.c                            |    7 
 arch/sh/kernel/setup.c                             |    1 
 arch/sparc/kernel/setup_32.c                       |    1 
 arch/sparc/kernel/setup_64.c                       |    1 
 arch/x86/entry/syscalls/syscall_32.tbl             |    5 
 arch/x86/entry/syscalls/syscall_64.tbl             |    5 
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c           |  129 ++--
 arch/x86/kernel/setup.c                            |    1 
 drivers/base/devtmpfs.c                            |    7 
 drivers/dax/super.c                                |    2 
 drivers/dma-buf/dma-buf.c                          |    2 
 drivers/dma-buf/sync_file.c                        |    2 
 drivers/gpu/drm/drm_drv.c                          |    3 
 drivers/gpu/drm/drm_syncobj.c                      |    2 
 drivers/gpu/drm/i915/i915_gemfs.c                  |    2 
 drivers/infiniband/hw/qib/qib_fs.c                 |    7 
 drivers/misc/ibmasm/ibmasmfs.c                     |   11 
 drivers/mtd/mtdsuper.c                             |   26 -
 drivers/oprofile/oprofilefs.c                      |    8 
 .../staging/lustre/lustre/llite/llite_internal.h   |    2 
 drivers/staging/lustre/lustre/llite/llite_lib.c    |    3 
 drivers/staging/lustre/lustre/mdc/mdc_lib.c        |    2 
 drivers/staging/lustre/lustre/mdc/mdc_locks.c      |    2 
 drivers/staging/lustre/lustre/obdclass/obd_mount.c |    7 
 drivers/staging/ncpfs/inode.c                      |   10 
 drivers/tty/pty.c                                  |    4 
 drivers/usb/gadget/function/f_fs.c                 |    7 
 drivers/usb/gadget/legacy/inode.c                  |    7 
 drivers/virtio/virtio_balloon.c                    |    2 
 drivers/xen/xenfs/super.c                          |    7 
 fs/9p/vfs_super.c                                  |    2 
 fs/Makefile                                        |    3 
 fs/adfs/super.c                                    |    9 
 fs/affs/super.c                                    |   13 
 fs/afs/internal.h                                  |    9 
 fs/afs/mntpt.c                                     |  147 ++--
 fs/afs/super.c                                     |  423 ++++++------
 fs/afs/volume.c                                    |    4 
 fs/aio.c                                           |    3 
 fs/anon_inodes.c                                   |   23 -
 fs/autofs4/autofs_i.h                              |    2 
 fs/autofs4/dev-ioctl.c                             |    2 
 fs/autofs4/init.c                                  |    4 
 fs/autofs4/inode.c                                 |    3 
 fs/befs/linuxvfs.c                                 |   11 
 fs/bfs/inode.c                                     |    8 
 fs/binfmt_misc.c                                   |    7 
 fs/block_dev.c                                     |    2 
 fs/btrfs/super.c                                   |   30 +
 fs/btrfs/tests/btrfs-tests.c                       |    2 
 fs/cachefiles/rdwr.c                               |    2 
 fs/ceph/super.c                                    |    3 
 fs/cifs/cifs_dfs_ref.c                             |    3 
 fs/cifs/cifsfs.c                                   |    5 
 fs/coda/inode.c                                    |   11 
 fs/configfs/mount.c                                |    7 
 fs/cramfs/inode.c                                  |   17 
 fs/debugfs/inode.c                                 |   14 
 fs/devpts/inode.c                                  |   10 
 fs/ecryptfs/main.c                                 |    2 
 fs/efivarfs/super.c                                |    9 
 fs/efs/super.c                                     |   14 
 fs/eventfd.c                                       |    2 
 fs/eventpoll.c                                     |    2 
 fs/exec.c                                          |    6 
 fs/exofs/super.c                                   |    7 
 fs/exportfs/expfs.c                                |    2 
 fs/ext2/super.c                                    |   14 
 fs/ext4/super.c                                    |   16 
 fs/f2fs/super.c                                    |   13 
 fs/fat/inode.c                                     |    3 
 fs/fat/namei_msdos.c                               |    8 
 fs/fat/namei_vfat.c                                |    8 
 fs/fcntl.c                                         |    6 
 fs/file.c                                          |   20 -
 fs/file_table.c                                    |    4 
 fs/freevxfs/vxfs_super.c                           |   12 
 fs/fs_context.c                                    |  689 ++++++++++++++++++++
 fs/fsopen.c                                        |  477 ++++++++++++++
 fs/fuse/control.c                                  |    9 
 fs/fuse/inode.c                                    |   16 
 fs/gfs2/ops_fstype.c                               |    6 
 fs/gfs2/super.c                                    |    4 
 fs/hfs/super.c                                     |   12 
 fs/hfsplus/super.c                                 |   12 
 fs/hostfs/hostfs_kern.c                            |    7 
 fs/hpfs/super.c                                    |   11 
 fs/hugetlbfs/inode.c                               |  337 ++++++----
 fs/internal.h                                      |   10 
 fs/isofs/inode.c                                   |   11 
 fs/jffs2/super.c                                   |   10 
 fs/jfs/super.c                                     |   11 
 fs/kernfs/mount.c                                  |   88 +--
 fs/libfs.c                                         |   17 
 fs/minix/inode.c                                   |   14 
 fs/namei.c                                         |  105 ++-
 fs/namespace.c                                     |  650 +++++++++++++++----
 fs/nfs/dir.c                                       |   15 
 fs/nfs/internal.h                                  |    4 
 fs/nfs/namespace.c                                 |    3 
 fs/nfs/nfs4namespace.c                             |    3 
 fs/nfs/nfs4proc.c                                  |    9 
 fs/nfs/nfs4super.c                                 |   27 -
 fs/nfs/super.c                                     |   22 -
 fs/nfsd/nfsctl.c                                   |    8 
 fs/nilfs2/super.c                                  |   10 
 fs/notify/fanotify/fanotify_user.c                 |   10 
 fs/notify/inotify/inotify_user.c                   |    2 
 fs/nsfs.c                                          |    5 
 fs/ntfs/super.c                                    |   13 
 fs/ocfs2/dlmfs/dlmfs.c                             |    5 
 fs/ocfs2/super.c                                   |   14 
 fs/omfs/inode.c                                    |    9 
 fs/open.c                                          |   31 +
 fs/openpromfs/inode.c                              |   11 
 fs/orangefs/orangefs-kernel.h                      |    2 
 fs/orangefs/super.c                                |    5 
 fs/overlayfs/super.c                               |   11 
 fs/pipe.c                                          |    3 
 fs/pnode.c                                         |    1 
 fs/proc/inode.c                                    |   50 -
 fs/proc/internal.h                                 |    6 
 fs/proc/root.c                                     |  212 +++++-
 fs/pstore/inode.c                                  |   10 
 fs/qnx4/inode.c                                    |   14 
 fs/qnx6/inode.c                                    |   14 
 fs/ramfs/inode.c                                   |    6 
 fs/reiserfs/super.c                                |   14 
 fs/romfs/super.c                                   |   13 
 fs/signalfd.c                                      |    3 
 fs/squashfs/super.c                                |   12 
 fs/statfs.c                                        |  431 +++++++++++++
 fs/super.c                                         |  402 +++++++++---
 fs/sysfs/mount.c                                   |   64 +-
 fs/sysv/inode.c                                    |    3 
 fs/sysv/super.c                                    |   16 
 fs/timerfd.c                                       |    2 
 fs/tracefs/inode.c                                 |   10 
 fs/ubifs/super.c                                   |    5 
 fs/udf/super.c                                     |   16 
 fs/ufs/super.c                                     |   11 
 fs/xfs/xfs_ioctl.c                                 |    2 
 fs/xfs/xfs_super.c                                 |   10 
 include/linux/anon_inodes.h                        |    6 
 include/linux/cgroup.h                             |    3 
 include/linux/debugfs.h                            |    8 
 include/linux/fcntl.h                              |    3 
 include/linux/file.h                               |   31 +
 include/linux/fs.h                                 |   73 +-
 include/linux/fs_context.h                         |  178 +++++
 include/linux/fsinfo.h                             |   25 +
 include/linux/fsnotify.h                           |    8 
 include/linux/kernfs.h                             |   36 +
 include/linux/lsm_hooks.h                          |   89 ++-
 include/linux/mount.h                              |    8 
 include/linux/mtd/super.h                          |    4 
 include/linux/nfs_fs.h                             |    3 
 include/linux/ramfs.h                              |    4 
 include/linux/security.h                           |   74 ++
 include/linux/shmem_fs.h                           |    3 
 include/linux/syscalls.h                           |   11 
 include/uapi/asm-generic/fcntl.h                   |    9 
 include/uapi/linux/fs.h                            |   68 --
 include/uapi/linux/fsinfo.h                        |  231 +++++++
 include/uapi/linux/magic.h                         |    1 
 include/uapi/linux/mount.h                         |   69 ++
 init/do_mounts.c                                   |    5 
 init/do_mounts_initrd.c                            |    1 
 ipc/mqueue.c                                       |  126 +++-
 kernel/bpf/inode.c                                 |    7 
 kernel/bpf/syscall.c                               |    6 
 kernel/cgroup/cgroup-internal.h                    |   42 +
 kernel/cgroup/cgroup-v1.c                          |  296 ++++-----
 kernel/cgroup/cgroup.c                             |  224 ++++---
 kernel/cgroup/cpuset.c                             |   65 ++
 kernel/events/core.c                               |    2 
 kernel/sys_ni.c                                    |    6 
 kernel/trace/trace.c                               |    7 
 mm/shmem.c                                         |   10 
 mm/zsmalloc.c                                      |    3 
 net/socket.c                                       |    3 
 net/sunrpc/rpc_pipe.c                              |    7 
 net/unix/af_unix.c                                 |    2 
 samples/statx/Makefile                             |    5 
 samples/statx/test-fsinfo.c                        |  179 +++++
 security/apparmor/apparmorfs.c                     |    8 
 security/apparmor/file.c                           |    2 
 security/apparmor/include/mount.h                  |   11 
 security/apparmor/lsm.c                            |   84 ++
 security/apparmor/mount.c                          |   47 +
 security/inode.c                                   |    7 
 security/keys/big_key.c                            |    2 
 security/security.c                                |   70 ++
 security/selinux/hooks.c                           |  294 ++++++++-
 security/selinux/selinuxfs.c                       |    8 
 security/smack/smack_lsm.c                         |  344 +++++++++-
 security/smack/smackfs.c                           |    9 
 security/tomoyo/common.h                           |    3 
 security/tomoyo/mount.c                            |   46 +
 security/tomoyo/tomoyo.c                           |   19 +
 205 files changed, 6775 insertions(+), 1836 deletions(-)
 create mode 100644 Documentation/filesystems/mounting.txt
 create mode 100644 fs/fs_context.c
 create mode 100644 fs/fsopen.c
 create mode 100644 include/linux/fs_context.h
 create mode 100644 include/linux/fsinfo.h
 create mode 100644 include/uapi/linux/fsinfo.h
 create mode 100644 include/uapi/linux/mount.h
 create mode 100644 samples/statx/test-fsinfo.c
