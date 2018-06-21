Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341A4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2C2208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2C2208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933716AbeFUMOA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:14:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49394 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933258AbeFUMN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:13:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 300991435;
        Thu, 21 Jun 2018 05:13:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ABF783F578;
        Thu, 21 Jun 2018 05:13:56 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCHv4 12/18] atomics/powerpc: define atomic64_fetch_add_unless()
Date:   Thu, 21 Jun 2018 13:13:15 +0100
Message-Id: <20180621121321.4761-13-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the arch/powerpc implementation of atomic64_add_unless()
into an implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/atomic.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index b5646c079c16..233dbf31911c 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -525,7 +525,7 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_xchg_relaxed(v, new) xchg_relaxed(&((v)->counter), (new))
 
 /**
- * atomic64_add_unless - add unless the number is a given value
+ * atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -533,13 +533,13 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
+static __inline__ long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 {
 	long t;
 
 	__asm__ __volatile__ (
 	PPC_ATOMIC_ENTRY_BARRIER
-"1:	ldarx	%0,0,%1		# atomic_fetch_add_unless\n\
+"1:	ldarx	%0,0,%1		# atomic64_fetch_add_unless\n\
 	cmpd	0,%0,%3 \n\
 	beq	2f \n\
 	add	%0,%2,%0 \n"
@@ -552,8 +552,9 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 	: "r" (&v->counter), "r" (a), "r" (u)
 	: "cc", "memory");
 
-	return t != u;
+	return t;
 }
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 /**
  * atomic_inc64_not_zero - increment unless the number is zero
-- 
2.11.0

