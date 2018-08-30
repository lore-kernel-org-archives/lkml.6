Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61265C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10179205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jlFq0QJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10179205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbeH3Sbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:31:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeH3Sbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V0aFxzFNjJIetc8WMsMUaz+Ek+jNFeACrTW7ULxgVHs=; b=jlFq0QJ4Y3ehNv/qHoGUoIRZp
        J9mfDaZd+CucksTBO1RHYIqckIJ8tRNWneEBe9WoSPaiSxc4MdTqsd4f0VnhEbLB4Mo57yJsCK7Bg
        8EgzxG5J4Cc6D1/E47kg9ZeI00w8IMOrX4Y6BtgOlFcTaOIFau6eZ3pANzU46EUb2w8GixcQMPETe
        8C45jiZnmjwROIVR2Ty6RZfbUme8FPX1B3+p7GHJXdVZE8niDi8FuRM3OkpkkdMRcuVozeKMY00OW
        Jcyu/YyPJEdH6lG0CHNyuaIoVh5LXOMIDOFKOkWH99/XoCEzK3USw8L56eim5yuzw4aghaTegHLkn
        s1jo1erBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvNwn-0001Pz-T4; Thu, 30 Aug 2018 14:29:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42A242024D73F; Thu, 30 Aug 2018 16:29:20 +0200 (CEST)
Date:   Thu, 30 Aug 2018 16:29:20 +0200
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
Message-ID: <20180830142920.GO24082@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830142354.GB13005@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 03:23:55PM +0100, Will Deacon wrote:

> Yes, that would be worth trying. However, I also just noticed that the
> fetch-ops (which are now used to implement test_and_set_bit_lock()) seem
> to be missing the backwards branch in the LL/SC case. Yet another diff
> below.
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
> index 4e0072730241..f06c5ed672b3 100644
> --- a/arch/arc/include/asm/atomic.h
> +++ b/arch/arc/include/asm/atomic.h
> @@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
>  	"1:	llock   %[orig], [%[ctr]]		\n"		\
>  	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
>  	"	scond   %[val], [%[ctr]]		\n"		\
> -	"						\n"		\
> +	"	bnz	1b				\n"		\
>  	: [val]	"=&r"	(val),						\
>  	  [orig] "=&r" (orig)						\
>  	: [ctr]	"r"	(&v->counter),					\

ACK!! sorry about that, no idea how I messed that up.

Also, once it all works, they should look at switching to _relaxed
atomics for LL/SC.
