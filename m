Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC4720661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JgeuBpHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfB0KQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:16:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33214 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbfB0KQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=08cEf7ZZhvS94txX18h+LwwmRkpo0Hu8Ik3eoUFAeiE=; b=JgeuBpHP2Zs8Wtaz6f54ALxCVR
        L+PbXTihGSpQSjIy0K/gw3bnVSPDJrURy3LElVKzzJ86lUZ3c8quUSfTBWS/zrdgECqUo8xOVFksk
        zZu6G7t84zRHNbrjwSiSSLi5x81PKElvVxlxd+BArLmWDfxA5fdI32U5iPMKhY0vsuHimzFNTLp8e
        VYp+5UXPp/DmbKyI6mZak6hYAsZc3FwhPQjcHcCUyu65pToCOvpOD5hhRngRZUBRbKx/C5sV3ZqrT
        BwJjn5E1q7jem9WTUnuvWiyY5Bd/VEccRlnX5VQP2mkGBfzvCIlsPz+WYXbpCSzQqtzZVyi669ZOa
        UgK14rKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gywGO-0007nt-JX; Wed, 27 Feb 2019 10:16:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 072B52852476F; Wed, 27 Feb 2019 11:16:29 +0100 (CET)
Message-Id: <20190227101544.301542054@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 27 Feb 2019 11:12:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 2/5] x86/percpu: Relax smp_processor_id()
References: <20190227101252.413192716@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav reported that since this_cpu_read() became asm-volatile, many
smp_processor_id() users generated worse code due to the extra
constraints.

However since smp_processor_id() is reading a stable value, we can use
__this_cpu_read().

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/smp.h |    3 ++-
 include/linux/smp.h        |   45 +++++++++++++++++++++++++++++++--------------
 2 files changed, 33 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -162,7 +162,8 @@ __visible void smp_call_function_single_
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define raw_smp_processor_id() (this_cpu_read(cpu_number))
+#define raw_smp_processor_id()  this_cpu_read(cpu_number)
+#define __smp_processor_id() __this_cpu_read(cpu_number)
 
 #ifdef CONFIG_X86_32
 extern int safe_smp_processor_id(void);
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -181,29 +181,46 @@ static inline int get_boot_cpu_id(void)
 
 #endif /* !SMP */
 
-/*
- * smp_processor_id(): get the current CPU ID.
+/**
+ * raw_processor_id() - get the current (unstable) CPU id
+ *
+ * For then you know what you are doing and need an unstable
+ * CPU id.
+ */
+
+/**
+ * smp_processor_id() - get the current (stable) CPU id
+ *
+ * This is the normal accessor to the CPU id and should be used
+ * whenever possible.
  *
- * if DEBUG_PREEMPT is enabled then we check whether it is
- * used in a preemption-safe way. (smp_processor_id() is safe
- * if it's used in a preemption-off critical section, or in
- * a thread that is bound to the current CPU.)
+ * The CPU id is stable when:
+ *
+ *  - IRQs are disabled;
+ *  - preemption is disabled;
+ *  - the task is CPU affine.
  *
- * NOTE: raw_smp_processor_id() is for internal use only
- * (smp_processor_id() is the preferred variant), but in rare
- * instances it might also be used to turn off false positives
- * (i.e. smp_processor_id() use that the debugging code reports but
- * which use for some reason is legal). Don't use this to hack around
- * the warning message, as your code might not work under PREEMPT.
+ * When CONFIG_DEBUG_PREEMPT; we verify these assumption and WARN
+ * when smp_processor_id() is used when the CPU id is not stable.
  */
+
+/*
+ * Allow the architecture to differentiate between a stable and unstable read.
+ * For example, x86 uses an IRQ-safe asm-volatile read for the unstable but a
+ * regular asm read for the stable.
+ */
+#ifndef __smp_processor_id
+#define __smp_processor_id(x) raw_smp_processor_id(x)
+#endif
+
 #ifdef CONFIG_DEBUG_PREEMPT
   extern unsigned int debug_smp_processor_id(void);
 # define smp_processor_id() debug_smp_processor_id()
 #else
-# define smp_processor_id() raw_smp_processor_id()
+# define smp_processor_id() __smp_processor_id()
 #endif
 
-#define get_cpu()		({ preempt_disable(); smp_processor_id(); })
+#define get_cpu()		({ preempt_disable(); __smp_processor_id(); })
 #define put_cpu()		preempt_enable()
 
 /*


