Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7373CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A138257C1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A138257C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbeFYLAN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:00:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54588 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932340AbeFYLAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:00:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D710322D7;
        Mon, 25 Jun 2018 04:00:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82FE63F73D;
        Mon, 25 Jun 2018 04:00:09 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCHv2 05/11] atomics: instrument cmpxchg_double*()
Date:   Mon, 25 Jun 2018 11:59:46 +0100
Message-Id: <20180625105952.3756-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625105952.3756-1-mark.rutland@arm.com>
References: <20180625105952.3756-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently don't instrument cmpxchg_double() and
cmpxchg_double_local() due to compilation issues reported in the past,
which are supposedly related to GCC bug 72873 [1], reported when GCC 7
was not yet released. This bug only applies to x86-64, and not other
architectures.

While the test case for GCC bug 72873 triggers issues with released
versions of GCC, the instrumented kernel code compiles fine for all
configurations I have tried, and it is unclear how the two cases
are/were related.

As we can't reproduce the kernel build failures, let's instrument
cmpxchg_double*() again. We can revisit the issue if build failures
reappear.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
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

