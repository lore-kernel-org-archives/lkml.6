Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B5F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sw4KGlKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B5F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeH3Ssw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:48:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbeH3SqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=POe38wAXINdAk1gkhCrnt5nqNHz3lYXAFOnU815bWk4=; b=sw4KGlKTS+Mn6lr2t4PPaO50T
        uRRCR8XPO8RgMB+31lR4cm6lJ6B94ukndrkkY5GJiWBq6+FyjubBpH9bJL6+NJwspwkSs4xlZ3AES
        QlizRUL1OrTddIHNHP/eRveW4Wv2d0OiPv2wsN91jO0lg4Kr7SGQNW8dRXjsR3Fmm/gM9awaNk6zu
        Qq4xq5VNAJ01pt8WTt4zaTvIGk7WUt7/B7ayHlezcSdfAN+qCYgvseUi+0nnEuzFzJH01+AKQlY2A
        LHthBuq1u8myaL6RB5IQgt0ayTyzbf1+dbbQi+Hacc32DGYATtjfjXbEoxlJ7TmHQoApWqK1E16/z
        GWEaFKJPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvOAj-0007rT-Hc; Thu, 30 Aug 2018 14:43:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12A082024D425; Thu, 30 Aug 2018 16:43:44 +0200 (CEST)
Date:   Thu, 30 Aug 2018 16:43:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180830144344.GW24142@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830142920.GO24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 04:29:20PM +0200, Peter Zijlstra wrote:

> Also, once it all works, they should look at switching to _relaxed
> atomics for LL/SC.

A little something like so.. should save a few smp_mb().

---

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 4e0072730241..714b54c308b0 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -44,7 +44,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned int val;						\
 									\
@@ -69,8 +69,11 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 	return val;							\
 }
 
+#define atomic_add_return_relaxed	atomic_add_return_relaxed
+#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned int val, orig;						\
 									\
@@ -96,6 +99,14 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 	return orig;							\
 }
 
+#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
+#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+
+#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
+#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
+#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
+#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+
 #else	/* !CONFIG_ARC_HAS_LLSC */
 
 #ifndef CONFIG_SMP
@@ -379,7 +390,7 @@ static inline void atomic64_##op(long long a, atomic64_t *v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
-static inline long long atomic64_##op##_return(long long a, atomic64_t *v)	\
+static inline long long atomic64_##op##_return_relaxed(long long a, atomic64_t *v)	\
 {									\
 	unsigned long long val;						\
 									\
@@ -401,8 +412,11 @@ static inline long long atomic64_##op##_return(long long a, atomic64_t *v)	\
 	return val;							\
 }
 
+#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
+#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
+
 #define ATOMIC64_FETCH_OP(op, op1, op2)		        		\
-static inline long long atomic64_fetch_##op(long long a, atomic64_t *v)	\
+static inline long long atomic64_fetch_##op##_relaxed(long long a, atomic64_t *v)	\
 {									\
 	unsigned long long val, orig;					\
 									\
@@ -424,6 +438,14 @@ static inline long long atomic64_fetch_##op(long long a, atomic64_t *v)	\
 	return orig;							\
 }
 
+#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
+#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+
+#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
+#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
+#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
+#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+
 #define ATOMIC64_OPS(op, op1, op2)					\
 	ATOMIC64_OP(op, op1, op2)					\
 	ATOMIC64_OP_RETURN(op, op1, op2)				\
@@ -434,6 +456,12 @@ static inline long long atomic64_fetch_##op(long long a, atomic64_t *v)	\
 
 ATOMIC64_OPS(add, add.f, adc)
 ATOMIC64_OPS(sub, sub.f, sbc)
+
+#undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, op1, op2)					\
+	ATOMIC64_OP(op, op1, op2)					\
+	ATOMIC64_FETCH_OP(op, op1, op2)
+
 ATOMIC64_OPS(and, and, and)
 ATOMIC64_OPS(andnot, bic, bic)
 ATOMIC64_OPS(or, or, or)
