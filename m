Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB91C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CCA20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CCA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbeG0JRa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:17:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeG0JRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:17:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fixcD-0002JB-7A; Fri, 27 Jul 2018 09:56:45 +0200
Date:   Fri, 27 Jul 2018 09:56:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT v3] arm64: fpsimd: use preemp_disable in addition to
 local_bh_disable()
Message-ID: <20180727075644.lapmhyxxdb6jbaqr@linutronix.de>
References: <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180724094623.37430032@gandalf.local.home>
 <20180726150634.cl3wccqur6qhle6p@linutronix.de>
 <1532661443.10554.5.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1532661443.10554.5.camel@gmx.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-27 05:17:23 [+0200], Mike Galbraith wrote:
> On Thu, 2018-07-26 at 17:06 +0200, Sebastian Andrzej Siewior wrote:
> > 
> > @@ -1115,6 +1139,7 @@ void kernel_neon_begin(void)
> >  
> >  	BUG_ON(!may_use_simd());
> >  
> > +	preempt_disable();
> >  	local_bh_disable();
> >  
> >  	__this_cpu_write(kernel_neon_busy, true);
> > @@ -1131,6 +1156,7 @@ void kernel_neon_begin(void)
> >  	preempt_disable();
> 
> Nit: this preempt_disable() could be removed...
>  
> >  	local_bh_enable();
> > +	preempt_enable();
> >  }
> >  EXPORT_SYMBOL(kernel_neon_begin);
> 
> ...instead of adding this one.

It could. I have currently no idea for the long term solution and this
keeps track what is intended to do. It might get replaced with
preempt_.*_rt()…

> 	-Mike

Sebastian
