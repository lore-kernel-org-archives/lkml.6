Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF82FECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3862084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3862084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbeGRKBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:01:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbeGRKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:01:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ffihU-000397-N0; Wed, 18 Jul 2018 11:24:48 +0200
Date:   Wed, 18 Jul 2018 11:24:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180718092448.v6j7wdahtsediqhh@linutronix.de>
References: <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718091209.u76gzacanj5avhdl@linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-18 11:12:10 [+0200], To Dave Martin wrote:
> > > -	if (may_use_simd()) {
> > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {
> > 
> > I suspect this is wrong -- see comments on the commit message.

I'm sorry, I pressed send too early, I was aiming for the draft folder.
So yes, based on that EFI that might be interruptible, let me try to
look at the initial issue again and maybe I get another idea how to deal
with this.
One question: If EFI is interruptible that means, we call into EFI - how
do we get out? Does EFI enable interrupts and the kernel receives an
interrupt and treats this EFI call like a regular context switch?

> > >  		kernel_neon_begin();
> > >  	} else {
> > 
> > [...]
> > 
> > Cheers
> > ---Dave

Sebastian
