Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2EAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C0420846
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH9kKYEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C0420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeIACb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeIACb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:31:27 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463F920841;
        Fri, 31 Aug 2018 22:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535754115;
        bh=yiuM0LmMCNa0Zcfc0pDNNpkzNuU0GVpMUTBN14M5TKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=fH9kKYEaWowQ7KvHl+bOX8F7W6aTZ5/sKHQJHhN83oFpUqPfVrRtW6QUZKr22UNjC
         QxZiuAPrcXIlUCWMkIwG5gLbN2u+D3RbLeOx6jyB+V5YGsHPF/aNOpTdwSqLnUn6je
         9sVSKCQDSxt6e9sxaugUWjpfVwY79n5+1MoWVs+8=
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
Subject: [PATCH 1/3] x86/entry/64: Document idtentry
Date:   Fri, 31 Aug 2018 15:21:47 -0700
Message-Id: <6e56c3ad94879e41afe345750bc28ccc0e820ea8.1535753890.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535753890.git.luto@kernel.org>
References: <cover.1535753890.git.luto@kernel.org>
In-Reply-To: <cover.1535753890.git.luto@kernel.org>
References: <cover.1535753890.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idtentry macro is complicated and magical.  Document what it
does to help future readers and to allow future patches to adjust
the code and docs at the same time.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S | 35 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c   |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 957dfb693ecc..1796c42e08af 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -900,6 +900,41 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
 
+/**
+ * idtentry - Generate an IDT entry stub
+ * @sym: Name of the generated entry point
+ * @do_sym: C function to be called
+ * @has_error_code: True if this IDT vector has an error code on the stack
+ * @paranoid: non-zero means that this vector may be invoked from kernel
+ *            mode with user GSBASE and/or user CR3.  2 is special -- see below.
+ * @shift_ist: Set to an IST index if entries from kernel mode should
+ *             decrement the IST stack so that nested entries get a fresh
+ *             stack.  (This is for #DB, which has a nasty habit of
+ *             recursing.)
+ *
+ * idtentry generates an IDT stub that sets up a usable kernel context,
+ * creates struct pt_regs, and calls @do_sym.  The stub has the following
+ * special behaviors:
+ *
+ * On an entry from user mode, the stub switches from the trampoline or
+ * IST stack to the normal thread stack.  On an exit to user mode, the
+ * normal exit-to-usermode path is invoked.
+ *
+ * On an exit to kernel mode, if paranoid == 0, we check for preemption,
+ * whereas we omit the preemption check if @paranoid != 0.  This is purely
+ * because the implementation is simpler this way.  The kernel only needs
+ * to check for asynchronous kernel preemption when IRQ handlers return.
+ *
+ * If @paranoid == 0, then the stub will handle IRET faults by pretending
+ * that the fault came from user mode.  It will handle gs_change faults by
+ * pretending that the fault happened with kernel GSBASE.  Since this handling
+ * is omitted for @paranoid != 0, the #GP, #SS, and #NP stubs must have
+ * @paranoid == 0.  This special handling will do the wrong thing for
+ * espfix-induced #DF on IRET, so #DF must not use @paranoid == 0.
+ *
+ * @paranoid == 2 is special: the stub will never switch stacks.  This is for
+ * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
+ */
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e6db475164ed..1a90821c0b74 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -383,6 +383,10 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code)
 		 * we won't enable interupts or schedule before we invoke
 		 * general_protection, so nothing will clobber the stack
 		 * frame we just set up.
+		 *
+		 * We will enter general_protection with kernel GSBASE,
+		 * which is what the stub expects, given that the faulting
+		 * RIP will be the IRET instruction.
 		 */
 		regs->ip = (unsigned long)general_protection;
 		regs->sp = (unsigned long)&gpregs->orig_ax;
-- 
2.17.1

