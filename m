Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53813C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C72923C7D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C72923C7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934370AbeFVDAi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:00:38 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:49566 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934278AbeFVDAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:00:37 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 22 Jun 2018 12:00:35 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 22 Jun 2018 12:00:35 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 22 Jun 2018 12:00:32 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180622030032.GB17010@X58A-UD3R>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <CANrsvRPAWv8LgSvPrGgLiXnjrtK3CmpJgdpNsuu-0LZJTYeYWQ@mail.gmail.com>
 <20180620174037.GZ3593@linux.vnet.ibm.com>
 <20180621063949.GA28024@X58A-UD3R>
 <20180621150407.GE3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621150407.GE3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 08:04:07AM -0700, Paul E. McKenney wrote:

> Nothing quite like concurrent programming to help one see one's own
> mistakes.  ;-)

Haha.

> Your reasoning has merit, but the nice thing about keeping "nmi" is
> that it helps casual readers see that NMIs must be handled.  If we
> rename this to "irq", we lose that hint and probably leave some
> readers wondering why the strange increment-by-2 code is there.
> So let's please keep the current names.

Got it. I will.

> >  /**
> > - * rcu_nmi_exit - inform RCU of exit from NMI context
> > + * rcu_irq_exit_common - inform RCU of exit from interrupt context
> >   *
> > - * If we are returning from the outermost NMI handler that interrupted an
> > - * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
> > - * to let the RCU grace-period handling know that the CPU is back to
> > - * being RCU-idle.
> > + * If we are returning from the outermost interrupt handler that
> > + * interrupted an RCU-idle period, update rdtp->dynticks and
> > + * rdtp->dynticks_irq_nesting to let the RCU grace-period handling
> > + * know that the CPU is back to being RCU-idle.
> >   *
> > - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> > - * with CONFIG_RCU_EQS_DEBUG=y.
> > + * If you add or remove a call to rcu_irq_exit_common(), be sure to
> > + * test with CONFIG_RCU_EQS_DEBUG=y.
> >   */
> > -void rcu_nmi_exit(void)
> > +static __always_inline void rcu_irq_exit_common(bool nmi)
> 
> However, I suggest making this function's parameter "irq" because ...

I will.

> Does the generated code really get rid of the conditional branches?
> I would hope that it wouild, but it is always good to check.  This
> should be easy to find in the assembly-language output because of the
> calls to rcu_prepare_for_idle() and rcu_dynticks_task_enter().

Good! It works as we expect, I did it only with x86_64 tho. Let me show
you the part we are interested in. The rest are almost same.

<rcu_nmi_exit>:
	5b                   	pop    %rbx
	5d                   	pop    %rbp
	41 5c                	pop    %r12
	41 5d                	pop    %r13
	41 5e                	pop    %r14
	41 5f                	pop    %r15
	e9 0f 75 ff ff       	jmpq   ffffffff810bb440 <rcu_dynticks_eqs_enter>

<rcu_irq_exit>:
	e8 e6 e5 ff ff       	callq  ffffffff810c26a0 <rcu_prepare_for_idle>
	e8 81 73 ff ff       	callq  ffffffff810bb440 <rcu_dynticks_eqs_enter>
	e8 ec 3a 2b 00       	callq  ffffffff81377bb0 <debug_smp_processor_id>
	65 48 8b 14 25 00 4d 	mov    %gs:0x14d00,%rdx
	01 00 
	89 82 94 03 00 00    	mov    %eax,0x394(%rdx)
	5b                   	pop    %rbx
	5d                   	pop    %rbp
	41 5c                	pop    %r12
	41 5d                	pop    %r13
	41 5e                	pop    %r14
	41 5f                	pop    %r15
	c3                   	retq

Even though they return in a little bit different way, anyway I can see
all the branchs we are interested in were removed by compiler!

> >  {
> >  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> >  	long incby = 2;
> > 
> >  	/* Complain about underflow. */
> > -	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting < 0);
> > +	WARN_ON_ONCE(rdtp->dynticks_irq_nesting < 0);
> > 
> >  	/*
> >  	 * If idle from RCU viewpoint, atomically increment ->dynticks
> > -	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
> > -	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
> > -	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
> > +	 * to mark non-idle and increment ->dynticks_irq_nesting by one.
> > +	 * Otherwise, increment ->dynticks_irq_nesting by two.  This means
> > +	 * if ->dynticks_irq_nesting is equal to one, we are guaranteed
> >  	 * to be in the outermost NMI handler that interrupted an RCU-idle
> >  	 * period (observation due to Andy Lutomirski).
> >  	 */
> >  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> > +
> > +		if (!nmi)
> > +			rcu_dynticks_task_exit();
> > +
> >  		rcu_dynticks_eqs_exit();
> > +
> > +		if (!nmi)
> 
> ... and checking for branches here.

Also good! The following is the only different part.

<rcu_nmi_enter>:
	e8 dc 81 ff ff       	callq  ffffffff810bc450 <rcu_dynticks_eqs_exit>

<rcu_irq_enter>:
	65 48 8b 04 25 00 4d 	mov    %gs:0x14d00,%rax
	01 00 
	c7 80 94 03 00 00 ff 	movl   $0xffffffff,0x394(%rax)
	ff ff ff 
	e8 b9 80 ff ff       	callq  ffffffff810bc450 <rcu_dynticks_eqs_exit>
	e8 d4 b9 ff ff       	callq  ffffffff810bfd70 <rcu_cleanup_after_idle>

--
Thanks,
Byungchul

