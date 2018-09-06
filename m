Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBCEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC5F20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC5F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeIFRMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:12:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40475 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIFRMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:12:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86Caps5294582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 05:36:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86Caows294570;
        Thu, 6 Sep 2018 05:36:50 -0700
Date:   Thu, 6 Sep 2018 05:36:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-9fe6299dde587788f245e9f7a5a1b296fad4e8c7@git.kernel.org>
Cc:     jannh@google.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, bpetkov@suse.de, luto@kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Reply-To: bpetkov@suse.de, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, jannh@google.com, gregkh@linuxfoundation.org,
          linux-kernel@vger.kernel.org, luto@kernel.org
In-Reply-To: <20180831194151.123586-1-jannh@google.com>
References: <20180831194151.123586-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/process: Don't mix user/kernel regs in 64bit
 __show_regs()
Git-Commit-ID: 9fe6299dde587788f245e9f7a5a1b296fad4e8c7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9fe6299dde587788f245e9f7a5a1b296fad4e8c7
Gitweb:     https://git.kernel.org/tip/9fe6299dde587788f245e9f7a5a1b296fad4e8c7
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 31 Aug 2018 21:41:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 6 Sep 2018 14:33:12 +0200

x86/process: Don't mix user/kernel regs in 64bit __show_regs()

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180831194151.123586-1-jannh@google.com

---
 arch/x86/include/asm/kdebug.h | 12 +++++++++++-
 arch/x86/kernel/dumpstack.c   | 11 +++--------
 arch/x86/kernel/process_32.c  |  4 ++--
 arch/x86/kernel/process_64.c  | 12 ++++++++++--
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index 395c9631e000..75f1e35e7c15 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -22,10 +22,20 @@ enum die_val {
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
 extern void die(const char *, struct pt_regs *,long);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_stack_regs(struct pt_regs *regs);
-extern void __show_regs(struct pt_regs *regs, int all);
+extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
 extern void show_iret_regs(struct pt_regs *regs);
 extern unsigned long oops_begin(void);
 extern void oops_end(unsigned long, struct pt_regs *, int signr);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index f56895106ccf..2b5886401e5f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -146,7 +146,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	 * they can be printed in the right context.
 	 */
 	if (!partial && on_stack(info, regs, sizeof(*regs))) {
-		__show_regs(regs, 0);
+		__show_regs(regs, SHOW_REGS_SHORT);
 
 	} else if (partial && on_stack(info, (void *)regs + IRET_FRAME_OFFSET,
 				       IRET_FRAME_SIZE)) {
@@ -344,7 +344,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	oops_exit();
 
 	/* Executive summary in case the oops scrolled away */
-	__show_regs(&exec_summary_regs, true);
+	__show_regs(&exec_summary_regs, SHOW_REGS_ALL);
 
 	if (!signr)
 		return;
@@ -407,14 +407,9 @@ void die(const char *str, struct pt_regs *regs, long err)
 
 void show_regs(struct pt_regs *regs)
 {
-	bool all = true;
-
 	show_regs_print_info(KERN_DEFAULT);
 
-	if (IS_ENABLED(CONFIG_X86_32))
-		all = !user_mode(regs);
-
-	__show_regs(regs, all);
+	__show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
 
 	/*
 	 * When in-kernel, we also print out the stack at the time of the fault..
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 2924fd447e61..5046a3c9dec2 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -59,7 +59,7 @@
 #include <asm/intel_rdt_sched.h>
 #include <asm/proto.h>
 
-void __show_regs(struct pt_regs *regs, int all)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -85,7 +85,7 @@ void __show_regs(struct pt_regs *regs, int all)
 	printk(KERN_DEFAULT "DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x EFLAGS: %08lx\n",
 	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss, regs->flags);
 
-	if (!all)
+	if (mode != SHOW_REGS_ALL)
 		return;
 
 	cr0 = read_cr0();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index a451bc374b9b..ea5ea850348d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -62,7 +62,7 @@
 __visible DEFINE_PER_CPU(unsigned long, rsp_scratch);
 
 /* Prints also some state that isn't saved in the pt_regs */
-void __show_regs(struct pt_regs *regs, int all)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L, fs, gs, shadowgs;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -87,9 +87,17 @@ void __show_regs(struct pt_regs *regs, int all)
 	printk(KERN_DEFAULT "R13: %016lx R14: %016lx R15: %016lx\n",
 	       regs->r13, regs->r14, regs->r15);
 
-	if (!all)
+	if (mode == SHOW_REGS_SHORT)
 		return;
 
+	if (mode == SHOW_REGS_USER) {
+		rdmsrl(MSR_FS_BASE, fs);
+		rdmsrl(MSR_KERNEL_GS_BASE, shadowgs);
+		printk(KERN_DEFAULT "FS:  %016lx GS:  %016lx\n",
+		       fs, shadowgs);
+		return;
+	}
+
 	asm("movl %%ds,%0" : "=r" (ds));
 	asm("movl %%cs,%0" : "=r" (cs));
 	asm("movl %%es,%0" : "=r" (es));
