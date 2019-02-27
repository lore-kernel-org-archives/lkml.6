Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626B4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B1720663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpjSNu8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfB0KYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:24:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0KYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P7IY9GE/HBpxcvHHQx9dUhY9oXem9806Fae/Yit3d10=; b=WpjSNu8S9xMvOThAtvCdeq/8Z
        DhxSSMYv6BaP9Hakmdea7YXZ4oZfzC8t6q4jNnGt2K5Jo+ZohFD+ivwhPitgtcxq5kWBjmqSa8vhK
        O9emWhjEHsLaWxh0QYyTKlVQ2ST1gKQYj/8szEWWUugb38NvRqd0uIOBd4+8Syr7f4EhkDhxdG6UG
        96Y4qw2k4s6OWSKrHVwJkfhMFT+rZs/GqkAonH7+F+k/dmSbzI5vK9KZdFeHUBEn6jUOiUa9FpqCO
        XH9NccOgRiYUUhdmxGnBeU/GrFQfE0ZbytQclSVMeMYJU2yrwQBqSsDckwN55rFcXNDeceZH2aNAP
        A5LyhybKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gywOM-0000nz-Q7; Wed, 27 Feb 2019 10:24:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F63A200F9F95; Wed, 27 Feb 2019 11:24:45 +0100 (CET)
Date:   Wed, 27 Feb 2019 11:24:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/5] x86/percpu: Optimize raw_cpu_xchg()
Message-ID: <20190227102445.GL32494@hirez.programming.kicks-ass.net>
References: <20190227101252.413192716@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227101252.413192716@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


And because it's one of _those_ days, I forgot to include one patch...

---
Subject: x86/percpu: Optimize raw_cpu_xchg()
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Feb 27 11:09:56 CET 2019

Since raw_cpu_xchg() doesn't need to be IRQ-safe, like
this_cpu_xchg(), we can use a simple load-store instead of the cmpxchg
loop.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/percpu.h |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -407,9 +407,21 @@ do {									\
 #define raw_cpu_or_1(pcp, val)		percpu_to_op(, "or", (pcp), val)
 #define raw_cpu_or_2(pcp, val)		percpu_to_op(, "or", (pcp), val)
 #define raw_cpu_or_4(pcp, val)		percpu_to_op(, "or", (pcp), val)
-#define raw_cpu_xchg_1(pcp, val)	percpu_xchg_op(, pcp, val)
-#define raw_cpu_xchg_2(pcp, val)	percpu_xchg_op(, pcp, val)
-#define raw_cpu_xchg_4(pcp, val)	percpu_xchg_op(, pcp, val)
+
+/*
+ * raw_cpu_xchg() can use a load-store since it is not required to be
+ * IRQ-safe.
+ */
+#define raw_percpu_xchg_op(var, nval)					\
+({									\
+	typeof(var) pxo_ret__ = raw_cpu_read(var);			\
+	raw_cpu_write(var, (nval));					\
+	pxo_ret__;							\
+})
+
+#define raw_cpu_xchg_1(pcp, val)	raw_percpu_xchg_op(pcp, val)
+#define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
+#define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
 
 #define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
 #define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
