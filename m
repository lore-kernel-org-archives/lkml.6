Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3522DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CEB20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CEB20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937009AbeFRKT5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:19:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59470 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933946AbeFRKTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:19:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5FF15BF;
        Mon, 18 Jun 2018 03:19:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B57D3F25D;
        Mon, 18 Jun 2018 03:19:54 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     mingo@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCHv3 11/18] atomics/arm: define atomic64_fetch_add_unless()
Date:   Mon, 18 Jun 2018 11:19:12 +0100
Message-Id: <20180618101919.51973-12-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180618101919.51973-1-mark.rutland@arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the arch/arm implementation of atomic64_add_unless() into
an implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/atomic.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 74460aa00fa0..852e1fee72b0 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -486,11 +486,11 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
 	return result;
 }
 
-static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
+static inline long long atomic64_fetch_add_unless(atomic64_t *v, long long a,
+						  long long u)
 {
-	long long val;
+	long long oldval, newval;
 	unsigned long tmp;
-	int ret = 1;
 
 	smp_mb();
 	prefetchw(&v->counter);
@@ -499,23 +499,23 @@ static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 "1:	ldrexd	%0, %H0, [%4]\n"
 "	teq	%0, %5\n"
 "	teqeq	%H0, %H5\n"
-"	moveq	%1, #0\n"
 "	beq	2f\n"
-"	adds	%Q0, %Q0, %Q6\n"
-"	adc	%R0, %R0, %R6\n"
-"	strexd	%2, %0, %H0, [%4]\n"
+"	adds	%Q1, %Q0, %Q6\n"
+"	adc	%R1, %R0, %R6\n"
+"	strexd	%2, %1, %H1, [%4]\n"
 "	teq	%2, #0\n"
 "	bne	1b\n"
 "2:"
-	: "=&r" (val), "+r" (ret), "=&r" (tmp), "+Qo" (v->counter)
+	: "=&r" (oldval), "=&r" (newval), "=&r" (tmp), "+Qo" (v->counter)
 	: "r" (&v->counter), "r" (u), "r" (a)
 	: "cc");
 
-	if (ret)
+	if (oldval != u)
 		smp_mb();
 
-	return ret;
+	return oldval;
 }
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 #define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
-- 
2.11.0

