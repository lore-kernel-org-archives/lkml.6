Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DEDC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2440205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2440205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbeG0RtH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:49:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52011 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbeG0RtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:49:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fj5ZO-0001hu-W2; Fri, 27 Jul 2018 18:26:23 +0200
Date:   Fri, 27 Jul 2018 18:26:22 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT v3] arm64: fpsimd: use preemp_disable in addition to
 local_bh_disable()
Message-ID: <20180727162622.gupa5kc4l2rlxtyb@linutronix.de>
References: <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180724094623.37430032@gandalf.local.home>
 <20180726150634.cl3wccqur6qhle6p@linutronix.de>
 <20180727153559.GA4240@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180727153559.GA4240@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-27 16:35:59 [+0100], Dave Martin wrote:
> On Thu, Jul 26, 2018 at 05:06:34PM +0200, Sebastian Andrzej Siewior wrote:
> > In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
> > code disables BH and expects that it is not preemptible. On -RT the
> > task remains preemptible but remains the same CPU. This may corrupt the
> > content of the SIMD registers if the task is preempted during
> > saving/restoring those registers.
> > 
> > Add preempt_disable()/enable() to enfore the required semantic on -RT.
> 
> Does this supersede the local_lock based approach?

Yes, it does.

> That would have been nice to have, but if there are open questions about
> how to do it then I guess something like this patch makes sense as a
> stopgap solution.
> 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > This should work. Compiling currently gcc-6 on the box to see what
> > happens. Since the crypto disables preemption "frequently" and I don't
> > expect or see anything to worry about.
> > 
> >  arch/arm64/kernel/fpsimd.c |   30 ++++++++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -157,6 +157,15 @@ static void sve_free(struct task_struct
> >  	__sve_free(task);
> >  }
> >  
> > +static void *sve_free_atomic(struct task_struct *task)
> > +{
> > +	void *sve_state = task->thread.sve_state;
> > +
> > +	WARN_ON(test_tsk_thread_flag(task, TIF_SVE));
> > +
> > +	task->thread.sve_state = NULL;
> > +	return sve_state;
> > +}
> 
> This feels a bit excessive.  Since there's only one call site, I'd
> prefer if the necessary code were simply inlined.  We wouldn't need the
> WARN either in that case, since (IIUC) it's only there to check for
> accidental misuse of this helper.
okay.

> >  /* Offset of FFR in the SVE register dump */
> >  static size_t sve_ffr_offset(int vl)
…
> I think we should have local helpers for the preempt+local_bh
> maintenance, since they're needed all over the place in this
> file.
okay.

> Cheers
> ---Dave

Sebastian
