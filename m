Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D88DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF0020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF0020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934144AbeFRKTu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:19:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936958AbeFRKTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:19:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6001480D;
        Mon, 18 Jun 2018 03:19:46 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92EB03F25D;
        Mon, 18 Jun 2018 03:19:43 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     mingo@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>
Subject: [PATCHv3 07/18] atomics: prepare for atomic64_fetch_add_unless()
Date:   Mon, 18 Jun 2018 11:19:08 +0100
Message-Id: <20180618101919.51973-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180618101919.51973-1-mark.rutland@arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently architecture must implement atomic_fetch_add_unless(), with
common code providing atomic_add_unless(). Architectures must also
implement atmic64_add_unless() directly, with no corresponding
atomic64_fetch_add_unless().

This divergenece is unfortunate, and means that the APIs for atomic_t,
atomic64_t, and atomic_long_t differ.

In preparation for unifying things, with architectures providing
atomic64_fetch_add_unless, this patch adds a generic
atomic64_add_unless() which will use atomic64_fetch_add_unless(). The
instrumented atomics are updated to take this case into account.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
---
 include/asm-generic/atomic-instrumented.h |  9 +++++++++
 include/linux/atomic.h                    | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 1f9b2a767d3c..ab011e1a02fc 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -93,11 +93,20 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #endif
 
+#ifdef arch_atomic64_fetch_add_unless
+#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+static __always_inline int atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	kasan_check_write(v, sizeof(*v));
+	return arch_atomic64_fetch_add_unless(v, a, u);
+}
+#else
 static __always_inline bool atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	kasan_check_write(v, sizeof(*v));
 	return arch_atomic64_add_unless(v, a, u);
 }
+#endif
 
 static __always_inline void atomic_inc(atomic_t *v)
 {
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index b89ba36cab94..3c03de648007 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -1043,6 +1043,22 @@ static inline int atomic_dec_if_positive(atomic_t *v)
 #endif /* atomic64_try_cmpxchg */
 
 /**
+ * atomic64_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+#ifdef atomic64_fetch_add_unless
+static inline bool atomic64_add_unless(atomic64_t *v, long long a, long long u)
+{
+	return atomic64_fetch_add_unless(v, a, u) != u;
+}
+#endif
+
+/**
  * atomic64_inc_not_zero - increment unless the number is zero
  * @v: pointer of type atomic64_t
  *
-- 
2.11.0

