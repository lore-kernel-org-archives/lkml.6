Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A831C5CFC2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200DC20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200DC20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936997AbeFRKTy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:19:54 -0400
Received: from foss.arm.com ([217.140.101.70]:59440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936958AbeFRKTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:19:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4939A15B2;
        Mon, 18 Jun 2018 03:19:51 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A28043F25D;
        Mon, 18 Jun 2018 03:19:49 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     mingo@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCHv3 09/18] atomics/alpha: define atomic64_fetch_add_unless()
Date:   Mon, 18 Jun 2018 11:19:10 +0100
Message-Id: <20180618101919.51973-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180618101919.51973-1-mark.rutland@arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the arch/alpha implementation of atomic64_add_unless() into
an implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/atomic.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 4a800a3424a3..dcb7bbeeae02 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -238,35 +238,36 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #define atomic_fetch_add_unless atomic_fetch_add_unless
 
 /**
- * atomic64_add_unless - add unless the number is a given value
+ * atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
  *
  * Atomically adds @a to @v, so long as it was not @u.
- * Returns true iff @v was not @u.
+ * Returns the old value of @v.
  */
-static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
+static __inline__ int atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
 {
-	long c, tmp;
+	long c, new, old;
 	smp_mb();
 	__asm__ __volatile__(
-	"1:	ldq_l	%[tmp],%[mem]\n"
-	"	cmpeq	%[tmp],%[u],%[c]\n"
-	"	addq	%[tmp],%[a],%[tmp]\n"
+	"1:	ldq_l	%[old],%[mem]\n"
+	"	cmpeq	%[old],%[u],%[c]\n"
+	"	addq	%[old],%[a],%[new]\n"
 	"	bne	%[c],2f\n"
-	"	stq_c	%[tmp],%[mem]\n"
-	"	beq	%[tmp],3f\n"
+	"	stq_c	%[new],%[mem]\n"
+	"	beq	%[new],3f\n"
 	"2:\n"
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
-	: [tmp] "=&r"(tmp), [c] "=&r"(c)
+	: [old] "=&r"(old), [new] "=&r"(new), [c] "=&r"(c)
 	: [mem] "m"(*v), [a] "rI"(a), [u] "rI"(u)
 	: "memory");
 	smp_mb();
-	return !c;
+	return old;
 }
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 /*
  * atomic64_dec_if_positive - decrement by 1 if old value positive
-- 
2.11.0

