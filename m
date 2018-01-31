Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753534AbeAaIuL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:50:11 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38480 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeAaIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:50:10 -0500
X-Google-Smtp-Source: AH8x227jE1e3A866WY3lFLm2pFWTV8Unab1Dx+bKeSsTGeXhs5qWrFbiKVno2uMMOBRS0dq2oCLW7w==
From: Eric Biggers <ebiggers3@gmail.com>
To: ebiederm@xmission.com, torvalds@linux-foundation.org
Cc: Christian Brauner <christian.brauner@canonical.com>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH] devpts: fix error handling in devpts_mntget()
Date: Wed, 31 Jan 2018 00:49:18 -0800
Message-Id: <20180131084918.15267-1-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <94eb2c05a3807b84210560f4a1fd@google.com>
References: <94eb2c05a3807b84210560f4a1fd@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If devpts_ptmx_path() returns an error code, then devpts_mntget()
dereferences an ERR_PTR():

    BUG: unable to handle kernel paging request at fffffffffffffff5
    IP: devpts_mntget+0x13f/0x280 fs/devpts/inode.c:173

Fix it by returning early in the error paths.

Reproducer:

    #define _GNU_SOURCE
    #include <fcntl.h>
    #include <sched.h>
    #include <sys/ioctl.h>
    #define TIOCGPTPEER _IO('T', 0x41)

    int main()
    {
        for (;;) {
            int fd = open("/dev/ptmx", 0);
            unshare(CLONE_NEWNS);
            ioctl(fd, TIOCGPTPEER, 0);
        }
    }

Fixes: 311fc65c9fb9 ("pty: Repair TIOCGPTPEER")
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: <stable@vger.kernel.org> # v4.13+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/devpts/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 7eae33ffa3fcc..e31d6ed3ec327 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -168,11 +168,11 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 	dput(path.dentry);
 	if (err) {
 		mntput(path.mnt);
-		path.mnt = ERR_PTR(err);
+		return ERR_PTR(err);
 	}
 	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
 		mntput(path.mnt);
-		path.mnt = ERR_PTR(-ENODEV);
+		return ERR_PTR(-ENODEV);
 	}
 	return path.mnt;
 }
-- 
2.16.1
