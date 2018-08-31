Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09113C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56DE20846
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYJNhReb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56DE20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIACb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeIACb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:31:27 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E987920843;
        Fri, 31 Aug 2018 22:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535754116;
        bh=SZUMjxbRB74u1VdxOnn9xCDl/KOy8peaoKX/yE1N2cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=sYJNhReb1+G9e53bi9YwbCmxmIv75ufXqHzN2KLcLcel5ksRp2/DUARPmJb30RX0k
         mRBFNCCVvaJjAtxTLxw98q4Ylip3djZWARxoTKzEt92GMSPtZh5fszLBduqgrG4VYd
         Ub0HCmoP3rZR0LtAFIZQnpXVt4JqLWLM2BKFWHpM=
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
Subject: [PATCH 2/3] x86/entry/64: Use the TSS sp2 slot for rsp_scratch
Date:   Fri, 31 Aug 2018 15:21:48 -0700
Message-Id: <9d79fddf6bab2fc40c2472bdea47f864603c1bf4.1535753890.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535753890.git.luto@kernel.org>
References: <cover.1535753890.git.luto@kernel.org>
In-Reply-To: <cover.1535753890.git.luto@kernel.org>
References: <cover.1535753890.git.luto@kernel.org>
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
 arch/x86/include/asm/processor.h   | 6 ++++++
 arch/x86/include/asm/thread_info.h | 1 +
 arch/x86/kernel/asm-offsets.c      | 3 ++-
 arch/x86/kernel/process_64.c       | 2 --
 4 files changed, 9 insertions(+), 3 deletions(-)

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
-- 
2.17.1

