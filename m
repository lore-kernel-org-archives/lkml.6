Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755894AbeDTPzy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:55:54 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:39081 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755850AbeDTPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:55:49 -0400
X-Google-Smtp-Source: AIpwx48SaWWVWbXWsS8km9/4Zl+ThOeK9WF6mvafy5PflkEJ3iNFOAhyqB6ku5iPmqondx/O8hNeRg==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH net-next 1/4] mm: provide a mmap_hook infrastructure
Date: Fri, 20 Apr 2018 08:55:39 -0700
Message-Id: <20180420155542.122183-2-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180420155542.122183-1-edumazet@google.com>
References: <20180420155542.122183-1-edumazet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding tcp mmap() implementation, I forgot that socket lock
had to be taken before current->mm->mmap_sem. syzbot eventually caught
the bug.

This patch provides a new mmap_hook() method in struct file_operations
that might be provided by fs to implement a finer control of whats
to be done before and after do_mmap_pgoff() and/or the mm->mmap_sem
acquire/release.

This is used in following patches by networking and TCP stacks
to solve the lockdep issue, and also allows some preparation
and cleanup work being done before/after mmap_sem is held,
allowing better scalability in multi-threading programs.

Fixes: 93ab6cc69162 ("tcp: implement mmap() for zero copy receive")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 include/linux/fs.h |  6 ++++++
 mm/util.c          | 19 ++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 92efaf1f89775f7b017477617dd983c10e0dc4d2..ef3526f84686585678861fc585efea974a69ca55 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1698,6 +1698,11 @@ struct block_device_operations;
 #define NOMMU_VMFLAGS \
 	(NOMMU_MAP_READ | NOMMU_MAP_WRITE | NOMMU_MAP_EXEC)
 
+enum mmap_hook {
+	MMAP_HOOK_PREPARE,
+	MMAP_HOOK_ROLLBACK,
+	MMAP_HOOK_COMMIT,
+};
 
 struct iov_iter;
 
@@ -1714,6 +1719,7 @@ struct file_operations {
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
+	int (*mmap_hook) (struct file *, enum mmap_hook);
 	unsigned long mmap_supported_flags;
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *, fl_owner_t id);
diff --git a/mm/util.c b/mm/util.c
index 1fc4fa7576f762bbbf341f056ca6d0be803a423f..3ddb18ab367f069d5884083e992e999546ccd995 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -350,11 +350,28 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 
 	ret = security_mmap_file(file, prot, flag);
 	if (!ret) {
-		if (down_write_killable(&mm->mmap_sem))
+		int (*mmap_hook)(struct file *, enum mmap_hook) = NULL;
+
+		if (file) {
+			mmap_hook = file->f_op->mmap_hook;
+
+			if (mmap_hook) {
+				ret = mmap_hook(file, MMAP_HOOK_PREPARE);
+				if (ret)
+					return ret;
+			}
+		}
+		if (down_write_killable(&mm->mmap_sem)) {
+			if (mmap_hook)
+				mmap_hook(file, MMAP_HOOK_ROLLBACK);
 			return -EINTR;
+		}
 		ret = do_mmap_pgoff(file, addr, len, prot, flag, pgoff,
 				    &populate, &uf);
 		up_write(&mm->mmap_sem);
+		if (mmap_hook)
+			mmap_hook(file, IS_ERR(ret) ? MMAP_HOOK_ROLLBACK :
+						      MMAP_HOOK_COMMIT);
 		userfaultfd_unmap_complete(mm, &uf);
 		if (populate)
 			mm_populate(ret, populate);
-- 
2.17.0.484.g0c8726318c-goog
