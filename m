Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49215C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03C8279D1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="O6AmjLcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03C8279D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeF1VNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:13:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40520 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbeF1VNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:13:19 -0400
Received: by mail-pl0-f65.google.com with SMTP id t6-v6so3356630plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lr27dvUUKVv882p2I5oyloz79KdnMfYxShhOHJpXPk8=;
        b=O6AmjLcHwt2sFJzazIcc0ritVpX/4NFqRVzsYmsnas77iKKRVxjYwX3x4EnPRyTTl/
         PF7FQ/Wv9X+K9ikdF5EuQ+QCpdSPusb8FXjfcmRQpAsto1RHAfpy9YTHiBn15ZHd5kNr
         OrQhbjg9r2d+ssH901HguE6UJFs0E47tUFs/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lr27dvUUKVv882p2I5oyloz79KdnMfYxShhOHJpXPk8=;
        b=Xmi9OZsyoBeu7UrjuUPJtbNbXFujU0SM1foiVeoVmPV+IyuuWK7yIMEGCw7Ry0wDEK
         8z30xRKIVacru9fkClySELM3H9HTielmYxGtK1e1OVYgyvFBADgWdJXyyCbAg2Fr5eSN
         NCiqwY2tdCF9UvtmmvknszO41FUU6seetvaS0tGHgKyFXKwG9FBE7JP+1wCW31Y7CjJI
         Ufq3OGb/y/FPOox2FiixyJjLHHtyYFOT2IaWBhMCaSm0CE2+Uz6WggTsYK6KHKeZmMqI
         WkdoDarZyf2g2tamjDHQVHTYCLqguOHJ1sEFweTS/siNchE213JV2eSiK7tkkgOlnQnb
         mYtw==
X-Gm-Message-State: APt69E3ok9ik3bkTG9rRnTqz2T997qnpK/DCJ+7SAwKxq+HU0KcaAvqy
        S/uAIT4s/NpAbsQjM5TcxWKY3Q==
X-Google-Smtp-Source: ADUXVKLootJCQkOkMSHFg3+ndLrnkeBHiSVMaciEB7OFM1Hu2peKSZcDWvAiz6mT5PAhmUAYIeqeSg==
X-Received: by 2002:a17:902:aa98:: with SMTP id d24-v6mr12187577plr.185.1530220398766;
        Thu, 28 Jun 2018 14:13:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id p127-v6sm9968311pfb.28.2018.06.28.14.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 14:13:16 -0700 (PDT)
Date:   Thu, 28 Jun 2018 14:13:15 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        max.byungchul.park@gmail.com,
        Byungchul Park <byungchul.park@lge.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180628211315.GA230720@joelaf.mtv.corp.google.com>
References: <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622205813.GV3593@linux.vnet.ibm.com>
 <20180622170042.4adfbe21@gandalf.local.home>
 <20180622211600.GX3593@linux.vnet.ibm.com>
 <CALCETrUqe_1dg=3KYOswGQv5i=_5WFYpcn27Z6oa2D7-nBa+Jw@mail.gmail.com>
 <20180623175356.GH3593@linux.vnet.ibm.com>
 <20180628200205.GA6374@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628200205.GA6374@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:02:05PM -0700, Paul E. McKenney wrote:
> > > <paulmck@linux.vnet.ibm.com> wrote:
[..]
> > > > > > > > So why this function-call structure?  Well, you see, NMI handlers can
> > > > > > > > take what appear to RCU to be normal interrupts...
> > > > > > > >
> > > > > > > > (And I just added that fun fact to Requirements.html.)
> > > > > > >
> > > > > > > Yes, I'll definitely go through all the interrupt requirements in the doc and
> > > > > > > thanks for referring me to it.
> > > > > >
> > > > > > My concern may well be obsolete.  It would be good if it was!  ;-)
> > > > >
> > > > > I'd love to mandate that irq_enter() must be paired with irq_exit(). I
> > > > > don't really see any rationale for it to be otherwise. If there is a
> > > > > case, perhaps it needs to be fixed.
> > > >
> > > > Given that the usermode helpers now look to be common code using
> > > > workqueues, kthreads, and calls to do_execve(), it might well be that
> > > > the days of half-interrupts are behind us.
> > > >
> > > > But how to actually validate this?  My offer of adding a WARN_ON_ONCE()
> > > > and waiting a few years still stands, but perhaps you have a better
> > > > approach.
> > > 
> > > I think you should add a WARN_ON_ONCE().  Let's get the bugs fixed.
> > 
> > Or the obscure features identified, as the case may be.  ;-)
> > 
> > Either way, will do!
> 
> And here is a prototype patch.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit ef544593a7bcad74628fa0537badc49dce1f2d95
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Thu Jun 28 12:45:23 2018 -0700
> 
>     rcu: Add warning to detect half-interrupts
>     
>     RCU's dyntick-idle code is written to tolerate half-interrupts, that it,
>     either an interrupt that invokes rcu_irq_enter() but never invokes the
>     corresponding rcu_irq_exit() on the one hand, or an interrupt that never
>     invokes rcu_irq_enter() but does invoke the "corresponding" rcu_irq_exit()
>     on the other.  These things really did happen at one time, as evidenced
>     by this ca-2011 LKML post:
>     
>     http://lkml.kernel.org/r/20111014170019.GE2428@linux.vnet.ibm.com
>     
>     The reason why RCU tolerates half-interrupts is that usermode helpers
>     used exceptions to invoke a system call from within the kernel such that
>     the system call did a normal return (not a return from exception) to
>     the calling context.  This caused rcu_irq_enter() to be invoked without
>     a matching rcu_irq_exit().  However, usermode helpers have since been
>     rewritten to make much more housebroken use of workqueues, kernel threads,
>     and do_execve(), and therefore should no longer produce half-interrupts.
>     No one knows of any other source of half-interrupts, but then again,
>     no one seems insane enough to go audit the entire kernel to verify that
>     half-interrupts really are a relic of the past.
>     
>     This commit therefore adds a pair of WARN_ON_ONCE() calls that will
>     trigger in the presence of half interrupts, which the code will continue
>     to handle correctly.  If neither of these WARN_ON_ONCE() trigger by
>     mid-2021, then perhaps RCU can stop handling half-interrupts, which
>     would be a considerable simplification.
>     
>     Reported-by: Steven Rostedt <rostedt@goodmis.org>
>     Reported-by: Joel Fernandes <joel@joelfernandes.org>
>     Reported-by: Andy Lutomirski <luto@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Looks good to me!

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel
 
