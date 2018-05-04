Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeEDG6h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:58:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41689 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbeEDG6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:58:35 -0400
X-Google-Smtp-Source: AB8JxZrok5zeWukneTSus8l4SJMtD6+A8hRvPfiopcBrg2gpPzQ+8VA+tgFWk/tzGYLViSi3Ke/7KA==
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
To: ldufour@linux.vnet.ibm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, cpandya@codeaurora.org,
        punit.agrawal@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: [PATCH v2 2/2] arm64/mm: add speculative page fault
Date: Fri,  4 May 2018 14:57:49 +0800
Message-Id: <1525417069-27401-2-git-send-email-opensource.ganesh@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525417069-27401-1-git-send-email-opensource.ganesh@gmail.com>
References: <1525417069-27401-1-git-send-email-opensource.ganesh@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the speculative page fault on the arm64
architecture.

I completed spf porting in 4.9. From the test result,
we can see app launching time improved by about 10% in average.
For the apps which have more than 50 threads, 15% or even more
improvement can be got.

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
---
v2:
  move find_vma() to do_page_fault()
  remove IS_ENABLED()
  remove fault != VM_FAULT_SIGSEGV check
  initilize vma = NULL
---
 arch/arm64/mm/fault.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4165485..efd5956 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -320,14 +320,12 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 #define VM_FAULT_BADMAP		0x010000
 #define VM_FAULT_BADACCESS	0x020000
 
-static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
+static int __do_page_fault(struct vm_area_struct *vma, unsigned long addr,
 			   unsigned int mm_flags, unsigned long vm_flags,
 			   struct task_struct *tsk)
 {
-	struct vm_area_struct *vma;
 	int fault;
 
-	vma = find_vma(mm, addr);
 	fault = VM_FAULT_BADMAP;
 	if (unlikely(!vma))
 		goto out;
@@ -371,6 +369,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	int fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	struct vm_area_struct *vma = NULL;
 
 	if (notify_page_fault(regs, esr))
 		return 0;
@@ -410,6 +409,16 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
 	/*
+	 * let's try a speculative page fault without grabbing the
+	 * mmap_sem.
+	 */
+	fault = handle_speculative_fault(mm, addr, mm_flags, &vma);
+	if (fault != VM_FAULT_RETRY) {
+		perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, addr);
+		goto done;
+	}
+
+	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
 	 * we can bug out early if this is from code which shouldn't.
@@ -431,7 +440,10 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, tsk);
+	if (!vma || !can_reuse_spf_vma(vma, addr))
+		vma = find_vma(mm, addr);
+
+	fault = __do_page_fault(vma, addr, mm_flags, vm_flags, tsk);
 	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault & VM_FAULT_RETRY) {
@@ -454,11 +466,20 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		if (mm_flags & FAULT_FLAG_ALLOW_RETRY) {
 			mm_flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			mm_flags |= FAULT_FLAG_TRIED;
+
+			/*
+			 * Do not try to reuse this vma and fetch it
+			 * again since we will release the mmap_sem.
+			 */
+			vma = NULL;
+
 			goto retry;
 		}
 	}
 	up_read(&mm->mmap_sem);
 
+done:
+
 	/*
 	 * Handle the "normal" (no error) case first.
 	 */
-- 
1.9.1
