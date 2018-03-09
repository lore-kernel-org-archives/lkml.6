Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeCIK6D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:58:03 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34154 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeCIK6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:58:02 -0500
X-Google-Smtp-Source: AG47ELuaHMGhf5rOzknnrXqjY8GCaLjRx2ja/H4dyT4UEOTH+txPZpZdedifWFWZKeBcPhO/XyZzqQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v1] devpts: resolve devpts bind-mounts
Date: Fri,  9 Mar 2018 11:57:52 +0100
Message-Id: <20180309105752.24017-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most libcs will still look at /dev/ptmx when opening the master fd of a pty
device. When /dev/ptmx is a bind-mount of /dev/pts/ptmx and the TIOCGPTPEER
ioctl() is used to safely retrieve a file descriptor for the slave side of
the pty based on the master fd, the /proc/self/fd/{0,1,2} symlinks will
point to /.

When the kernel tries to look up the root mount of the dentry for the slave
file descriptor it will detect that the dentry is escaping its bind-mount
since the root mount of the dentry is /dev/pts where the devpts is mounted
but the root mount of /dev/ptmx is /dev.

Having bind-mounts of /dev/pts/ptmx to /dev/ptmx not working correctly is a
regression. In addition, it is also a fairly common scenario in containers
employing user namespaces.

To handle bind-mounts of /dev/pts/ptmx to /dev/ptmx correctly we need to
walk up the bind-mounts for /dev/ptmx in devpts_mntget(). This also means
we need to remove the
"if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)" check from
devpts_ptmx_path(). However, devpts_acquire() needs to perform that check.
The reason is that while the devpts mounted at /dev/pts has devtmpfs
mounted at /dev as its parent mount:

21 -- -- / /dev
-- 21 -- / /dev/pts

they are on different devices

-- -- 0:6  / /dev
-- -- 0:20 / /dev/pts

which has the consequence that the pathname of the directory which forms
the root of the /dev/pts mount is /. So if we bind-mount /dev/pts/ptmx to
/dev/ptmx we will end up on the same device as the devtmpfs mount on
/dev/pts

-- -- 0:20 /ptmx /dev/ptmx

but given that / is the pathname of the directory which forms the root of
the /dev/pts bind-mount, the resulting source will be /ptmx. So in
devpts_acquire() we need to check if
"(path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)" and exit early before
we try to call path_pts(). If we call path_pts() in the bind-mount case we
will hit path_parent_directory() which will **not** yield /dev as parent
directory but rather / and fail. We should still perform the path_pts()
check in devpts_acquire() if we haven't found a suitable devpts filesystem
at open time but we should always try to exit early in devpts_acquire() and
defer the bind-mount resolution to devpts_mntget(). If we fail in
devpts_mntget() we will end up with a wrong /proc/<pid>/fd/{0,1,2} symlink,
if we fail in devpts_acquire() we will end up with a failed
open("/dev/ptmx") which is more troublesome.

Here's a little reproducer that presupposes a libc that uses TIOCGPTPEER in
its openpty() implementation:

unshare --mount
mount --bind /dev/pts/ptmx /dev/ptmx
chmod 666 /dev/ptmx
script
ls -al /proc/self/fd/0

with output:

lrwx------ 1 chb chb 64 Mar  7 16:41 /proc/self/fd/0 -> /

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
---
ChangeLog v0->v1:
- remove
        /* Has the devpts filesystem already been found? */
        if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
	                return 0
  from devpts_ptmx_path()
- check superblock after devpts_ptmx_path() returned
---
 fs/devpts/inode.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index e31d6ed3ec32..89ee17733087 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -138,10 +138,6 @@ static int devpts_ptmx_path(struct path *path)
 	struct super_block *sb;
 	int err;
 
-	/* Has the devpts filesystem already been found? */
-	if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
-		return 0;
-
 	/* Is a devpts filesystem at "pts" in the same directory? */
 	err = path_pts(path);
 	if (err)
@@ -163,6 +159,26 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 
 	path = filp->f_path;
 	path_get(&path);
+	if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
+	    (path.mnt->mnt_root == fsi->ptmx_dentry)) {
+		/* Walk upward while the start point is a bind mount of a single
+		 * file.
+		 */
+		while (path.mnt->mnt_root == path.dentry)
+			if (follow_up(&path) == 0)
+				break;
+
+		/* Is this path a valid devpts filesystem? */
+		err = devpts_ptmx_path(&path);
+		dput(path.dentry);
+		if (err == 0)
+			goto check_devpts_sb;
+
+		path_put(&path);
+		path = filp->f_path;
+		path_get(&path);
+		goto check_devpts_sb;
+	}
 
 	err = devpts_ptmx_path(&path);
 	dput(path.dentry);
@@ -170,10 +186,13 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 		mntput(path.mnt);
 		return ERR_PTR(err);
 	}
+
+check_devpts_sb:
 	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
 		mntput(path.mnt);
 		return ERR_PTR(-ENODEV);
 	}
+
 	return path.mnt;
 }
 
@@ -187,10 +206,16 @@ struct pts_fs_info *devpts_acquire(struct file *filp)
 	path = filp->f_path;
 	path_get(&path);
 
-	err = devpts_ptmx_path(&path);
-	if (err) {
-		result = ERR_PTR(err);
-		goto out;
+	/* Has the devpts filesystem already been found? */
+	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
+		/* Is there an appropriate devpts filesystem in the parent
+		 * directory?
+		 */
+		err = devpts_ptmx_path(&path);
+		if (err) {
+			result = ERR_PTR(err);
+			goto out;
+		}
 	}
 
 	/*
-- 
2.15.1
