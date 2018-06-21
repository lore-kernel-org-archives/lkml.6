Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315D0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB898208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB898208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933795AbeFUMQN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:16:13 -0400
Received: from foss.arm.com ([217.140.101.70]:49342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933460AbeFUMNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:13:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 543FC1435;
        Thu, 21 Jun 2018 05:13:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 001863F578;
        Thu, 21 Jun 2018 05:13:47 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv4 08/18] atomics/generic: define atomic64_fetch_add_unless()
Date:   Thu, 21 Jun 2018 13:13:11 +0100
Message-Id: <20180621121321.4761-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step towards unifying the atomic/atomic64/atomic_long APIs, this
patch converts the generic implementation of atomic64_add_unless() into
a generic implementation of atomic64_fetch_add_unless().

A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
this, provided it is given a preprocessor definition.

No functional change is intended as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/atomic64.h |  3 ++-
 lib/atomic64.c                 | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 5105275ac825..49460107b29a 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -53,7 +53,8 @@ ATOMIC64_OPS(xor)
 extern long long atomic64_dec_if_positive(atomic64_t *v);
 extern long long atomic64_cmpxchg(atomic64_t *v, long long o, long long n);
 extern long long atomic64_xchg(atomic64_t *v, long long new);
-extern bool	 atomic64_add_unless(atomic64_t *v, long long a, long long u);
+extern long long atomic64_fetch_add_unless(atomic64_t *v, long long a, long long u);
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
 
 #define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
diff --git a/lib/atomic64.c b/lib/atomic64.c
index 4230f4b8906c..16ac13113c8e 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -178,18 +178,18 @@ long long atomic64_xchg(atomic64_t *v, long long new)
 }
 EXPORT_SYMBOL(atomic64_xchg);
 
-bool atomic64_add_unless(atomic64_t *v, long long a, long long u)
+long long atomic64_fetch_add_unless(atomic64_t *v, long long a, long long u)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
-	bool ret = false;
+	long long val;
 
 	raw_spin_lock_irqsave(lock, flags);
-	if (v->counter != u) {
+	val = v->counter;
+	if (val != u)
 		v->counter += a;
-		ret = true;
 	}
 	raw_spin_unlock_irqrestore(lock, flags);
-	return ret;
+	return val;
 }
-EXPORT_SYMBOL(atomic64_add_unless);
+EXPORT_SYMBOL(atomic64_fetch_add_unless);
-- 
2.11.0

