Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044882088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044882088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeGYPq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:46:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47013 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbeGYPq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:46:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEYZiw403369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:34:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEYZ7i403366;
        Wed, 25 Jul 2018 07:34:35 -0700
Date:   Wed, 25 Jul 2018 07:34:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-df79ed2c064363cdc7d2d896923c1885d4e30520@git.kernel.org>
Cc:     dvyukov@google.com, torvalds@linux-foundation.org,
        will.deacon@arm.com, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, boqun.feng@gmail.com
Reply-To: will.deacon@arm.com, hpa@zytor.com, peterz@infradead.org,
          mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
          linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
          dvyukov@google.com, torvalds@linux-foundation.org
In-Reply-To: <20180716113017.3909-4-mark.rutland@arm.com>
References: <20180716113017.3909-4-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Simplify cmpxchg()
 instrumentation
Git-Commit-ID: df79ed2c064363cdc7d2d896923c1885d4e30520
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

Commit-ID:  df79ed2c064363cdc7d2d896923c1885d4e30520
Gitweb:     https://git.kernel.org/tip/df79ed2c064363cdc7d2d896923c1885d4e30520
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Mon, 16 Jul 2018 12:30:08 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:53:58 +0200

locking/atomics: Simplify cmpxchg() instrumentation

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
Link: http://lkml.kernel.org/r/20180716113017.3909-4-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
