Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C996CECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0432086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hw6ulbw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0432086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeGVSnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730090AbeGVSnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:43:02 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57E920878;
        Sun, 22 Jul 2018 17:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532281535;
        bh=BNJSDyUcS534h4/I6xNgsBJtQJXPMxd7px3/OcnTBr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Hw6ulbw40Rert94iMS/zWYY1vTzL4uFwG7MHLTmeOV2eSHcQ6v9h36AfyB3bA19Tw
         5kovAaLFPQ8tBxJEiWaY357c7QY7xyieJwaiR4/lxXDvKUiLfy2ORZuj2Kj1QeR3ii
         p0dSqVgDvFI32KxFGrm0E1IMA0dyqmYRTKicXgEM=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [RFC 1/2] x86/entry/64: Use the TSS sp2 slot for rsp_scratch
Date:   Sun, 22 Jul 2018 10:45:26 -0700
Message-Id: <38b5a24f3c9f519dd7dc98171eb3a3c669fff48c.1532281180.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1532281180.git.luto@kernel.org>
References: <cover.1532281180.git.luto@kernel.org>
In-Reply-To: <cover.1532281180.git.luto@kernel.org>
References: <cover.1532281180.git.luto@kernel.org>
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
 arch/x86/include/asm/processor.h   | 5 +++++
 arch/x86/include/asm/thread_info.h | 1 +
 arch/x86/kernel/asm-offsets_64.c   | 1 +
 arch/x86/kernel/process_64.c       | 2 --
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cfd29ee8c3da..2ef4c39ded45 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -308,7 +308,12 @@ struct x86_hw_tss {
 	 */
 	u64			sp1;
 
+	/*
+	 * sp2 is scratch space used by the SYSCALL64 handler.  Linux does
+	 * not use rung 2, so sp2 is not otherwise needed.
+	 */
 	u64			sp2;
+
 	u64			reserved2;
 	u64			ist[7];
 	u32			reserved3;
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 2ff2a30a264f..9a2f84233e39 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -209,6 +209,7 @@ static inline int arch_within_stack_frames(const void * const stack,
 
 #ifdef CONFIG_X86_64
 # define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)
+# define rsp_scratch (cpu_tss_rw + TSS_sp2)
 #endif
 
 #endif
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index b2dcd161f514..621bf6b5a63b 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -67,6 +67,7 @@ int main(void)
 	OFFSET(TSS_ist, tss_struct, x86_tss.ist);
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
+	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 	BLANK();
 
 #ifdef CONFIG_STACKPROTECTOR
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 12bb445fb98d..3ed5fed181cc 100644
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
-- 
2.17.1

