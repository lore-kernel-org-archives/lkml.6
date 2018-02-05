Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeBEBjL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:39:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:43680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752715AbeBEB2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:30 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 34/64] arch/parisc: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:24 +0100
Message-Id: <20180205012754.23615-35-dbueso@wotan.suse.de>
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
 arch/parisc/kernel/traps.c | 7 ++++---
 arch/parisc/mm/fault.c     | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index c919e6c0a687..ac73697c7952 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -718,8 +718,9 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 
 		if (user_mode(regs)) {
 			struct vm_area_struct *vma;
+			DEFINE_RANGE_LOCK_FULL(mmrange);
 
-			down_read(&current->mm->mmap_sem);
+			mm_read_lock(current->mm, &mmrange);
 			vma = find_vma(current->mm,regs->iaoq[0]);
 			if (vma && (regs->iaoq[0] >= vma->vm_start)
 				&& (vma->vm_flags & VM_EXEC)) {
@@ -727,10 +728,10 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 				fault_address = regs->iaoq[0];
 				fault_space = regs->iasq[0];
 
-				up_read(&current->mm->mmap_sem);
+				mm_read_unlock(current->mm, &mmrange);
 				break; /* call do_page_fault() */
 			}
-			up_read(&current->mm->mmap_sem);
+			mm_read_unlock(current->mm, &mmrange);
 		}
 		/* Fall Through */
 	case 27: 
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 79db33a0cb0c..f4877e321c28 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -282,7 +282,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	if (acc_type & VM_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 retry:
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	vma = find_vma_prev(mm, address, &prev_vma);
 	if (!vma || address < vma->vm_start)
 		goto check_expansion;
@@ -339,7 +339,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 			goto retry;
 		}
 	}
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return;
 
 check_expansion:
@@ -351,7 +351,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
  * Something tried to access memory that isn't in our memory map..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 	if (user_mode(regs)) {
 		struct siginfo si;
@@ -427,7 +427,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	parisc_terminate("Bad Address (null pointer deref?)", regs, code, address);
 
   out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	if (!user_mode(regs))
 		goto no_context;
 	pagefault_out_of_memory();
-- 
2.13.6
