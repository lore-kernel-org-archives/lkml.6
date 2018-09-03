Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65459C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFC72077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBI6yOgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFC72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeICGs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:48:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RO9UQM7RG6KsPGcU1VOnAzKoscjv1x+4M6m2dLGo10U=; b=WBI6yOgWb0ecnyOG/8/s2k5vmm
        2X7VA6Wq+hJAtjY9vb1zPUaoWG26bnZDBkPwtZDofTIzhdpDLAL5o4d7tAaOv4yfIKcFwbvZI7AE9
        CK1ZUA5JAbyrzlHsYgLiIjNbe5VCHXMUOImZe9RwfW5+8fM7XomCwguIuGvhNd9htjzd5zQvNvdoR
        smVZ7+pygbk9XzDOUAi7emcaghUo2eCOSH+/kIA1dBQkq4k3WSuZwQA/l08yws/jzldBdaoxyJ0Kk
        2Hl1ILBSSFGd/otTMfBe4RC2vHGQJ0Ks79PWOoNNZXAh53rTZGRmKm2UQK1ooFzguQxEnmfcEe5h9
        CR3kVzXg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwedj-0005Tr-Dg; Mon, 03 Sep 2018 02:30:55 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] x86: fix kernel-doc atomic.h warnings
Message-ID: <0a1e678d-c8c5-b32c-2640-ed4e94d399d2@infradead.org>
Date:   Sun, 2 Sep 2018 19:30:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in arch/x86/include/asm/atomic.h that are
caused by having a #define macro between the kernel-doc notation
and the function name.  Fixed by moving the #define macro to after
the function implementation.

Make the same change for atomic64_{32,64}.h for consistency even
though there were no kernel-doc warnings found in these header files,
but there would be if they were used in generation of documentation.

Fixes these kernel-doc warnings:

../arch/x86/include/asm/atomic.h:84: warning: Excess function parameter 'i' description in 'arch_atomic_sub_and_test'
../arch/x86/include/asm/atomic.h:84: warning: Excess function parameter 'v' description in 'arch_atomic_sub_and_test'
../arch/x86/include/asm/atomic.h:96: warning: Excess function parameter 'v' description in 'arch_atomic_inc'
../arch/x86/include/asm/atomic.h:109: warning: Excess function parameter 'v' description in 'arch_atomic_dec'
../arch/x86/include/asm/atomic.h:124: warning: Excess function parameter 'v' description in 'arch_atomic_dec_and_test'
../arch/x86/include/asm/atomic.h:138: warning: Excess function parameter 'v' description in 'arch_atomic_inc_and_test'
../arch/x86/include/asm/atomic.h:153: warning: Excess function parameter 'i' description in 'arch_atomic_add_negative'
../arch/x86/include/asm/atomic.h:153: warning: Excess function parameter 'v' description in 'arch_atomic_add_negative'

Fixes: 18cc1814d4e7 ("atomics/treewide: Make test ops optional")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/x86/include/asm/atomic.h      |   12 ++++++------
 arch/x86/include/asm/atomic64_32.h |    8 ++++----
 arch/x86/include/asm/atomic64_64.h |   12 ++++++------
 3 files changed, 16 insertions(+), 16 deletions(-)

--- lnx-419-rc2.orig/arch/x86/include/asm/atomic.h
+++ lnx-419-rc2/arch/x86/include/asm/atomic.h
@@ -80,11 +80,11 @@ static __always_inline void arch_atomic_
  * true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, "er", i, "%0", e);
 }
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 
 /**
  * arch_atomic_inc - increment atomic variable
@@ -92,12 +92,12 @@ static __always_inline bool arch_atomic_
  *
  * Atomically increments @v by 1.
  */
-#define arch_atomic_inc arch_atomic_inc
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "incl %0"
 		     : "+m" (v->counter));
 }
+#define arch_atomic_inc arch_atomic_inc
 
 /**
  * arch_atomic_dec - decrement atomic variable
@@ -105,12 +105,12 @@ static __always_inline void arch_atomic_
  *
  * Atomically decrements @v by 1.
  */
-#define arch_atomic_dec arch_atomic_dec
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "decl %0"
 		     : "+m" (v->counter));
 }
+#define arch_atomic_dec arch_atomic_dec
 
 /**
  * arch_atomic_dec_and_test - decrement and test
@@ -120,11 +120,11 @@ static __always_inline void arch_atomic_
  * returns true if the result is 0, or false for all other
  * cases.
  */
-#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", e);
 }
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 
 /**
  * arch_atomic_inc_and_test - increment and test
@@ -134,11 +134,11 @@ static __always_inline bool arch_atomic_
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, "%0", e);
 }
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
 /**
  * arch_atomic_add_negative - add and test if negative
@@ -149,11 +149,11 @@ static __always_inline bool arch_atomic_
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-#define arch_atomic_add_negative arch_atomic_add_negative
 static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, "er", i, "%0", s);
 }
+#define arch_atomic_add_negative arch_atomic_add_negative
 
 /**
  * arch_atomic_add_return - add integer and return
--- lnx-419-rc2.orig/arch/x86/include/asm/atomic64_32.h
+++ lnx-419-rc2/arch/x86/include/asm/atomic64_32.h
@@ -205,12 +205,12 @@ static inline long long arch_atomic64_su
  *
  * Atomically increments @v by 1.
  */
-#define arch_atomic64_inc arch_atomic64_inc
 static inline void arch_atomic64_inc(atomic64_t *v)
 {
 	__alternative_atomic64(inc, inc_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
 }
+#define arch_atomic64_inc arch_atomic64_inc
 
 /**
  * arch_atomic64_dec - decrement atomic64 variable
@@ -218,12 +218,12 @@ static inline void arch_atomic64_inc(ato
  *
  * Atomically decrements @v by 1.
  */
-#define arch_atomic64_dec arch_atomic64_dec
 static inline void arch_atomic64_dec(atomic64_t *v)
 {
 	__alternative_atomic64(dec, dec_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
 }
+#define arch_atomic64_dec arch_atomic64_dec
 
 /**
  * arch_atomic64_add_unless - add unless the number is a given value
@@ -245,7 +245,6 @@ static inline int arch_atomic64_add_unle
 	return (int)a;
 }
 
-#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
 	int r;
@@ -253,8 +252,8 @@ static inline int arch_atomic64_inc_not_
 			     "S" (v) : "ecx", "edx", "memory");
 	return r;
 }
+#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 
-#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 static inline long long arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	long long r;
@@ -262,6 +261,7 @@ static inline long long arch_atomic64_de
 			     "S" (v) : "ecx", "memory");
 	return r;
 }
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
 #undef alternative_atomic64
 #undef __alternative_atomic64
--- lnx-419-rc2.orig/arch/x86/include/asm/atomic64_64.h
+++ lnx-419-rc2/arch/x86/include/asm/atomic64_64.h
@@ -71,11 +71,11 @@ static inline void arch_atomic64_sub(lon
  * true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, "er", i, "%0", e);
 }
+#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 
 /**
  * arch_atomic64_inc - increment atomic64 variable
@@ -83,13 +83,13 @@ static inline bool arch_atomic64_sub_and
  *
  * Atomically increments @v by 1.
  */
-#define arch_atomic64_inc arch_atomic64_inc
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "incq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter));
 }
+#define arch_atomic64_inc arch_atomic64_inc
 
 /**
  * arch_atomic64_dec - decrement atomic64 variable
@@ -97,13 +97,13 @@ static __always_inline void arch_atomic6
  *
  * Atomically decrements @v by 1.
  */
-#define arch_atomic64_dec arch_atomic64_dec
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "decq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter));
 }
+#define arch_atomic64_dec arch_atomic64_dec
 
 /**
  * arch_atomic64_dec_and_test - decrement and test
@@ -113,11 +113,11 @@ static __always_inline void arch_atomic6
  * returns true if the result is 0, or false for all other
  * cases.
  */
-#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, "%0", e);
 }
+#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 
 /**
  * arch_atomic64_inc_and_test - increment and test
@@ -127,11 +127,11 @@ static inline bool arch_atomic64_dec_and
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, "%0", e);
 }
+#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 
 /**
  * arch_atomic64_add_negative - add and test if negative
@@ -142,11 +142,11 @@ static inline bool arch_atomic64_inc_and
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-#define arch_atomic64_add_negative arch_atomic64_add_negative
 static inline bool arch_atomic64_add_negative(long i, atomic64_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, "er", i, "%0", s);
 }
+#define arch_atomic64_add_negative arch_atomic64_add_negative
 
 /**
  * arch_atomic64_add_return - add and return

