Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC27EC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537FB20890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537FB20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbeGYPsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:48:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeGYPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:48:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEZbPJ403445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:35:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEZb9S403442;
        Wed, 25 Jul 2018 07:35:37 -0700
Date:   Wed, 25 Jul 2018 07:35:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-4d2b25f630c731218d04f72580b4de68cb7a6e00@git.kernel.org>
Cc:     will.deacon@arm.com, tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mark.rutland@arm.com,
        torvalds@linux-foundation.org, arnd@arndb.de, mingo@kernel.org,
        dvyukov@google.com, peterz@infradead.org
Reply-To: arnd@arndb.de, torvalds@linux-foundation.org,
          peterz@infradead.org, mingo@kernel.org, dvyukov@google.com,
          hpa@zytor.com, mark.rutland@arm.com, boqun.feng@gmail.com,
          linux-kernel@vger.kernel.org, will.deacon@arm.com,
          tglx@linutronix.de
In-Reply-To: <20180716113017.3909-6-mark.rutland@arm.com>
References: <20180716113017.3909-6-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Instrument cmpxchg_double*()
Git-Commit-ID: 4d2b25f630c731218d04f72580b4de68cb7a6e00
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

Commit-ID:  4d2b25f630c731218d04f72580b4de68cb7a6e00
Gitweb:     https://git.kernel.org/tip/4d2b25f630c731218d04f72580b4de68cb7a6e00
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Mon, 16 Jul 2018 12:30:10 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:53:59 +0200

locking/atomics: Instrument cmpxchg_double*()

We currently don't instrument cmpxchg_double() and
cmpxchg_double_local() due to compilation issues reported in the past,
which are supposedly related to GCC bug 72873 [1], reported when GCC 7
was not yet released. This bug only applies to x86-64, and does not
apply to other architectures.

While the test case for GCC bug 72873 triggers issues with released
versions of GCC, the instrumented kernel code compiles fine for all
configurations I have tried, and it is unclear how the two cases
are/were related.

As we can't reproduce the kernel build failures, let's instrument
cmpxchg_double*() again. We can revisit the issue if build failures
reappear.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: andy.shevchenko@gmail.com
Cc: aryabinin@virtuozzo.com
Cc: catalin.marinas@arm.com
Cc: glider@google.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: parri.andrea@gmail.com
Cc: peter@hurleysoftware.com
Link: http://lkml.kernel.org/r/20180716113017.3909-6-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/atomic-instrumented.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 53481b6eacdf..0d4b1d3dbc1e 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -450,23 +450,18 @@ static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
 	arch_cmpxchg64_local(__ai_ptr, (old), (new));			\
 })
 
-/*
- * Originally we had the following code here:
- *     __typeof__(p1) ____p1 = (p1);
- *     kasan_check_write(____p1, 2 * sizeof(*____p1));
- *     arch_cmpxchg_double(____p1, (p2), (o1), (o2), (n1), (n2));
- * But it leads to compilation failures (see gcc issue 72873).
- * So for now it's left non-instrumented.
- * There are few callers of cmpxchg_double(), so it's not critical.
- */
 #define cmpxchg_double(p1, p2, o1, o2, n1, n2)				\
 ({									\
-	arch_cmpxchg_double((p1), (p2), (o1), (o2), (n1), (n2));	\
+	typeof(p1) __ai_p1 = (p1);					\
+	kasan_check_write(__ai_p1, 2 * sizeof(*__ai_p1));		\
+	arch_cmpxchg_double(__ai_p1, (p2), (o1), (o2), (n1), (n2));	\
 })
 
-#define cmpxchg_double_local(p1, p2, o1, o2, n1, n2)			\
-({									\
-	arch_cmpxchg_double_local((p1), (p2), (o1), (o2), (n1), (n2));	\
+#define cmpxchg_double_local(p1, p2, o1, o2, n1, n2)				\
+({										\
+	typeof(p1) __ai_p1 = (p1);						\
+	kasan_check_write(__ai_p1, 2 * sizeof(*__ai_p1));			\
+	arch_cmpxchg_double_local(__ai_p1, (p2), (o1), (o2), (n1), (n2));	\
 })
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
