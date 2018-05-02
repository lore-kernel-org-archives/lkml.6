Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeEBHzC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:55:02 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45907 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeEBHy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:54:59 -0400
X-Google-Smtp-Source: AB8JxZoLNN6Q8OTMHvuTMboxmCr2IR3CtGGbBVIs3PH4uA2Uzi9aPBbd815qr35a9E00r3Umz/SKaw==
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
To: ldufour@linux.vnet.ibm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ganesh Mahendran <opensource.ganesh@gmail.com>
Subject: [PATCH 2/2] arm64/mm: add speculative page fault
Date: Wed,  2 May 2018 15:54:32 +0800
Message-Id: <1525247672-2165-2-git-send-email-opensource.ganesh@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
References: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
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
This patch is on top of Laurent's v10 spf
---
 arch/arm64/mm/fault.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4165485..e7992a3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -322,11 +322,13 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 
 static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
 			   unsigned int mm_flags, unsigned long vm_flags,
-			   struct task_struct *tsk)
+			   struct task_struct *tsk, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *vma;
 	int fault;
 
+	if (!vma || !can_reuse_spf_vma(vma, addr))
+		vma = find_vma(mm, addr);
+
 	vma = find_vma(mm, addr);
 	fault = VM_FAULT_BADMAP;
 	if (unlikely(!vma))
@@ -371,6 +373,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	int fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	struct vm_area_struct *vma;
 
 	if (notify_page_fault(regs, esr))
 		return 0;
@@ -409,6 +412,25 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT)) {
+		fault = handle_speculative_fault(mm, addr, mm_flags, &vma);
+		/*
+		 * Page fault is done if VM_FAULT_RETRY is not returned.
+		 * But if the memory protection keys are active, we don't know
+		 * if the fault is due to key mistmatch or due to a
+		 * classic protection check.
+		 * To differentiate that, we will need the VMA we no
+		 * more have, so let's retry with the mmap_sem held.
+		 */
+		if (fault != VM_FAULT_RETRY &&
+			 fault != VM_FAULT_SIGSEGV) {
+			perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, addr);
+			goto done;
+		}
+	} else {
+		vma = NULL;
+	}
+
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -431,7 +453,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 #endif
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, tsk);
+	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, tsk, vma);
 	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault & VM_FAULT_RETRY) {
@@ -454,11 +476,21 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		if (mm_flags & FAULT_FLAG_ALLOW_RETRY) {
 			mm_flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			mm_flags |= FAULT_FLAG_TRIED;
+
+			/*
+			 * Do not try to reuse this vma and fetch it
+			 * again since we will release the mmap_sem.
+			 */
+			if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
+				vma = NULL;
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
