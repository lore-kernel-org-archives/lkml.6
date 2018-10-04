Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568FCC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C958213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DrgEMh+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C958213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJDQ2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:28:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FwXSA2vlA3kYtDrc2VofYRsC1goOIpv130XSEPzwg/8=; b=DrgEMh+E3cjWoTzrYFoVYeQfA
        XsmsGRLxWTw0xXuy3hN1aSTDBh0GuQh1nQBVWviLrNsBrexJdG03kwiUAbDj12AJmeEZZBk80wIfx
        s+z4ig9XigD1XwBhkJi1bEijeury3+TEZqVfi9D4A4Z8rgbSMUkfEGCENLa5EUTFHwlX+hNsjYXLA
        IQZ8zUqgJvY2nZdykt73AN1hgyrcelbhsH39jXL2pwObwpOuH1PyyEHKmZ1Ft5wkSk7hqUrLL0x5j
        UJ0nM15LalQWdkHC8IkniHZhPwdKImpjkjbvLcsPcexcz2IyNho6ySemOZ8r/k9d7BuKxmItIAc4x
        Cj43jCXEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g803D-0001RT-Fr; Thu, 04 Oct 2018 09:36:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44AF52070945E; Thu,  4 Oct 2018 11:18:47 +0200 (CEST)
Date:   Thu, 4 Oct 2018 11:18:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        bigeasy@linutronix.de, hpa@linux.intel.com, JBeulich@suse.com,
        bp@alien8.de
Subject: Re: [PATCH v2 3/4] x86/asm: Simplify GEN_*_RMWcc() macros
Message-ID: <20181004091847.GJ19272@hirez.programming.kicks-ass.net>
References: <20181003130257.156322446@infradead.org>
 <20181003130957.108960094@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003130957.108960094@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 03:03:00PM +0200, Peter Zijlstra wrote:
> +#define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
> +({									\
> +	__label__ cc_label;						\
>  	asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"		\
> +			: : [var] "m" (_var), ## __VA_ARGS__		\
>  			: clobbers : cc_label);				\
> +	0;								\
>  cc_label:								\
> +	1;								\
> +})

That's obviously crap...

This one seems to actually compile and generate identical code:

#define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
({									\
	bool c = false;							\
	asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"		\
			: : [var] "m" (_var), ## __VA_ARGS__		\
			: clobbers : cc_label);				\
	if (0) {							\
cc_label:	c = true;						\
	}								\
	c;								\
})
