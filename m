Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EBFC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE328208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="E/TWy8I3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE328208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeJPD0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:26:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44310 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeJPD0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:26:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so9632039pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/SmIcgBVAk6gZKsas40nJsrIcVKBBO6iOo1aR6JLto4=;
        b=E/TWy8I3HZE2MbvHdUDiwROhdCIT0lcnA8GMvYiDwCcqg/EUuUvoKciZChTQHhoHZr
         roPACIDv6uCHAvCGYNAhBfkbxMezMVzgRsDrhYbD7o7YRVhX5+ILd2kmRDzzeTY7UyLR
         H8a2WvZNBm4V0gNzjoHhY+SaGxd5zQ+IBQNMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/SmIcgBVAk6gZKsas40nJsrIcVKBBO6iOo1aR6JLto4=;
        b=Cs/khCzIuCg7KzT8AZnEpdAt7EfZfWiXb+RXEJRTlojijv1Nu/FsholrF1ym00S21Y
         0P/1B5aUPrRY8novTuyoQc7galJ9VNGNEv2Ot0q1VDY3bF0L3d1kt3UmWfKugyQAxleQ
         uTP5am/5amgY+Rl7Gh7UFjHBVtaJ2wlquVq4L9+/j2VOjhI3zMJNFTKoRmLz9RRpqcCz
         3AXA7vWrHuA5EytOqR4StPbNU/JBPsEicsW+rYxo+RWMbGYCmS4EzqDZft94TASwhapE
         +e6jV4p++hwROm9zqUkuYe9GBXFZG8CtD1TuOIfHBMWlKBL2cqtwoTdKK0q/RiyRvGaq
         lVYA==
X-Gm-Message-State: ABuFfojageca7TeKKXi7jSok4NsQHmMTioB2aHTI6nEcC1BjohaXgTS3
        ze99Xt0Vt6IlhtFl/yISvFysEA==
X-Google-Smtp-Source: ACcGV62q46z4qTbFNJb9oMTyKTj7sjaRermm5mSaSkdv/mviftNoCZfPi5OTPTyvne0dJgEugI+S8g==
X-Received: by 2002:a63:26c4:: with SMTP id m187-v6mr17450023pgm.268.1539632394274;
        Mon, 15 Oct 2018 12:39:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z15-v6sm14344370pfn.170.2018.10.15.12.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 12:39:53 -0700 (PDT)
Date:   Mon, 15 Oct 2018 12:39:51 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Message-ID: <20181015193951.GA33528@joelaf.mtv.corp.google.com>
References: <20181014212955.95267-1-joel@joelfernandes.org>
 <20181014231731.GN2674@linux.ibm.com>
 <20181015020827.GA217384@joelaf.mtv.corp.google.com>
 <20181015021349.GB217384@joelaf.mtv.corp.google.com>
 <20181015023328.GP2674@linux.ibm.com>
 <20181015024758.GA227989@joelaf.mtv.corp.google.com>
 <5151da01-343b-bb37-353e-b6652ae530f5@suse.com>
 <20181015112112.GT2674@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015112112.GT2674@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:21:12AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 15, 2018 at 09:05:22AM +0300, Nikolay Borisov wrote:
> > On 15.10.2018 05:47, Joel Fernandes wrote:
> > > On Sun, Oct 14, 2018 at 07:33:28PM -0700, Paul E. McKenney wrote:
> > >> On Sun, Oct 14, 2018 at 07:13:49PM -0700, Joel Fernandes wrote:
> > >>> On Sun, Oct 14, 2018 at 07:08:27PM -0700, Joel Fernandes wrote:
> > >>>> On Sun, Oct 14, 2018 at 04:17:31PM -0700, Paul E. McKenney wrote:
> > >>>>> On Sun, Oct 14, 2018 at 02:29:55PM -0700, Joel Fernandes (Google) wrote:
> > >>>>>> The Requirements.html document says "Disabling Preemption Does Not Block
> > >>>>>> Grace Periods". However this is no longer true with the RCU
> > >>>>>> consolidation. Lets remove the obsolete (non-)requirement entirely.
> > >>>>>>
> > >>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >>>>>
> > >>>>> Good catch, queued, thank you!
> > >>>>
> > >>>> Thanks! By the way after I sent the patch, I also tried Oleg's experiment to
> > >>>> confirm that this is indeed obsolete.  :)
> > >>>>
> > >>>> One thing interesting came up when I tried synchronize_rcu_expedited()
> > >>>> instead of synchronize_rcu() in Oleg's experiment, I still saw a multiple
> > >>>> millisecond delay between when the rcu read section completely and the
> > >>>> synchronize_rcu_expedited returns:
> > >>>>
> > >>>> For example, with synchronize_rcu_expedited, the 'SPIN done' and the 'SYNC
> > >>>> done' are about 3 millisecond apart:
> > >>>> [   77.599142] SPIN start
> > >>>> [   77.601595] SYNC start
> > >>>> [   82.604950] SPIN done!
> > >>>> [   82.607836] SYNC done!
> > >>>>  I saw anywhere from 2-6 milliseconds.
> > >>>>
> > >>>> The reason I bring this up is according to Requirements.html: In some cases,
> > >>>> the multi-millisecond synchronize_rcu() latencies are unacceptable. In these
> > >>>> cases, synchronize_rcu_expedited() may be used instead,.. so either I messed
> > >>>> something up in the experiment, or I need to update this part of the document ;-)
> > >>
> > >> In normal testing, 2-6 milliseconds is indeed excessive.  Could you please
> > >> point me at Oleg's experiment?  Also, what CONFIG_PREEMPT setting were
> > >> you using?  (My guess is CONFIG_PREEMPT=y.)
> > > 
> > > The CONFIG_PREEMPT config I am using is CONFIG_PREEMPT=y.
> > > 
> > >>> So I realized I'm running in Qemu so it could also be a scheduling delay of
> > >>> the vcpu thread. So apologies about the noise if the experiment works fine
> > >>> for you.
> > >>
> > >> I used rcuperf, which might not be doing the same thing as Oleg's
> > >> experiment.
> > > 
> > > The experiment is mentioned at:
> > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg912055.html
> > > 
> > > If you apply the below diff, it applies cleanly on rcu/dev. And then run:
> > > taskset 2 perl -e 'syscall 157, 666, 5000' &
> > > taskset 1 perl -e 'syscall 157, 777'
> > > 
> > > diff --git a/kernel/sys.c b/kernel/sys.c
> > > index cf5c67533ff1..b654b7566ca3 100644
> > > --- a/kernel/sys.c
> > > +++ b/kernel/sys.c
> > > @@ -2261,6 +2261,9 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
> > >  	return -EINVAL;
> > >  }
> > >  
> > > +#include <linux/delay.h>
> > > +
> > > +
> > >  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> > >  		unsigned long, arg4, unsigned long, arg5)
> > >  {
> > > @@ -2274,6 +2277,19 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> > >  
> > >  	error = 0;
> > >  	switch (option) {
> > > +	case 666:
> > > +		preempt_disable();
> > > +		pr_crit("SPIN start\n");
> > > +		while (arg2--)
> > > +			mdelay(1);
> 
> OK, this is the problem.  When you spin in the kernel for several
> milliseconds with preemption disabled, the consolidated grace period
> is -required- to wait for this preemption-disabled reader to complete,
> whether expedited or not.
> 
> So, expected behavior.  ;-)

Cool. Thanks for confirming. I ran some tests too and if I reduce the
preempt_disabled section's duration, then the delay for
synchronize_rcu_expedited is much lesser indeed.

> In any case, please don't spin for milliseconds with preemption disabled.
> The real-time guys are unlikely to be happy with you if you do this!

Well just to clarify, I was just running Oleg's test which did this. This
test was mentioned in the original documentation that I deleted. Ofcourse I
would not dare do such a thing in production code :-D. I guess to Oleg's
defense, he did it to very that synchronize_rcu() was not blocked on
preempt-disable sections which was a different test.

> > > +		pr_crit("SPIN done!\n");
> > > +		preempt_enable();
> > > +		break;
> > > +	case 777:
> > > +		pr_crit("SYNC start\n");
> > > +		synchronize_rcu();
> > > +		pr_crit("SYNC done!\n");
> > 
> > But you are using the console printing infrastructure which is rather
> > heavyweight. Try replacing pr_* calls with trace_printk so that you
> > write to the lock-free ring buffer, this will reduce the noise from the
> > heavy console printing infrastructure.
> 
> And this might be a problem as well.

This was not the issue (or atleast not fully the issue) since I saw the same
thing with trace_printk. It was exactly what you said - which is the
excessively long preempt disabled times.

thanks!

 - Joel

