Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbeBEBlt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:41:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:44106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752343AbeBEB2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:21 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 19/64] mm/mlock: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:09 +0100
Message-Id: <20180205012754.23615-20-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Conversion is straightforward, mmap_sem is used within the
same function context. No changes in semantics.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 mm/mlock.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 3f6bd953e8b0..dfd175b2cf20 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -686,7 +686,7 @@ static __must_check int do_mlock(unsigned long start, size_t len,
 	lock_limit >>= PAGE_SHIFT;
 	locked = len >> PAGE_SHIFT;
 
-	if (down_write_killable(&current->mm->mmap_sem))
+	if (mm_write_lock_killable(current->mm, &mmrange))
 		return -EINTR;
 
 	locked += current->mm->locked_vm;
@@ -705,7 +705,7 @@ static __must_check int do_mlock(unsigned long start, size_t len,
 	if ((locked <= lock_limit) || capable(CAP_IPC_LOCK))
 		error = apply_vma_lock_flags(start, len, flags, &mmrange);
 
-	up_write(&current->mm->mmap_sem);
+	mm_write_unlock(current->mm, &mmrange);
 	if (error)
 		return error;
 
@@ -741,10 +741,10 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
 
-	if (down_write_killable(&current->mm->mmap_sem))
+	if (mm_write_lock_killable(current->mm, &mmrange))
 		return -EINTR;
 	ret = apply_vma_lock_flags(start, len, 0, &mmrange);
-	up_write(&current->mm->mmap_sem);
+	mm_write_unlock(current->mm, &mmrange);
 
 	return ret;
 }
@@ -811,14 +811,14 @@ SYSCALL_DEFINE1(mlockall, int, flags)
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	lock_limit >>= PAGE_SHIFT;
 
-	if (down_write_killable(&current->mm->mmap_sem))
+	if (mm_write_lock_killable(current->mm, &mmrange))
 		return -EINTR;
 
 	ret = -ENOMEM;
 	if (!(flags & MCL_CURRENT) || (current->mm->total_vm <= lock_limit) ||
 	    capable(CAP_IPC_LOCK))
 		ret = apply_mlockall_flags(flags, &mmrange);
-	up_write(&current->mm->mmap_sem);
+	mm_write_unlock(current->mm, &mmrange);
 	if (!ret && (flags & MCL_CURRENT))
 		mm_populate(0, TASK_SIZE);
 
@@ -830,10 +830,10 @@ SYSCALL_DEFINE0(munlockall)
 	int ret;
 	DEFINE_RANGE_LOCK_FULL(mmrange);
 
-	if (down_write_killable(&current->mm->mmap_sem))
+	if (mm_write_lock_killable(current->mm, &mmrange))
 		return -EINTR;
 	ret = apply_mlockall_flags(0, &mmrange);
-	up_write(&current->mm->mmap_sem);
+	mm_write_unlock(current->mm, &mmrange);
 	return ret;
 }
 
-- 
2.13.6
