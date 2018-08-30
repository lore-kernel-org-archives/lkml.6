Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C12AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FB32073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AyyhI0TM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FB32073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeH3STm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:19:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbeH3STl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nQFQWuWAaE2h2gwOIdyZjpCcGVFc/ZfL+60lnpyWtxc=; b=AyyhI0TMsuaJo1NwckOLjbz9g
        uNHjYzK3QYLlaqfWAdt1jd71A6UVvqtNklqKQTcWP4Pwfo10a7OgfbJ1ISChNn45mpblqaQQ5ZU5m
        AxxPx5P5UQoAG5KN+adLJgzCjuhwXCxgW9L97LfVr2rlYGZX7uBDVby1FlYzFSrOnW5vq/7hyw1TD
        6MWzop93ZElwVMIMgOBhjS7hUxl6zCZh6qYgGoqrpMHZPlPG5yZlw09unIhJqSK37O0Vwa+ouvSCa
        ncCY2LmRj9x26psRqj7TYjMt4fYYkTzx6eRXdcdf2yTOShEPTsBRVOHDLjPiJ96Tb/j6SryZ3mMy2
        C+95PrHlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvNl5-0004eV-3v; Thu, 30 Aug 2018 14:17:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D80C2024D444; Thu, 30 Aug 2018 16:17:13 +0200 (CEST)
Date:   Thu, 30 Aug 2018 16:17:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     "will.deacon@arm.com" <will.deacon@arm.com>,
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
Message-ID: <20180830141713.GN24082@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535629996.4465.44.camel@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:53:17AM +0000, Eugeniy Paltsev wrote:
> I can see crashes with LLSC enabled in both SMP running on 4 cores
> and SMP running on 1 core.

So you're running on LL/SC enabled hardware; that would make Will's
patch irrelevant (although still a good idea for the hardware that does
care about that spinlocked atomic crud).

Does something like the below cure things? That would confirm the
suggestion that the change to __clear_bit_unlock() is the curprit.

If that doesn't cure things, then we've been looking in entirely the
wrong place.

---
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 3ae021368f48..79c6978152f8 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -57,12 +57,7 @@ static inline void clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 static inline void __clear_bit_unlock(unsigned int nr,
 				      volatile unsigned long *p)
 {
-	unsigned long old;
-
-	p += BIT_WORD(nr);
-	old = READ_ONCE(*p);
-	old &= ~BIT_MASK(nr);
-	atomic_long_set_release((atomic_long_t *)p, old);
+	clear_bit_unlock(nr, p);
 }
 
 /**
