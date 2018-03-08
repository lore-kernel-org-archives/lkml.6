Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCHRBF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:01:05 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36801 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbeCHRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:01:03 -0500
X-Google-Smtp-Source: AG47ELsqNrAujuQC3V/ymNX/NCUkLdnPkYjXjLuXL0gQMbp776IpijPnYtAIL6LRMgeoKKQeI4ToCg==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] devpts: resolve devpts bind-mounts
Date: Thu,  8 Mar 2018 18:00:51 +0100
Message-Id: <20180308170051.17007-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most libcs will still look at /dev/ptmx when opening the master fd of pty
device. When /dev/ptmx is a bind-mount of /dev/pts/ptmx and the TIOCGPTPEER
ioctl() is used to safely retrieve a file descriptor for the slave side of the
pty based on the master fd the /proc/self/fd/{0,1,2} symlinks will point to "/".
When the kernel tries to look up the root mount of the dentry for the slave
file descriptor it will detect that the dentry is escaping it's bind-mount
since the root mount of the dentry is /dev/pts where the devpts is mounted but
the root mount of /dev/ptmx is /dev.
Having bind-mounts of /dev/pts/ptmx to /dev/ptmx not working correctly is a
regression. In addition, it is also a fairly common scenario in containers
employing user namespaces.
To handle this situation correctly we walk up the bind-mounts for the /dev/ptmx
file.

Here's a little reproducer that presupposes a libc that uses TIOCGPTPEER in its
openpty() implementation:

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
 fs/devpts/inode.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index e31d6ed3ec32..4059e3e69d57 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -163,6 +163,26 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 
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
+		if (err == 0) {
+			dput(path.dentry);
+			return path.mnt;
+		}
+
+		path_put(&path);
+		path = filp->f_path;
+		path_get(&path);
+	}
 
 	err = devpts_ptmx_path(&path);
 	dput(path.dentry);
-- 
2.15.1
