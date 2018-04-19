Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeDSNcL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:32:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753072AbeDSNcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:32:03 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/24] VFS: Require specification of size of mount data for
 internal mounts [ver #7]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org
Date: Thu, 19 Apr 2018 14:31:58 +0100
Message-ID: <152414471831.23902.8972659684331925948.stgit@warthog.procyon.org.uk>
In-Reply-To: <152414466005.23902.12967974041384198114.stgit@warthog.procyon.org.uk>
References: <152414466005.23902.12967974041384198114.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Require specification of the size of the mount data passed to the VFS
mounting functions by internal mounts.  The problem is that the legacy
handling for the upcoming mount-context patches has to copy an entire page
as that's how big the buffer is defined as being, but some of the internal
calls pass in a short bit of stack space, with the result that the stack
guard page may get hit.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/ia64/kernel/perfmon.c                         |    3 +
 arch/powerpc/platforms/cell/spufs/inode.c          |    6 +--
 arch/s390/hypfs/inode.c                            |    7 ++-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c           |    2 -
 drivers/base/devtmpfs.c                            |    6 +--
 drivers/dax/super.c                                |    2 -
 drivers/gpu/drm/drm_drv.c                          |    3 +
 drivers/gpu/drm/i915/i915_gemfs.c                  |    2 -
 drivers/infiniband/hw/qib/qib_fs.c                 |    7 ++-
 drivers/misc/ibmasm/ibmasmfs.c                     |   11 +++--
 drivers/mtd/mtdsuper.c                             |   26 +++++++-----
 drivers/oprofile/oprofilefs.c                      |    8 ++--
 .../staging/lustre/lustre/llite/llite_internal.h   |    2 -
 drivers/staging/lustre/lustre/llite/llite_lib.c    |    3 +
 drivers/staging/lustre/lustre/obdclass/obd_mount.c |    7 ++-
 drivers/staging/ncpfs/inode.c                      |   10 +++--
 drivers/usb/gadget/function/f_fs.c                 |    7 ++-
 drivers/usb/gadget/legacy/inode.c                  |    7 ++-
 drivers/virtio/virtio_balloon.c                    |    2 -
 drivers/xen/xenfs/super.c                          |    7 ++-
 fs/9p/vfs_super.c                                  |    2 -
 fs/adfs/super.c                                    |    9 ++--
 fs/affs/super.c                                    |   13 ++++--
 fs/afs/mntpt.c                                     |    3 +
 fs/afs/super.c                                     |    6 ++-
 fs/aio.c                                           |    3 +
 fs/anon_inodes.c                                   |    3 +
 fs/autofs4/autofs_i.h                              |    2 -
 fs/autofs4/init.c                                  |    4 +-
 fs/autofs4/inode.c                                 |    3 +
 fs/befs/linuxvfs.c                                 |   11 +++--
 fs/bfs/inode.c                                     |    8 ++--
 fs/binfmt_misc.c                                   |    7 ++-
 fs/block_dev.c                                     |    2 -
 fs/btrfs/super.c                                   |   30 ++++++++------
 fs/btrfs/tests/btrfs-tests.c                       |    2 -
 fs/ceph/super.c                                    |    3 +
 fs/cifs/cifs_dfs_ref.c                             |    3 +
 fs/cifs/cifsfs.c                                   |    5 +-
 fs/coda/inode.c                                    |   11 +++--
 fs/configfs/mount.c                                |    7 ++-
 fs/cramfs/inode.c                                  |   17 +++++---
 fs/debugfs/inode.c                                 |   14 ++++--
 fs/devpts/inode.c                                  |   10 +++--
 fs/ecryptfs/main.c                                 |    2 -
 fs/efivarfs/super.c                                |    9 +++-
 fs/efs/super.c                                     |   14 ++++--
 fs/exofs/super.c                                   |    7 ++-
 fs/ext2/super.c                                    |   14 ++++--
 fs/ext4/super.c                                    |   16 +++++--
 fs/f2fs/super.c                                    |   11 +++--
 fs/fat/inode.c                                     |    3 +
 fs/fat/namei_msdos.c                               |    8 ++--
 fs/fat/namei_vfat.c                                |    8 ++--
 fs/freevxfs/vxfs_super.c                           |   12 ++++-
 fs/fuse/control.c                                  |    9 +++-
 fs/fuse/inode.c                                    |   16 +++++--
 fs/gfs2/ops_fstype.c                               |    6 ++-
 fs/gfs2/super.c                                    |    4 +-
 fs/hfs/super.c                                     |   12 ++++-
 fs/hfsplus/super.c                                 |   12 ++++-
 fs/hostfs/hostfs_kern.c                            |    7 ++-
 fs/hpfs/super.c                                    |   11 +++--
 fs/hugetlbfs/inode.c                               |   13 ++++--
 fs/internal.h                                      |    4 +-
 fs/isofs/inode.c                                   |   11 +++--
 fs/jffs2/super.c                                   |   10 +++--
 fs/jfs/super.c                                     |   11 +++--
 fs/kernfs/mount.c                                  |    3 +
 fs/libfs.c                                         |    2 -
 fs/minix/inode.c                                   |   14 ++++--
 fs/namespace.c                                     |   38 ++++++++++-------
 fs/nfs/internal.h                                  |    4 +-
 fs/nfs/namespace.c                                 |    3 +
 fs/nfs/nfs4namespace.c                             |    3 +
 fs/nfs/nfs4super.c                                 |   27 +++++++-----
 fs/nfs/super.c                                     |   22 +++++-----
 fs/nfsd/nfsctl.c                                   |    8 ++--
 fs/nilfs2/super.c                                  |   10 +++--
 fs/nsfs.c                                          |    3 +
 fs/ntfs/super.c                                    |   13 ++++--
 fs/ocfs2/dlmfs/dlmfs.c                             |    5 +-
 fs/ocfs2/super.c                                   |   14 ++++--
 fs/omfs/inode.c                                    |    9 +++-
 fs/openpromfs/inode.c                              |   11 +++--
 fs/orangefs/orangefs-kernel.h                      |    2 -
 fs/orangefs/super.c                                |    5 +-
 fs/overlayfs/super.c                               |   11 +++--
 fs/pipe.c                                          |    3 +
 fs/proc/inode.c                                    |    3 +
 fs/proc/internal.h                                 |    4 +-
 fs/proc/root.c                                     |   11 +++--
 fs/pstore/inode.c                                  |   10 +++--
 fs/qnx4/inode.c                                    |   14 ++++--
 fs/qnx6/inode.c                                    |   14 ++++--
 fs/ramfs/inode.c                                   |    6 +--
 fs/reiserfs/super.c                                |   14 ++++--
 fs/romfs/super.c                                   |   13 ++++--
 fs/squashfs/super.c                                |   12 ++++-
 fs/super.c                                         |   44 +++++++++++---------
 fs/sysfs/mount.c                                   |    2 -
 fs/sysv/inode.c                                    |    3 +
 fs/sysv/super.c                                    |   16 +++++--
 fs/tracefs/inode.c                                 |   10 +++--
 fs/ubifs/super.c                                   |    5 +-
 fs/udf/super.c                                     |   16 +++++--
 fs/ufs/super.c                                     |   11 +++--
 fs/xfs/xfs_super.c                                 |   10 +++--
 include/linux/debugfs.h                            |    8 ++--
 include/linux/fs.h                                 |   29 +++++++------
 include/linux/lsm_hooks.h                          |   13 ++++--
 include/linux/mount.h                              |    5 +-
 include/linux/mtd/super.h                          |    4 +-
 include/linux/ramfs.h                              |    4 +-
 include/linux/security.h                           |   17 ++++----
 include/linux/shmem_fs.h                           |    3 +
 init/do_mounts.c                                   |    4 +-
 ipc/mqueue.c                                       |    9 ++--
 kernel/bpf/inode.c                                 |    7 ++-
 kernel/cgroup/cgroup.c                             |    2 -
 kernel/cgroup/cpuset.c                             |    7 ++-
 kernel/trace/trace.c                               |    7 ++-
 mm/shmem.c                                         |   10 +++--
 mm/zsmalloc.c                                      |    3 +
 net/socket.c                                       |    3 +
 net/sunrpc/rpc_pipe.c                              |    7 ++-
 security/apparmor/apparmorfs.c                     |    8 ++--
 security/apparmor/lsm.c                            |    3 +
 security/inode.c                                   |    7 ++-
 security/security.c                                |   18 +++++---
 security/selinux/hooks.c                           |   11 +++--
 security/selinux/selinuxfs.c                       |    8 ++--
 security/smack/smack_lsm.c                         |    6 ++-
 security/smack/smackfs.c                           |    9 +++-
 security/tomoyo/tomoyo.c                           |    4 +-
 135 files changed, 710 insertions(+), 470 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 8fb280e33114..cefb4dd72b53 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -611,7 +611,8 @@ pfm_unprotect_ctx_ctxsw(pfm_context_t *x, unsigned long f)
 static const struct dentry_operations pfmfs_dentry_operations;
 
 static struct dentry *
-pfmfs_mount(struct file_system_type *fs_type, int flags, const char *dev_name, void *data)
+pfmfs_mount(struct file_system_type *fs_type, int flags, const char *dev_name,
+	    void *data, size_t data_size)
 {
 	return mount_pseudo(fs_type, "pfm:", NULL, &pfmfs_dentry_operations,
 			PFMFS_MAGIC);
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index db329d4bf1c3..90d55b47c471 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -734,7 +734,7 @@ spufs_create_root(struct super_block *sb, void *data)
 }
 
 static int
-spufs_fill_super(struct super_block *sb, void *data, int silent)
+spufs_fill_super(struct super_block *sb, void *data, size_t data_size, int silent)
 {
 	struct spufs_sb_info *info;
 	static const struct super_operations s_ops = {
@@ -761,9 +761,9 @@ spufs_fill_super(struct super_block *sb, void *data, int silent)
 
 static struct dentry *
 spufs_mount(struct file_system_type *fstype, int flags,
-		const char *name, void *data)
+		const char *name, void *data, size_t data_size)
 {
-	return mount_single(fstype, flags, data, spufs_fill_super);
+	return mount_single(fstype, flags, data, data_size, spufs_fill_super);
 }
 
 static struct file_system_type spufs_type = {
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 43bbe63e2992..791dcbffd65d 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -266,7 +266,8 @@ static int hypfs_show_options(struct seq_file *s, struct dentry *root)
 	return 0;
 }
 
-static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
+static int hypfs_fill_super(struct super_block *sb,
+			    void *data, size_t data_size, int silent)
 {
 	struct inode *root_inode;
 	struct dentry *root_dentry;
@@ -309,9 +310,9 @@ static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *hypfs_mount(struct file_system_type *fst, int flags,
-			const char *devname, void *data)
+			const char *devname, void *data, size_t data_size)
 {
-	return mount_single(fst, flags, data, hypfs_fill_super);
+	return mount_single(fst, flags, data, data_size, hypfs_fill_super);
 }
 
 static void hypfs_kill_super(struct super_block *sb)
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index fca759d272a1..3584ef8de1fd 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1207,7 +1207,7 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 
 static struct dentry *rdt_mount(struct file_system_type *fs_type,
 				int flags, const char *unused_dev_name,
-				void *data)
+				void *data, size_t data_size)
 {
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 79a235184fb5..1b87a1e03b45 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -57,12 +57,12 @@ static int __init mount_param(char *str)
 __setup("devtmpfs.mount=", mount_param);
 
 static struct dentry *dev_mount(struct file_system_type *fs_type, int flags,
-		      const char *dev_name, void *data)
+		      const char *dev_name, void *data, size_t data_size)
 {
 #ifdef CONFIG_TMPFS
-	return mount_single(fs_type, flags, data, shmem_fill_super);
+	return mount_single(fs_type, flags, data, data_size, shmem_fill_super);
 #else
-	return mount_single(fs_type, flags, data, ramfs_fill_super);
+	return mount_single(fs_type, flags, data, data_size, ramfs_fill_super);
 #endif
 }
 
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 2b2332b605e4..cda4ab7b1dd4 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -396,7 +396,7 @@ static const struct super_operations dax_sops = {
 };
 
 static struct dentry *dax_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *data)
+		int flags, const char *dev_name, void *data, size_t data_size)
 {
 	return mount_pseudo(fs_type, "dax:", &dax_sops, NULL, DAXFS_MAGIC);
 }
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index a1b9338736e3..fc652bb90b78 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -375,7 +375,8 @@ static const struct super_operations drm_fs_sops = {
 };
 
 static struct dentry *drm_fs_mount(struct file_system_type *fs_type, int flags,
-				   const char *dev_name, void *data)
+				   const char *dev_name,
+				   void *data, size_t data_size)
 {
 	return mount_pseudo(fs_type,
 			    "drm:",
diff --git a/drivers/gpu/drm/i915/i915_gemfs.c b/drivers/gpu/drm/i915/i915_gemfs.c
index 888b7d3f04c3..bf0a355e8f46 100644
--- a/drivers/gpu/drm/i915/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/i915_gemfs.c
@@ -57,7 +57,7 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 		int flags = 0;
 		int err;
 
-		err = sb->s_op->remount_fs(sb, &flags, options);
+		err = sb->s_op->remount_fs(sb, &flags, options, sizeof(options));
 		if (err) {
 			kern_unmount(gemfs);
 			return err;
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index 1d940a2885c9..28648ef1f4cc 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -506,7 +506,8 @@ static int remove_device_files(struct super_block *sb,
  * after device init.  The direct add_cntr_files() call handles adding
  * them from the init code, when the fs is already mounted.
  */
-static int qibfs_fill_super(struct super_block *sb, void *data, int silent)
+static int qibfs_fill_super(struct super_block *sb,
+			    void *data, size_t data_size, int silent)
 {
 	struct qib_devdata *dd, *tmp;
 	unsigned long flags;
@@ -541,11 +542,11 @@ static int qibfs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *qibfs_mount(struct file_system_type *fs_type, int flags,
-			const char *dev_name, void *data)
+			const char *dev_name, void *data, size_t data_size)
 {
 	struct dentry *ret;
 
-	ret = mount_single(fs_type, flags, data, qibfs_fill_super);
+	ret = mount_single(fs_type, flags, data, data_size, qibfs_fill_super);
 	if (!IS_ERR(ret))
 		qib_super = ret->d_sb;
 	return ret;
diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index e05c3245930a..d0378eec6bca 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -88,13 +88,15 @@ static LIST_HEAD(service_processors);
 
 static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode);
 static void ibmasmfs_create_files (struct super_block *sb);
-static int ibmasmfs_fill_super (struct super_block *sb, void *data, int silent);
+static int ibmasmfs_fill_super (struct super_block *sb, void *data, size_t data_size,
+				int silent);
 
 
 static struct dentry *ibmasmfs_mount(struct file_system_type *fst,
-			int flags, const char *name, void *data)
+				     int flags, const char *name,
+				     void *data, size_t data_size)
 {
-	return mount_single(fst, flags, data, ibmasmfs_fill_super);
+	return mount_single(fst, flags, data, data_size, ibmasmfs_fill_super);
 }
 
 static const struct super_operations ibmasmfs_s_ops = {
@@ -112,7 +114,8 @@ static struct file_system_type ibmasmfs_type = {
 };
 MODULE_ALIAS_FS("ibmasmfs");
 
-static int ibmasmfs_fill_super (struct super_block *sb, void *data, int silent)
+static int ibmasmfs_fill_super (struct super_block *sb,
+				void *data, size_t data_size, int silent)
 {
 	struct inode *root;
 
diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index d58a61c09304..13706ea5cf50 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -61,9 +61,9 @@ static int get_sb_mtd_set(struct super_block *sb, void *_mtd)
  * get a superblock on an MTD-backed filesystem
  */
 static struct dentry *mount_mtd_aux(struct file_system_type *fs_type, int flags,
-			  const char *dev_name, void *data,
+			  const char *dev_name, void *data, size_t data_size,
 			  struct mtd_info *mtd,
-			  int (*fill_super)(struct super_block *, void *, int))
+			  int (*fill_super)(struct super_block *, void *, size_t, int))
 {
 	struct super_block *sb;
 	int ret;
@@ -79,7 +79,7 @@ static struct dentry *mount_mtd_aux(struct file_system_type *fs_type, int flags,
 	pr_debug("MTDSB: New superblock for device %d (\"%s\")\n",
 	      mtd->index, mtd->name);
 
-	ret = fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
+	ret = fill_super(sb, data, data_size, flags & SB_SILENT ? 1 : 0);
 	if (ret < 0) {
 		deactivate_locked_super(sb);
 		return ERR_PTR(ret);
@@ -105,8 +105,10 @@ static struct dentry *mount_mtd_aux(struct file_system_type *fs_type, int flags,
  * get a superblock on an MTD-backed filesystem by MTD device number
  */
 static struct dentry *mount_mtd_nr(struct file_system_type *fs_type, int flags,
-			 const char *dev_name, void *data, int mtdnr,
-			 int (*fill_super)(struct super_block *, void *, int))
+				   const char *dev_name,
+				   void *data, size_t data_size, int mtdnr,
+				   int (*fill_super)(struct super_block *, void *,
+						     size_t, int))
 {
 	struct mtd_info *mtd;
 
@@ -116,15 +118,16 @@ static struct dentry *mount_mtd_nr(struct file_system_type *fs_type, int flags,
 		return ERR_CAST(mtd);
 	}
 
-	return mount_mtd_aux(fs_type, flags, dev_name, data, mtd, fill_super);
+	return mount_mtd_aux(fs_type, flags, dev_name, data, data_size, mtd,
+			     fill_super);
 }
 
 /*
  * set up an MTD-based superblock
  */
 struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
-	       const char *dev_name, void *data,
-	       int (*fill_super)(struct super_block *, void *, int))
+			 const char *dev_name, void *data, size_t data_size,
+			 int (*fill_super)(struct super_block *, void *, size_t, int))
 {
 #ifdef CONFIG_BLOCK
 	struct block_device *bdev;
@@ -153,7 +156,7 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 			if (!IS_ERR(mtd))
 				return mount_mtd_aux(
 					fs_type, flags,
-					dev_name, data, mtd,
+					dev_name, data, data_size, mtd,
 					fill_super);
 
 			printk(KERN_NOTICE "MTD:"
@@ -170,7 +173,7 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 				pr_debug("MTDSB: mtd%%d, mtdnr %d\n",
 				      mtdnr);
 				return mount_mtd_nr(fs_type, flags,
-						     dev_name, data,
+						    dev_name, data, data_size,
 						     mtdnr, fill_super);
 			}
 		}
@@ -197,7 +200,8 @@ struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 	if (major != MTD_BLOCK_MAJOR)
 		goto not_an_MTD_device;
 
-	return mount_mtd_nr(fs_type, flags, dev_name, data, mtdnr, fill_super);
+	return mount_mtd_nr(fs_type, flags, dev_name, data, data_size, mtdnr,
+			    fill_super);
 
 not_an_MTD_device:
 #endif /* CONFIG_BLOCK */
diff --git a/drivers/oprofile/oprofilefs.c b/drivers/oprofile/oprofilefs.c
index 4ea08979312c..c721d7fd7c7e 100644
--- a/drivers/oprofile/oprofilefs.c
+++ b/drivers/oprofile/oprofilefs.c
@@ -238,7 +238,8 @@ struct dentry *oprofilefs_mkdir(struct dentry *parent, char const *name)
 }
 
 
-static int oprofilefs_fill_super(struct super_block *sb, void *data, int silent)
+static int oprofilefs_fill_super(struct super_block *sb,
+				 void *data, size_t data_size, int silent)
 {
 	struct inode *root_inode;
 
@@ -265,9 +266,10 @@ static int oprofilefs_fill_super(struct super_block *sb, void *data, int silent)
 
 
 static struct dentry *oprofilefs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, oprofilefs_fill_super);
+	return mount_single(fs_type, flags, data, data_size,
+			    oprofilefs_fill_super);
 }
 
 
diff --git a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drivers/staging/lustre/lustre/llite/llite_internal.h
index d46bcf71b273..48b218ecdbd6 100644
--- a/drivers/staging/lustre/lustre/llite/llite_internal.h
+++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
@@ -810,7 +810,7 @@ int ll_iocontrol(struct inode *inode, struct file *file,
 		 unsigned int cmd, unsigned long arg);
 int ll_flush_ctx(struct inode *inode);
 void ll_umount_begin(struct super_block *sb);
-int ll_remount_fs(struct super_block *sb, int *flags, char *data);
+int ll_remount_fs(struct super_block *sb, int *flags, char *data, size_t data_size);
 int ll_show_options(struct seq_file *seq, struct dentry *dentry);
 void ll_dirty_page_discard_warn(struct page *page, int ioret);
 int ll_prep_inode(struct inode **inode, struct ptlrpc_request *req,
diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/staging/lustre/lustre/llite/llite_lib.c
index e7500c53fafc..d8bb57ff3797 100644
--- a/drivers/staging/lustre/lustre/llite/llite_lib.c
+++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
@@ -2039,7 +2039,8 @@ void ll_umount_begin(struct super_block *sb)
 	schedule();
 }
 
-int ll_remount_fs(struct super_block *sb, int *flags, char *data)
+int ll_remount_fs(struct super_block *sb, int *flags,
+		  char *data, size_t data_size)
 {
 	struct ll_sb_info *sbi = ll_s2sbi(sb);
 	char *profilenm = get_profile_name(sb);
diff --git a/drivers/staging/lustre/lustre/obdclass/obd_mount.c b/drivers/staging/lustre/lustre/obdclass/obd_mount.c
index f5e8214ac37b..0fc2a5604a10 100644
--- a/drivers/staging/lustre/lustre/obdclass/obd_mount.c
+++ b/drivers/staging/lustre/lustre/obdclass/obd_mount.c
@@ -1112,7 +1112,8 @@ static int lmd_parse(char *options, struct lustre_mount_data *lmd)
  * and this is where we start setting things up.
  * @param data Mount options (e.g. -o flock,abort_recov)
  */
-static int lustre_fill_super(struct super_block *sb, void *lmd2_data, int silent)
+static int lustre_fill_super(struct super_block *sb,
+			     void *lmd2_data, size_t data_size, int silent)
 {
 	struct lustre_mount_data *lmd;
 	struct lustre_sb_info *lsi;
@@ -1207,9 +1208,9 @@ EXPORT_SYMBOL(lustre_register_super_ops);
 
 /***************** FS registration ******************/
 static struct dentry *lustre_mount(struct file_system_type *fs_type, int flags,
-				   const char *devname, void *data)
+				   const char *devname, void *data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, data, lustre_fill_super);
+	return mount_nodev(fs_type, flags, data, data_size, lustre_fill_super);
 }
 
 static void lustre_kill_super(struct super_block *sb)
diff --git a/drivers/staging/ncpfs/inode.c b/drivers/staging/ncpfs/inode.c
index bb411610a071..c26606ed0a0c 100644
--- a/drivers/staging/ncpfs/inode.c
+++ b/drivers/staging/ncpfs/inode.c
@@ -101,7 +101,8 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(ncp_inode_cachep);
 }
 
-static int ncp_remount(struct super_block *sb, int *flags, char* data)
+static int ncp_remount(struct super_block *sb, int *flags,
+		       char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_NODIRATIME;
@@ -466,7 +467,8 @@ static int ncp_parse_options(struct ncp_mount_data_kernel *data, char *options)
 	return ret;
 }
 
-static int ncp_fill_super(struct super_block *sb, void *raw_data, int silent)
+static int ncp_fill_super(struct super_block *sb,
+			  void *raw_data, size_t data_size, int silent)
 {
 	struct ncp_mount_data_kernel data;
 	struct ncp_server *server;
@@ -1023,9 +1025,9 @@ int ncp_notify_change(struct dentry *dentry, struct iattr *attr)
 }
 
 static struct dentry *ncp_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, data, ncp_fill_super);
+	return mount_nodev(fs_type, flags, data, data_size, ncp_fill_super);
 }
 
 static struct file_system_type ncp_fs_type = {
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 0294e4f18873..694d59e613f4 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1355,7 +1355,8 @@ struct ffs_sb_fill_data {
 	struct ffs_data *ffs_data;
 };
 
-static int ffs_sb_fill(struct super_block *sb, void *_data, int silent)
+static int ffs_sb_fill(struct super_block *sb, void *_data, size_t data_size,
+		       int silent)
 {
 	struct ffs_sb_fill_data *data = _data;
 	struct inode	*inode;
@@ -1483,7 +1484,7 @@ static int ffs_fs_parse_opts(struct ffs_sb_fill_data *data, char *opts)
 
 static struct dentry *
 ffs_fs_mount(struct file_system_type *t, int flags,
-	      const char *dev_name, void *opts)
+	     const char *dev_name, void *opts, size_t data_size)
 {
 	struct ffs_sb_fill_data data = {
 		.perms = {
@@ -1525,7 +1526,7 @@ ffs_fs_mount(struct file_system_type *t, int flags,
 	ffs->private_data = ffs_dev;
 	data.ffs_data = ffs;
 
-	rv = mount_nodev(t, flags, &data, ffs_sb_fill);
+	rv = mount_nodev(t, flags, &data, sizeof(data), ffs_sb_fill);
 	if (IS_ERR(rv) && data.ffs_data) {
 		ffs_release_dev(data.ffs_data);
 		ffs_data_put(data.ffs_data);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 37ca0e669bd8..286a982b43a3 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1990,7 +1990,8 @@ static const struct super_operations gadget_fs_operations = {
 };
 
 static int
-gadgetfs_fill_super (struct super_block *sb, void *opts, int silent)
+gadgetfs_fill_super (struct super_block *sb, void *opts, size_t data_size,
+		     int silent)
 {
 	struct inode	*inode;
 	struct dev_data	*dev;
@@ -2046,9 +2047,9 @@ gadgetfs_fill_super (struct super_block *sb, void *opts, int silent)
 /* "mount -t gadgetfs path /dev/gadget" ends up here */
 static struct dentry *
 gadgetfs_mount (struct file_system_type *t, int flags,
-		const char *path, void *opts)
+		const char *path, void *opts, size_t data_size)
 {
-	return mount_single (t, flags, opts, gadgetfs_fill_super);
+	return mount_single (t, flags, opts, data_size, gadgetfs_fill_super);
 }
 
 static void
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 6b237e3f4983..49f4a03ec162 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -526,7 +526,7 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 }
 
 static struct dentry *balloon_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *data)
+		int flags, const char *dev_name, void *data, size_t data_size)
 {
 	static const struct dentry_operations ops = {
 		.d_dname = simple_dname,
diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
index 71ddfb4cf61c..fc4e6e43b66f 100644
--- a/drivers/xen/xenfs/super.c
+++ b/drivers/xen/xenfs/super.c
@@ -42,7 +42,8 @@ static const struct file_operations capabilities_file_ops = {
 	.llseek = default_llseek,
 };
 
-static int xenfs_fill_super(struct super_block *sb, void *data, int silent)
+static int xenfs_fill_super(struct super_block *sb,
+			    void *data, size_t data_size, int silent)
 {
 	static const struct tree_descr xenfs_files[] = {
 		[2] = { "xenbus", &xen_xenbus_fops, S_IRUSR|S_IWUSR },
@@ -69,9 +70,9 @@ static int xenfs_fill_super(struct super_block *sb, void *data, int silent)
 
 static struct dentry *xenfs_mount(struct file_system_type *fs_type,
 				  int flags, const char *dev_name,
-				  void *data)
+				  void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, xenfs_fill_super);
+	return mount_single(fs_type, flags, data, data_size, xenfs_fill_super);
 }
 
 static struct file_system_type xenfs_type = {
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 48ce50484e80..7def28abd3a5 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -116,7 +116,7 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
  */
 
 static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
-		       const char *dev_name, void *data)
+		       const char *dev_name, void *data, size_t data_size)
 {
 	struct super_block *sb = NULL;
 	struct inode *inode = NULL;
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index cfda2c7caedc..8a7b2d263afd 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -210,7 +210,7 @@ static int parse_options(struct super_block *sb, char *options)
 	return 0;
 }
 
-static int adfs_remount(struct super_block *sb, int *flags, char *data)
+static int adfs_remount(struct super_block *sb, int *flags, char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_NODIRATIME;
@@ -362,7 +362,8 @@ static inline unsigned long adfs_discsize(struct adfs_discrecord *dr, int block_
 	return discsize;
 }
 
-static int adfs_fill_super(struct super_block *sb, void *data, int silent)
+static int adfs_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	struct adfs_discrecord *dr;
 	struct buffer_head *bh;
@@ -522,9 +523,9 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *adfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, adfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size, adfs_fill_super);
 }
 
 static struct file_system_type adfs_fs_type = {
diff --git a/fs/affs/super.c b/fs/affs/super.c
index e602619aed9d..b406ffca2066 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -26,7 +26,8 @@
 
 static int affs_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int affs_show_options(struct seq_file *m, struct dentry *root);
-static int affs_remount (struct super_block *sb, int *flags, char *data);
+static int affs_remount (struct super_block *sb, int *flags,
+			 char *data, size_t data_size);
 
 static void
 affs_commit_super(struct super_block *sb, int wait)
@@ -334,7 +335,8 @@ static int affs_show_options(struct seq_file *m, struct dentry *root)
  * hopefully have the guts to do so. Until then: sorry for the mess.
  */
 
-static int affs_fill_super(struct super_block *sb, void *data, int silent)
+static int affs_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	struct affs_sb_info	*sbi;
 	struct buffer_head	*root_bh = NULL;
@@ -549,7 +551,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static int
-affs_remount(struct super_block *sb, int *flags, char *data)
+affs_remount(struct super_block *sb, int *flags, char *data, size_t data_size)
 {
 	struct affs_sb_info	*sbi = AFFS_SB(sb);
 	int			 blocksize;
@@ -632,9 +634,10 @@ affs_statfs(struct dentry *dentry, struct kstatfs *buf)
 }
 
 static struct dentry *affs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, affs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  affs_fill_super);
 }
 
 static void affs_kill_sb(struct super_block *sb)
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 99fd13500a97..c45aa1776591 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -152,7 +152,8 @@ static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
 
 	/* try and do the mount */
 	_debug("--- attempting mount %s -o %s ---", devname, options);
-	mnt = vfs_submount(mntpt, &afs_fs_type, devname, options);
+	mnt = vfs_submount(mntpt, &afs_fs_type, devname,
+			   options, strlen(options) + 1);
 	_debug("--- mount result %p ---", mnt);
 
 	free_page((unsigned long) devname);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 65081ec3c36e..7d17d01ca0cd 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -31,7 +31,8 @@
 
 static void afs_i_init_once(void *foo);
 static struct dentry *afs_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data);
+				int flags, const char *dev_name,
+				void *data, size_t data_size);
 static void afs_kill_super(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
 static void afs_destroy_inode(struct inode *inode);
@@ -460,7 +461,8 @@ static void afs_destroy_sbi(struct afs_super_info *as)
  * get an AFS superblock
  */
 static struct dentry *afs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *options)
+				int flags, const char *dev_name,
+				void *options, size_t data_size)
 {
 	struct afs_mount_params params;
 	struct super_block *sb;
diff --git a/fs/aio.c b/fs/aio.c
index 88d7927ffbc6..09ac6fd6dba9 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -234,7 +234,8 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 }
 
 static struct dentry *aio_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *data)
+				int flags, const char *dev_name,
+				void *data, size_t data_size)
 {
 	static const struct dentry_operations ops = {
 		.d_dname	= simple_dname,
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 3168ee4e77f4..13c06a7e0b85 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -39,7 +39,8 @@ static const struct dentry_operations anon_inodefs_dentry_operations = {
 };
 
 static struct dentry *anon_inodefs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *data)
+					 int flags, const char *dev_name,
+					 void *data, size_t data_size)
 {
 	return mount_pseudo(fs_type, "anon_inode:", NULL,
 			&anon_inodefs_dentry_operations, ANON_INODE_FS_MAGIC);
diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 4737615f0eaa..06a975ee5724 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -201,7 +201,7 @@ static inline void managed_dentry_clear_managed(struct dentry *dentry)
 
 /* Initializing function */
 
-int autofs4_fill_super(struct super_block *, void *, int);
+int autofs4_fill_super(struct super_block *, void *, size_t, int);
 struct autofs_info *autofs4_new_ino(struct autofs_sb_info *);
 void autofs4_clean_ino(struct autofs_info *);
 
diff --git a/fs/autofs4/init.c b/fs/autofs4/init.c
index 8cf0e63389ae..3335cfdb9403 100644
--- a/fs/autofs4/init.c
+++ b/fs/autofs4/init.c
@@ -11,9 +11,9 @@
 #include "autofs_i.h"
 
 static struct dentry *autofs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, data, autofs4_fill_super);
+	return mount_nodev(fs_type, flags, data, data_size, autofs4_fill_super);
 }
 
 static struct file_system_type autofs_fs_type = {
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 09e7d68dff02..49389477ba36 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -206,7 +206,8 @@ static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
 	return (*pipefd < 0);
 }
 
-int autofs4_fill_super(struct super_block *s, void *data, int silent)
+int autofs4_fill_super(struct super_block *s, void *data, size_t data_size,
+		       int silent)
 {
 	struct inode *root_inode;
 	struct dentry *root;
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index af2832aaeec5..70f958115745 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -52,7 +52,7 @@ static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
 static int befs_nls2utf(struct super_block *sb, const char *in, int in_len,
 			char **out, int *out_len);
 static void befs_put_super(struct super_block *);
-static int befs_remount(struct super_block *, int *, char *);
+static int befs_remount(struct super_block *, int *, char *, size_t);
 static int befs_statfs(struct dentry *, struct kstatfs *);
 static int befs_show_options(struct seq_file *, struct dentry *);
 static int parse_options(char *, struct befs_mount_options *);
@@ -817,7 +817,7 @@ befs_put_super(struct super_block *sb)
  * Load a set of NLS translations if needed.
  */
 static int
-befs_fill_super(struct super_block *sb, void *data, int silent)
+befs_fill_super(struct super_block *sb, void *data, size_t data_size, int silent)
 {
 	struct buffer_head *bh;
 	struct befs_sb_info *befs_sb;
@@ -949,7 +949,7 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static int
-befs_remount(struct super_block *sb, int *flags, char *data)
+befs_remount(struct super_block *sb, int *flags, char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	if (!(*flags & SB_RDONLY))
@@ -983,9 +983,10 @@ befs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static struct dentry *
 befs_mount(struct file_system_type *fs_type, int flags, const char *dev_name,
-	    void *data)
+	   void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, befs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  befs_fill_super);
 }
 
 static struct file_system_type befs_fs_type = {
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 9a69392f1fb3..6e76e4e762e8 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -317,7 +317,8 @@ void bfs_dump_imap(const char *prefix, struct super_block *s)
 #endif
 }
 
-static int bfs_fill_super(struct super_block *s, void *data, int silent)
+static int bfs_fill_super(struct super_block *s, void *data, size_t data_size,
+			  int silent)
 {
 	struct buffer_head *bh, *sbh;
 	struct bfs_super_block *bfs_sb;
@@ -460,9 +461,10 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
 }
 
 static struct dentry *bfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, bfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  bfs_fill_super);
 }
 
 static struct file_system_type bfs_fs_type = {
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a41b48f82a70..274de8bfc004 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -814,7 +814,8 @@ static const struct super_operations s_ops = {
 	.evict_inode	= bm_evict_inode,
 };
 
-static int bm_fill_super(struct super_block *sb, void *data, int silent)
+static int bm_fill_super(struct super_block *sb, void *data, size_t data_size,
+			 int silent)
 {
 	int err;
 	static const struct tree_descr bm_files[] = {
@@ -830,9 +831,9 @@ static int bm_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *bm_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, bm_fill_super);
+	return mount_single(fs_type, flags, data, data_size, bm_fill_super);
 }
 
 static struct linux_binfmt misc_format = {
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e27065..313e57b06425 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -786,7 +786,7 @@ static const struct super_operations bdev_sops = {
 };
 
 static struct dentry *bd_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
 	struct dentry *dent;
 	dent = mount_pseudo(fs_type, "bdev:", &bdev_sops, NULL, BDEVFS_MAGIC);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0628092b0b1b..8d8fcd2f0403 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -64,7 +64,8 @@ static const struct super_operations btrfs_super_ops;
 static struct file_system_type btrfs_fs_type;
 static struct file_system_type btrfs_root_fs_type;
 
-static int btrfs_remount(struct super_block *sb, int *flags, char *data);
+static int btrfs_remount(struct super_block *sb, int *flags,
+			 char *data, size_t data_size);
 
 const char *btrfs_decode_error(int errno)
 {
@@ -1453,7 +1454,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 	return root;
 }
 
-static int parse_security_options(char *orig_opts,
+static int parse_security_options(char *orig_opts, size_t data_size,
 				  struct security_mnt_opts *sec_opts)
 {
 	char *secdata = NULL;
@@ -1462,7 +1463,7 @@ static int parse_security_options(char *orig_opts,
 	secdata = alloc_secdata();
 	if (!secdata)
 		return -ENOMEM;
-	ret = security_sb_copy_data(orig_opts, secdata);
+	ret = security_sb_copy_data(orig_opts, data_size, secdata);
 	if (ret) {
 		free_secdata(secdata);
 		return ret;
@@ -1510,7 +1511,8 @@ static int setup_security_options(struct btrfs_fs_info *fs_info,
  *       for multiple device setup.  Make sure to keep it in sync.
  */
 static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
-		int flags, const char *device_name, void *data)
+				       int flags, const char *device_name,
+				       void *data, size_t data_size)
 {
 	struct block_device *bdev = NULL;
 	struct super_block *s;
@@ -1531,7 +1533,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 
 	security_init_mnt_opts(&new_sec_opts);
 	if (data) {
-		error = parse_security_options(data, &new_sec_opts);
+		error = parse_security_options(data, data_size, &new_sec_opts);
 		if (error)
 			return ERR_PTR(error);
 	}
@@ -1635,7 +1637,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
  *      "btrfs subvolume set-default", mount_subvol() is called always.
  */
 static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
-		const char *device_name, void *data)
+		const char *device_name, void *data, size_t data_size)
 {
 	struct vfsmount *mnt_root;
 	struct dentry *root;
@@ -1655,21 +1657,24 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
 	}
 
 	/* mount device's root (/) */
-	mnt_root = vfs_kern_mount(&btrfs_root_fs_type, flags, device_name, data);
+	mnt_root = vfs_kern_mount(&btrfs_root_fs_type, flags, device_name,
+				  data, data_size);
 	if (PTR_ERR_OR_ZERO(mnt_root) == -EBUSY) {
 		if (flags & SB_RDONLY) {
 			mnt_root = vfs_kern_mount(&btrfs_root_fs_type,
-				flags & ~SB_RDONLY, device_name, data);
+				flags & ~SB_RDONLY, device_name,
+				data, data_size);
 		} else {
 			mnt_root = vfs_kern_mount(&btrfs_root_fs_type,
-				flags | SB_RDONLY, device_name, data);
+				flags | SB_RDONLY, device_name,
+				data, data_size);
 			if (IS_ERR(mnt_root)) {
 				root = ERR_CAST(mnt_root);
 				goto out;
 			}
 
 			down_write(&mnt_root->mnt_sb->s_umount);
-			error = btrfs_remount(mnt_root->mnt_sb, &flags, NULL);
+			error = btrfs_remount(mnt_root->mnt_sb, &flags, NULL, 0);
 			up_write(&mnt_root->mnt_sb->s_umount);
 			if (error < 0) {
 				root = ERR_PTR(error);
@@ -1751,7 +1756,8 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 }
 
-static int btrfs_remount(struct super_block *sb, int *flags, char *data)
+static int btrfs_remount(struct super_block *sb, int *flags,
+			 char *data, size_t data_size)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *root = fs_info->tree_root;
@@ -1770,7 +1776,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		struct security_mnt_opts new_sec_opts;
 
 		security_init_mnt_opts(&new_sec_opts);
-		ret = parse_security_options(data, &new_sec_opts);
+		ret = parse_security_options(data, data_size, &new_sec_opts);
 		if (ret)
 			goto restore;
 		ret = setup_security_options(fs_info, sb,
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 30ed438da2a9..d646cf7b04e5 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -24,7 +24,7 @@ static const struct super_operations btrfs_test_super_ops = {
 
 static struct dentry *btrfs_test_mount(struct file_system_type *fs_type,
 				       int flags, const char *dev_name,
-				       void *data)
+				       void *data, size_t data_size)
 {
 	return mount_pseudo(fs_type, "btrfs_test:", &btrfs_test_super_ops,
 			    NULL, BTRFS_TEST_MAGIC);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b33082e6878f..81d035a7a204 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1002,7 +1002,8 @@ static int ceph_setup_bdi(struct super_block *sb, struct ceph_fs_client *fsc)
 }
 
 static struct dentry *ceph_mount(struct file_system_type *fs_type,
-		       int flags, const char *dev_name, void *data)
+				 int flags, const char *dev_name,
+				 void *data, size_t data_size)
 {
 	struct super_block *sb;
 	struct ceph_fs_client *fsc;
diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index 6b61df117fd4..461d052a5d73 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -260,7 +260,8 @@ static struct vfsmount *cifs_dfs_do_refmount(struct dentry *mntpt,
 	if (IS_ERR(mountdata))
 		return (struct vfsmount *)mountdata;
 
-	mnt = vfs_submount(mntpt, &cifs_fs_type, devname, mountdata);
+	mnt = vfs_submount(mntpt, &cifs_fs_type, devname,
+			   mountdata, strlen(mountdata) + 1);
 	kfree(mountdata);
 	kfree(devname);
 	return mnt;
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f715609b13f3..b4004c3b3a2a 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -572,7 +572,8 @@ static int cifs_show_stats(struct seq_file *s, struct dentry *root)
 }
 #endif
 
-static int cifs_remount(struct super_block *sb, int *flags, char *data)
+static int cifs_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_NODIRATIME;
@@ -675,7 +676,7 @@ static int cifs_set_super(struct super_block *sb, void *data)
 
 static struct dentry *
 cifs_do_mount(struct file_system_type *fs_type,
-	      int flags, const char *dev_name, void *data)
+	      int flags, const char *dev_name, void *data, size_t data_size)
 {
 	int rc;
 	struct super_block *sb;
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 97424cf206c0..dd819c150f70 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -93,7 +93,8 @@ void coda_destroy_inodecache(void)
 	kmem_cache_destroy(coda_inode_cachep);
 }
 
-static int coda_remount(struct super_block *sb, int *flags, char *data)
+static int coda_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_NOATIME;
@@ -150,7 +151,8 @@ static int get_device_index(struct coda_mount_data *data)
 	return -1;
 }
 
-static int coda_fill_super(struct super_block *sb, void *data, int silent)
+static int coda_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	struct inode *root = NULL;
 	struct venus_comm *vc;
@@ -316,9 +318,10 @@ static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
 /* init_coda: used by filesystems.c to register coda */
 
 static struct dentry *coda_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+				 int flags, const char *dev_name,
+				 void *data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, data, coda_fill_super);
+	return mount_nodev(fs_type, flags, data, data_size, coda_fill_super);
 }
 
 struct file_system_type coda_fs_type = {
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index cfd91320e869..c9c7c14eb9db 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -66,7 +66,8 @@ static struct configfs_dirent configfs_root = {
 	.s_iattr	= NULL,
 };
 
-static int configfs_fill_super(struct super_block *sb, void *data, int silent)
+static int configfs_fill_super(struct super_block *sb,
+			       void *data, size_t data_size, int silent)
 {
 	struct inode *inode;
 	struct dentry *root;
@@ -103,9 +104,9 @@ static int configfs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *configfs_do_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, configfs_fill_super);
+	return mount_single(fs_type, flags, data, data_size, configfs_fill_super);
 }
 
 static struct file_system_type configfs_fs_type = {
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 017b0ab19bc4..79527b703256 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -502,7 +502,8 @@ static void cramfs_kill_sb(struct super_block *sb)
 	kfree(sbi);
 }
 
-static int cramfs_remount(struct super_block *sb, int *flags, char *data)
+static int cramfs_remount(struct super_block *sb, int *flags,
+			  char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_RDONLY;
@@ -603,7 +604,8 @@ static int cramfs_finalize_super(struct super_block *sb,
 	return 0;
 }
 
-static int cramfs_blkdev_fill_super(struct super_block *sb, void *data,
+static int cramfs_blkdev_fill_super(struct super_block *sb,
+				    void *data, size_t data_size,
 				    int silent)
 {
 	struct cramfs_sb_info *sbi;
@@ -625,8 +627,8 @@ static int cramfs_blkdev_fill_super(struct super_block *sb, void *data,
 	return cramfs_finalize_super(sb, &super.root);
 }
 
-static int cramfs_mtd_fill_super(struct super_block *sb, void *data,
-				 int silent)
+static int cramfs_mtd_fill_super(struct super_block *sb,
+				 void *data, size_t data_size, int silent)
 {
 	struct cramfs_sb_info *sbi;
 	struct cramfs_super super;
@@ -951,18 +953,19 @@ static const struct super_operations cramfs_ops = {
 };
 
 static struct dentry *cramfs_mount(struct file_system_type *fs_type, int flags,
-				   const char *dev_name, void *data)
+				   const char *dev_name,
+				   void *data, size_t data_size)
 {
 	struct dentry *ret = ERR_PTR(-ENOPROTOOPT);
 
 	if (IS_ENABLED(CONFIG_CRAMFS_MTD)) {
-		ret = mount_mtd(fs_type, flags, dev_name, data,
+		ret = mount_mtd(fs_type, flags, dev_name, data, data_size,
 				cramfs_mtd_fill_super);
 		if (!IS_ERR(ret))
 			return ret;
 	}
 	if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV)) {
-		ret = mount_bdev(fs_type, flags, dev_name, data,
+		ret = mount_bdev(fs_type, flags, dev_name, data, data_size,
 				 cramfs_blkdev_fill_super);
 	}
 	return ret;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 13b01351dd1c..57ba6d891c85 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -130,7 +130,8 @@ static int debugfs_apply_options(struct super_block *sb)
 	return 0;
 }
 
-static int debugfs_remount(struct super_block *sb, int *flags, char *data)
+static int debugfs_remount(struct super_block *sb, int *flags,
+			   char *data, size_t data_size)
 {
 	int err;
 	struct debugfs_fs_info *fsi = sb->s_fs_info;
@@ -190,7 +191,7 @@ static struct vfsmount *debugfs_automount(struct path *path)
 {
 	debugfs_automount_t f;
 	f = (debugfs_automount_t)path->dentry->d_fsdata;
-	return f(path->dentry, d_inode(path->dentry)->i_private);
+	return f(path->dentry, d_inode(path->dentry)->i_private, 0);
 }
 
 static const struct dentry_operations debugfs_dops = {
@@ -199,7 +200,8 @@ static const struct dentry_operations debugfs_dops = {
 	.d_automount = debugfs_automount,
 };
 
-static int debug_fill_super(struct super_block *sb, void *data, int silent)
+static int debug_fill_super(struct super_block *sb,
+			    void *data, size_t data_size, int silent)
 {
 	static const struct tree_descr debug_files[] = {{""}};
 	struct debugfs_fs_info *fsi;
@@ -235,9 +237,9 @@ static int debug_fill_super(struct super_block *sb, void *data, int silent)
 
 static struct dentry *debug_mount(struct file_system_type *fs_type,
 			int flags, const char *dev_name,
-			void *data)
+			void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, debug_fill_super);
+	return mount_single(fs_type, flags, data, data_size, debug_fill_super);
 }
 
 static struct file_system_type debug_fs_type = {
@@ -539,7 +541,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_dir);
 struct dentry *debugfs_create_automount(const char *name,
 					struct dentry *parent,
 					debugfs_automount_t f,
-					void *data)
+					void *data, size_t data_size)
 {
 	struct dentry *dentry = start_creating(name, parent);
 	struct inode *inode;
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index e072e955ce33..2dee3d0c8554 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -386,7 +386,8 @@ static void update_ptmx_mode(struct pts_fs_info *fsi)
 	}
 }
 
-static int devpts_remount(struct super_block *sb, int *flags, char *data)
+static int devpts_remount(struct super_block *sb, int *flags,
+			  char *data, size_t data_size)
 {
 	int err;
 	struct pts_fs_info *fsi = DEVPTS_SB(sb);
@@ -447,7 +448,8 @@ static void *new_pts_fs_info(struct super_block *sb)
 }
 
 static int
-devpts_fill_super(struct super_block *s, void *data, int silent)
+devpts_fill_super(struct super_block *s, void *data, size_t data_size,
+		  int silent)
 {
 	struct inode *inode;
 	int error;
@@ -504,9 +506,9 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
  *     instance are independent of the PTYs in other devpts instances.
  */
 static struct dentry *devpts_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, data, devpts_fill_super);
+	return mount_nodev(fs_type, flags, data, data_size, devpts_fill_super);
 }
 
 static void devpts_kill_sb(struct super_block *sb)
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 025d66a705db..5d029b7e069a 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -488,7 +488,7 @@ static struct file_system_type ecryptfs_fs_type;
  * @raw_data: The options passed into the kernel
  */
 static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags,
-			const char *dev_name, void *raw_data)
+			const char *dev_name, void *raw_data, size_t data_size)
 {
 	struct super_block *s;
 	struct ecryptfs_sb_info *sbi;
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 5b68e4294faa..db0e417f1c7e 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -191,7 +191,8 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
 	return 0;
 }
 
-static int efivarfs_fill_super(struct super_block *sb, void *data, int silent)
+static int efivarfs_fill_super(struct super_block *sb,
+			       void *data, size_t data_size, int silent)
 {
 	struct inode *inode = NULL;
 	struct dentry *root;
@@ -227,9 +228,11 @@ static int efivarfs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *efivarfs_mount(struct file_system_type *fs_type,
-				    int flags, const char *dev_name, void *data)
+				     int flags, const char *dev_name,
+				     void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, efivarfs_fill_super);
+	return mount_single(fs_type, flags, data, data_size,
+			    efivarfs_fill_super);
 }
 
 static void efivarfs_kill_sb(struct super_block *sb)
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 6ffb7ba1547a..ce85f22651f3 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -19,12 +19,14 @@
 #include <linux/efs_fs_sb.h>
 
 static int efs_statfs(struct dentry *dentry, struct kstatfs *buf);
-static int efs_fill_super(struct super_block *s, void *d, int silent);
+static int efs_fill_super(struct super_block *s, void *d, size_t data_size,
+			  int silent);
 
 static struct dentry *efs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, efs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  efs_fill_super);
 }
 
 static void efs_kill_sb(struct super_block *s)
@@ -113,7 +115,8 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(efs_inode_cachep);
 }
 
-static int efs_remount(struct super_block *sb, int *flags, char *data)
+static int efs_remount(struct super_block *sb, int *flags,
+		       char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_RDONLY;
@@ -253,7 +256,8 @@ static int efs_validate_super(struct efs_sb_info *sb, struct efs_super *super) {
 	return 0;    
 }
 
-static int efs_fill_super(struct super_block *s, void *d, int silent)
+static int efs_fill_super(struct super_block *s, void *d, size_t data_size,
+			  int silent)
 {
 	struct efs_sb_info *sb;
 	struct buffer_head *bh;
diff --git a/fs/exofs/super.c b/fs/exofs/super.c
index 179cd5c2f52a..21886644b6f3 100644
--- a/fs/exofs/super.c
+++ b/fs/exofs/super.c
@@ -705,7 +705,8 @@ static int exofs_read_lookup_dev_table(struct exofs_sb_info *sbi,
 /*
  * Read the superblock from the OSD and fill in the fields
  */
-static int exofs_fill_super(struct super_block *sb, void *data, int silent)
+static int exofs_fill_super(struct super_block *sb, void *data, size_t data_size,
+			    int silent)
 {
 	struct inode *root;
 	struct exofs_mountopt *opts = data;
@@ -861,7 +862,7 @@ static int exofs_fill_super(struct super_block *sb, void *data, int silent)
  */
 static struct dentry *exofs_mount(struct file_system_type *type,
 			  int flags, const char *dev_name,
-			  void *data)
+			  void *data, size_t data_size)
 {
 	struct exofs_mountopt opts;
 	int ret;
@@ -872,7 +873,7 @@ static struct dentry *exofs_mount(struct file_system_type *type,
 
 	if (!opts.dev_name)
 		opts.dev_name = dev_name;
-	return mount_nodev(type, flags, &opts, exofs_fill_super);
+	return mount_nodev(type, flags, &opts, 0, exofs_fill_super);
 }
 
 /*
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index de1694512f1f..ca2cd53959b3 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -39,7 +39,8 @@
 #include "acl.h"
 
 static void ext2_write_super(struct super_block *sb);
-static int ext2_remount (struct super_block * sb, int * flags, char * data);
+static int ext2_remount (struct super_block * sb, int * flags,
+			 char * data, size_t data_size);
 static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf);
 static int ext2_sync_fs(struct super_block *sb, int wait);
 static int ext2_freeze(struct super_block *sb);
@@ -815,7 +816,8 @@ static unsigned long descriptor_loc(struct super_block *sb,
 	return ext2_group_first_block_no(sb, bg) + has_super;
 }
 
-static int ext2_fill_super(struct super_block *sb, void *data, int silent)
+static int ext2_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
 	struct buffer_head * bh;
@@ -1319,7 +1321,8 @@ static void ext2_write_super(struct super_block *sb)
 		ext2_sync_fs(sb, 1);
 }
 
-static int ext2_remount (struct super_block * sb, int * flags, char * data)
+static int ext2_remount (struct super_block * sb, int * flags,
+			 char *data, size_t data_size)
 {
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_super_block * es;
@@ -1473,9 +1476,10 @@ static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf)
 }
 
 static struct dentry *ext2_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  ext2_fill_super);
 }
 
 #ifdef CONFIG_QUOTA
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 185f7e61f4cf..966c79a9c93c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -70,12 +70,13 @@ static void ext4_mark_recovery_complete(struct super_block *sb,
 static void ext4_clear_journal_err(struct super_block *sb,
 				   struct ext4_super_block *es);
 static int ext4_sync_fs(struct super_block *sb, int wait);
-static int ext4_remount(struct super_block *sb, int *flags, char *data);
+static int ext4_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size);
 static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int ext4_unfreeze(struct super_block *sb);
 static int ext4_freeze(struct super_block *sb);
 static struct dentry *ext4_mount(struct file_system_type *fs_type, int flags,
-		       const char *dev_name, void *data);
+		       const char *dev_name, void *data, size_t data_size);
 static inline int ext2_feature_set_ok(struct super_block *sb);
 static inline int ext3_feature_set_ok(struct super_block *sb);
 static int ext4_feature_set_ok(struct super_block *sb, int readonly);
@@ -3405,7 +3406,8 @@ static void ext4_set_resv_clusters(struct super_block *sb)
 	atomic64_set(&sbi->s_resv_clusters, resv_clusters);
 }
 
-static int ext4_fill_super(struct super_block *sb, void *data, int silent)
+static int ext4_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
 	char *orig_data = kstrdup(data, GFP_KERNEL);
@@ -4976,7 +4978,8 @@ struct ext4_mount_options {
 #endif
 };
 
-static int ext4_remount(struct super_block *sb, int *flags, char *data)
+static int ext4_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size)
 {
 	struct ext4_super_block *es;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -5735,9 +5738,10 @@ static int ext4_get_next_id(struct super_block *sb, struct kqid *qid)
 #endif
 
 static struct dentry *ext4_mount(struct file_system_type *fs_type, int flags,
-		       const char *dev_name, void *data)
+		       const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ext4_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  ext4_fill_super);
 }
 
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined(CONFIG_EXT4_USE_FOR_EXT2)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a31cc49b7295..96db72d025d8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1384,7 +1384,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_QUOTA
 static int f2fs_enable_quotas(struct super_block *sb);
 #endif
-static int f2fs_remount(struct super_block *sb, int *flags, char *data)
+static int f2fs_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct f2fs_mount_info org_mount_opt;
@@ -2589,7 +2590,8 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 	}
 }
 
-static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
+static int f2fs_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	struct f2fs_sb_info *sbi;
 	struct f2fs_super_block *raw_super;
@@ -3015,9 +3017,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
-			const char *dev_name, void *data)
+			const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  f2fs_fill_super);
 }
 
 static void kill_f2fs_super(struct super_block *sb)
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index ffbbf0520d9e..53765ffd96c0 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -778,7 +778,8 @@ static void __exit fat_destroy_inodecache(void)
 	kmem_cache_destroy(fat_inode_cachep);
 }
 
-static int fat_remount(struct super_block *sb, int *flags, char *data)
+static int fat_remount(struct super_block *sb, int *flags,
+		       char *data, size_t data_size)
 {
 	bool new_rdonly;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 582ca731a6c9..8df24e45fea6 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -650,16 +650,18 @@ static void setup(struct super_block *sb)
 	sb->s_flags |= SB_NOATIME;
 }
 
-static int msdos_fill_super(struct super_block *sb, void *data, int silent)
+static int msdos_fill_super(struct super_block *sb, void *data, size_t data_size,
+			    int silent)
 {
 	return fat_fill_super(sb, data, silent, 0, setup);
 }
 
 static struct dentry *msdos_mount(struct file_system_type *fs_type,
 			int flags, const char *dev_name,
-			void *data)
+			void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  msdos_fill_super);
 }
 
 static struct file_system_type msdos_fs_type = {
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 2649759c478a..b3c2c0ccde15 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1054,16 +1054,18 @@ static void setup(struct super_block *sb)
 		sb->s_d_op = &vfat_dentry_ops;
 }
 
-static int vfat_fill_super(struct super_block *sb, void *data, int silent)
+static int vfat_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	return fat_fill_super(sb, data, silent, 1, setup);
 }
 
 static struct dentry *vfat_mount(struct file_system_type *fs_type,
 		       int flags, const char *dev_name,
-		       void *data)
+		       void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  vfat_fill_super);
 }
 
 static struct file_system_type vfat_fs_type = {
diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index 48b24bb50d02..1c6cf91f6de9 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -113,7 +113,8 @@ vxfs_statfs(struct dentry *dentry, struct kstatfs *bufp)
 	return 0;
 }
 
-static int vxfs_remount(struct super_block *sb, int *flags, char *data)
+static int vxfs_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_RDONLY;
@@ -199,6 +200,7 @@ static int vxfs_try_sb_magic(struct super_block *sbp, int silent,
  * vxfs_read_super - read superblock into memory and initialize filesystem
  * @sbp:		VFS superblock (to fill)
  * @dp:			fs private mount data
+ * @data_size:		size of mount data
  * @silent:		do not complain loudly when sth is wrong
  *
  * Description:
@@ -211,7 +213,8 @@ static int vxfs_try_sb_magic(struct super_block *sbp, int silent,
  * Locking:
  *   We are under @sbp->s_lock.
  */
-static int vxfs_fill_super(struct super_block *sbp, void *dp, int silent)
+static int vxfs_fill_super(struct super_block *sbp, void *dp, size_t data_size,
+			   int silent)
 {
 	struct vxfs_sb_info	*infp;
 	struct vxfs_sb		*rsbp;
@@ -312,9 +315,10 @@ static int vxfs_fill_super(struct super_block *sbp, void *dp, int silent)
  * The usual module blurb.
  */
 static struct dentry *vxfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, vxfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  vxfs_fill_super);
 }
 
 static struct file_system_type vxfs_fs_type = {
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index b9ea99c5b5b3..5d0abd02aa83 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -290,7 +290,8 @@ void fuse_ctl_remove_conn(struct fuse_conn *fc)
 	drop_nlink(d_inode(fuse_control_sb->s_root));
 }
 
-static int fuse_ctl_fill_super(struct super_block *sb, void *data, int silent)
+static int fuse_ctl_fill_super(struct super_block *sb,
+			       void *data, size_t data_size, int silent)
 {
 	static const struct tree_descr empty_descr = {""};
 	struct fuse_conn *fc;
@@ -317,9 +318,11 @@ static int fuse_ctl_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *fuse_ctl_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name, void *raw_data)
+				     int flags, const char *dev_name,
+				     void *raw_data, size_t data_size)
 {
-	return mount_single(fs_type, flags, raw_data, fuse_ctl_fill_super);
+	return mount_single(fs_type, flags, raw_data, data_size,
+			    fuse_ctl_fill_super);
 }
 
 static void fuse_ctl_kill_sb(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ef309958e060..e150d078419f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -138,7 +138,8 @@ static void fuse_evict_inode(struct inode *inode)
 	}
 }
 
-static int fuse_remount_fs(struct super_block *sb, int *flags, char *data)
+static int fuse_remount_fs(struct super_block *sb, int *flags,
+			   char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	if (*flags & SB_MANDLOCK)
@@ -1043,7 +1044,8 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
-static int fuse_fill_super(struct super_block *sb, void *data, int silent)
+static int fuse_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	struct fuse_dev *fud;
 	struct fuse_conn *fc;
@@ -1187,9 +1189,10 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 
 static struct dentry *fuse_mount(struct file_system_type *fs_type,
 		       int flags, const char *dev_name,
-		       void *raw_data)
+		       void *raw_data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, raw_data, fuse_fill_super);
+	return mount_nodev(fs_type, flags, raw_data, data_size,
+			   fuse_fill_super);
 }
 
 static void fuse_kill_sb_anon(struct super_block *sb)
@@ -1217,9 +1220,10 @@ MODULE_ALIAS_FS("fuse");
 #ifdef CONFIG_BLOCK
 static struct dentry *fuse_mount_blk(struct file_system_type *fs_type,
 			   int flags, const char *dev_name,
-			   void *raw_data)
+			   void *raw_data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, raw_data, fuse_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, raw_data, data_size,
+			  fuse_fill_super);
 }
 
 static void fuse_kill_sb_blk(struct super_block *sb)
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 3ba3f167641c..a8a664eed01e 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1239,6 +1239,7 @@ static int test_gfs2_super(struct super_block *s, void *ptr)
  * @flags: Mount flags
  * @dev_name: The name of the device
  * @data: The mount arguments
+ * @data_size: The size of the mount arguments
  *
  * Q. Why not use get_sb_bdev() ?
  * A. We need to select one of two root directories to mount, independent
@@ -1248,7 +1249,7 @@ static int test_gfs2_super(struct super_block *s, void *ptr)
  */
 
 static struct dentry *gfs2_mount(struct file_system_type *fs_type, int flags,
-		       const char *dev_name, void *data)
+		       const char *dev_name, void *data, size_t data_size)
 {
 	struct block_device *bdev;
 	struct super_block *s;
@@ -1345,7 +1346,8 @@ static int set_meta_super(struct super_block *s, void *ptr)
 }
 
 static struct dentry *gfs2_mount_meta(struct file_system_type *fs_type,
-			int flags, const char *dev_name, void *data)
+				      int flags, const char *dev_name,
+				      void *data, size_t data_size)
 {
 	struct super_block *s;
 	struct gfs2_sbd *sdp;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index cf5c7f3080d2..a2add54e63e3 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1228,11 +1228,13 @@ static int gfs2_statfs(struct dentry *dentry, struct kstatfs *buf)
  * @sb:  the filesystem
  * @flags:  the remount flags
  * @data:  extra data passed in (not used right now)
+ * @data_size: size of the extra data
  *
  * Returns: errno
  */
 
-static int gfs2_remount_fs(struct super_block *sb, int *flags, char *data)
+static int gfs2_remount_fs(struct super_block *sb, int *flags,
+			   char *data, size_t data_size)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_args args = sdp->sd_args; /* Default to current settings */
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 173876782f73..e739b381b041 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -111,7 +111,8 @@ static int hfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static int hfs_remount(struct super_block *sb, int *flags, char *data)
+static int hfs_remount(struct super_block *sb, int *flags,
+		       char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_NODIRATIME;
@@ -382,7 +383,8 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
  * hfs_btree_init() to get the necessary data about the extents and
  * catalog B-trees and, finally, reading the root inode into memory.
  */
-static int hfs_fill_super(struct super_block *sb, void *data, int silent)
+static int hfs_fill_super(struct super_block *sb, void *data, size_t data_size,
+			  int silent)
 {
 	struct hfs_sb_info *sbi;
 	struct hfs_find_data fd;
@@ -458,9 +460,11 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *hfs_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data)
+				int flags, const char *dev_name,
+				void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, hfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  hfs_fill_super);
 }
 
 static struct file_system_type hfs_fs_type = {
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 513c357c734b..758e2315be60 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -326,7 +326,8 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static int hfsplus_remount(struct super_block *sb, int *flags, char *data)
+static int hfsplus_remount(struct super_block *sb, int *flags,
+			   char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
@@ -371,7 +372,8 @@ static const struct super_operations hfsplus_sops = {
 	.show_options	= hfsplus_show_options,
 };
 
-static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
+static int hfsplus_fill_super(struct super_block *sb,
+			      void *data, size_t data_size, int silent)
 {
 	struct hfsplus_vh *vhdr;
 	struct hfsplus_sb_info *sbi;
@@ -640,9 +642,11 @@ static void hfsplus_destroy_inode(struct inode *inode)
 #define HFSPLUS_INODE_SIZE	sizeof(struct hfsplus_inode_info)
 
 static struct dentry *hfsplus_mount(struct file_system_type *fs_type,
-			  int flags, const char *dev_name, void *data)
+				    int flags, const char *dev_name,
+				    void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, hfsplus_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  hfsplus_fill_super);
 }
 
 static struct file_system_type hfsplus_fs_type = {
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 3cd85eb5bbb1..09047b506764 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -923,7 +923,8 @@ static const struct inode_operations hostfs_link_iops = {
 	.get_link	= hostfs_get_link,
 };
 
-static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
+static int hostfs_fill_sb_common(struct super_block *sb,
+				 void *d, size_t data_size, int silent)
 {
 	struct inode *root_inode;
 	char *host_root_path, *req_root = d;
@@ -983,9 +984,9 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 
 static struct dentry *hostfs_read_sb(struct file_system_type *type,
 			  int flags, const char *dev_name,
-			  void *data)
+			  void *data, size_t data_size)
 {
-	return mount_nodev(type, flags, data, hostfs_fill_sb_common);
+	return mount_nodev(type, flags, data, data_size, hostfs_fill_sb_common);
 }
 
 static void hostfs_kill_sb(struct super_block *s)
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index f2c3ebcd309c..53e585b27c05 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -445,7 +445,8 @@ HPFS filesystem options:\n\
 \n");
 }
 
-static int hpfs_remount_fs(struct super_block *s, int *flags, char *data)
+static int hpfs_remount_fs(struct super_block *s, int *flags,
+			   char *data, size_t data_size)
 {
 	kuid_t uid;
 	kgid_t gid;
@@ -540,7 +541,8 @@ static const struct super_operations hpfs_sops =
 	.show_options	= hpfs_show_options,
 };
 
-static int hpfs_fill_super(struct super_block *s, void *options, int silent)
+static int hpfs_fill_super(struct super_block *s,
+			   void *options, size_t data_size, int silent)
 {
 	struct buffer_head *bh0, *bh1, *bh2;
 	struct hpfs_boot_block *bootblock;
@@ -757,9 +759,10 @@ bail2:	brelse(bh0);
 }
 
 static struct dentry *hpfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, hpfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  hpfs_fill_super);
 }
 
 static struct file_system_type hpfs_fs_type = {
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d508c7844681..76fb8eb2bea8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1220,7 +1220,8 @@ hugetlbfs_parse_options(char *options, struct hugetlbfs_config *pconfig)
 }
 
 static int
-hugetlbfs_fill_super(struct super_block *sb, void *data, int silent)
+hugetlbfs_fill_super(struct super_block *sb, void *data, size_t data_size,
+		     int silent)
 {
 	int ret;
 	struct hugetlbfs_config config;
@@ -1279,9 +1280,10 @@ hugetlbfs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *hugetlbfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, data, hugetlbfs_fill_super);
+	return mount_nodev(fs_type, flags, data, data_size,
+			   hugetlbfs_fill_super);
 }
 
 static struct file_system_type hugetlbfs_fs_type = {
@@ -1420,10 +1422,11 @@ static int __init init_hugetlbfs_fs(void)
 	for_each_hstate(h) {
 		char buf[50];
 		unsigned ps_kb = 1U << (h->order + PAGE_SHIFT - 10);
+		int n;
 
-		snprintf(buf, sizeof(buf), "pagesize=%uK", ps_kb);
+		n = snprintf(buf, sizeof(buf), "pagesize=%uK", ps_kb);
 		hugetlbfs_vfsmount[i] = kern_mount_data(&hugetlbfs_fs_type,
-							buf);
+							buf, n + 1);
 
 		if (IS_ERR(hugetlbfs_vfsmount[i])) {
 			pr_err("Cannot mount internal hugetlbfs for "
diff --git a/fs/internal.h b/fs/internal.h
index e08972db0303..1afa522c5f30 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -98,10 +98,10 @@ extern struct file *get_empty_filp(void);
 /*
  * super.c
  */
-extern int do_remount_sb(struct super_block *, int, void *, int);
+extern int do_remount_sb(struct super_block *, int, void *, size_t, int);
 extern bool trylock_super(struct super_block *sb);
 extern struct dentry *mount_fs(struct file_system_type *,
-			       int, const char *, void *);
+			       int, const char *, void *, size_t);
 extern struct super_block *user_get_super(dev_t);
 
 /*
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index bc258a4402f6..4f24361db2d6 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -111,7 +111,8 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(isofs_inode_cachep);
 }
 
-static int isofs_remount(struct super_block *sb, int *flags, char *data)
+static int isofs_remount(struct super_block *sb, int *flags,
+			 char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	if (!(*flags & SB_RDONLY))
@@ -616,7 +617,8 @@ static bool rootdir_empty(struct super_block *sb, unsigned long block)
  * Note: a check_disk_change() has been done immediately prior
  * to this call, so we don't need to check again.
  */
-static int isofs_fill_super(struct super_block *s, void *data, int silent)
+static int isofs_fill_super(struct super_block *s, void *data, size_t data_size,
+			    int silent)
 {
 	struct buffer_head *bh = NULL, *pri_bh = NULL;
 	struct hs_primary_descriptor *h_pri = NULL;
@@ -1555,9 +1557,10 @@ struct inode *__isofs_iget(struct super_block *sb,
 }
 
 static struct dentry *isofs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, isofs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  isofs_fill_super);
 }
 
 static struct file_system_type iso9660_fs_type = {
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index f60dee7faf03..51715d90473a 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -238,7 +238,8 @@ static int jffs2_parse_options(struct jffs2_sb_info *c, char *data)
 	return 0;
 }
 
-static int jffs2_remount_fs(struct super_block *sb, int *flags, char *data)
+static int jffs2_remount_fs(struct super_block *sb, int *flags,
+			    char *data, size_t data_size)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
 	int err;
@@ -267,7 +268,8 @@ static const struct super_operations jffs2_super_operations =
 /*
  * fill in the superblock
  */
-static int jffs2_fill_super(struct super_block *sb, void *data, int silent)
+static int jffs2_fill_super(struct super_block *sb,
+			    void *data, size_t data_size, int silent)
 {
 	struct jffs2_sb_info *c;
 	int ret;
@@ -312,9 +314,9 @@ static int jffs2_fill_super(struct super_block *sb, void *data, int silent)
 
 static struct dentry *jffs2_mount(struct file_system_type *fs_type,
 			int flags, const char *dev_name,
-			void *data)
+			void *data, size_t data_size)
 {
-	return mount_mtd(fs_type, flags, dev_name, data, jffs2_fill_super);
+	return mount_mtd(fs_type, flags, dev_name, data, data_size, jffs2_fill_super);
 }
 
 static void jffs2_put_super (struct super_block *sb)
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 1b9264fd54b6..88f30ff12564 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -456,7 +456,8 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
 	return 0;
 }
 
-static int jfs_remount(struct super_block *sb, int *flags, char *data)
+static int jfs_remount(struct super_block *sb, int *flags,
+		       char *data, size_t data_size)
 {
 	s64 newLVSize = 0;
 	int rc = 0;
@@ -516,7 +517,8 @@ static int jfs_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
-static int jfs_fill_super(struct super_block *sb, void *data, int silent)
+static int jfs_fill_super(struct super_block *sb, void *data, size_t data_size,
+			  int silent)
 {
 	struct jfs_sb_info *sbi;
 	struct inode *inode;
@@ -698,9 +700,10 @@ static int jfs_unfreeze(struct super_block *sb)
 }
 
 static struct dentry *jfs_do_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, jfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  jfs_fill_super);
 }
 
 static int jfs_sync_fs(struct super_block *sb, int wait)
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 26dd9a50f383..c05efbd1822e 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -22,7 +22,8 @@
 
 struct kmem_cache *kernfs_node_cache;
 
-static int kernfs_sop_remount_fs(struct super_block *sb, int *flags, char *data)
+static int kernfs_sop_remount_fs(struct super_block *sb, int *flags,
+				 char *data, size_t data_size)
 {
 	struct kernfs_root *root = kernfs_info(sb)->root;
 	struct kernfs_syscall_ops *scops = root->syscall_ops;
diff --git a/fs/libfs.c b/fs/libfs.c
index 0fb590d79f30..9f1f4884b7cc 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -578,7 +578,7 @@ int simple_pin_fs(struct file_system_type *type, struct vfsmount **mount, int *c
 	spin_lock(&pin_fs_lock);
 	if (unlikely(!*mount)) {
 		spin_unlock(&pin_fs_lock);
-		mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
+		mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL, 0);
 		if (IS_ERR(mnt))
 			return PTR_ERR(mnt);
 		spin_lock(&pin_fs_lock);
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 72e308c3e66b..3d91d9096b24 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -22,7 +22,8 @@
 static int minix_write_inode(struct inode *inode,
 		struct writeback_control *wbc);
 static int minix_statfs(struct dentry *dentry, struct kstatfs *buf);
-static int minix_remount (struct super_block * sb, int * flags, char * data);
+static int minix_remount (struct super_block * sb, int * flags,
+			  char * data, size_t data_size);
 
 static void minix_evict_inode(struct inode *inode)
 {
@@ -118,7 +119,8 @@ static const struct super_operations minix_sops = {
 	.remount_fs	= minix_remount,
 };
 
-static int minix_remount (struct super_block * sb, int * flags, char * data)
+static int minix_remount (struct super_block * sb, int * flags,
+			  char * data, size_t data_size)
 {
 	struct minix_sb_info * sbi = minix_sb(sb);
 	struct minix_super_block * ms;
@@ -155,7 +157,8 @@ static int minix_remount (struct super_block * sb, int * flags, char * data)
 	return 0;
 }
 
-static int minix_fill_super(struct super_block *s, void *data, int silent)
+static int minix_fill_super(struct super_block *s, void *data, size_t data_size,
+			    int silent)
 {
 	struct buffer_head *bh;
 	struct buffer_head **map;
@@ -651,9 +654,10 @@ void minix_truncate(struct inode * inode)
 }
 
 static struct dentry *minix_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, minix_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  minix_fill_super);
 }
 
 static struct file_system_type minix_fs_type = {
diff --git a/fs/namespace.c b/fs/namespace.c
index 3f98e1a36b84..8fc4f3459b80 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1020,7 +1020,8 @@ static struct mount *skip_mnt_tree(struct mount *p)
 }
 
 struct vfsmount *
-vfs_kern_mount(struct file_system_type *type, int flags, const char *name, void *data)
+vfs_kern_mount(struct file_system_type *type, int flags, const char *name,
+	       void *data, size_t data_size)
 {
 	struct mount *mnt;
 	struct dentry *root;
@@ -1035,7 +1036,7 @@ vfs_kern_mount(struct file_system_type *type, int flags, const char *name, void
 	if (flags & SB_KERNMOUNT)
 		mnt->mnt.mnt_flags = MNT_INTERNAL;
 
-	root = mount_fs(type, flags, name, data);
+	root = mount_fs(type, flags, name, data, data_size);
 	if (IS_ERR(root)) {
 		mnt_free_id(mnt);
 		free_vfsmnt(mnt);
@@ -1055,7 +1056,7 @@ EXPORT_SYMBOL_GPL(vfs_kern_mount);
 
 struct vfsmount *
 vfs_submount(const struct dentry *mountpoint, struct file_system_type *type,
-	     const char *name, void *data)
+	     const char *name, void *data, size_t data_size)
 {
 	/* Until it is worked out how to pass the user namespace
 	 * through from the parent mount to the submount don't support
@@ -1064,7 +1065,7 @@ vfs_submount(const struct dentry *mountpoint, struct file_system_type *type,
 	if (mountpoint->d_sb->s_user_ns != &init_user_ns)
 		return ERR_PTR(-EPERM);
 
-	return vfs_kern_mount(type, SB_SUBMOUNT, name, data);
+	return vfs_kern_mount(type, SB_SUBMOUNT, name, data, data_size);
 }
 EXPORT_SYMBOL_GPL(vfs_submount);
 
@@ -1594,7 +1595,7 @@ static int do_umount(struct mount *mnt, int flags)
 			return -EPERM;
 		down_write(&sb->s_umount);
 		if (!sb_rdonly(sb))
-			retval = do_remount_sb(sb, SB_RDONLY, NULL, 0);
+			retval = do_remount_sb(sb, SB_RDONLY, NULL, 0, 0);
 		up_write(&sb->s_umount);
 		return retval;
 	}
@@ -2287,7 +2288,7 @@ static int change_mount_flags(struct vfsmount *mnt, int ms_flags)
  * on it - tough luck.
  */
 static int do_remount(struct path *path, int ms_flags, int sb_flags,
-		      int mnt_flags, void *data)
+		      int mnt_flags, void *data, size_t data_size)
 {
 	int err;
 	struct super_block *sb = path->mnt->mnt_sb;
@@ -2326,7 +2327,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		return -EPERM;
 	}
 
-	err = security_sb_remount(sb, data);
+	err = security_sb_remount(sb, data, data_size);
 	if (err)
 		return err;
 
@@ -2336,7 +2337,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	else if (!capable(CAP_SYS_ADMIN))
 		err = -EPERM;
 	else
-		err = do_remount_sb(sb, sb_flags, data, 0);
+		err = do_remount_sb(sb, sb_flags, data, data_size, 0);
 	if (!err) {
 		lock_mount_hash();
 		mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
@@ -2502,7 +2503,8 @@ static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags);
  * namespace's tree
  */
 static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
-			int mnt_flags, const char *name, void *data)
+			int mnt_flags, const char *name,
+			void *data, size_t data_size)
 {
 	struct file_system_type *type;
 	struct vfsmount *mnt;
@@ -2515,7 +2517,7 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (!type)
 		return -ENODEV;
 
-	mnt = vfs_kern_mount(type, sb_flags, name, data);
+	mnt = vfs_kern_mount(type, sb_flags, name, data, data_size);
 	if (!IS_ERR(mnt) && (type->fs_flags & FS_HAS_SUBTYPE) &&
 	    !mnt->mnt_sb->s_subtype)
 		mnt = fs_set_subtype(mnt, fstype);
@@ -2771,6 +2773,7 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 {
 	struct path path;
 	unsigned int mnt_flags = 0, sb_flags;
+	size_t data_size = data_page ? PAGE_SIZE : 0;
 	int retval = 0;
 
 	/* Discard magic */
@@ -2789,8 +2792,8 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 	if (retval)
 		return retval;
 
-	retval = security_sb_mount(dev_name, &path,
-				   type_page, flags, data_page);
+	retval = security_sb_mount(dev_name, &path, type_page, flags,
+				   data_page, data_size);
 	if (!retval && !may_mount())
 		retval = -EPERM;
 	if (!retval && (flags & SB_MANDLOCK) && !may_mandlock())
@@ -2837,7 +2840,7 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 
 	if (flags & MS_REMOUNT)
 		retval = do_remount(&path, flags, sb_flags, mnt_flags,
-				    data_page);
+				    data_page, data_size);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&path, dev_name, flags & MS_REC);
 	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
@@ -2846,7 +2849,7 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 		retval = do_move_mount(&path, dev_name);
 	else
 		retval = do_new_mount(&path, type_page, sb_flags, mnt_flags,
-				      dev_name, data_page);
+				      dev_name, data_page, data_size);
 dput_out:
 	path_put(&path);
 	return retval;
@@ -3236,7 +3239,7 @@ static void __init init_mount_tree(void)
 	type = get_fs_type("rootfs");
 	if (!type)
 		panic("Can't find rootfs type");
-	mnt = vfs_kern_mount(type, 0, "rootfs", NULL);
+	mnt = vfs_kern_mount(type, 0, "rootfs", NULL, 0);
 	put_filesystem(type);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
@@ -3298,10 +3301,11 @@ void put_mnt_ns(struct mnt_namespace *ns)
 	free_mnt_ns(ns);
 }
 
-struct vfsmount *kern_mount_data(struct file_system_type *type, void *data)
+struct vfsmount *kern_mount_data(struct file_system_type *type,
+				 void *data, size_t data_size)
 {
 	struct vfsmount *mnt;
-	mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, data);
+	mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, data, data_size);
 	if (!IS_ERR(mnt)) {
 		/*
 		 * it is a longterm mount, don't release mnt until
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 8357ff69962f..db0f3ca3a35c 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -405,7 +405,7 @@ int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_mount_
 int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
 struct dentry *nfs_fs_mount_common(struct nfs_server *, int, const char *,
 				   struct nfs_mount_info *, struct nfs_subversion *);
-struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
+struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *, size_t);
 struct dentry * nfs_xdev_mount_common(struct file_system_type *, int,
 		const char *, struct nfs_mount_info *);
 void nfs_kill_super(struct super_block *);
@@ -466,7 +466,7 @@ int  nfs_show_options(struct seq_file *, struct dentry *);
 int  nfs_show_devname(struct seq_file *, struct dentry *);
 int  nfs_show_path(struct seq_file *, struct dentry *);
 int  nfs_show_stats(struct seq_file *, struct dentry *);
-int nfs_remount(struct super_block *sb, int *flags, char *raw_data);
+int nfs_remount(struct super_block *sb, int *flags, char *raw_data, size_t data_size);
 
 /* write.c */
 extern void nfs_pageio_init_write(struct nfs_pageio_descriptor *pgio,
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index e5686be67be8..df9e87331558 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -216,7 +216,8 @@ static struct vfsmount *nfs_do_clone_mount(struct nfs_server *server,
 					   const char *devname,
 					   struct nfs_clone_mount *mountdata)
 {
-	return vfs_submount(mountdata->dentry, &nfs_xdev_fs_type, devname, mountdata);
+	return vfs_submount(mountdata->dentry, &nfs_xdev_fs_type, devname,
+			    mountdata, 0);
 }
 
 /**
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 24f06dcc2b08..191cb4202056 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -278,7 +278,8 @@ static struct vfsmount *try_location(struct nfs_clone_mount *mountdata,
 				mountdata->hostname,
 				mountdata->mnt_path);
 
-		mnt = vfs_submount(mountdata->dentry, &nfs4_referral_fs_type, page, mountdata);
+		mnt = vfs_submount(mountdata->dentry, &nfs4_referral_fs_type, page,
+				   mountdata, 0);
 		if (!IS_ERR(mnt))
 			break;
 	}
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 6fb7cb6b3f4b..e72e5dbdfcd0 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -18,11 +18,11 @@
 static int nfs4_write_inode(struct inode *inode, struct writeback_control *wbc);
 static void nfs4_evict_inode(struct inode *inode);
 static struct dentry *nfs4_remote_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data);
+	int flags, const char *dev_name, void *raw_data, size_t data_size);
 static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data);
+	int flags, const char *dev_name, void *raw_data, size_t data_size);
 static struct dentry *nfs4_remote_referral_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data);
+	int flags, const char *dev_name, void *raw_data, size_t data_size);
 
 static struct file_system_type nfs4_remote_fs_type = {
 	.owner		= THIS_MODULE,
@@ -105,7 +105,7 @@ static void nfs4_evict_inode(struct inode *inode)
  */
 static struct dentry *
 nfs4_remote_mount(struct file_system_type *fs_type, int flags,
-		  const char *dev_name, void *info)
+		  const char *dev_name, void *info, size_t data_size)
 {
 	struct nfs_mount_info *mount_info = info;
 	struct nfs_server *server;
@@ -127,7 +127,7 @@ nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 }
 
 static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type,
-		int flags, void *data, const char *hostname)
+		int flags, void *data, size_t data_size, const char *hostname)
 {
 	struct vfsmount *root_mnt;
 	char *root_devname;
@@ -142,7 +142,8 @@ static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type,
 		snprintf(root_devname, len, "[%s]:/", hostname);
 	else
 		snprintf(root_devname, len, "%s:/", hostname);
-	root_mnt = vfs_kern_mount(fs_type, flags, root_devname, data);
+	root_mnt = vfs_kern_mount(fs_type, flags, root_devname,
+				  data, data_size);
 	kfree(root_devname);
 	return root_mnt;
 }
@@ -247,8 +248,8 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 
 	export_path = data->nfs_server.export_path;
 	data->nfs_server.export_path = "/";
-	root_mnt = nfs_do_root_mount(&nfs4_remote_fs_type, flags, mount_info,
-			data->nfs_server.hostname);
+	root_mnt = nfs_do_root_mount(&nfs4_remote_fs_type, flags, mount_info, 0,
+				     data->nfs_server.hostname);
 	data->nfs_server.export_path = export_path;
 
 	res = nfs_follow_remote_path(root_mnt, export_path);
@@ -261,7 +262,8 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 
 static struct dentry *
 nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
-			   const char *dev_name, void *raw_data)
+			   const char *dev_name,
+			   void *raw_data, size_t data_size)
 {
 	struct nfs_mount_info mount_info = {
 		.fill_super = nfs_fill_super,
@@ -294,7 +296,8 @@ nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
  * Create an NFS4 server record on referral traversal
  */
 static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *raw_data)
+					  int flags, const char *dev_name,
+					  void *raw_data, size_t data_size)
 {
 	struct nfs_clone_mount *data = raw_data;
 	char *export_path;
@@ -306,8 +309,8 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 	export_path = data->mnt_path;
 	data->mnt_path = "/";
 
-	root_mnt = nfs_do_root_mount(&nfs4_remote_referral_fs_type,
-			flags, data, data->hostname);
+	root_mnt = nfs_do_root_mount(&nfs4_remote_referral_fs_type, flags,
+				     data, 0, data->hostname);
 	data->mnt_path = export_path;
 
 	res = nfs_follow_remote_path(root_mnt, export_path);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 5e470e233c83..b5f27d6999e5 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -287,7 +287,8 @@ static match_table_t nfs_vers_tokens = {
 };
 
 static struct dentry *nfs_xdev_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *raw_data);
+				     int flags, const char *dev_name,
+				     void *raw_data, size_t data_size);
 
 struct file_system_type nfs_fs_type = {
 	.owner		= THIS_MODULE,
@@ -1203,7 +1204,7 @@ static int nfs_get_option_ul_bound(substring_t args[], unsigned long *option,
  * skipped as they are encountered.  If there were no errors, return 1;
  * otherwise return 0 (zero).
  */
-static int nfs_parse_mount_options(char *raw,
+static int nfs_parse_mount_options(char *raw, size_t raw_size,
 				   struct nfs_parsed_mount_data *mnt)
 {
 	char *p, *string, *secdata;
@@ -1221,7 +1222,7 @@ static int nfs_parse_mount_options(char *raw,
 	if (!secdata)
 		goto out_nomem;
 
-	rc = security_sb_copy_data(raw, secdata);
+	rc = security_sb_copy_data(raw, raw_size, secdata);
 	if (rc)
 		goto out_security_failure;
 
@@ -2151,7 +2152,7 @@ static int nfs_validate_mount_data(struct file_system_type *fs_type,
 }
 #endif
 
-static int nfs_validate_text_mount_data(void *options,
+static int nfs_validate_text_mount_data(void *options, size_t data_size,
 					struct nfs_parsed_mount_data *args,
 					const char *dev_name)
 {
@@ -2160,7 +2161,7 @@ static int nfs_validate_text_mount_data(void *options,
 	int max_pathlen = NFS_MAXPATHLEN;
 	struct sockaddr *sap = (struct sockaddr *)&args->nfs_server.address;
 
-	if (nfs_parse_mount_options((char *)options, args) == 0)
+	if (nfs_parse_mount_options((char *)options, data_size, args) == 0)
 		return -EINVAL;
 
 	if (!nfs_verify_server_address(sap))
@@ -2243,7 +2244,7 @@ nfs_compare_remount_data(struct nfs_server *nfss,
 }
 
 int
-nfs_remount(struct super_block *sb, int *flags, char *raw_data)
+nfs_remount(struct super_block *sb, int *flags, char *raw_data, size_t data_size)
 {
 	int error;
 	struct nfs_server *nfss = sb->s_fs_info;
@@ -2290,7 +2291,7 @@ nfs_remount(struct super_block *sb, int *flags, char *raw_data)
 
 	/* overwrite those values with any that were specified */
 	error = -EINVAL;
-	if (!nfs_parse_mount_options((char *)options, data))
+	if (!nfs_parse_mount_options((char *)options, data_size, data))
 		goto out;
 
 	/*
@@ -2662,7 +2663,7 @@ struct dentry *nfs_fs_mount_common(struct nfs_server *server,
 EXPORT_SYMBOL_GPL(nfs_fs_mount_common);
 
 struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data)
+	int flags, const char *dev_name, void *raw_data, size_t data_size)
 {
 	struct nfs_mount_info mount_info = {
 		.fill_super = nfs_fill_super,
@@ -2680,7 +2681,8 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 	/* Validate the mount data */
 	error = nfs_validate_mount_data(fs_type, raw_data, mount_info.parsed, mount_info.mntfh, dev_name);
 	if (error == NFS_TEXT_DATA)
-		error = nfs_validate_text_mount_data(raw_data, mount_info.parsed, dev_name);
+		error = nfs_validate_text_mount_data(raw_data, data_size,
+						     mount_info.parsed, dev_name);
 	if (error < 0) {
 		mntroot = ERR_PTR(error);
 		goto out;
@@ -2724,7 +2726,7 @@ EXPORT_SYMBOL_GPL(nfs_kill_super);
  */
 static struct dentry *
 nfs_xdev_mount(struct file_system_type *fs_type, int flags,
-		const char *dev_name, void *raw_data)
+		const char *dev_name, void *raw_data, size_t data_size)
 {
 	struct nfs_clone_mount *data = raw_data;
 	struct nfs_mount_info mount_info = {
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d107b4426f7e..661296305123 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1144,7 +1144,8 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
  *	populating the filesystem.
  */
 
-static int nfsd_fill_super(struct super_block * sb, void * data, int silent)
+static int nfsd_fill_super(struct super_block * sb,
+			   void * data, size_t data_size, int silent)
 {
 	static const struct tree_descr nfsd_files[] = {
 		[NFSD_List] = {"exports", &exports_nfsd_operations, S_IRUGO},
@@ -1179,10 +1180,11 @@ static int nfsd_fill_super(struct super_block * sb, void * data, int silent)
 }
 
 static struct dentry *nfsd_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
 	struct net *net = current->nsproxy->net_ns;
-	return mount_ns(fs_type, flags, data, net, net->user_ns, nfsd_fill_super);
+	return mount_ns(fs_type, flags, data, data_size,
+			net, net->user_ns, nfsd_fill_super);
 }
 
 static void nfsd_umount(struct super_block *sb)
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 6ffeca84d7c3..3a21a1ab141f 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -69,7 +69,8 @@ struct kmem_cache *nilfs_segbuf_cachep;
 struct kmem_cache *nilfs_btree_path_cache;
 
 static int nilfs_setup_super(struct super_block *sb, int is_mount);
-static int nilfs_remount(struct super_block *sb, int *flags, char *data);
+static int nilfs_remount(struct super_block *sb, int *flags,
+			 char *data, size_t data_size);
 
 void __nilfs_msg(struct super_block *sb, const char *level, const char *fmt,
 		 ...)
@@ -1118,7 +1119,8 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
-static int nilfs_remount(struct super_block *sb, int *flags, char *data)
+static int nilfs_remount(struct super_block *sb, int *flags,
+			 char *data, size_t data_size)
 {
 	struct the_nilfs *nilfs = sb->s_fs_info;
 	unsigned long old_sb_flags;
@@ -1278,7 +1280,7 @@ static int nilfs_test_bdev_super(struct super_block *s, void *data)
 
 static struct dentry *
 nilfs_mount(struct file_system_type *fs_type, int flags,
-	     const char *dev_name, void *data)
+	    const char *dev_name, void *data, size_t data_size)
 {
 	struct nilfs_super_data sd;
 	struct super_block *s;
@@ -1346,7 +1348,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 			 * Try remount to setup mount states if the current
 			 * tree is not mounted and only snapshots use this sb.
 			 */
-			err = nilfs_remount(s, &flags, data);
+			err = nilfs_remount(s, &flags, data, data_size);
 			if (err)
 				goto failed_super;
 		}
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 60702d677bd4..f069eb6495b0 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -263,7 +263,8 @@ static const struct super_operations nsfs_ops = {
 	.show_path = nsfs_show_path,
 };
 static struct dentry *nsfs_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name, void *data)
+				 int flags, const char *dev_name,
+				 void *data, size_t data_size)
 {
 	return mount_pseudo(fs_type, "nsfs:", &nsfs_ops,
 			&ns_dentry_operations, NSFS_MAGIC);
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index bb7159f697f2..8501bbcceb5a 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -456,6 +456,7 @@ static inline int ntfs_clear_volume_flags(ntfs_volume *vol, VOLUME_FLAGS flags)
  * @sb:		superblock of mounted ntfs filesystem
  * @flags:	remount flags
  * @opt:	remount options string
+ * @data_size:	size of the options string
  *
  * Change the mount options of an already mounted ntfs filesystem.
  *
@@ -463,7 +464,8 @@ static inline int ntfs_clear_volume_flags(ntfs_volume *vol, VOLUME_FLAGS flags)
  * ntfs_remount() returns successfully (i.e. returns 0).  Otherwise,
  * @sb->s_flags are not changed.
  */
-static int ntfs_remount(struct super_block *sb, int *flags, char *opt)
+static int ntfs_remount(struct super_block *sb, int *flags,
+			char *opt, size_t data_size)
 {
 	ntfs_volume *vol = NTFS_SB(sb);
 
@@ -2694,6 +2696,7 @@ static const struct super_operations ntfs_sops = {
  * ntfs_fill_super - mount an ntfs filesystem
  * @sb:		super block of ntfs filesystem to mount
  * @opt:	string containing the mount options
+ * @data_size:	size of the mount options string
  * @silent:	silence error output
  *
  * ntfs_fill_super() is called by the VFS to mount the device described by @sb
@@ -2708,7 +2711,8 @@ static const struct super_operations ntfs_sops = {
  *
  * NOTE: @sb->s_flags contains the mount options flags.
  */
-static int ntfs_fill_super(struct super_block *sb, void *opt, const int silent)
+static int ntfs_fill_super(struct super_block *sb, void *opt, size_t data_size,
+			   const int silent)
 {
 	ntfs_volume *vol;
 	struct buffer_head *bh;
@@ -3060,9 +3064,10 @@ struct kmem_cache *ntfs_index_ctx_cache;
 DEFINE_MUTEX(ntfs_lock);
 
 static struct dentry *ntfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  ntfs_fill_super);
 }
 
 static struct file_system_type ntfs_fs_type = {
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 602c71f32740..642e471a6472 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -568,6 +568,7 @@ static int dlmfs_unlink(struct inode *dir,
 
 static int dlmfs_fill_super(struct super_block * sb,
 			    void * data,
+			    size_t data_size,
 			    int silent)
 {
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
@@ -617,9 +618,9 @@ static const struct inode_operations dlmfs_file_inode_operations = {
 };
 
 static struct dentry *dlmfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, data, dlmfs_fill_super);
+	return mount_nodev(fs_type, flags, data, data_size, dlmfs_fill_super);
 }
 
 static struct file_system_type dlmfs_fs_type = {
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 3415e0b09398..62237837a098 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -107,7 +107,8 @@ static int ocfs2_check_set_options(struct super_block *sb,
 static int ocfs2_show_options(struct seq_file *s, struct dentry *root);
 static void ocfs2_put_super(struct super_block *sb);
 static int ocfs2_mount_volume(struct super_block *sb);
-static int ocfs2_remount(struct super_block *sb, int *flags, char *data);
+static int ocfs2_remount(struct super_block *sb, int *flags,
+			 char *data, size_t data_size);
 static void ocfs2_dismount_volume(struct super_block *sb, int mnt_err);
 static int ocfs2_initialize_mem_caches(void);
 static void ocfs2_free_mem_caches(void);
@@ -633,7 +634,8 @@ static unsigned long long ocfs2_max_file_offset(unsigned int bbits,
 	return (((unsigned long long)bytes) << bitshift) - trim;
 }
 
-static int ocfs2_remount(struct super_block *sb, int *flags, char *data)
+static int ocfs2_remount(struct super_block *sb, int *flags,
+			 char *data, size_t data_size)
 {
 	int incompat_features;
 	int ret = 0;
@@ -999,7 +1001,8 @@ static void ocfs2_disable_quotas(struct ocfs2_super *osb)
 	}
 }
 
-static int ocfs2_fill_super(struct super_block *sb, void *data, int silent)
+static int ocfs2_fill_super(struct super_block *sb, void *data, size_t data_size,
+			    int silent)
 {
 	struct dentry *root;
 	int status, sector_size;
@@ -1236,9 +1239,10 @@ static int ocfs2_fill_super(struct super_block *sb, void *data, int silent)
 static struct dentry *ocfs2_mount(struct file_system_type *fs_type,
 			int flags,
 			const char *dev_name,
-			void *data)
+			void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ocfs2_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  ocfs2_fill_super);
 }
 
 static struct file_system_type ocfs2_fs_type = {
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index ee14af9e26f2..e5258fefcd2b 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -454,7 +454,8 @@ static int parse_options(char *options, struct omfs_sb_info *sbi)
 	return 1;
 }
 
-static int omfs_fill_super(struct super_block *sb, void *data, int silent)
+static int omfs_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	struct buffer_head *bh, *bh2;
 	struct omfs_super_block *omfs_sb;
@@ -596,9 +597,11 @@ static int omfs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *omfs_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name, void *data)
+				 int flags, const char *dev_name,
+				 void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, omfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  omfs_fill_super);
 }
 
 static struct file_system_type omfs_fs_type = {
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 2200662a9bf1..6171138c76c7 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -366,7 +366,8 @@ static struct inode *openprom_iget(struct super_block *sb, ino_t ino)
 	return inode;
 }
 
-static int openprom_remount(struct super_block *sb, int *flags, char *data)
+static int openprom_remount(struct super_block *sb, int *flags,
+			    char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_NOATIME;
@@ -380,7 +381,8 @@ static const struct super_operations openprom_sops = {
 	.remount_fs	= openprom_remount,
 };
 
-static int openprom_fill_super(struct super_block *s, void *data, int silent)
+static int openprom_fill_super(struct super_block *s,
+			       void *data, size_t data_size, int silent)
 {
 	struct inode *root_inode;
 	struct op_inode_info *oi;
@@ -415,9 +417,10 @@ static int openprom_fill_super(struct super_block *s, void *data, int silent)
 }
 
 static struct dentry *openprom_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, openprom_fill_super);
+	return mount_single(fs_type, flags, data, data_size,
+			    openprom_fill_super);
 }
 
 static struct file_system_type openprom_fs_type = {
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index c29bb0ebc6bb..411725292d37 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -319,7 +319,7 @@ extern uint64_t orangefs_features;
 struct dentry *orangefs_mount(struct file_system_type *fst,
 			   int flags,
 			   const char *devname,
-			   void *data);
+			   void *data, size_t data_size);
 
 void orangefs_kill_sb(struct super_block *sb);
 int orangefs_remount(struct orangefs_sb_info_s *);
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 3ae5fdba0225..3f082ad5f355 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -206,7 +206,8 @@ static int orangefs_statfs(struct dentry *dentry, struct kstatfs *buf)
  * Remount as initiated by VFS layer.  We just need to reparse the mount
  * options, no need to signal pvfs2-client-core about it.
  */
-static int orangefs_remount_fs(struct super_block *sb, int *flags, char *data)
+static int orangefs_remount_fs(struct super_block *sb, int *flags,
+			       char *data, size_t data_size)
 {
 	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_remount_fs: called\n");
 	return parse_mount_options(sb, data, 1);
@@ -456,7 +457,7 @@ static int orangefs_fill_sb(struct super_block *sb,
 struct dentry *orangefs_mount(struct file_system_type *fst,
 			   int flags,
 			   const char *devname,
-			   void *data)
+			   void *data, size_t data_size)
 {
 	int ret = -EINVAL;
 	struct super_block *sb = ERR_PTR(-EINVAL);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e8551c97de51..b5548c5a19be 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -379,7 +379,8 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	return 0;
 }
 
-static int ovl_remount(struct super_block *sb, int *flags, char *data)
+static int ovl_remount(struct super_block *sb, int *flags,
+		       char *data, size_t data_size)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 
@@ -1355,7 +1356,8 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 	goto out;
 }
 
-static int ovl_fill_super(struct super_block *sb, void *data, int silent)
+static int ovl_fill_super(struct super_block *sb, void *data, size_t data_size,
+			  int silent)
 {
 	struct path upperpath = { };
 	struct dentry *root_dentry;
@@ -1493,9 +1495,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *ovl_mount(struct file_system_type *fs_type, int flags,
-				const char *dev_name, void *raw_data)
+				const char *dev_name,
+				void *raw_data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, raw_data, ovl_fill_super);
+	return mount_nodev(fs_type, flags, raw_data, data_size, ovl_fill_super);
 }
 
 static struct file_system_type ovl_fs_type = {
diff --git a/fs/pipe.c b/fs/pipe.c
index 39d6f431da83..915032a76bfd 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1179,7 +1179,8 @@ static const struct super_operations pipefs_ops = {
  * d_name - pipe: will go nicely and kill the special-casing in procfs.
  */
 static struct dentry *pipefs_mount(struct file_system_type *fs_type,
-			 int flags, const char *dev_name, void *data)
+				   int flags, const char *dev_name,
+				   void *data, size_t data_size)
 {
 	return mount_pseudo(fs_type, "pipe:", &pipefs_ops,
 			&pipefs_dentry_operations, PIPEFS_MAGIC);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 2cf3b74391ca..df65431c00be 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -490,7 +490,8 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 	return inode;
 }
 
-int proc_fill_super(struct super_block *s, void *data, int silent)
+int proc_fill_super(struct super_block *s, void *data, size_t data_size,
+		    int silent)
 {
 	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
 	struct inode *root_inode;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 0f1692e63cb6..3362732fffa3 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -195,7 +195,7 @@ extern const struct inode_operations proc_pid_link_inode_operations;
 void proc_init_kmemcache(void);
 void set_proc_pid_nlink(void);
 extern struct inode *proc_get_inode(struct super_block *, struct proc_dir_entry *);
-extern int proc_fill_super(struct super_block *, void *data, int flags);
+extern int proc_fill_super(struct super_block *, void *, size_t, int);
 extern void proc_entry_rundown(struct proc_dir_entry *);
 
 /*
@@ -256,7 +256,7 @@ extern struct proc_dir_entry proc_root;
 extern int proc_parse_options(char *options, struct pid_namespace *pid);
 
 extern void proc_self_init(void);
-extern int proc_remount(struct super_block *, int *, char *);
+extern int proc_remount(struct super_block *, int *, char *, size_t);
 
 /*
  * task_[no]mmu.c
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 61b7340b357a..99ce06c4e1a2 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -78,7 +78,8 @@ int proc_parse_options(char *options, struct pid_namespace *pid)
 	return 1;
 }
 
-int proc_remount(struct super_block *sb, int *flags, char *data)
+int proc_remount(struct super_block *sb, int *flags,
+		 char *data, size_t data_size)
 {
 	struct pid_namespace *pid = sb->s_fs_info;
 
@@ -87,7 +88,8 @@ int proc_remount(struct super_block *sb, int *flags, char *data)
 }
 
 static struct dentry *proc_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+				 int flags, const char *dev_name,
+				 void *data, size_t data_size)
 {
 	struct pid_namespace *ns;
 
@@ -98,7 +100,8 @@ static struct dentry *proc_mount(struct file_system_type *fs_type,
 		ns = task_active_pid_ns(current);
 	}
 
-	return mount_ns(fs_type, flags, data, ns, ns->user_ns, proc_fill_super);
+	return mount_ns(fs_type, flags, data, data_size, ns, ns->user_ns,
+			proc_fill_super);
 }
 
 static void proc_kill_sb(struct super_block *sb)
@@ -212,7 +215,7 @@ int pid_ns_prepare_proc(struct pid_namespace *ns)
 {
 	struct vfsmount *mnt;
 
-	mnt = kern_mount_data(&proc_fs_type, ns);
+	mnt = kern_mount_data(&proc_fs_type, ns, 0);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5fcb845b9fec..793258231096 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -271,7 +271,8 @@ static int pstore_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static int pstore_remount(struct super_block *sb, int *flags, char *data)
+static int pstore_remount(struct super_block *sb, int *flags,
+			  char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	parse_options(data);
@@ -432,7 +433,8 @@ void pstore_get_records(int quiet)
 	inode_unlock(d_inode(root));
 }
 
-static int pstore_fill_super(struct super_block *sb, void *data, int silent)
+static int pstore_fill_super(struct super_block *sb,
+			     void *data, size_t data_size, int silent)
 {
 	struct inode *inode;
 
@@ -464,9 +466,9 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *pstore_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, pstore_fill_super);
+	return mount_single(fs_type, flags, data, data_size, pstore_fill_super);
 }
 
 static void pstore_kill_sb(struct super_block *sb)
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 3d46fe302fcb..be35529c8052 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -29,7 +29,8 @@ static const struct super_operations qnx4_sops;
 
 static struct inode *qnx4_alloc_inode(struct super_block *sb);
 static void qnx4_destroy_inode(struct inode *inode);
-static int qnx4_remount(struct super_block *sb, int *flags, char *data);
+static int qnx4_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size);
 static int qnx4_statfs(struct dentry *, struct kstatfs *);
 
 static const struct super_operations qnx4_sops =
@@ -40,7 +41,8 @@ static const struct super_operations qnx4_sops =
 	.remount_fs	= qnx4_remount,
 };
 
-static int qnx4_remount(struct super_block *sb, int *flags, char *data)
+static int qnx4_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size)
 {
 	struct qnx4_sb_info *qs;
 
@@ -183,7 +185,8 @@ static const char *qnx4_checkroot(struct super_block *sb,
 	return "bitmap file not found.";
 }
 
-static int qnx4_fill_super(struct super_block *s, void *data, int silent)
+static int qnx4_fill_super(struct super_block *s, void *data, size_t data_size,
+			   int silent)
 {
 	struct buffer_head *bh;
 	struct inode *root;
@@ -383,9 +386,10 @@ static void destroy_inodecache(void)
 }
 
 static struct dentry *qnx4_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, qnx4_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  qnx4_fill_super);
 }
 
 static struct file_system_type qnx4_fs_type = {
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 4aeb26bcb4d0..a415c1b5f936 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -30,7 +30,8 @@ static const struct super_operations qnx6_sops;
 static void qnx6_put_super(struct super_block *sb);
 static struct inode *qnx6_alloc_inode(struct super_block *sb);
 static void qnx6_destroy_inode(struct inode *inode);
-static int qnx6_remount(struct super_block *sb, int *flags, char *data);
+static int qnx6_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size);
 static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int qnx6_show_options(struct seq_file *seq, struct dentry *root);
 
@@ -53,7 +54,8 @@ static int qnx6_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static int qnx6_remount(struct super_block *sb, int *flags, char *data)
+static int qnx6_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_RDONLY;
@@ -294,7 +296,8 @@ static struct buffer_head *qnx6_check_first_superblock(struct super_block *s,
 static struct inode *qnx6_private_inode(struct super_block *s,
 					struct qnx6_root_node *p);
 
-static int qnx6_fill_super(struct super_block *s, void *data, int silent)
+static int qnx6_fill_super(struct super_block *s, void *data, size_t data_size,
+			   int silent)
 {
 	struct buffer_head *bh1 = NULL, *bh2 = NULL;
 	struct qnx6_super_block *sb1 = NULL, *sb2 = NULL;
@@ -643,9 +646,10 @@ static void destroy_inodecache(void)
 }
 
 static struct dentry *qnx6_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, qnx6_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  qnx6_fill_super);
 }
 
 static struct file_system_type qnx6_fs_type = {
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 11201b2d06b9..2e9b23b4a98b 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -217,7 +217,7 @@ static int ramfs_parse_options(char *data, struct ramfs_mount_opts *opts)
 	return 0;
 }
 
-int ramfs_fill_super(struct super_block *sb, void *data, int silent)
+int ramfs_fill_super(struct super_block *sb, void *data, size_t data_size, int silent)
 {
 	struct ramfs_fs_info *fsi;
 	struct inode *inode;
@@ -248,9 +248,9 @@ int ramfs_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 struct dentry *ramfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, data, ramfs_fill_super);
+	return mount_nodev(fs_type, flags, data, data_size, ramfs_fill_super);
 }
 
 static void ramfs_kill_sb(struct super_block *sb)
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 1fc934d24459..d8631cb38485 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -61,7 +61,8 @@ static int is_any_reiserfs_magic_string(struct reiserfs_super_block *rs)
 		is_reiserfs_jr(rs));
 }
 
-static int reiserfs_remount(struct super_block *s, int *flags, char *data);
+static int reiserfs_remount(struct super_block *s, int *flags,
+			    char *data, size_t data_size);
 static int reiserfs_statfs(struct dentry *dentry, struct kstatfs *buf);
 
 static int reiserfs_sync_fs(struct super_block *s, int wait)
@@ -1433,7 +1434,8 @@ static void handle_quota_files(struct super_block *s, char **qf_names,
 }
 #endif
 
-static int reiserfs_remount(struct super_block *s, int *mount_flags, char *arg)
+static int reiserfs_remount(struct super_block *s, int *mount_flags,
+			    char *arg, size_t data_size)
 {
 	struct reiserfs_super_block *rs;
 	struct reiserfs_transaction_handle th;
@@ -1898,7 +1900,8 @@ static int function2code(hashf_t func)
 	if (!(silent))				\
 		reiserfs_warning(s, id, __VA_ARGS__)
 
-static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
+static int reiserfs_fill_super(struct super_block *s, void *data, size_t data_size,
+			       int silent)
 {
 	struct inode *root_inode;
 	struct reiserfs_transaction_handle th;
@@ -2600,9 +2603,10 @@ static ssize_t reiserfs_quota_write(struct super_block *sb, int type,
 
 static struct dentry *get_super_block(struct file_system_type *fs_type,
 			   int flags, const char *dev_name,
-			   void *data)
+			   void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, reiserfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  reiserfs_fill_super);
 }
 
 static int __init init_reiserfs_fs(void)
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 8f06fd1f3d69..1c5b16ba3da7 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -448,7 +448,8 @@ static int romfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 /*
  * remounting must involve read-only
  */
-static int romfs_remount(struct super_block *sb, int *flags, char *data)
+static int romfs_remount(struct super_block *sb, int *flags,
+			 char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_RDONLY;
@@ -482,7 +483,8 @@ static __u32 romfs_checksum(const void *data, int size)
 /*
  * fill in the superblock
  */
-static int romfs_fill_super(struct super_block *sb, void *data, int silent)
+static int romfs_fill_super(struct super_block *sb, void *data, size_t data_size,
+			    int silent)
 {
 	struct romfs_super_block *rsb;
 	struct inode *root;
@@ -575,16 +577,17 @@ static int romfs_fill_super(struct super_block *sb, void *data, int silent)
  */
 static struct dentry *romfs_mount(struct file_system_type *fs_type,
 			int flags, const char *dev_name,
-			void *data)
+			void *data, size_t data_size)
 {
 	struct dentry *ret = ERR_PTR(-EINVAL);
 
 #ifdef CONFIG_ROMFS_ON_MTD
-	ret = mount_mtd(fs_type, flags, dev_name, data, romfs_fill_super);
+	ret = mount_mtd(fs_type, flags, dev_name, data, data_size,
+			romfs_fill_super);
 #endif
 #ifdef CONFIG_ROMFS_ON_BLOCK
 	if (ret == ERR_PTR(-EINVAL))
-		ret = mount_bdev(fs_type, flags, dev_name, data,
+		ret = mount_bdev(fs_type, flags, dev_name, data, data_size,
 				  romfs_fill_super);
 #endif
 	return ret;
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 8a73b97217c8..ed6881d97b3c 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -76,7 +76,8 @@ static const struct squashfs_decompressor *supported_squashfs_filesystem(short
 }
 
 
-static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
+static int squashfs_fill_super(struct super_block *sb,
+			       void *data, size_t data_size, int silent)
 {
 	struct squashfs_sb_info *msblk;
 	struct squashfs_super_block *sblk = NULL;
@@ -370,7 +371,8 @@ static int squashfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 }
 
 
-static int squashfs_remount(struct super_block *sb, int *flags, char *data)
+static int squashfs_remount(struct super_block *sb, int *flags,
+			    char *data, size_t data_size)
 {
 	sync_filesystem(sb);
 	*flags |= SB_RDONLY;
@@ -398,9 +400,11 @@ static void squashfs_put_super(struct super_block *sb)
 
 
 static struct dentry *squashfs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *data)
+				     int flags, const char *dev_name,
+				     void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, squashfs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  squashfs_fill_super);
 }
 
 
diff --git a/fs/super.c b/fs/super.c
index f7c5629bbbda..9117e3447837 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -827,11 +827,13 @@ struct super_block *user_get_super(dev_t dev)
  *	@sb:	superblock in question
  *	@sb_flags: revised superblock flags
  *	@data:	the rest of options
+ *	@data_size: The size of the data
  *      @force: whether or not to force the change
  *
  *	Alters the mount options of a mounted file system.
  */
-int do_remount_sb(struct super_block *sb, int sb_flags, void *data, int force)
+int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
+		  size_t data_size, int force)
 {
 	int retval;
 	int remount_ro;
@@ -874,7 +876,7 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data, int force)
 	}
 
 	if (sb->s_op->remount_fs) {
-		retval = sb->s_op->remount_fs(sb, &sb_flags, data);
+		retval = sb->s_op->remount_fs(sb, &sb_flags, data, data_size);
 		if (retval) {
 			if (!force)
 				goto cancel_readonly;
@@ -913,7 +915,7 @@ static void do_emergency_remount_callback(struct super_block *sb)
 		/*
 		 * What lock protects sb->s_flags??
 		 */
-		do_remount_sb(sb, SB_RDONLY, NULL, 1);
+		do_remount_sb(sb, SB_RDONLY, NULL, 0, 1);
 	}
 	up_write(&sb->s_umount);
 }
@@ -1062,8 +1064,9 @@ static int ns_set_super(struct super_block *sb, void *data)
 }
 
 struct dentry *mount_ns(struct file_system_type *fs_type,
-	int flags, void *data, void *ns, struct user_namespace *user_ns,
-	int (*fill_super)(struct super_block *, void *, int))
+	int flags, void *data, size_t data_size,
+	void *ns, struct user_namespace *user_ns,
+	int (*fill_super)(struct super_block *, void *, size_t, int))
 {
 	struct super_block *sb;
 
@@ -1080,7 +1083,7 @@ struct dentry *mount_ns(struct file_system_type *fs_type,
 
 	if (!sb->s_root) {
 		int err;
-		err = fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
+		err = fill_super(sb, data, data_size, flags & SB_SILENT ? 1 : 0);
 		if (err) {
 			deactivate_locked_super(sb);
 			return ERR_PTR(err);
@@ -1110,8 +1113,8 @@ static int test_bdev_super(struct super_block *s, void *data)
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int flags, const char *dev_name, void *data, size_t data_size,
+	int (*fill_super)(struct super_block *, void *, size_t, int))
 {
 	struct block_device *bdev;
 	struct super_block *s;
@@ -1163,7 +1166,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 		s->s_mode = mode;
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
 		sb_set_blocksize(s, block_size(bdev));
-		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
+		error = fill_super(s, data, data_size, flags & SB_SILENT ? 1 : 0);
 		if (error) {
 			deactivate_locked_super(s);
 			goto error;
@@ -1200,8 +1203,8 @@ EXPORT_SYMBOL(kill_block_super);
 #endif
 
 struct dentry *mount_nodev(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int flags, void *data, size_t data_size,
+	int (*fill_super)(struct super_block *, void *, size_t, int))
 {
 	int error;
 	struct super_block *s = sget(fs_type, NULL, set_anon_super, flags, NULL);
@@ -1209,7 +1212,7 @@ struct dentry *mount_nodev(struct file_system_type *fs_type,
 	if (IS_ERR(s))
 		return ERR_CAST(s);
 
-	error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
+	error = fill_super(s, data, data_size, flags & SB_SILENT ? 1 : 0);
 	if (error) {
 		deactivate_locked_super(s);
 		return ERR_PTR(error);
@@ -1225,8 +1228,8 @@ static int compare_single(struct super_block *s, void *p)
 }
 
 struct dentry *mount_single(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int flags, void *data, size_t data_size,
+	int (*fill_super)(struct super_block *, void *, size_t, int))
 {
 	struct super_block *s;
 	int error;
@@ -1235,21 +1238,22 @@ struct dentry *mount_single(struct file_system_type *fs_type,
 	if (IS_ERR(s))
 		return ERR_CAST(s);
 	if (!s->s_root) {
-		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
+		error = fill_super(s, data, data_size, flags & SB_SILENT ? 1 : 0);
 		if (error) {
 			deactivate_locked_super(s);
 			return ERR_PTR(error);
 		}
 		s->s_flags |= SB_ACTIVE;
 	} else {
-		do_remount_sb(s, flags, data, 0);
+		do_remount_sb(s, flags, data, data_size, 0);
 	}
 	return dget(s->s_root);
 }
 EXPORT_SYMBOL(mount_single);
 
 struct dentry *
-mount_fs(struct file_system_type *type, int flags, const char *name, void *data)
+mount_fs(struct file_system_type *type, int flags, const char *name,
+	 void *data, size_t data_size)
 {
 	struct dentry *root;
 	struct super_block *sb;
@@ -1261,12 +1265,12 @@ mount_fs(struct file_system_type *type, int flags, const char *name, void *data)
 		if (!secdata)
 			goto out;
 
-		error = security_sb_copy_data(data, secdata);
+		error = security_sb_copy_data(data, data_size, secdata);
 		if (error)
 			goto out_free_secdata;
 	}
 
-	root = type->mount(type, flags, name, data);
+	root = type->mount(type, flags, name, data, data_size);
 	if (IS_ERR(root)) {
 		error = PTR_ERR(root);
 		goto out_free_secdata;
@@ -1276,7 +1280,7 @@ mount_fs(struct file_system_type *type, int flags, const char *name, void *data)
 	WARN_ON(!sb->s_bdi);
 	sb->s_flags |= SB_BORN;
 
-	error = security_sb_kern_mount(sb, flags, secdata);
+	error = security_sb_kern_mount(sb, flags, secdata, data_size);
 	if (error)
 		goto out_sb;
 
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index b428d317ae92..b2b7d9ae4aba 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -21,7 +21,7 @@ static struct kernfs_root *sysfs_root;
 struct kernfs_node *sysfs_root_kn;
 
 static struct dentry *sysfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
 	struct dentry *root;
 	void *ns;
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index bec9f79adb25..47f66bbc4578 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -57,7 +57,8 @@ static int sysv_sync_fs(struct super_block *sb, int wait)
 	return 0;
 }
 
-static int sysv_remount(struct super_block *sb, int *flags, char *data)
+static int sysv_remount(struct super_block *sb, int *flags,
+			char *data, size_t data_size)
 {
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 
diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index 89765ddfb738..275c7038eecd 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -349,7 +349,8 @@ static int complete_read_super(struct super_block *sb, int silent, int size)
 	return 1;
 }
 
-static int sysv_fill_super(struct super_block *sb, void *data, int silent)
+static int sysv_fill_super(struct super_block *sb, void *data, size_t data_size,
+			   int silent)
 {
 	struct buffer_head *bh1, *bh = NULL;
 	struct sysv_sb_info *sbi;
@@ -470,7 +471,8 @@ static int v7_sanity_check(struct super_block *sb, struct buffer_head *bh)
 	return 1;
 }
 
-static int v7_fill_super(struct super_block *sb, void *data, int silent)
+static int v7_fill_super(struct super_block *sb, void *data, size_t data_size,
+			 int silent)
 {
 	struct sysv_sb_info *sbi;
 	struct buffer_head *bh;
@@ -528,15 +530,17 @@ static int v7_fill_super(struct super_block *sb, void *data, int silent)
 /* Every kernel module contains stuff like this. */
 
 static struct dentry *sysv_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, sysv_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  sysv_fill_super);
 }
 
 static struct dentry *v7_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, v7_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  v7_fill_super);
 }
 
 static struct file_system_type sysv_fs_type = {
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index bea8ad876bf9..85b3f230e202 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -225,7 +225,8 @@ static int tracefs_apply_options(struct super_block *sb)
 	return 0;
 }
 
-static int tracefs_remount(struct super_block *sb, int *flags, char *data)
+static int tracefs_remount(struct super_block *sb, int *flags,
+			   char *data, size_t data_size)
 {
 	int err;
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
@@ -264,7 +265,8 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
-static int trace_fill_super(struct super_block *sb, void *data, int silent)
+static int trace_fill_super(struct super_block *sb,
+			    void *data, size_t data_size, int silent)
 {
 	static const struct tree_descr trace_files[] = {{""}};
 	struct tracefs_fs_info *fsi;
@@ -299,9 +301,9 @@ static int trace_fill_super(struct super_block *sb, void *data, int silent)
 
 static struct dentry *trace_mount(struct file_system_type *fs_type,
 			int flags, const char *dev_name,
-			void *data)
+			void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, trace_fill_super);
+	return mount_single(fs_type, flags, data, data_size, trace_fill_super);
 }
 
 static struct file_system_type trace_fs_type = {
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 6c397a389105..90144fecbf27 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1842,7 +1842,8 @@ static void ubifs_put_super(struct super_block *sb)
 	mutex_unlock(&c->umount_mutex);
 }
 
-static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
+static int ubifs_remount_fs(struct super_block *sb, int *flags,
+			    char *data, size_t data_size)
 {
 	int err;
 	struct ubifs_info *c = sb->s_fs_info;
@@ -2105,7 +2106,7 @@ static int sb_set(struct super_block *sb, void *data)
 }
 
 static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
-			const char *name, void *data)
+			const char *name, void *data, size_t data_size)
 {
 	struct ubi_volume_desc *ubi;
 	struct ubifs_info *c;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 7949c338efa5..91212c33c8d7 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -87,10 +87,10 @@ enum {
 enum { UDF_MAX_LINKS = 0xffff };
 
 /* These are the "meat" - everything else is stuffing */
-static int udf_fill_super(struct super_block *, void *, int);
+static int udf_fill_super(struct super_block *, void *, size_t, int);
 static void udf_put_super(struct super_block *);
 static int udf_sync_fs(struct super_block *, int);
-static int udf_remount_fs(struct super_block *, int *, char *);
+static int udf_remount_fs(struct super_block *, int *, char *, size_t);
 static void udf_load_logicalvolint(struct super_block *, struct kernel_extent_ad);
 static int udf_find_fileset(struct super_block *, struct kernel_lb_addr *,
 			    struct kernel_lb_addr *);
@@ -126,9 +126,11 @@ struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
 
 /* UDF filesystem type */
 static struct dentry *udf_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data)
+				int flags, const char *dev_name,
+				void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, udf_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  udf_fill_super);
 }
 
 static struct file_system_type udf_fstype = {
@@ -610,7 +612,8 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 	return 1;
 }
 
-static int udf_remount_fs(struct super_block *sb, int *flags, char *options)
+static int udf_remount_fs(struct super_block *sb, int *flags,
+			  char *options, size_t data_size)
 {
 	struct udf_options uopt;
 	struct udf_sb_info *sbi = UDF_SB(sb);
@@ -2083,7 +2086,8 @@ u64 lvid_get_unique_id(struct super_block *sb)
 	return ret;
 }
 
-static int udf_fill_super(struct super_block *sb, void *options, int silent)
+static int udf_fill_super(struct super_block *sb,
+			  void *options, size_t data_size, int silent)
 {
 	int ret = -EINVAL;
 	struct inode *inode = NULL;
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 8254b8b3690f..b52917639e30 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -772,7 +772,8 @@ static u64 ufs_max_bytes(struct super_block *sb)
 	return res << uspi->s_bshift;
 }
 
-static int ufs_fill_super(struct super_block *sb, void *data, int silent)
+static int ufs_fill_super(struct super_block *sb, void *data, size_t data_size,
+			  int silent)
 {
 	struct ufs_sb_info * sbi;
 	struct ufs_sb_private_info * uspi;
@@ -1295,7 +1296,8 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	return -ENOMEM;
 }
 
-static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
+static int ufs_remount (struct super_block *sb, int *mount_flags,
+			char *data, size_t data_size)
 {
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
@@ -1503,9 +1505,10 @@ static const struct super_operations ufs_super_ops = {
 };
 
 static struct dentry *ufs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ufs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  ufs_fill_super);
 }
 
 static struct file_system_type ufs_fs_type = {
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d71424052917..0d91c924b8f5 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1268,7 +1268,8 @@ STATIC int
 xfs_fs_remount(
 	struct super_block	*sb,
 	int			*flags,
-	char			*options)
+	char			*options,
+	size_t			data_size)
 {
 	struct xfs_mount	*mp = XFS_M(sb);
 	xfs_sb_t		*sbp = &mp->m_sb;
@@ -1607,6 +1608,7 @@ STATIC int
 xfs_fs_fill_super(
 	struct super_block	*sb,
 	void			*data,
+	size_t			data_size,
 	int			silent)
 {
 	struct inode		*root;
@@ -1796,9 +1798,11 @@ xfs_fs_mount(
 	struct file_system_type	*fs_type,
 	int			flags,
 	const char		*dev_name,
-	void			*data)
+	void			*data,
+	size_t			data_size)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, xfs_fs_fill_super);
+	return mount_bdev(fs_type, flags, dev_name, data, data_size,
+			  xfs_fs_fill_super);
 }
 
 static long
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 3b0ba54cc4d5..a02de1b397ca 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -75,11 +75,11 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
 struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 				      const char *dest);
 
-typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
+typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *, size_t);
 struct dentry *debugfs_create_automount(const char *name,
 					struct dentry *parent,
 					debugfs_automount_t f,
-					void *data);
+					void *data, size_t data_size);
 
 void debugfs_remove(struct dentry *dentry);
 void debugfs_remove_recursive(struct dentry *dentry);
@@ -204,8 +204,8 @@ static inline struct dentry *debugfs_create_symlink(const char *name,
 
 static inline struct dentry *debugfs_create_automount(const char *name,
 					struct dentry *parent,
-					struct vfsmount *(*f)(void *),
-					void *data)
+					struct vfsmount *(*f)(void *, size_t),
+					void *data, size_t data_size)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..9703931cf095 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1827,7 +1827,7 @@ struct super_operations {
 	int (*thaw_super) (struct super_block *);
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
-	int (*remount_fs) (struct super_block *, int *, char *);
+	int (*remount_fs) (struct super_block *, int *, char *, size_t);
 	void (*umount_begin) (struct super_block *);
 
 	int (*show_options)(struct seq_file *, struct dentry *);
@@ -2075,7 +2075,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	struct dentry *(*mount) (struct file_system_type *, int,
-		       const char *, void *);
+				 const char *, void *, size_t);
 	void (*kill_sb) (struct super_block *);
 	struct module *owner;
 	struct file_system_type * next;
@@ -2094,26 +2094,27 @@ struct file_system_type {
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
 
 extern struct dentry *mount_ns(struct file_system_type *fs_type,
-	int flags, void *data, void *ns, struct user_namespace *user_ns,
-	int (*fill_super)(struct super_block *, void *, int));
+	int flags, void *data, size_t data_size,
+	void *ns, struct user_namespace *user_ns,
+	int (*fill_super)(struct super_block *, void *, size_t, int));
 #ifdef CONFIG_BLOCK
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
+	int flags, const char *dev_name, void *data, size_t data_size,
+	int (*fill_super)(struct super_block *, void *, size_t, int));
 #else
 static inline struct dentry *mount_bdev(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
+	int flags, const char *dev_name, void *data, size_t data_size,
+	int (*fill_super)(struct super_block *, void *, size_t, int))
 {
 	return ERR_PTR(-ENODEV);
 }
 #endif
 extern struct dentry *mount_single(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
+	int flags, void *data, size_t data_size,
+	int (*fill_super)(struct super_block *, void *, size_t, int));
 extern struct dentry *mount_nodev(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
+	int flags, void *data, size_t data_size,
+	int (*fill_super)(struct super_block *, void *, size_t, int));
 extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
 void generic_shutdown_super(struct super_block *sb);
 #ifdef CONFIG_BLOCK
@@ -2173,8 +2174,8 @@ mount_pseudo(struct file_system_type *fs_type, char *name,
 
 extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
-extern struct vfsmount *kern_mount_data(struct file_system_type *, void *data);
-#define kern_mount(type) kern_mount_data(type, NULL)
+extern struct vfsmount *kern_mount_data(struct file_system_type *, void *, size_t);
+#define kern_mount(type) kern_mount_data(type, NULL, 0)
 extern void kern_unmount(struct vfsmount *mnt);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index da20f90d40bb..d533ca038604 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -148,6 +148,7 @@
  *	@type contains the filesystem type.
  *	@flags contains the mount flags.
  *	@data contains the filesystem-specific data.
+ *	@data_size contains the size of the data.
  *	Return 0 if permission is granted.
  * @sb_copy_data:
  *	Allow mount option data to be copied prior to parsing by the filesystem,
@@ -157,6 +158,7 @@
  *	specific options to avoid having to make filesystems aware of them.
  *	@type the type of filesystem being mounted.
  *	@orig the original mount data copied from userspace.
+ *	@orig_data is the size of the original data
  *	@copy copied data which will be passed to the security module.
  *	Returns 0 if the copy was successful.
  * @sb_remount:
@@ -164,6 +166,7 @@
  *	are being made to those options.
  *	@sb superblock being remounted
  *	@data contains the filesystem-specific data.
+ *	@data_size contains the size of the data.
  *	Return 0 if permission is granted.
  * @sb_umount:
  *	Check permission before the @mnt file system is unmounted.
@@ -1506,13 +1509,15 @@ union security_list_options {
 
 	int (*sb_alloc_security)(struct super_block *sb);
 	void (*sb_free_security)(struct super_block *sb);
-	int (*sb_copy_data)(char *orig, char *copy);
-	int (*sb_remount)(struct super_block *sb, void *data);
-	int (*sb_kern_mount)(struct super_block *sb, int flags, void *data);
+	int (*sb_copy_data)(char *orig, size_t orig_size, char *copy);
+	int (*sb_remount)(struct super_block *sb, void *data, size_t data_size);
+	int (*sb_kern_mount)(struct super_block *sb, int flags,
+			     void *data, size_t data_size);
 	int (*sb_show_options)(struct seq_file *m, struct super_block *sb);
 	int (*sb_statfs)(struct dentry *dentry);
 	int (*sb_mount)(const char *dev_name, const struct path *path,
-			const char *type, unsigned long flags, void *data);
+			const char *type, unsigned long flags,
+			void *data, size_t data_size);
 	int (*sb_umount)(struct vfsmount *mnt, int flags);
 	int (*sb_pivotroot)(const struct path *old_path, const struct path *new_path);
 	int (*sb_set_mnt_opts)(struct super_block *sb,
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 45b1f56c6c2f..8a1031a511c9 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -90,10 +90,11 @@ extern struct vfsmount *clone_private_mount(const struct path *path);
 struct file_system_type;
 extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				      int flags, const char *name,
-				      void *data);
+				      void *data, size_t data_size);
 extern struct vfsmount *vfs_submount(const struct dentry *mountpoint,
 				     struct file_system_type *type,
-				     const char *name, void *data);
+				     const char *name,
+				     void *data, size_t data_size);
 
 extern void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list);
 extern void mark_mounts_for_expiry(struct list_head *mounts);
diff --git a/include/linux/mtd/super.h b/include/linux/mtd/super.h
index f456230f9330..3f37c7cd711c 100644
--- a/include/linux/mtd/super.h
+++ b/include/linux/mtd/super.h
@@ -19,8 +19,8 @@
 #include <linux/mount.h>
 
 extern struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
-		      const char *dev_name, void *data,
-		      int (*fill_super)(struct super_block *, void *, int));
+		      const char *dev_name, void *data, size_t data_size,
+		      int (*fill_super)(struct super_block *, void *, size_t, int));
 extern void kill_mtd_super(struct super_block *sb);
 
 
diff --git a/include/linux/ramfs.h b/include/linux/ramfs.h
index 5ef7d54caac2..6d64e6be9928 100644
--- a/include/linux/ramfs.h
+++ b/include/linux/ramfs.h
@@ -5,7 +5,7 @@
 struct inode *ramfs_get_inode(struct super_block *sb, const struct inode *dir,
 	 umode_t mode, dev_t dev);
 extern struct dentry *ramfs_mount(struct file_system_type *fs_type,
-	 int flags, const char *dev_name, void *data);
+	 int flags, const char *dev_name, void *data, size_t data_size);
 
 #ifdef CONFIG_MMU
 static inline int
@@ -21,6 +21,6 @@ extern const struct file_operations ramfs_file_operations;
 extern const struct vm_operations_struct generic_file_vm_ops;
 extern int __init init_ramfs_fs(void);
 
-int ramfs_fill_super(struct super_block *sb, void *data, int silent);
+int ramfs_fill_super(struct super_block *sb, void *data, size_t data_size, int silent);
 
 #endif
diff --git a/include/linux/security.h b/include/linux/security.h
index 60a85bd9dfef..22b83dc28bd3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -243,13 +243,13 @@ int security_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
 			   unsigned int mnt_flags);
 int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
-int security_sb_copy_data(char *orig, char *copy);
-int security_sb_remount(struct super_block *sb, void *data);
-int security_sb_kern_mount(struct super_block *sb, int flags, void *data);
+int security_sb_copy_data(char *orig, size_t orig_size, char *copy);
+int security_sb_remount(struct super_block *sb, void *data, size_t data_size);
+int security_sb_kern_mount(struct super_block *sb, int flags, void *data, size_t data_size);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(const char *dev_name, const struct path *path,
-		      const char *type, unsigned long flags, void *data);
+		      const char *type, unsigned long flags, void *data, size_t data_size);
 int security_sb_umount(struct vfsmount *mnt, int flags);
 int security_sb_pivotroot(const struct path *old_path, const struct path *new_path);
 int security_sb_set_mnt_opts(struct super_block *sb,
@@ -591,17 +591,18 @@ static inline int security_sb_alloc(struct super_block *sb)
 static inline void security_sb_free(struct super_block *sb)
 { }
 
-static inline int security_sb_copy_data(char *orig, char *copy)
+static inline int security_sb_copy_data(char *orig, size_t orig_size, char *copy)
 {
 	return 0;
 }
 
-static inline int security_sb_remount(struct super_block *sb, void *data)
+static inline int security_sb_remount(struct super_block *sb, void *data, size_t data_size)
 {
 	return 0;
 }
 
-static inline int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
+static inline int security_sb_kern_mount(struct super_block *sb, int flags,
+					 void *data, size_t data_size)
 {
 	return 0;
 }
@@ -619,7 +620,7 @@ static inline int security_sb_statfs(struct dentry *dentry)
 
 static inline int security_sb_mount(const char *dev_name, const struct path *path,
 				    const char *type, unsigned long flags,
-				    void *data)
+				    void *data, size_t data_size)
 {
 	return 0;
 }
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 73b5e655a76e..f170fc673047 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -49,7 +49,8 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
  * Functions in mm/shmem.c called directly from elsewhere:
  */
 extern int shmem_init(void);
-extern int shmem_fill_super(struct super_block *sb, void *data, int silent);
+extern int shmem_fill_super(struct super_block *sb, void *data, size_t data_size,
+			    int silent);
 extern struct file *shmem_file_setup(const char *name,
 					loff_t size, unsigned long flags);
 extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
diff --git a/init/do_mounts.c b/init/do_mounts.c
index ea6f21bb9440..d4fc2a5afdb6 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -606,7 +606,7 @@ void __init prepare_namespace(void)
 
 static bool is_tmpfs;
 static struct dentry *rootfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
 	static unsigned long once;
 	void *fill = ramfs_fill_super;
@@ -617,7 +617,7 @@ static struct dentry *rootfs_mount(struct file_system_type *fs_type,
 	if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
 		fill = shmem_fill_super;
 
-	return mount_nodev(fs_type, flags, data, fill);
+	return mount_nodev(fs_type, flags, data, data_size, fill);
 }
 
 static struct file_system_type rootfs_fs_type = {
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a808f29d4c5a..910c3c7532e6 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -322,7 +322,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 	return ERR_PTR(ret);
 }
 
-static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
+static int mqueue_fill_super(struct super_block *sb, void *data, size_t data_size, int silent)
 {
 	struct inode *inode;
 	struct ipc_namespace *ns = sb->s_fs_info;
@@ -345,7 +345,7 @@ static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
 
 static struct dentry *mqueue_mount(struct file_system_type *fs_type,
 			 int flags, const char *dev_name,
-			 void *data)
+			 void *data, size_t data_size)
 {
 	struct ipc_namespace *ns;
 	if (flags & SB_KERNMOUNT) {
@@ -354,7 +354,8 @@ static struct dentry *mqueue_mount(struct file_system_type *fs_type,
 	} else {
 		ns = current->nsproxy->ipc_ns;
 	}
-	return mount_ns(fs_type, flags, data, ns, ns->user_ns, mqueue_fill_super);
+	return mount_ns(fs_type, flags, data, data_size, ns, ns->user_ns,
+			mqueue_fill_super);
 }
 
 static void init_once(void *foo)
@@ -1536,7 +1537,7 @@ int mq_init_ns(struct ipc_namespace *ns)
 	ns->mq_msg_default   = DFLT_MSG;
 	ns->mq_msgsize_default  = DFLT_MSGSIZE;
 
-	ns->mq_mnt = kern_mount_data(&mqueue_fs_type, ns);
+	ns->mq_mnt = kern_mount_data(&mqueue_fs_type, ns, 0);
 	if (IS_ERR(ns->mq_mnt)) {
 		int err = PTR_ERR(ns->mq_mnt);
 		ns->mq_mnt = NULL;
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index bf6da59ae0d0..d663a1efcfcc 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -480,7 +480,7 @@ static int bpf_parse_options(char *data, struct bpf_mount_opts *opts)
 	return 0;
 }
 
-static int bpf_fill_super(struct super_block *sb, void *data, int silent)
+static int bpf_fill_super(struct super_block *sb, void *data, size_t data_size, int silent)
 {
 	static const struct tree_descr bpf_rfiles[] = { { "" } };
 	struct bpf_mount_opts opts;
@@ -506,9 +506,10 @@ static int bpf_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *bpf_mount(struct file_system_type *type, int flags,
-				const char *dev_name, void *data)
+				const char *dev_name, void *data,
+				size_t data_size)
 {
-	return mount_nodev(type, flags, data, bpf_fill_super);
+	return mount_nodev(type, flags, data, data_size, bpf_fill_super);
 }
 
 static struct file_system_type bpf_fs_type = {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a662bfcbea0e..c2678e4800fc 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2010,7 +2010,7 @@ struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
 
 static struct dentry *cgroup_mount(struct file_system_type *fs_type,
 			 int flags, const char *unused_dev_name,
-			 void *data)
+			 void *data, size_t data_size)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct dentry *dentry;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b42037e6e81d..3c8ef37879f0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -316,7 +316,8 @@ static inline bool is_in_v2_mode(void)
  * silently switch it to mount "cgroup" instead
  */
 static struct dentry *cpuset_mount(struct file_system_type *fs_type,
-			 int flags, const char *unused_dev_name, void *data)
+				   int flags, const char *unused_dev_name,
+				   void *data, size_t data_size)
 {
 	struct file_system_type *cgroup_fs = get_fs_type("cgroup");
 	struct dentry *ret = ERR_PTR(-ENODEV);
@@ -324,8 +325,8 @@ static struct dentry *cpuset_mount(struct file_system_type *fs_type,
 		char mountopts[] =
 			"cpuset,noprefix,"
 			"release_agent=/sbin/cpuset_release_agent";
-		ret = cgroup_fs->mount(cgroup_fs, flags,
-					   unused_dev_name, mountopts);
+		ret = cgroup_fs->mount(cgroup_fs, flags, unused_dev_name,
+				       mountopts, data_size);
 		put_filesystem(cgroup_fs);
 	}
 	return ret;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dfbcf9ee1447..ed301a4235e6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7961,7 +7961,8 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	ftrace_init_tracefs(tr, d_tracer);
 }
 
-static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
+static struct vfsmount *trace_automount(struct dentry *mntpt,
+					void *data, size_t data_size)
 {
 	struct vfsmount *mnt;
 	struct file_system_type *type;
@@ -7974,7 +7975,7 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	type = get_fs_type("tracefs");
 	if (!type)
 		return NULL;
-	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
+	mnt = vfs_submount(mntpt, type, "tracefs", NULL, 0);
 	put_filesystem(type);
 	if (IS_ERR(mnt))
 		return NULL;
@@ -8010,7 +8011,7 @@ struct dentry *tracing_init_dentry(void)
 	 * work with the newer kerenl.
 	 */
 	tr->dir = debugfs_create_automount("tracing", NULL,
-					   trace_automount, NULL);
+					   trace_automount, NULL, 0);
 	if (!tr->dir) {
 		pr_warn_once("Could not create debugfs directory 'tracing'\n");
 		return ERR_PTR(-ENOMEM);
diff --git a/mm/shmem.c b/mm/shmem.c
index 9d6c7e595415..76838f26822f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3602,7 +3602,8 @@ static int shmem_parse_options(char *options, struct shmem_sb_info *sbinfo,
 
 }
 
-static int shmem_remount_fs(struct super_block *sb, int *flags, char *data)
+static int shmem_remount_fs(struct super_block *sb, int *flags,
+			    char *data, size_t data_size)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	struct shmem_sb_info config = *sbinfo;
@@ -3772,7 +3773,8 @@ static void shmem_put_super(struct super_block *sb)
 	sb->s_fs_info = NULL;
 }
 
-int shmem_fill_super(struct super_block *sb, void *data, int silent)
+int shmem_fill_super(struct super_block *sb, void *data, size_t data_size,
+		     int silent)
 {
 	struct inode *inode;
 	struct shmem_sb_info *sbinfo;
@@ -3986,9 +3988,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
 };
 
 static struct dentry *shmem_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+	int flags, const char *dev_name, void *data, size_t data_size)
 {
-	return mount_nodev(fs_type, flags, data, shmem_fill_super);
+	return mount_nodev(fs_type, flags, data, data_size, shmem_fill_super);
 }
 
 static struct file_system_type shmem_fs_type = {
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 61cb05dc950c..dc60f6d89f31 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1814,7 +1814,8 @@ static enum fullness_group putback_zspage(struct size_class *class,
 
 #ifdef CONFIG_COMPACTION
 static struct dentry *zs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *data)
+			       int flags, const char *dev_name,
+			       void *data, size_t data_size)
 {
 	static const struct dentry_operations ops = {
 		.d_dname = simple_dname,
diff --git a/net/socket.c b/net/socket.c
index f10f1d947c78..34d3dd0f8ba3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -353,7 +353,8 @@ static const struct xattr_handler *sockfs_xattr_handlers[] = {
 };
 
 static struct dentry *sockfs_mount(struct file_system_type *fs_type,
-			 int flags, const char *dev_name, void *data)
+				   int flags, const char *dev_name,
+				   void *data, size_t data_size)
 {
 	return mount_pseudo_xattr(fs_type, "socket:", &sockfs_ops,
 				  sockfs_xattr_handlers,
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 0f08934b2cea..7ae4237e3ddd 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1382,7 +1382,7 @@ rpc_gssd_dummy_depopulate(struct dentry *pipe_dentry)
 }
 
 static int
-rpc_fill_super(struct super_block *sb, void *data, int silent)
+rpc_fill_super(struct super_block *sb, void *data, size_t data_size, int silent)
 {
 	struct inode *inode;
 	struct dentry *root, *gssd_dentry;
@@ -1445,10 +1445,11 @@ EXPORT_SYMBOL_GPL(gssd_running);
 
 static struct dentry *
 rpc_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *data)
+	  int flags, const char *dev_name, void *data, size_t data_size)
 {
 	struct net *net = current->nsproxy->net_ns;
-	return mount_ns(fs_type, flags, data, net, net->user_ns, rpc_fill_super);
+	return mount_ns(fs_type, flags, data, data_size,
+			net, net->user_ns, rpc_fill_super);
 }
 
 static void rpc_kill_sb(struct super_block *sb)
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 949dd8a48164..04548c8102f3 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -137,7 +137,8 @@ static const struct super_operations aafs_super_ops = {
 	.show_path = aafs_show_path,
 };
 
-static int fill_super(struct super_block *sb, void *data, int silent)
+static int fill_super(struct super_block *sb, void *data, size_t data_size,
+		      int silent)
 {
 	static struct tree_descr files[] = { {""} };
 	int error;
@@ -151,9 +152,10 @@ static int fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *aafs_mount(struct file_system_type *fs_type,
-				 int flags, const char *dev_name, void *data)
+				 int flags, const char *dev_name, void *data,
+				 size_t data_size)
 {
-	return mount_single(fs_type, flags, data, fill_super);
+	return mount_single(fs_type, flags, data, data_size, fill_super);
 }
 
 static struct file_system_type aafs_ops = {
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 14398dec2e38..d60c3b9c6a07 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -591,7 +591,8 @@ static int apparmor_sb_mountpoint(struct fs_context *fc, struct path *mountpoint
 }
 
 static int apparmor_sb_mount(const char *dev_name, const struct path *path,
-			     const char *type, unsigned long flags, void *data)
+			     const char *type, unsigned long flags,
+			     void *data, size_t data_size)
 {
 	struct aa_label *label;
 	int error = 0;
diff --git a/security/inode.c b/security/inode.c
index 8dd9ca8848e4..a89a00714f33 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -39,7 +39,8 @@ static const struct super_operations securityfs_super_operations = {
 	.evict_inode	= securityfs_evict_inode,
 };
 
-static int fill_super(struct super_block *sb, void *data, int silent)
+static int fill_super(struct super_block *sb, void *data, size_t data_size,
+		      int silent)
 {
 	static const struct tree_descr files[] = {{""}};
 	int error;
@@ -55,9 +56,9 @@ static int fill_super(struct super_block *sb, void *data, int silent)
 
 static struct dentry *get_sb(struct file_system_type *fs_type,
 		  int flags, const char *dev_name,
-		  void *data)
+		  void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, fill_super);
+	return mount_single(fs_type, flags, data, data_size, fill_super);
 }
 
 static struct file_system_type fs_type = {
diff --git a/security/security.c b/security/security.c
index 42e4ea19b61c..35abdc964724 100644
--- a/security/security.c
+++ b/security/security.c
@@ -409,20 +409,20 @@ void security_sb_free(struct super_block *sb)
 	call_void_hook(sb_free_security, sb);
 }
 
-int security_sb_copy_data(char *orig, char *copy)
+int security_sb_copy_data(char *orig, size_t data_size, char *copy)
 {
-	return call_int_hook(sb_copy_data, 0, orig, copy);
+	return call_int_hook(sb_copy_data, 0, orig, data_size, copy);
 }
 EXPORT_SYMBOL(security_sb_copy_data);
 
-int security_sb_remount(struct super_block *sb, void *data)
+int security_sb_remount(struct super_block *sb, void *data, size_t data_size)
 {
-	return call_int_hook(sb_remount, 0, sb, data);
+	return call_int_hook(sb_remount, 0, sb, data, data_size);
 }
 
-int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
+int security_sb_kern_mount(struct super_block *sb, int flags, void *data, size_t data_size)
 {
-	return call_int_hook(sb_kern_mount, 0, sb, flags, data);
+	return call_int_hook(sb_kern_mount, 0, sb, flags, data, data_size);
 }
 
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
@@ -436,9 +436,11 @@ int security_sb_statfs(struct dentry *dentry)
 }
 
 int security_sb_mount(const char *dev_name, const struct path *path,
-                       const char *type, unsigned long flags, void *data)
+		      const char *type, unsigned long flags,
+		      void *data, size_t data_size)
 {
-	return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
+	return call_int_hook(sb_mount, 0, dev_name, path, type, flags,
+			     data, data_size);
 }
 
 int security_sb_umount(struct vfsmount *mnt, int flags)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 969a2a0dc582..46d31858eaba 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2782,7 +2782,7 @@ static inline void take_selinux_option(char **to, char *from, int *first,
 	}
 }
 
-static int selinux_sb_copy_data(char *orig, char *copy)
+static int selinux_sb_copy_data(char *orig, size_t data_size, char *copy)
 {
 	int fnosec, fsec, rc = 0;
 	char *in_save, *in_curr, *in_end;
@@ -2824,7 +2824,7 @@ static int selinux_sb_copy_data(char *orig, char *copy)
 	return rc;
 }
 
-static int selinux_sb_remount(struct super_block *sb, void *data)
+static int selinux_sb_remount(struct super_block *sb, void *data, size_t data_size)
 {
 	int rc, i, *flags;
 	struct security_mnt_opts opts;
@@ -2844,7 +2844,7 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 	secdata = alloc_secdata();
 	if (!secdata)
 		return -ENOMEM;
-	rc = selinux_sb_copy_data(data, secdata);
+	rc = selinux_sb_copy_data(data, data_size, secdata);
 	if (rc)
 		goto out_free_secdata;
 
@@ -2909,7 +2909,7 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 	goto out_free_opts;
 }
 
-static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
+static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data, size_t data_size)
 {
 	const struct cred *cred = current_cred();
 	struct common_audit_data ad;
@@ -2942,7 +2942,8 @@ static int selinux_mount(const char *dev_name,
 			 const struct path *path,
 			 const char *type,
 			 unsigned long flags,
-			 void *data)
+			 void *data,
+			 size_t data_size)
 {
 	const struct cred *cred = current_cred();
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 245160373dab..87c07ff2ae7e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1884,7 +1884,8 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 
 #define NULL_FILE_NAME "null"
 
-static int sel_fill_super(struct super_block *sb, void *data, int silent)
+static int sel_fill_super(struct super_block *sb, void *data, size_t data_size,
+			  int silent)
 {
 	struct selinux_fs_info *fsi;
 	int ret;
@@ -1999,9 +2000,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 }
 
 static struct dentry *sel_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data)
+				int flags, const char *dev_name,
+				void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, sel_fill_super);
+	return mount_single(fs_type, flags, data, data_size, sel_fill_super);
 }
 
 static void sel_kill_sb(struct super_block *sb)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 549aaa46353b..5dc31a940961 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -869,6 +869,7 @@ static void smack_sb_free_security(struct super_block *sb)
 /**
  * smack_sb_copy_data - copy mount options data for processing
  * @orig: where to start
+ * @orig_size: Size of orig buffer
  * @smackopts: mount options string
  *
  * Returns 0 on success or -ENOMEM on error.
@@ -876,7 +877,7 @@ static void smack_sb_free_security(struct super_block *sb)
  * Copy the Smack specific mount options out of the mount
  * options list.
  */
-static int smack_sb_copy_data(char *orig, char *smackopts)
+static int smack_sb_copy_data(char *orig, size_t orig_size, char *smackopts)
 {
 	char *cp, *commap, *otheropts, *dp;
 
@@ -1157,7 +1158,8 @@ static int smack_set_mnt_opts(struct super_block *sb,
  *
  * Returns 0 on success, an error code on failure
  */
-static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
+static int smack_sb_kern_mount(struct super_block *sb, int flags,
+			       void *data, size_t data_size)
 {
 	int rc = 0;
 	char *options = data;
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f6482e53d55a..f4e91c5d6c2c 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2844,13 +2844,15 @@ static const struct file_operations smk_ptrace_ops = {
  * smk_fill_super - fill the smackfs superblock
  * @sb: the empty superblock
  * @data: unused
+ * @data_size: size of data buffer
  * @silent: unused
  *
  * Fill in the well known entries for the smack filesystem
  *
  * Returns 0 on success, an error code on failure
  */
-static int smk_fill_super(struct super_block *sb, void *data, int silent)
+static int smk_fill_super(struct super_block *sb, void *data, size_t data_size,
+			  int silent)
 {
 	int rc;
 	struct inode *root_inode;
@@ -2934,9 +2936,10 @@ static int smk_fill_super(struct super_block *sb, void *data, int silent)
  * Returns what the lower level code does.
  */
 static struct dentry *smk_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data)
+				int flags, const char *dev_name,
+				void *data, size_t data_size)
 {
-	return mount_single(fs_type, flags, data, smk_fill_super);
+	return mount_single(fs_type, flags, data, data_size, smk_fill_super);
 }
 
 static struct file_system_type smk_fs_type = {
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 31fd6bd4f657..c3a0ae4fa7ce 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -413,11 +413,13 @@ static int tomoyo_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
  * @type:     Name of filesystem type. Maybe NULL.
  * @flags:    Mount options.
  * @data:     Optional data. Maybe NULL.
+ * @data_size: Size of data.
  *
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_sb_mount(const char *dev_name, const struct path *path,
-			   const char *type, unsigned long flags, void *data)
+			   const char *type, unsigned long flags,
+			   void *data, size_t data_size)
 {
 	return tomoyo_mount_permission(dev_name, path, type, flags, data);
 }
