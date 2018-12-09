Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4736C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8957820837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8957820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeLIV65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:58:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36194 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbeLIVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:39 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW730-0002iq-Ue; Sun, 09 Dec 2018 21:55:35 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003Wn-S7; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jann Horn" <jannh@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Borislav Petkov" <bpetkov@suse.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.207550430@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 216/328] x86/process: Don't mix user/kernel regs in
 64bit __show_regs()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 9fe6299dde587788f245e9f7a5a1b296fad4e8c7 upstream.

When the kernel.print-fatal-signals sysctl has been enabled, a simple
userspace crash will cause the kernel to write a crash dump that contains,
among other things, the kernel gsbase into dmesg.

As suggested by Andy, limit output to pt_regs, FS_BASE and KERNEL_GS_BASE
in this case.

This also moves the bitness-specific logic from show_regs() into
process_{32,64}.c.

Fixes: 45807a1df9f5 ("vdso: print fatal signals")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20180831194151.123586-1-jannh@google.com
[bwh: Backported to 3.16:
 - Keep using user_mode_vm() to in 32-bit show_regs()
 - Also update call to __show_regs() in kmemcheck
 - Don't add redundant rdmsrl()s in 64-bit __show_regs()
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -21,12 +21,22 @@ enum die_val {
 	DIE_NMIUNKNOWN,
 };
 
+enum show_regs_mode {
+	SHOW_REGS_SHORT,
+	/*
+	 * For when userspace crashed, but we don't think it's our fault, and
+	 * therefore don't print kernel registers.
+	 */
+	SHOW_REGS_USER,
+	SHOW_REGS_ALL
+};
+
 extern void printk_address(unsigned long address);
 extern void die(const char *, struct pt_regs *,long);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_trace(struct task_struct *t, struct pt_regs *regs,
 		       unsigned long *sp, unsigned long bp);
-extern void __show_regs(struct pt_regs *regs, int all);
+extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
 extern unsigned long oops_begin(void);
 extern void oops_end(unsigned long, struct pt_regs *, int signr);
 #ifdef CONFIG_KEXEC
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -123,7 +123,7 @@ void show_regs(struct pt_regs *regs)
 	int i;
 
 	show_regs_print_info(KERN_EMERG);
-	__show_regs(regs, !user_mode_vm(regs));
+	__show_regs(regs, user_mode_vm(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
 
 	/*
 	 * When in-kernel, we also print out the stack and code at the
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -301,7 +301,7 @@ void show_regs(struct pt_regs *regs)
 
 	sp = regs->sp;
 	show_regs_print_info(KERN_DEFAULT);
-	__show_regs(regs, 1);
+	__show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
 
 	/*
 	 * When in-kernel, we also print out the stack and code at the
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -66,7 +66,7 @@ unsigned long thread_saved_pc(struct tas
 	return ((unsigned long *)tsk->thread.sp)[3];
 }
 
-void __show_regs(struct pt_regs *regs, int all)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -95,7 +95,7 @@ void __show_regs(struct pt_regs *regs, i
 	printk(KERN_DEFAULT " DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x\n",
 	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss);
 
-	if (!all)
+	if (mode != SHOW_REGS_ALL)
 		return;
 
 	cr0 = read_cr0();
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -56,7 +56,7 @@ asmlinkage extern void ret_from_fork(voi
 __visible DEFINE_PER_CPU_USER_MAPPED(unsigned long, old_rsp);
 
 /* Prints also some state that isn't saved in the pt_regs */
-void __show_regs(struct pt_regs *regs, int all)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L, fs, gs, shadowgs;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -88,9 +88,15 @@ void __show_regs(struct pt_regs *regs, i
 	rdmsrl(MSR_GS_BASE, gs);
 	rdmsrl(MSR_KERNEL_GS_BASE, shadowgs);
 
-	if (!all)
+	if (mode == SHOW_REGS_SHORT)
 		return;
 
+	if (mode == SHOW_REGS_USER) {
+		printk(KERN_DEFAULT "FS:  %016lx GS:  %016lx\n",
+		       fs, shadowgs);
+		return;
+	}
+
 	cr0 = read_cr0();
 	cr2 = read_cr2();
 	cr3 = read_cr3();
--- a/arch/x86/mm/kmemcheck/error.c
+++ b/arch/x86/mm/kmemcheck/error.c
@@ -132,7 +132,7 @@ void kmemcheck_error_recall(void)
 		break;
 	}
 
-	__show_regs(&e->regs, 1);
+	__show_regs(&e->regs, SHOW_REGS_ALL);
 	print_stack_trace(&e->trace, 0);
 }
 

