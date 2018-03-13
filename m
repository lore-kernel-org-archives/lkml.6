Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbeCMMSO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:18:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35828 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932857AbeCMMSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:18:08 -0400
X-Google-Smtp-Source: AG47ELtZFwHO3kirX2hoI4i5ZyC4ej2wIWxPWnkeLNOn+sOPZs3jRVvBa92F/bABx9Pa6nLv3uYlGw==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org
Cc: containers@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/4 v5] devpts: resolve devpts bind-mounts
Date: Tue, 13 Mar 2018 13:17:11 +0100
Message-Id: <20180313121713.32551-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180313121713.32551-1-christian.brauner@ubuntu.com>
References: <20180313121713.32551-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most libcs will still look at /dev/ptmx when opening the master fd of a pty
device. When /dev/ptmx is a bind-mount of /dev/pts/ptmx and the TIOCGPTPEER
ioctl() is used to safely retrieve a file descriptor for the slave side of
the pty based on the master fd, the /proc/self/fd/{0,1,2} symlinks will
point to /. A very simply reproducer for this issue presupposing a libc
that uses TIOCGPTPEER in its openpty() implementation is:

unshare --mount
mount --bind /dev/pts/ptmx /dev/ptmx
chmod 666 /dev/ptmx
script
ls -al /proc/self/fd/0

Having bind-mounts of /dev/pts/ptmx to /dev/ptmx not working correctly is a
regression. In addition, it is also a fairly common scenario in containers
employing user namespaces.

The reason for the current failure is that the kernel tries to verify the
useability of the devpts filesystem without resolving the /dev/ptmx
bind-mount first. This will lead it to detect that the dentry is escaping
its bind-mount. The reason is that while the devpts filesystem mounted at
/dev/pts has the devtmpfs mounted at /dev as its parent mount:

21 -- -- / /dev
-- 21 -- / /dev/pts

devtmpfs and devpts are on different devices

-- -- 0:6  / /dev
-- -- 0:20 / /dev/pts

This has the consequence that the pathname of the parent directory of the
devpts filesystem mount at /dev/pts is /. So if /dev/ptmx is a bind-mount
of /dev/pts/ptmx then the /dev/ptmx bind-mount and the devpts mount at
/dev/pts will end up being located on the same device which is recorded in
the superblock of their vfsmount. This means the parent directory of the
/dev/ptmx bind-mount will be /ptmx:

-- -- ---- /ptmx /dev/ptmx

Without the bind-mount resolution patch the kernel will now perform the
bind-mount escape check directly on /dev/ptmx. The function responsible for
this is devpts_ptmx_path() which calls pts_path() which in turn calls
path_parent_directory(). Based on the above explanation,
path_parent_directory() will yield / as the parent directory for the
/dev/ptmx bind-mount and not the expected /dev. Thus, the kernel detects
that /dev/ptmx is escaping its bind-mount and will set /proc/<pid>/fd/<nr>
to /.

This patch changes the logic to first resolve any bind-mounts. After the
bind-mounts have been resolved (i.e. we have traced it back to the
associated devpts mount) devpts_ptmx_path() can be called. In order to
guarantee correct path generation for the slave file descriptor the kernel
now requires that a pts directory is found in the parent directory of the
ptmx bind-mount. This implies that when doing bind-mounts the ptmx
bind-mount and the devpts mount should have a common parent directory. A
valid example is:

mount -t devpts devpts /dev/pts
mount --bind /dev/pts/ptmx /dev/ptmx

an invalid example is:

mount -t devpts devpts /dev/pts
mount --bind /dev/pts/ptmx /ptmx

This allows us to support:
- calling open on ptmx devices located inside non-standard devpts mounts:
  mount -t devpts devpts /mnt
  master = open("/mnt/ptmx", ...);
  slave = ioctl(master, TIOCGPTPEER, ...);
- calling open on ptmx devices located outside the devpts mount with a
  common ancestor directory:
  mount -t devpts devpts /dev/pts
  mount --bind /dev/pts/ptmx /dev/ptmx
  master = open("/dev/ptmx", ...);
  slave = ioctl(master, TIOCGPTPEER, ...);

while failing on ptmx devices located outside the devpts mount without a
common ancestor directory:
  mount -t devpts devpts /dev/pts
  mount --bind /dev/pts/ptmx /ptmx
  master = open("/ptmx", ...);
  slave = ioctl(master, TIOCGPTPEER, ...);

in which case save path generation cannot be guaranteed.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
---
ChangeLog v4->v5:
* reverse error handling logic to further simplify (Linus)
ChangeLog v3->v4:
* simplify if condition (Eric)
ChangeLog v2->v3:
* rework logic to account for non-standard devpts mounts such as
  mount -t devpts devpts /mnt (Christian)
ChangeLog v1->v2:
* move removal of if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
  condition to separate patch with non-functional changes (Linus)
ChangeLog v0->v1:
* remove
        /* Has the devpts filesystem already been found? */
        if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
                        return 0
  from devpts_ptmx_path() (Eric)
* check superblock after devpts_ptmx_path() returned (Christian)
---
 fs/devpts/inode.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 71b901936113..542364bf923e 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -160,21 +160,27 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 	path = filp->f_path;
 	path_get(&path);
 
-	/* Has the devpts filesystem already been found? */
-	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC)
+	/* Walk upward while the start point is a bind mount of
+	 * a single file.
+	 */
+	while (path.mnt->mnt_root == path.dentry)
+		if (follow_up(&path) == 0)
+			break;
+
+	/* devpts_ptmx_path() finds a devpts fs or returns an error. */
+	if ((path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) ||
+	    (DEVPTS_SB(path.mnt->mnt_sb) != fsi))
 		err = devpts_ptmx_path(&path);
 	dput(path.dentry);
-	if (err) {
-		mntput(path.mnt);
-		return ERR_PTR(err);
-	}
+	if (!err) {
+		if (DEVPTS_SB(path.mnt->mnt_sb) == fsi)
+			return path.mnt;
 
-	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
-		mntput(path.mnt);
-		return ERR_PTR(-ENODEV);
+		err = -ENODEV;
 	}
 
-	return path.mnt;
+	mntput(path.mnt);
+	return ERR_PTR(err);
 }
 
 struct pts_fs_info *devpts_acquire(struct file *filp)
-- 
2.15.1
