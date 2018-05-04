Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeEDRkI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:40:08 -0400
Received: from foss.arm.com ([217.140.101.70]:57428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbeEDRkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:40:06 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        will.deacon@arm.com
Subject: [PATCH 6/6] arm64: instrument smp_{load_acquire,store_release}
Date: Fri,  4 May 2018 18:39:37 +0100
Message-Id: <20180504173937.25300-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504173937.25300-1-mark.rutland@arm.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our __smp_store_release() and __smp_load_acquire() macros use inline
assembly, which is opaque to kasan. This means that kasan can't catch
erroneous use of these.

This patch adds kasan instrumentation to both.

It might be better to turn these into __arch_* variants, as we do for
the atomics, but this works for the time being.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/barrier.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index f11518af96a9..1a9c601619e5 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -20,6 +20,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/kasan-checks.h>
+
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		asm volatile(__nops(n))
 
@@ -68,31 +70,33 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
 
 #define __smp_store_release(p, v)					\
 do {									\
+	typeof(p) __p = (p);						\
 	union { typeof(*p) __val; char __c[1]; } __u =			\
 		{ .__val = (__force typeof(*p)) (v) }; 			\
 	compiletime_assert_atomic_type(*p);				\
+	kasan_check_write(__p, sizeof(*__p));				\
 	switch (sizeof(*p)) {						\
 	case 1:								\
 		asm volatile ("stlrb %w1, %0"				\
-				: "=Q" (*p)				\
+				: "=Q" (*__p)				\
 				: "r" (*(__u8 *)__u.__c)		\
 				: "memory");				\
 		break;							\
 	case 2:								\
 		asm volatile ("stlrh %w1, %0"				\
-				: "=Q" (*p)				\
+				: "=Q" (*__p)				\
 				: "r" (*(__u16 *)__u.__c)		\
 				: "memory");				\
 		break;							\
 	case 4:								\
 		asm volatile ("stlr %w1, %0"				\
-				: "=Q" (*p)				\
+				: "=Q" (*__p)				\
 				: "r" (*(__u32 *)__u.__c)		\
 				: "memory");				\
 		break;							\
 	case 8:								\
 		asm volatile ("stlr %1, %0"				\
-				: "=Q" (*p)				\
+				: "=Q" (*__p)				\
 				: "r" (*(__u64 *)__u.__c)		\
 				: "memory");				\
 		break;							\
@@ -102,27 +106,29 @@ do {									\
 #define __smp_load_acquire(p)						\
 ({									\
 	union { typeof(*p) __val; char __c[1]; } __u;			\
+	typeof(p) __p = (p);						\
 	compiletime_assert_atomic_type(*p);				\
+	kasan_check_read(__p, sizeof(*__p));				\
 	switch (sizeof(*p)) {						\
 	case 1:								\
 		asm volatile ("ldarb %w0, %1"				\
 			: "=r" (*(__u8 *)__u.__c)			\
-			: "Q" (*p) : "memory");				\
+			: "Q" (*__p) : "memory");			\
 		break;							\
 	case 2:								\
 		asm volatile ("ldarh %w0, %1"				\
 			: "=r" (*(__u16 *)__u.__c)			\
-			: "Q" (*p) : "memory");				\
+			: "Q" (*__p) : "memory");			\
 		break;							\
 	case 4:								\
 		asm volatile ("ldar %w0, %1"				\
 			: "=r" (*(__u32 *)__u.__c)			\
-			: "Q" (*p) : "memory");				\
+			: "Q" (*__p) : "memory");			\
 		break;							\
 	case 8:								\
 		asm volatile ("ldar %0, %1"				\
 			: "=r" (*(__u64 *)__u.__c)			\
-			: "Q" (*p) : "memory");				\
+			: "Q" (*__p) : "memory");			\
 		break;							\
 	}								\
 	__u.__val;							\
-- 
2.11.0
