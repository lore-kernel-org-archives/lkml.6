Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B24C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABBC208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABBC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933667AbeFUMN4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:13:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49370 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933478AbeFUMNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:13:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D50A715BE;
        Thu, 21 Jun 2018 05:13:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80FB13F578;
        Thu, 21 Jun 2018 05:13:52 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCHv4 10/18] atomics/arc: define atomic64_fetch_add_unless()
Date:   Thu, 21 Jun 2018 13:13:13 +0100
Message-Id: <20180621121321.4761-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the arch/arc implementation of atomic64_add_unless() into
an implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic.h | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 60da80481c5d..4917ffa61579 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -531,41 +531,40 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
 }
 
 /**
- * atomic64_add_unless - add unless the number is a given value
+ * atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
  *
- * if (v != u) { v += a; ret = 1} else {ret = 0}
- * Returns 1 iff @v was not @u (i.e. if add actually happened)
+ * Atomically adds @a to @v, if it was not @u.
+ * Returns the old value of @v
  */
-static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
+static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
+						  long long u)
 {
-	long long val;
-	int op_done;
+	long long old, temp;
 
 	smp_mb();
 
 	__asm__ __volatile__(
 	"1:	llockd  %0, [%2]	\n"
-	"	mov	%1, 1		\n"
 	"	brne	%L0, %L4, 2f	# continue to add since v != u \n"
 	"	breq.d	%H0, %H4, 3f	# return since v == u \n"
-	"	mov	%1, 0		\n"
 	"2:				\n"
-	"	add.f   %L0, %L0, %L3	\n"
-	"	adc     %H0, %H0, %H3	\n"
-	"	scondd  %0, [%2]	\n"
+	"	add.f   %L1, %L0, %L3	\n"
+	"	adc     %H1, %H0, %H3	\n"
+	"	scondd  %1, [%2]	\n"
 	"	bnz     1b		\n"
 	"3:				\n"
-	: "=&r"(val), "=&r" (op_done)
+	: "=&r"(old), "=&r" (temp)
 	: "r"(&v->counter), "r"(a), "r"(u)
 	: "cc");	/* memory clobber comes from smp_mb() */
 
 	smp_mb();
 
-	return op_done;
+	return old;
 }
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 #define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
-- 
2.11.0

