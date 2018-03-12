Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeCLMZL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:25:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeCLMZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:25:04 -0400
Date: Mon, 12 Mar 2018 05:24:41 -0700
From: tip-bot for Dmitry Vyukov <tipbot@zytor.com>
Message-ID: <tip-a35353bb9eb1990a44a0d7585f99e9589bcdb682@git.kernel.org>
Cc: mingo@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, torvalds@linux-foundation.org, mingo@kernel.org,
        mark.rutland@arm.com, tglx@linutronix.de
In-Reply-To: <2fa6e7f0210fd20fe404e5b67e6e9213af2b69a1.1517246437.git.dvyukov@google.com>
References: <2fa6e7f0210fd20fe404e5b67e6e9213af2b69a1.1517246437.git.dvyukov@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, asm-generic: Add KASAN
 instrumentation to atomic operations
Git-Commit-ID: a35353bb9eb1990a44a0d7585f99e9589bcdb682
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a35353bb9eb1990a44a0d7585f99e9589bcdb682
Gitweb:     https://git.kernel.org/tip/a35353bb9eb1990a44a0d7585f99e9589bcdb682
Author:     Dmitry Vyukov <dvyukov@google.com>
AuthorDate: Mon, 29 Jan 2018 18:26:06 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:15:35 +0100

locking/atomic, asm-generic: Add KASAN instrumentation to atomic operations

KASAN uses compiler instrumentation to intercept all memory accesses. But it does
not see memory accesses done in assembly code. One notable user of assembly code
is atomic operations. Frequently, for example, an atomic reference decrement is
the last access to an object and a good candidate for a racy use-after-free.

Add manual KASAN checks to atomic operations.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>,
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/2fa6e7f0210fd20fe404e5b67e6e9213af2b69a1.1517246437.git.dvyukov@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/atomic-instrumented.h | 62 +++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index b966194d120a..82e080505982 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -2,44 +2,53 @@
 #define _LINUX_ATOMIC_INSTRUMENTED_H
 
 #include <linux/build_bug.h>
+#include <linux/kasan-checks.h>
 
 static __always_inline int atomic_read(const atomic_t *v)
 {
+	kasan_check_read(v, sizeof(*v));
 	return arch_atomic_read(v);
 }
 
 static __always_inline s64 atomic64_read(const atomic64_t *v)
 {
+	kasan_check_read(v, sizeof(*v));
 	return arch_atomic64_read(v);
 }
 
 static __always_inline void atomic_set(atomic_t *v, int i)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic_set(v, i);
 }
 
 static __always_inline void atomic64_set(atomic64_t *v, s64 i)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_set(v, i);
 }
 
 static __always_inline int atomic_xchg(atomic_t *v, int i)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_xchg(v, i);
 }
 
 static __always_inline s64 atomic64_xchg(atomic64_t *v, s64 i)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_xchg(v, i);
 }
 
 static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg(v, old, new);
 }
 
 static __always_inline s64 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg(v, old, new);
 }
 
@@ -47,6 +56,8 @@ static __always_inline s64 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 #define atomic_try_cmpxchg atomic_try_cmpxchg
 static __always_inline bool atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
+	kasan_check_write(v, sizeof(*v));
+	kasan_check_read(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg(v, old, new);
 }
 #endif
@@ -55,234 +66,281 @@ static __always_inline bool atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 #define atomic64_try_cmpxchg atomic64_try_cmpxchg
 static __always_inline bool atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
+	kasan_check_write(v, sizeof(*v));
+	kasan_check_read(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg(v, old, new);
 }
 #endif
 
 static __always_inline int __atomic_add_unless(atomic_t *v, int a, int u)
 {
+	kasan_check_write(v, sizeof(*v));
 	return __arch_atomic_add_unless(v, a, u);
 }
 
 
 static __always_inline bool atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_add_unless(v, a, u);
 }
 
 static __always_inline void atomic_inc(atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic_inc(v);
 }
 
 static __always_inline void atomic64_inc(atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_inc(v);
 }
 
 static __always_inline void atomic_dec(atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic_dec(v);
 }
 
 static __always_inline void atomic64_dec(atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_dec(v);
 }
 
 static __always_inline void atomic_add(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic_add(i, v);
 }
 
 static __always_inline void atomic64_add(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_add(i, v);
 }
 
 static __always_inline void atomic_sub(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic_sub(i, v);
 }
 
 static __always_inline void atomic64_sub(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_sub(i, v);
 }
 
 static __always_inline void atomic_and(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic_and(i, v);
 }
 
 static __always_inline void atomic64_and(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_and(i, v);
 }
 
 static __always_inline void atomic_or(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic_or(i, v);
 }
 
 static __always_inline void atomic64_or(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_or(i, v);
 }
 
 static __always_inline void atomic_xor(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic_xor(i, v);
 }
 
 static __always_inline void atomic64_xor(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	arch_atomic64_xor(i, v);
 }
 
 static __always_inline int atomic_inc_return(atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_inc_return(v);
 }
 
 static __always_inline s64 atomic64_inc_return(atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_return(v);
 }
 
 static __always_inline int atomic_dec_return(atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_dec_return(v);
 }
 
 static __always_inline s64 atomic64_dec_return(atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_return(v);
 }
 
 static __always_inline s64 atomic64_inc_not_zero(atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_not_zero(v);
 }
 
 static __always_inline s64 atomic64_dec_if_positive(atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_if_positive(v);
 }
 
 static __always_inline bool atomic_dec_and_test(atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_dec_and_test(v);
 }
 
 static __always_inline bool atomic64_dec_and_test(atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_dec_and_test(v);
 }
 
 static __always_inline bool atomic_inc_and_test(atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_inc_and_test(v);
 }
 
 static __always_inline bool atomic64_inc_and_test(atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_inc_and_test(v);
 }
 
 static __always_inline int atomic_add_return(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_add_return(i, v);
 }
 
 static __always_inline s64 atomic64_add_return(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_add_return(i, v);
 }
 
 static __always_inline int atomic_sub_return(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_sub_return(i, v);
 }
 
 static __always_inline s64 atomic64_sub_return(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_return(i, v);
 }
 
 static __always_inline int atomic_fetch_add(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_add(i, v);
 }
 
 static __always_inline s64 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add(i, v);
 }
 
 static __always_inline int atomic_fetch_sub(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub(i, v);
 }
 
 static __always_inline s64 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub(i, v);
 }
 
 static __always_inline int atomic_fetch_and(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_and(i, v);
 }
 
 static __always_inline s64 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and(i, v);
 }
 
 static __always_inline int atomic_fetch_or(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_or(i, v);
 }
 
 static __always_inline s64 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or(i, v);
 }
 
 static __always_inline int atomic_fetch_xor(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor(i, v);
 }
 
 static __always_inline s64 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor(i, v);
 }
 
 static __always_inline bool atomic_sub_and_test(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_sub_and_test(i, v);
 }
 
 static __always_inline bool atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_sub_and_test(i, v);
 }
 
 static __always_inline bool atomic_add_negative(int i, atomic_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic_add_negative(i, v);
 }
 
 static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
 {
+	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_add_negative(i, v);
 }
 
 static __always_inline unsigned long
 cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
+	kasan_check_write(ptr, size);
 	switch (size) {
 	case 1:
 		return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
@@ -308,6 +366,7 @@ static __always_inline unsigned long
 sync_cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new,
 		  int size)
 {
+	kasan_check_write(ptr, size);
 	switch (size) {
 	case 1:
 		return arch_sync_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
@@ -334,6 +393,7 @@ static __always_inline unsigned long
 cmpxchg_local_size(volatile void *ptr, unsigned long old, unsigned long new,
 		   int size)
 {
+	kasan_check_write(ptr, size);
 	switch (size) {
 	case 1:
 		return arch_cmpxchg_local((u8 *)ptr, (u8)old, (u8)new);
@@ -359,6 +419,7 @@ cmpxchg_local_size(volatile void *ptr, unsigned long old, unsigned long new,
 static __always_inline u64
 cmpxchg64_size(volatile u64 *ptr, u64 old, u64 new)
 {
+	kasan_check_write(ptr, sizeof(*ptr));
 	return arch_cmpxchg64(ptr, old, new);
 }
 
@@ -371,6 +432,7 @@ cmpxchg64_size(volatile u64 *ptr, u64 old, u64 new)
 static __always_inline u64
 cmpxchg64_local_size(volatile u64 *ptr, u64 old, u64 new)
 {
+	kasan_check_write(ptr, sizeof(*ptr));
 	return arch_cmpxchg64_local(ptr, old, new);
 }
 
