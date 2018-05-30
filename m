Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeE3Lhu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:37:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60778 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752230AbeE3LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:01 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>,
        "Al Viro" <viro@ZenIV.linux.org.uk>,
        "Al Viro" <viro@ZenIV.linux.org.uk>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.786114198@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 130/153] fs: Teach path_connected to handle nfs
 filesystems with multiple roots.
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 95dd77580ccd66a0da96e6d4696945b8cea39431 upstream.

On nfsv2 and nfsv3 the nfs server can export subsets of the same
filesystem and report the same filesystem identifier, so that the nfs
client can know they are the same filesystem.  The subsets can be from
disjoint directory trees.  The nfsv2 and nfsv3 filesystems provides no
way to find the common root of all directory trees exported form the
server with the same filesystem identifier.

The practical result is that in struct super s_root for nfs s_root is
not necessarily the root of the filesystem.  The nfs mount code sets
s_root to the root of the first subset of the nfs filesystem that the
kernel mounts.

This effects the dcache invalidation code in generic_shutdown_super
currently called shrunk_dcache_for_umount and that code for years
has gone through an additional list of dentries that might be dentry
trees that need to be freed to accomodate nfs.

When I wrote path_connected I did not realize nfs was so special, and
it's hueristic for avoiding calling is_subdir can fail.

The practical case where this fails is when there is a move of a
directory from the subtree exposed by one nfs mount to the subtree
exposed by another nfs mount.  This move can happen either locally or
remotely.  With the remote case requiring that the move directory be cached
before the move and that after the move someone walks the path
to where the move directory now exists and in so doing causes the
already cached directory to be moved in the dcache through the magic
of d_splice_alias.

If someone whose working directory is in the move directory or a
subdirectory and now starts calling .. from the initial mount of nfs
(where s_root == mnt_root), then path_connected as a heuristic will
not bother with the is_subdir check.  As s_root really is not the root
of the nfs filesystem this heuristic is wrong, and the path may
actually not be connected and path_connected can fail.

The is_subdir function might be cheap enough that we can call it
unconditionally.  Verifying that will take some benchmarking and
the result may not be the same on all kernels this fix needs
to be backported to.  So I am avoiding that for now.

Filesystems with snapshots such as nilfs and btrfs do something
similar.  But as the directory tree of the snapshots are disjoint
from one another and from the main directory tree rename won't move
things between them and this problem will not occur.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Fixes: 397d425dc26d ("vfs: Test for and handle paths that are unreachable from their mnt_root")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[bwh: Backported to 3.2:
 - Add the super_block::s_iflags field
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -408,9 +408,10 @@ EXPORT_SYMBOL(path_put);
 static bool path_connected(const struct path *path)
 {
 	struct vfsmount *mnt = path->mnt;
+	struct super_block *sb = mnt->mnt_sb;
 
-	/* Only bind mounts can have disconnected paths */
-	if (mnt->mnt_root == mnt->mnt_sb->s_root)
+	/* Bind mounts and multi-root filesystems can have disconnected paths */
+	if (!(sb->s_iflags & SB_I_MULTIROOT) && (mnt->mnt_root == sb->s_root))
 		return true;
 
 	return is_subdir(path->dentry, mnt->mnt_root);
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2288,6 +2288,8 @@ static struct dentry *nfs_fs_mount(struc
 		/* initial superblock/root creation */
 		nfs_fill_super(s, data);
 		nfs_fscache_get_super_cookie(s, data->fscache_uniq, NULL);
+		if (!(server->flags & NFS_MOUNT_UNSHARED))
+			s->s_iflags |= SB_I_MULTIROOT;
 	}
 
 	mntroot = nfs_get_root(s, mntfh, dev_name);
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1416,6 +1416,9 @@ extern int send_sigurg(struct fown_struc
 #define UMOUNT_NOFOLLOW	0x00000008	/* Don't follow symlink on umount */
 #define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
 
+/* sb->s_iflags */
+#define SB_I_MULTIROOT	0x00000008	/* Multiple roots to the dentry tree */
+
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
 
@@ -1432,6 +1435,7 @@ struct super_block {
 	const struct quotactl_ops	*s_qcop;
 	const struct export_operations *s_export_op;
 	unsigned long		s_flags;
+	unsigned long		s_iflags;	/* internal SB_I_* flags */
 	unsigned long		s_magic;
 	struct dentry		*s_root;
 	struct rw_semaphore	s_umount;
