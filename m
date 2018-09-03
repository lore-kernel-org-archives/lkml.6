Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A1CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D8D20870
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9dmMDb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D8D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIDDWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:32856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeIDDWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:22:05 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1EB20867;
        Mon,  3 Sep 2018 22:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536015586;
        bh=wId+dpuEA3UHHzFBpmohcKY24iTKAieK23VJlYBewFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=m9dmMDb4Kpc4JAPJDSw8ATzFpNDl/grR1xnbZujERDLnT8ppn3lSWzNVFTSNJtysU
         qWwWOdRfWnEi+3FrHZFn8U/TFk4iAjej/4tqqBxEsSrA2jvK/FlgEqNnbKek5ka3qe
         QUpiKkFM59R3ZE4IRGxF6vsD44a+qFwDBkhY4ya0=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 2/3] x86/entry/64: Use the TSS sp2 slot for SYSCALL/SYSRET scratch space
Date:   Mon,  3 Sep 2018 15:59:43 -0700
Message-Id: <08e769a0023dbad4bac6f34f3631dbaf8ad59f4f.1536015544.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536015544.git.luto@kernel.org>
References: <cover.1536015544.git.luto@kernel.org>
In-Reply-To: <cover.1536015544.git.luto@kernel.org>
References: <cover.1536015544.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the non-trampoline SYSCALL64 path, we use a percpu variable to
temporarily store the user RSP value.  Instead of a separate
variable, use the otherwise unused sp2 slot in the TSS.  This will
improve cache locality, as the sp1 slot is already used in the same
code to find the kernel stack.  It will also simplify a future
change to make the non-trampoline path work in PTI mode.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S        | 16 +++++++++-------
 arch/x86/include/asm/processor.h |  6 ++++++
 arch/x86/kernel/asm-offsets.c    |  3 ++-
 arch/x86/kernel/process_64.c     |  2 --
 arch/x86/xen/xen-asm_64.S        |  8 +++++---
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1796c42e08af..17ae40602539 100644
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
index c24297268ebc..8433d76bc37b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -313,7 +313,13 @@ struct x86_hw_tss {
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
-- 
2.17.1

