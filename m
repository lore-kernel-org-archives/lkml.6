Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD9C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C14320844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C14320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeIHOUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:20:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36767 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbeIHOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:20:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w889YRSY1040050
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 8 Sep 2018 02:34:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w889YRog1040047;
        Sat, 8 Sep 2018 02:34:27 -0700
Date:   Sat, 8 Sep 2018 02:34:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-98f05b5138f0a9b56022295cc1387e635b25635d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        torvalds@linux-foundation.org, acme@kernel.org,
        peterz@infradead.org, dave.hansen@linux.intel.com,
        ak@linux.intel.com, jpoimboe@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, bp@suse.de,
        bp@alien8.de, mingo@kernel.org, adrian.hunter@intel.com,
        jolsa@redhat.com, tglx@linutronix.de, luto@kernel.org
Reply-To: hpa@zytor.com, jpoimboe@redhat.com,
          alexander.shishkin@linux.intel.com, bp@alien8.de, bp@suse.de,
          mingo@kernel.org, adrian.hunter@intel.com, luto@kernel.org,
          jolsa@redhat.com, tglx@linutronix.de, joro@8bytes.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          acme@kernel.org, dave.hansen@linux.intel.com,
          peterz@infradead.org, ak@linux.intel.com
In-Reply-To: <08e769a0023dbad4bac6f34f3631dbaf8ad59f4f.1536015544.git.luto@kernel.org>
References: <08e769a0023dbad4bac6f34f3631dbaf8ad59f4f.1536015544.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Use the TSS sp2 slot for SYSCALL/SYSRET
 scratch space
Git-Commit-ID: 98f05b5138f0a9b56022295cc1387e635b25635d
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

Commit-ID:  98f05b5138f0a9b56022295cc1387e635b25635d
Gitweb:     https://git.kernel.org/tip/98f05b5138f0a9b56022295cc1387e635b25635d
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 3 Sep 2018 15:59:43 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 8 Sep 2018 11:20:11 +0200

x86/entry/64: Use the TSS sp2 slot for SYSCALL/SYSRET scratch space

In the non-trampoline SYSCALL64 path, a percpu variable is used to
temporarily store the user RSP value.

Instead of a separate variable, use the otherwise unused sp2 slot in the
TSS.  This will improve cache locality, as the sp1 slot is already used in
the same code to find the kernel stack.  It will also simplify a future
change to make the non-trampoline path work in PTI mode.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/08e769a0023dbad4bac6f34f3631dbaf8ad59f4f.1536015544.git.luto@kernel.org

---
 arch/x86/entry/entry_64.S        | 16 +++++++++-------
 arch/x86/include/asm/processor.h |  6 ++++++
 arch/x86/kernel/asm-offsets.c    |  3 ++-
 arch/x86/kernel/process_64.c     |  2 --
 arch/x86/xen/xen-asm_64.S        |  8 +++++---
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ce6af4460e9c..7e82e553183a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -215,18 +215,20 @@ ENTRY(entry_SYSCALL_64)
 	/*
 	 * This path is only taken when PAGE_TABLE_ISOLATION is disabled so it
 	 * is not required to switch CR3.
+	 *
+	 * tss.sp2 is scratch space.
 	 */
-	movq	%rsp, PER_CPU_VAR(rsp_scratch)
+	movq	%rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
-	pushq	$__USER_DS			/* pt_regs->ss */
-	pushq	PER_CPU_VAR(rsp_scratch)	/* pt_regs->sp */
-	pushq	%r11				/* pt_regs->flags */
-	pushq	$__USER_CS			/* pt_regs->cs */
-	pushq	%rcx				/* pt_regs->ip */
+	pushq	$__USER_DS				/* pt_regs->ss */
+	pushq	PER_CPU_VAR(cpu_tss_rw + TSS_sp2)	/* pt_regs->sp */
+	pushq	%r11					/* pt_regs->flags */
+	pushq	$__USER_CS				/* pt_regs->cs */
+	pushq	%rcx					/* pt_regs->ip */
 GLOBAL(entry_SYSCALL_64_after_hwframe)
-	pushq	%rax				/* pt_regs->orig_ax */
+	pushq	%rax					/* pt_regs->orig_ax */
 
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d53c54b842da..b2bb1d691efc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -315,7 +315,13 @@ struct x86_hw_tss {
 	 */
 	u64			sp1;
 
+	/*
+	 * Since Linux does not use ring 2, the 'sp2' slot is unused by
+	 * hardware.  entry_SYSCALL_64 uses it as scratch space to stash
+	 * the user RSP value.
+	 */
 	u64			sp2;
+
 	u64			reserved2;
 	u64			ist[7];
 	u32			reserved3;
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 01de31db300d..fc2e90d3429a 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -105,7 +105,8 @@ void common(void) {
 	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
 	DEFINE(MASK_entry_stack, (~(sizeof(struct entry_stack) - 1)));
 
-	/* Offset for sp0 and sp1 into the tss_struct */
+	/* Offset for fields in tss_struct */
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
+	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index a451bc374b9b..0fa7aa19f09e 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -59,8 +59,6 @@
 #include <asm/unistd_32_ia32.h>
 #endif
 
-__visible DEFINE_PER_CPU(unsigned long, rsp_scratch);
-
 /* Prints also some state that isn't saved in the pt_regs */
 void __show_regs(struct pt_regs *regs, int all)
 {
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 417b339e5c8e..bb1c2da0381d 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -91,13 +91,15 @@ ENTRY(xen_iret)
 ENTRY(xen_sysret64)
 	/*
 	 * We're already on the usermode stack at this point, but
-	 * still with the kernel gs, so we can easily switch back
+	 * still with the kernel gs, so we can easily switch back.
+	 *
+	 * tss.sp2 is scratch space.
 	 */
-	movq %rsp, PER_CPU_VAR(rsp_scratch)
+	movq %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
 	movq PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	pushq $__USER_DS
-	pushq PER_CPU_VAR(rsp_scratch)
+	pushq PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
 	pushq %r11
 	pushq $__USER_CS
 	pushq %rcx
