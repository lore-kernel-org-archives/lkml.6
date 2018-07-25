Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D9C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C7E2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C7E2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbeGYPrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:47:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58225 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbeGYPrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:47:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEZ8Eb403411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:35:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEZ7WH403408;
        Wed, 25 Jul 2018 07:35:07 -0700
Date:   Wed, 25 Jul 2018 07:35:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-f9881cc43b118efc6f82fef2d121166113ee9f8e@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com,
        torvalds@linux-foundation.org, hpa@zytor.com, mark.rutland@arm.com,
        will.deacon@arm.com, dvyukov@google.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, mark.rutland@arm.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          boqun.feng@gmail.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dvyukov@google.com, will.deacon@arm.com
In-Reply-To: <20180716113017.3909-5-mark.rutland@arm.com>
References: <20180716113017.3909-5-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Instrument xchg()
Git-Commit-ID: f9881cc43b118efc6f82fef2d121166113ee9f8e
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

Commit-ID:  f9881cc43b118efc6f82fef2d121166113ee9f8e
Gitweb:     https://git.kernel.org/tip/f9881cc43b118efc6f82fef2d121166113ee9f8e
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Mon, 16 Jul 2018 12:30:09 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:53:59 +0200

locking/atomics: Instrument xchg()

While we instrument all of the (non-relaxed) atomic_*() functions and
cmpxchg(), we missed xchg().

Let's add instrumentation for xchg(), fixing up x86 to implement
arch_xchg().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: andy.shevchenko@gmail.com
Cc: arnd@arndb.de
Cc: aryabinin@virtuozzo.com
Cc: catalin.marinas@arm.com
Cc: glider@google.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: parri.andrea@gmail.com
Cc: peter@hurleysoftware.com
Link: http://lkml.kernel.org/r/20180716113017.3909-5-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
