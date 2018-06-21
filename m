Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513D7C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134C9208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134C9208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeFUMNm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:13:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49266 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932763AbeFUMNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:13:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C18C915BE;
        Thu, 21 Jun 2018 05:13:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90AAA3F578;
        Thu, 21 Jun 2018 05:13:36 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCHv4 03/18] atomics/treewide: remove atomic_inc_not_zero_hint()
Date:   Thu, 21 Jun 2018 13:13:06 +0100
Message-Id: <20180621121321.4761-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621121321.4761-1-mark.rutland@arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While documentation suggests atomic_inc_not_zero_hint() will perform better
than atomic_inc_not_zero(), this is unlikely to be the case. No architectures
implement atomic_inc_not_zero_hint() directly, and thus it either falls back to
atomic_inc_not_zero(), or a loop using atomic_cmpxchg().

Whenever the hint does not match the value in memory, the repeated use of
atomic_cmpxchg() will be more expensive than the read that
atomic_inc_not_zero_hint() attempts to avoid. For architectures with LL/SC
atomics, a read cannot be avoided, and it would always be better to use
atomic_inc_not_zero() directly. For other architectures, their own
atomic_inc_not_zero() is likely to be more optimal than an atomic_cmpxchg()
loop regardless.

Generally, atomic_inc_not_zero_hint() is liable to perform worse than
atomic_inc_not_zero(). Further, atomic_inc_not_zero_hint() only exists
for atomic_t, and not atomic64_t or atomic_long_t, and there is only one
user in the kernel tree.

Given all this, let's remove atomic_inc_not_zero_hint(), and migrate the
existing user over to atomic_inc_not_zero().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/atomic.h | 32 --------------------------------
 net/atm/pppoatm.c      |  2 +-
 2 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 9cc982936675..5c5620ae5a35 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -571,38 +571,6 @@ static inline int atomic_fetch_andnot_release(int i, atomic_t *v)
 }
 #endif
 
-/**
- * atomic_inc_not_zero_hint - increment if not null
- * @v: pointer of type atomic_t
- * @hint: probable value of the atomic before the increment
- *
- * This version of atomic_inc_not_zero() gives a hint of probable
- * value of the atomic. This helps processor to not read the memory
- * before doing the atomic read/modify/write cycle, lowering
- * number of bus transactions on some arches.
- *
- * Returns: 0 if increment was not done, 1 otherwise.
- */
-#ifndef atomic_inc_not_zero_hint
-static inline int atomic_inc_not_zero_hint(atomic_t *v, int hint)
-{
-	int val, c = hint;
-
-	/* sanity test, should be removed by compiler if hint is a constant */
-	if (!hint)
-		return atomic_inc_not_zero(v);
-
-	do {
-		val = atomic_cmpxchg(v, c, c + 1);
-		if (val == c)
-			return 1;
-		c = val;
-	} while (c);
-
-	return 0;
-}
-#endif
-
 #ifndef atomic_inc_unless_negative
 static inline int atomic_inc_unless_negative(atomic_t *p)
 {
diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
index 21d9d341a619..a4d82afd4586 100644
--- a/net/atm/pppoatm.c
+++ b/net/atm/pppoatm.c
@@ -244,7 +244,7 @@ static int pppoatm_may_send(struct pppoatm_vcc *pvcc, int size)
 	 * the packet count limit, so...
 	 */
 	if (atm_may_send(pvcc->atmvcc, size) &&
-	    atomic_inc_not_zero_hint(&pvcc->inflight, NONE_INFLIGHT))
+	    atomic_inc_not_zero(&pvcc->inflight))
 		return 1;
 
 	/*
-- 
2.11.0

