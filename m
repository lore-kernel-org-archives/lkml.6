Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00B121B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196730;
	bh=AlT1FIsaHGqXQQZrjEMpCuAnOm73kd5vjfGJQDSHJyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qEuHWL+5SmoE9GsIsMkN6rybrQ9BE/JKIQe/XU81oKcCyA4H0tiutwHOSF7QJiJWh
	 YqD0QzNcX8Eowqt8BrGkw1o77tXt2hqkF+UzTKenCKDRpsKceQli/UExVW91Tkzrks
	 8t3wTsXjg57X/WhrG6xR1hmdanZRJVvXvN5/a/oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391027AbfBOCMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389114AbfBOCME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FDF21B68;
        Fri, 15 Feb 2019 02:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196722;
        bh=AlT1FIsaHGqXQQZrjEMpCuAnOm73kd5vjfGJQDSHJyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yyOBgayGjwsY8U3n+K2U/Ik631si4xF4j6Rto4uW4eWHuWuOiAA/909Ab0R8eJxfN
         qtysIzYS6j81M9guV8pOKUXYAhS2YcBfHvr41hQHE0sVl8vB+CfWWDrujFnhRYLJdI
         83qKekfoGfujy6JLWE+TRwX828PlqUDbq2jN92rM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 26/65] ARC: show_regs: lockdep: avoid page allocator...
Date:   Thu, 14 Feb 2019 21:10:42 -0500
Message-Id: <20190215021121.177674-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

[ Upstream commit ab6c03676cb190156603cf4c5ecf97aa406c9c53 ]

and use smaller/on-stack buffer instead

The motivation for this change was lockdep splat like below.

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

So signal handling core calls show_regs() with preemption disabled but
an ensuing GFP_KERNEL page allocator call is flagged by lockdep.

We could have switched to GFP_NOWAIT, but turns out that is not enough
anways and eliding page allocator call leads to less code and
instruction traces to sift thru when debugging pesky crashes.

FWIW, this patch doesn't cure the lockdep splat (which next patch does).

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/kernel/troubleshoot.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index e8d9fb452346..5c6663321e87 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -18,6 +18,8 @@
 #include <asm/arcregs.h>
 #include <asm/irqflags.h>
 
+#define ARC_PATH_MAX	256
+
 /*
  * Common routine to print scratch regs (r0-r12) or callee regs (r13-r25)
  *   -Prints 3 regs per line and a CR.
@@ -58,11 +60,12 @@ static void show_callee_regs(struct callee_regs *cregs)
 	print_reg_file(&(cregs->r13), 13);
 }
 
-static void print_task_path_n_nm(struct task_struct *tsk, char *buf)
+static void print_task_path_n_nm(struct task_struct *tsk)
 {
 	char *path_nm = NULL;
 	struct mm_struct *mm;
 	struct file *exe_file;
+	char buf[ARC_PATH_MAX];
 
 	mm = get_task_mm(tsk);
 	if (!mm)
@@ -72,7 +75,7 @@ static void print_task_path_n_nm(struct task_struct *tsk, char *buf)
 	mmput(mm);
 
 	if (exe_file) {
-		path_nm = file_path(exe_file, buf, 255);
+		path_nm = file_path(exe_file, buf, ARC_PATH_MAX-1);
 		fput(exe_file);
 	}
 
@@ -80,10 +83,9 @@ static void print_task_path_n_nm(struct task_struct *tsk, char *buf)
 	pr_info("Path: %s\n", !IS_ERR(path_nm) ? path_nm : "?");
 }
 
-static void show_faulting_vma(unsigned long address, char *buf)
+static void show_faulting_vma(unsigned long address)
 {
 	struct vm_area_struct *vma;
-	char *nm = buf;
 	struct mm_struct *active_mm = current->active_mm;
 
 	/* can't use print_vma_addr() yet as it doesn't check for
@@ -96,8 +98,11 @@ static void show_faulting_vma(unsigned long address, char *buf)
 	 * if the container VMA is not found
 	 */
 	if (vma && (vma->vm_start <= address)) {
+		char buf[ARC_PATH_MAX];
+		char *nm = "?";
+
 		if (vma->vm_file) {
-			nm = file_path(vma->vm_file, buf, PAGE_SIZE - 1);
+			nm = file_path(vma->vm_file, buf, ARC_PATH_MAX-1);
 			if (IS_ERR(nm))
 				nm = "?";
 		}
@@ -173,13 +178,8 @@ void show_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
 	struct callee_regs *cregs;
-	char *buf;
 
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
-		return;
-
-	print_task_path_n_nm(tsk, buf);
+	print_task_path_n_nm(tsk);
 	show_regs_print_info(KERN_INFO);
 
 	show_ecr_verbose(regs);
@@ -189,7 +189,7 @@ void show_regs(struct pt_regs *regs)
 		(void *)regs->blink, (void *)regs->ret);
 
 	if (user_mode(regs))
-		show_faulting_vma(regs->ret, buf); /* faulting code, not data */
+		show_faulting_vma(regs->ret); /* faulting code, not data */
 
 	pr_info("[STAT32]: 0x%08lx", regs->status32);
 
@@ -221,8 +221,6 @@ void show_regs(struct pt_regs *regs)
 	cregs = (struct callee_regs *)current->thread.callee_reg;
 	if (cregs)
 		show_callee_regs(cregs);
-
-	free_page((unsigned long)buf);
 }
 
 void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
-- 
2.19.1

