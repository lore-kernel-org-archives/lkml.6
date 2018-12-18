Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71086C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44171218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ThMzo9sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeLRSyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:54:17 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:55830 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeLRSyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:54:13 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CE13710C0BCA;
        Tue, 18 Dec 2018 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545159252; bh=Dmmf92XTwIVxBegyy3MkhN2/6mGU00jYdmv+BDLE/IE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ThMzo9szwxcID/+P7MyBY/Cp9ofIE1KLDillTJ6gm35dEj7gaNI20io/OOShc3jMq
         HFi8LPMi7C514pAxxkClHW9kfDDQTW0QrqEP8U1Xx3mp7qWTple8eGMBLoSdZSLZ7f
         U1c6CuGUnOgI0Ydhcpo9IGy8U5CbvmOiAK5L8GV+yk/20cUKoQEocfmgcUZP+I0jeu
         6NoTRUA/JMqutWgZJ/rGKP/BHXRKHKYhyQEvc1LSyz+hqpPAIycMy2vTxlAejo1aEz
         rDgohiU8PLyIueCutbIETbIKBpJd+cK8dMdx9mBUZxqoYeOrz6HEoOktmSKsdrSVPs
         P0ttPOcpmUTbw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id AE4A0399B;
        Tue, 18 Dec 2018 10:54:12 -0800 (PST)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 10:54:12 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Dec 2018 00:24:11 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Dec 2018 00:24:11 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>
Subject: [PATCH 1/2] ARC: show_regs: avoid page allocator
Date:   Tue, 18 Dec 2018 10:53:58 -0800
Message-ID: <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use on-stack smaller buffers instead of dynamic pages.

The motivation for this change was to address lockdep splat when
signal handling code calls show_regs (with preemption disabled) and
ARC show_regs calls into sleepable page allocator.

| potentially unexpected fatal signal 11.
| BUG: sleeping function called from invalid context at ../mm/page_alloc.c:4317
| in_atomic(): 1, irqs_disabled(): 0, pid: 57, name: segv
| no locks held by segv/57.
| Preemption disabled at:
| [<8182f17e>] get_signal+0x4a6/0x7c4
| CPU: 0 PID: 57 Comm: segv Not tainted 4.17.0+ #23
|
| Stack Trace:
|  arc_unwind_core.constprop.1+0xd0/0xf4
|  __might_sleep+0x1f6/0x234
|  __get_free_pages+0x174/0xca0
|  show_regs+0x22/0x330
|  get_signal+0x4ac/0x7c4     # print_fatal_signals() -> preempt_disable()
|  do_signal+0x30/0x224
|  resume_user_mode_begin+0x90/0xd8

Despite this, lockdep still barfs (see next change), but this patch
still has merit as in we use smaller/localized buffers now and there's
less instructoh trace to sift thru when debugging pesky issues.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/troubleshoot.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index e8d9fb452346..2885bec71fb8 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -58,11 +58,12 @@ static void show_callee_regs(struct callee_regs *cregs)
 	print_reg_file(&(cregs->r13), 13);
 }
 
-static void print_task_path_n_nm(struct task_struct *tsk, char *buf)
+static void print_task_path_n_nm(struct task_struct *tsk)
 {
 	char *path_nm = NULL;
 	struct mm_struct *mm;
 	struct file *exe_file;
+	char buf[256];
 
 	mm = get_task_mm(tsk);
 	if (!mm)
@@ -80,10 +81,9 @@ static void print_task_path_n_nm(struct task_struct *tsk, char *buf)
 	pr_info("Path: %s\n", !IS_ERR(path_nm) ? path_nm : "?");
 }
 
-static void show_faulting_vma(unsigned long address, char *buf)
+static void show_faulting_vma(unsigned long address)
 {
 	struct vm_area_struct *vma;
-	char *nm = buf;
 	struct mm_struct *active_mm = current->active_mm;
 
 	/* can't use print_vma_addr() yet as it doesn't check for
@@ -96,8 +96,11 @@ static void show_faulting_vma(unsigned long address, char *buf)
 	 * if the container VMA is not found
 	 */
 	if (vma && (vma->vm_start <= address)) {
+		char buf[256];
+		char *nm = "?";
+
 		if (vma->vm_file) {
-			nm = file_path(vma->vm_file, buf, PAGE_SIZE - 1);
+			nm = file_path(vma->vm_file, buf, 256-1);
 			if (IS_ERR(nm))
 				nm = "?";
 		}
@@ -173,13 +176,8 @@ void show_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
 	struct callee_regs *cregs;
-	char *buf;
-
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
-		return;
 
-	print_task_path_n_nm(tsk, buf);
+	print_task_path_n_nm(tsk);
 	show_regs_print_info(KERN_INFO);
 
 	show_ecr_verbose(regs);
@@ -189,7 +187,7 @@ void show_regs(struct pt_regs *regs)
 		(void *)regs->blink, (void *)regs->ret);
 
 	if (user_mode(regs))
-		show_faulting_vma(regs->ret, buf); /* faulting code, not data */
+		show_faulting_vma(regs->ret); /* faulting code, not data */
 
 	pr_info("[STAT32]: 0x%08lx", regs->status32);
 
@@ -221,8 +219,6 @@ void show_regs(struct pt_regs *regs)
 	cregs = (struct callee_regs *)current->thread.callee_reg;
 	if (cregs)
 		show_callee_regs(cregs);
-
-	free_page((unsigned long)buf);
 }
 
 void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
-- 
2.7.4

