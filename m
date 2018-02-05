Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBEBgI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:36:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:43458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbeBEB3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:29:07 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 44/64] arch/score: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:34 +0100
Message-Id: <20180205012754.23615-45-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

This becomes quite straightforward with the mmrange in place.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/score/mm/fault.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/score/mm/fault.c b/arch/score/mm/fault.c
index 07a8637ad142..535df3b377a5 100644
--- a/arch/score/mm/fault.c
+++ b/arch/score/mm/fault.c
@@ -81,7 +81,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -127,7 +127,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	else
 		tsk->min_flt++;
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return;
 
 	/*
@@ -135,7 +135,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	* Fix it, but check if it's kernel or user first..
 	 */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
@@ -174,14 +174,14 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	* us unable to handle the page fault gracefully.
 	*/
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	if (!user_mode(regs))
 		goto no_context;
 	pagefault_out_of_memory();
 	return;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
 		goto no_context;
-- 
2.13.6
