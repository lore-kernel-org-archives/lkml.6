Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792DEC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A2924940
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvZ6Cast"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A2924940
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbeFVWDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754134AbeFVWDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:03:51 -0400
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com [209.85.128.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557852494B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 22:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529705030;
        bh=y2LfsOkUy0geQhJWzpS7qq05B7nz1ufctTY8cqGV6Y4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jvZ6CastbE5+5FAryMQz3aEWMrVoOY2tzDD9CqWEXeb5W0NzCzIb4jW6vqU+RBwt/
         6MxgGRK4InS4ImaL132sab/ibqgzXsD9EFxr46m9UvIrAWD9qzk1qImkJgl/BUPEVq
         kEznuQbGq9k0qai+w+qAWLVtoaLTnKq08RRgRa64=
Received: by mail-wr0-f173.google.com with SMTP id k6-v6so7997628wrp.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:03:50 -0700 (PDT)
X-Gm-Message-State: APt69E3YDpk99EDNeufN82uIU6L2RrYaFeXLuXstJ8pXSyo38w1TFIOV
        eI0jODSUfCACEX7t8vUcjOePSYavs5cXyQz0s+9rLA==
X-Google-Smtp-Source: ADUXVKKkL/I0vjbienj+53b72sbyFMNUtGWkanjcG8mLioTcjIJTjL5H0eepKVh8i+cnPQZnSzCcrA8wKsObRWvZBdc=
X-Received: by 2002:adf:85ec:: with SMTP id 41-v6mr2905158wru.120.1529705028785;
 Fri, 22 Jun 2018 15:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com> <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com> <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com> <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622205813.GV3593@linux.vnet.ibm.com> <20180622170042.4adfbe21@gandalf.local.home>
 <20180622211600.GX3593@linux.vnet.ibm.com>
In-Reply-To: <20180622211600.GX3593@linux.vnet.ibm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 15:03:35 -0700
X-Gmail-Original-Message-ID: <CALCETrUqe_1dg=3KYOswGQv5i=_5WFYpcn27Z6oa2D7-nBa+Jw@mail.gmail.com>
Message-ID: <CALCETrUqe_1dg=3KYOswGQv5i=_5WFYpcn27Z6oa2D7-nBa+Jw@mail.gmail.com>
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct rcu_dynticks
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, joel@joelfernandes.org,
        max.byungchul.park@gmail.com,
        Byungchul Park <byungchul.park@lge.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 2:14 PM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> On Fri, Jun 22, 2018 at 05:00:42PM -0400, Steven Rostedt wrote:
> > On Fri, 22 Jun 2018 13:58:13 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> >
> > > Something like this:
> > >
> > >     IRQ entered
> > >
> > > And never exited.  Ever.  I actually saw this in 2011.
> >
> > I still believe this was actually a bug. And perhaps you made the RCU
> > code robust enough to handle this bug ;-)
>
> Welcome to my world!
>
> But I recall it being used in several places, so if it was a bug, it
> was an intentional bug.  Probably the worst kind.
>
> Sort of like nested NMIs and interrupts within NMI handlers.  ;-)
>
> > > Or something like this:
> > >
> > >     IRQ exited
> > >
> > > Without a corresponding IRQ enter.
> > >
> > > The current code handles both of these situations, at least assuming
> > > that the interrupt entry/exit happens during a non-idle period.
> > >
> > > > > So why this function-call structure?  Well, you see, NMI handlers can
> > > > > take what appear to RCU to be normal interrupts...
> > > > >
> > > > > (And I just added that fun fact to Requirements.html.)
> > > >
> > > > Yes, I'll definitely go through all the interrupt requirements in the doc and
> > > > thanks for referring me to it.
> > >
> > > My concern may well be obsolete.  It would be good if it was!  ;-)
> >
> > I'd love to mandate that irq_enter() must be paired with irq_exit(). I
> > don't really see any rationale for it to be otherwise. If there is a
> > case, perhaps it needs to be fixed.
>
> Given that the usermode helpers now look to be common code using
> workqueues, kthreads, and calls to do_execve(), it might well be that
> the days of half-interrupts are behind us.
>
> But how to actually validate this?  My offer of adding a WARN_ON_ONCE()
> and waiting a few years still stands, but perhaps you have a better
> approach.

I think you should add a WARN_ON_ONCE().  Let's get the bugs fixed.

--Andy
