Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9A1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D5240E7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9D5240E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeGEQlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:41:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53416 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753459AbeGEQl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:41:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52D017A9;
        Thu,  5 Jul 2018 09:41:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22D053F5BA;
        Thu,  5 Jul 2018 09:41:25 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, will.deacon@arm.com
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linuxdrivers@attotech.com,
        mark.rutland@arm.com, mingo@kernel.org, mingo@redhat.com,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: [PATCHv3 04/12] atomics/treewide: instrument xchg()
Date:   Thu,  5 Jul 2018 17:40:45 +0100
Message-Id: <20180705164053.10073-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180705164053.10073-1-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we instrument all of the (non-relaxed) atomic_*() functions and
cmpxchg(), we missed xchg().

Let's add instrumentation for xchg(), fixing up x86 to implement
arch_xchg().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/x86/include/asm/atomic.h             | 2 +-
 arch/x86/include/asm/atomic64_64.h        | 2 +-
 arch/x86/include/asm/cmpxchg.h            | 2 +-
 include/asm-generic/atomic-instrumented.h | 7 +++++++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 823fd2f320cf..b143717b92b3 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -202,7 +202,7 @@ static __always_inline bool arch_atomic_try_cmpxchg(atomic_t *v, int *old, int n
 
 static inline int arch_atomic_xchg(atomic_t *v, int new)
 {
-	return xchg(&v->counter, new);
+	return arch_xchg(&v->counter, new);
 }
 
 static inline void arch_atomic_and(int i, atomic_t *v)
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 849f1c566a11..4343d9b4f30e 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -188,7 +188,7 @@ static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, l
 
 static inline long arch_atomic64_xchg(atomic64_t *v, long new)
 {
-	return xchg(&v->counter, new);
+	return arch_xchg(&v->counter, new);
 }
 
 static inline void arch_atomic64_and(long i, atomic64_t *v)
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index e3efd8a06066..a55d79b233d3 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -75,7 +75,7 @@ extern void __add_wrong_size(void)
  * use "asm volatile" and "memory" clobbers to prevent gcc from moving
  * information around.
  */
-#define xchg(ptr, v)	__xchg_op((ptr), (v), xchg, "")
+#define arch_xchg(ptr, v)	__xchg_op((ptr), (v), xchg, "")
 
 /*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index c7c3e4cdd942..53481b6eacdf 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -408,6 +408,13 @@ static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
 }
 #endif
 
+#define xchg(ptr, new)							\
+({									\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_xchg(__ai_ptr, (new));					\
+})
+
 #define cmpxchg(ptr, old, new)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-- 
2.11.0

