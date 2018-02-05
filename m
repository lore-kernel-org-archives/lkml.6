Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeBEB2h (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:28:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:43681 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752416AbeBEB2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:05 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 15/64] ipc: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:05 +0100
Message-Id: <20180205012754.23615-16-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

This is straightforward as the necessary syscalls already
know about mmrange. No change in semantics.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/shm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 6c29c791c7f2..4ab752647ca9 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1398,7 +1398,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	if (err)
 		goto out_fput;
 
-	if (down_write_killable(&current->mm->mmap_sem)) {
+	if (mm_write_lock_killable(current->mm, &mmrange)) {
 		err = -EINTR;
 		goto out_fput;
 	}
@@ -1419,7 +1419,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	if (IS_ERR_VALUE(addr))
 		err = (long)addr;
 invalid:
-	up_write(&current->mm->mmap_sem);
+	mm_write_unlock(current->mm, &mmrange);
 	if (populate)
 		mm_populate(addr, populate);
 
@@ -1494,7 +1494,7 @@ SYSCALL_DEFINE1(shmdt, char __user *, shmaddr)
 	if (addr & ~PAGE_MASK)
 		return retval;
 
-	if (down_write_killable(&mm->mmap_sem))
+	if (mm_write_lock_killable(mm, &mmrange))
 		return -EINTR;
 
 	/*
@@ -1585,7 +1585,7 @@ SYSCALL_DEFINE1(shmdt, char __user *, shmaddr)
 
 #endif
 
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	return retval;
 }
 
-- 
2.13.6
