Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F5C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FD32177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547079093;
	bh=h9FpAV7ViS0x77yN0brgUg1SlZ1S+BVD3oJKuVUo6qY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mTEtuOPsja8h1/nk/WHVxULew95iA+MCuh22rbC3pcXzCQ8GQczwweaJk7sxDIVBb
	 V9ZEV3s/9UgVBwhWgaVz7/eYg3lrAJmoJp2p9hhuRtFYafDvkQoqurbLp8mK40CRpt
	 Dm0yc7k/Z8P8ZM5IbVXjeaxpmBuHPSswxclvZapU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfAJALd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:11:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfAJALc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:11:32 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707DF2173B;
        Thu, 10 Jan 2019 00:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547079090;
        bh=h9FpAV7ViS0x77yN0brgUg1SlZ1S+BVD3oJKuVUo6qY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uF5ROo5CAjeOfV2heuc2LntifdxgtrpMa0MogXYqMU13mCCVcKJkzHLvwiw5pt2Vm
         SbIosPXeOlC3Wc8rQMb5aMeLJ+ThhFt0IB5NURIdBo91N4F8lYRiR0iGduU204fKLV
         0c2sB4UjEd/2Qjj4uTobcZ0gnz23ONxWt4wrX/Hg=
Date:   Thu, 10 Jan 2019 09:11:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/kprobes: Fix to avoid kretprobe recursion
Message-Id: <20190110091127.17e902c318578b192051eeb0@kernel.org>
In-Reply-To: <20190109110816.72a7ae85@gandalf.local.home>
References: <154692263564.1133.17363562046971295490.stgit@devbox>
        <154692272225.1133.799265848498671353.stgit@devbox>
        <20190109110816.72a7ae85@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 11:08:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  8 Jan 2019 13:45:22 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix to avoid kretprobe recursion loop by setting a dummy
> > kprobes to current_kprobe per-cpu variable.
> > 
> > This bug has been introduced with the asm-coded trampoline
> > code, since previously it used another kprobe for hooking
> > the function return placeholder (which only has a nop) and
> > trampoline handler was called from that kprobe.
> > 
> > This revives the old lost kprobe again.
> > 
> > With this fix, we don't see deadlock anymore.
> > 
> > # echo "r:event_1 __fdget" >> kprobe_events
> > # echo "r:event_2 _raw_spin_lock_irqsave" >> kprobe_events
> > # echo 1 > events/kprobes/enable
> > 
> > And you can see that all inner-called kretprobe are skipped.
> > 
> > # cat kprobe_profile
> >   event_1                                  235               0
> >   event_2                                19375           19612
> > 
> > The 1st column is recorded count and the 2nd is missed count.
> > Above shows (event_1 rec) + (event_2 rec) ~= (event_2 missed)
> 
> I don't quite understand the above. Is the miss count because we missed
> event_2 events for both event_1 and event_2?
> 
>  trace raw_spin_lock()
>     handler calls raw_spin_lock()
>           trace raw_spin_lock() [ skip ]

Yes, both events(kretprobe) eventually hits event_2 in trampoline_handler()'s
spin_lock_irqsave().

> 
> I'm also guessing that the 2 extra (19612 - (235 + 19375) = 2) are
> possibly due to the displaying being racy?

Yes, it can be racy.

Thank you,

> 
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Reported-by: Andrea Righi <righi.andrea@gmail.com>
> > Fixes: c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/x86/kernel/kprobes/core.c |   22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index 69b6400d1ce2..f4b954ff5b89 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -749,11 +749,16 @@ asm(
> >  NOKPROBE_SYMBOL(kretprobe_trampoline);
> >  STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> >  
> > +static struct kprobe kretprobe_kprobe = {
> > +	.addr = (void *)kretprobe_trampoline,
> > +};
> > +
> >  /*
> >   * Called from kretprobe_trampoline
> >   */
> >  static __used void *trampoline_handler(struct pt_regs *regs)
> >  {
> > +	struct kprobe_ctlblk *kcb;
> >  	struct kretprobe_instance *ri = NULL;
> >  	struct hlist_head *head, empty_rp;
> >  	struct hlist_node *tmp;
> > @@ -763,6 +768,17 @@ static __used void *trampoline_handler(struct pt_regs *regs)
> >  	void *frame_pointer;
> >  	bool skipped = false;
> >  
> > +	preempt_disable();
> > +
> > +	/*
> > +	 * Set a dummy kprobe for avoiding kretprobe recursion.
> > +	 * Since kretprobe never run in kprobe handler, kprobe must not
> > +	 * be running at this point.
> > +	 */
> > +	kcb = get_kprobe_ctlblk();
> > +	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
> 
> If an interrupt comes in here, is this still safe, if the interrupt
> handler has a kretprobe too?
> 
> -- Steve
> 
> > +	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > +
> >  	INIT_HLIST_HEAD(&empty_rp);
> >  	kretprobe_hash_lock(current, &head, &flags);
> >  	/* fixup registers */
> > @@ -838,10 +854,9 @@ static __used void *trampoline_handler(struct pt_regs *regs)
> >  		orig_ret_address = (unsigned long)ri->ret_addr;
> >  		if (ri->rp && ri->rp->handler) {
> >  			__this_cpu_write(current_kprobe, &ri->rp->kp);
> > -			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
> >  			ri->ret_addr = correct_ret_addr;
> >  			ri->rp->handler(ri, regs);
> > -			__this_cpu_write(current_kprobe, NULL);
> > +			__this_cpu_write(current_kprobe, &kretprobe_kprobe);
> >  		}
> >  
> >  		recycle_rp_inst(ri, &empty_rp);
> > @@ -857,6 +872,9 @@ static __used void *trampoline_handler(struct pt_regs *regs)
> >  
> >  	kretprobe_hash_unlock(current, &flags);
> >  
> > +	__this_cpu_write(current_kprobe, NULL);
> > +	preempt_enable();
> > +
> >  	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
> >  		hlist_del(&ri->hlist);
> >  		kfree(ri);
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
