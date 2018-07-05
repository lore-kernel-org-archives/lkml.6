Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F20C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4468F240E7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4468F240E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeGEQlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:41:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53452 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753459AbeGEQld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:41:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 610E080D;
        Thu,  5 Jul 2018 09:41:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30F303F5BA;
        Thu,  5 Jul 2018 09:41:30 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, will.deacon@arm.com
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linuxdrivers@attotech.com,
        mark.rutland@arm.com, mingo@kernel.org, mingo@redhat.com,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: [PATCHv3 05/12] atomics: instrument cmpxchg_double*()
Date:   Thu,  5 Jul 2018 17:40:46 +0100
Message-Id: <20180705164053.10073-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180705164053.10073-1-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
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
-- 
2.11.0

