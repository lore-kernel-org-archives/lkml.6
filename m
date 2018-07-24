Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AE7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81BF2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81BF2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbeGXPwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:52:34 -0400
Received: from foss.arm.com ([217.140.101.70]:53010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388460AbeGXPwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:52:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FFA180D;
        Tue, 24 Jul 2018 07:45:45 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67AD33F237;
        Tue, 24 Jul 2018 07:45:43 -0700 (PDT)
Date:   Tue, 24 Jul 2018 15:45:35 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180724144522.GA4240@e103592.cambridge.arm.com>
References: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180718092448.v6j7wdahtsediqhh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718092448.v6j7wdahtsediqhh@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:24:48AM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-07-18 11:12:10 [+0200], To Dave Martin wrote:
> > > > -	if (may_use_simd()) {
> > > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {
> > > 
> > > I suspect this is wrong -- see comments on the commit message.
> 
> I'm sorry, I pressed send too early, I was aiming for the draft folder.
> So yes, based on that EFI that might be interruptible, let me try to
> look at the initial issue again and maybe I get another idea how to deal
> with this.
> One question: If EFI is interruptible that means, we call into EFI - how
> do we get out? Does EFI enable interrupts and the kernel receives an
> interrupt and treats this EFI call like a regular context switch?

AFAIK the only safe way to get out permanently is for the call to
return.  Note, I've not gone through the spec in fine detail myself.

The OS may handle interrupts occurring during the EFI call, but we
still have to return to EFI afterwards to finish off the call.  From
the Linux perspective, I think this means that EFI calls are non-
preemptible.

Under RT, I'm pretty sure that we can't safely resume the interrupted
EFI call on a different cpu from the one it was interrupted on.  Even
if it doesn't say this explicitly in the UEFI spec, I think it will be
assumed in implementations.


Certain EFI calls are not long-running and may need to be called from
interrupt context in Linux, which means that there may be live kernel-
mode NEON state.  This is why there are separate FPSIMD/SVE percpu stash
buffers for EFI specifically.

Does this make sense?  It's is probably not very clear, but I'm trying
to hide the fact that I haven't looked at the UEFI spec for ages...

Cheers
---Dave
