Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C2D240E7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C2D240E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeGEQl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:41:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53380 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753483AbeGEQlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:41:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBA2B1650;
        Thu,  5 Jul 2018 09:41:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F90E3F5BA;
        Thu,  5 Jul 2018 09:41:20 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, will.deacon@arm.com
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linuxdrivers@attotech.com,
        mark.rutland@arm.com, mingo@kernel.org, mingo@redhat.com,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: [PATCHv3 03/12] atomics: simplify cmpxchg() instrumentation
Date:   Thu,  5 Jul 2018 17:40:44 +0100
Message-Id: <20180705164053.10073-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180705164053.10073-1-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we define some fairly verbose wrappers for the cmpxchg()
family so that we can pass a pointer and size into kasan_check_write().

The wrappers duplicate the size-switching logic necessary in arch code,
and only work for scalar types. On some architectures, (cmp)xchg are
used on non-scalar types, and thus the instrumented wrappers need to be
able to handle this.

We could take the type-punning logic from {READ,WRITE}_ONCE(), but this
makes the wrappers even more verbose, and requires several local
variables in the macros.

Instead, let's simplify the wrappers into simple macros which:

* snapshot the pointer into a single local variable, called __ai_ptr to
  avoid conflicts with variables in the scope of the caller.

* call kasan_check_write() on __ai_ptr.

* invoke the relevant arch_*() function, passing the original arguments,
  bar __ai_ptr being substituted for ptr.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/atomic-instrumented.h | 100 +++++-------------------------
 1 file changed, 15 insertions(+), 85 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 3c64e95d5ed0..c7c3e4cdd942 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -408,109 +408,39 @@ static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
 }
 #endif
 
-static __always_inline unsigned long
-cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
-{
-	kasan_check_write(ptr, size);
-	switch (size) {
-	case 1:
-		return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
-	case 2:
-		return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
-	case 4:
-		return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
-	case 8:
-		BUILD_BUG_ON(sizeof(unsigned long) != 8);
-		return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
-	}
-	BUILD_BUG();
-	return 0;
-}
-
 #define cmpxchg(ptr, old, new)						\
 ({									\
-	((__typeof__(*(ptr)))cmpxchg_size((ptr), (unsigned long)(old),	\
-		(unsigned long)(new), sizeof(*(ptr))));			\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_cmpxchg(__ai_ptr, (old), (new));				\
 })
 
-static __always_inline unsigned long
-sync_cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new,
-		  int size)
-{
-	kasan_check_write(ptr, size);
-	switch (size) {
-	case 1:
-		return arch_sync_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
-	case 2:
-		return arch_sync_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
-	case 4:
-		return arch_sync_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
-	case 8:
-		BUILD_BUG_ON(sizeof(unsigned long) != 8);
-		return arch_sync_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
-	}
-	BUILD_BUG();
-	return 0;
-}
-
 #define sync_cmpxchg(ptr, old, new)					\
 ({									\
-	((__typeof__(*(ptr)))sync_cmpxchg_size((ptr),			\
-		(unsigned long)(old), (unsigned long)(new),		\
-		sizeof(*(ptr))));					\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_sync_cmpxchg(__ai_ptr, (old), (new));			\
 })
 
-static __always_inline unsigned long
-cmpxchg_local_size(volatile void *ptr, unsigned long old, unsigned long new,
-		   int size)
-{
-	kasan_check_write(ptr, size);
-	switch (size) {
-	case 1:
-		return arch_cmpxchg_local((u8 *)ptr, (u8)old, (u8)new);
-	case 2:
-		return arch_cmpxchg_local((u16 *)ptr, (u16)old, (u16)new);
-	case 4:
-		return arch_cmpxchg_local((u32 *)ptr, (u32)old, (u32)new);
-	case 8:
-		BUILD_BUG_ON(sizeof(unsigned long) != 8);
-		return arch_cmpxchg_local((u64 *)ptr, (u64)old, (u64)new);
-	}
-	BUILD_BUG();
-	return 0;
-}
-
 #define cmpxchg_local(ptr, old, new)					\
 ({									\
-	((__typeof__(*(ptr)))cmpxchg_local_size((ptr),			\
-		(unsigned long)(old), (unsigned long)(new),		\
-		sizeof(*(ptr))));					\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_cmpxchg_local(__ai_ptr, (old), (new));			\
 })
 
-static __always_inline u64
-cmpxchg64_size(volatile u64 *ptr, u64 old, u64 new)
-{
-	kasan_check_write(ptr, sizeof(*ptr));
-	return arch_cmpxchg64(ptr, old, new);
-}
-
 #define cmpxchg64(ptr, old, new)					\
 ({									\
-	((__typeof__(*(ptr)))cmpxchg64_size((ptr), (u64)(old),		\
-		(u64)(new)));						\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_cmpxchg64(__ai_ptr, (old), (new));				\
 })
 
-static __always_inline u64
-cmpxchg64_local_size(volatile u64 *ptr, u64 old, u64 new)
-{
-	kasan_check_write(ptr, sizeof(*ptr));
-	return arch_cmpxchg64_local(ptr, old, new);
-}
-
 #define cmpxchg64_local(ptr, old, new)					\
 ({									\
-	((__typeof__(*(ptr)))cmpxchg64_local_size((ptr), (u64)(old),	\
-		(u64)(new)));						\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_cmpxchg64_local(__ai_ptr, (old), (new));			\
 })
 
 /*
-- 
2.11.0

