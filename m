Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711C9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0A625C02
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0A625C02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934710AbeFYPCx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934559AbeFYPCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:02:52 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323A425BFE;
        Mon, 25 Jun 2018 15:02:51 +0000 (UTC)
Date:   Mon, 25 Jun 2018 11:02:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Message-ID: <20180625110248.5e679a8d@gandalf.local.home>
In-Reply-To: <20180625144849.GN3593@linux.vnet.ibm.com>
References: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
        <20180622062351.GC17010@X58A-UD3R>
        <20180623174954.GA3584@linux.vnet.ibm.com>
        <20180625100708.3cb50ced@gandalf.local.home>
        <20180625144849.GN3593@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 07:48:49 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > > @@ -923,7 +932,7 @@ void rcu_user_exit(void)
> > >  #endif /* CONFIG_NO_HZ_FULL */
> > >  
> > >  /**
> > > - * rcu_nmi_enter - inform RCU of entry to NMI context
> > > + * rcu_nmi_enter_common - inform RCU of entry to NMI context
> > >   *
> > >   * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
> > >   * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
> > > @@ -931,10 +940,10 @@ void rcu_user_exit(void)
> > >   * long as the nesting level does not overflow an int.  (You will probably
> > >   * run out of stack space first.)
> > >   *
> > > - * If you add or remove a call to rcu_nmi_enter(), be sure to test
> > > + * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> > >   * with CONFIG_RCU_EQS_DEBUG=y.
> > >   */
> > > -void rcu_nmi_enter(void)
> > > +static __always_inline void rcu_nmi_enter_common(bool irq)
> > >  {
> > >  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> > >  	long incby = 2;
> > > @@ -951,7 +960,15 @@ void rcu_nmi_enter(void)
> > >  	 * period (observation due to Andy Lutomirski).
> > >  	 */
> > >  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> > > +
> > > +		if (irq)
> > > +			rcu_dynticks_task_exit();
> > > +
> > >  		rcu_dynticks_eqs_exit();
> > > +
> > > +		if (irq)
> > > +			rcu_cleanup_after_idle();
> > > +
> > >  		incby = 1;
> > >  	}
> > >  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),  
> > 
> > 
> > There is a slight change here, although I don't think it is an issue,
> > but I want to bring it up just in case.
> > 
> > The old way had:
> > 
> > 	rcu_dynticks_task_exit();
> > 	rcu_dynticks_eqs_exit();
> > 	trace_rcu_dyntick();
> > 	rcu_cleanup_after_idle();
> > 
> > The new way has:
> > 
> > 	rcu_dynticks_task_exit();
> > 	rcu_dynticks_eqs_exit();
> > 	rcu_cleanup_after_idle();
> > 	trace_rcu_dyntick();
> > 
> > As that tracepoint will use RCU, will this cause any side effects?
> > 
> > My thought is that the new way is actually more correct, as I'm not
> > sure we wanted RCU usage before the rcu_cleanup_after_idle().  
> 
> I believe that this is OK because is is the position of the call to
> rcu_dynticks_eqs_exit() that really matters.  Before this call, RCU
> is not yet watching, and after this call it is watching.  Reversing
> the calls to rcu_cleanup_after_idle() and trace_rcu_dyntick() has them
> both being invoked while RCU is watching.
> 
> All that rcu_cleanup_after_idle() does is to account for the time that
> passed while the CPU was idle, for example, advancing callbacks to allow
> for how ever many RCU grace periods completed during that idle period.
> 
> Or am I missing something subtle.

As I stated above, I actually think the new way is more correct. That's
because the trace event is the first user of RCU here and it probably
wont be the last. It makes more sense to do it after the call to
rcu_cleanup_after_idle(), just because it keeps all the RCU users after
the RCU internal code for coming out of idle. Sure,
rcu_cleanup_after_idle() doesn't do anything now that could affect
this, but maybe it will in the future?

> 
> (At the very least, you would be quite right to ask that this be added
> to the commit log!)
> 

Yes, I agree. There should be a comment in the change log about this
simply because this is technically a functional change.

-- Steve
