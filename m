Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7253ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379202087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cW8pkVWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379202087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbeIXW37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:29:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbeIXW36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dqqSZ8YvAX0EwDqB0f6MQiQThrNZOmSXNQ77OylbiAY=; b=cW8pkVWnQTWSA72ZoepcjgLcf
        OA1eZfEs/N3mU6yBB9bI0KaTSM/2DH2sgg1CdRNKH+QKKV0baO1bmZGy1BX8HCdAZEdcbpQArIOzX
        TZwir4MO3KhseQepTRpar2ec41WrStWlErYo5uVN9XAnriQcunYW6K6uov+IZlvk/TAS4JNnh4tgu
        aFxDsGY617BlWgph0QZYiGkbF4Uz9LGUqQEX/ST3xRR+0sTyDy1MDGJmwegEXWIb9OBrkSPZ0a1ly
        BRj5A0A9/qLkjbx9nzkA9Rl6oq4dBgm//xUjGPfLwfxQ5W/n8/8kQKBUd4IAX8V3EW8TQcz6TUqCE
        Z8aI8mFgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4Th5-0007Xk-M0; Mon, 24 Sep 2018 16:26:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A89EB20289D0D; Mon, 24 Sep 2018 18:26:40 +0200 (CEST)
Date:   Mon, 24 Sep 2018 18:26:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180924162640.GB7060@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
 <20180924151400.GT1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924151400.GT1413@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:14:00PM +0100, Patrick Bellasi wrote:

> ... still it's difficult to give a precise definition of knee point,
> unless you know about platforms which have a sharp change in energy
> efficiency.
> 
> The only cases we know about are those where:
> 
> A) multiple frequencies uses the same voltage, e.g.
> 
> 
>      ^                                     *
>      | Energy                              O
>      | efficiency                         O+
>      |                                   O |
>      |                                 O*  |
>      |                              O**    |
>      |   O**                    O***       |
>      |   +  O**            O****           |
>      |   |     O**   O*****                |
>      |   |        O**                      |
>      |   |          +                      |
>      |   |  Same V  |   Increasing V       |
>      +---+----------+----------------------+----------->
>          |          |                      | Frequency
>          L          M                      H
> 
> B) there is a big frequency gap between low frequency OPPs and high
>    frequency OPPs, e.g.
> 
>                                        O
>     ^                                **+
>     | Energy                       **  |
>     | efficiency                 **    |
>     |                          **      |
>     |                        **        |
>     |                      **          |
>     |                    **            |
>     |                  **              |
>     |               O**                |
>     |        O******+                  |
>     |O*******       |                  |
>     |               |                  |
>     ++--------------+------------------+------>
>      |              |                  |  Frequency
>      L              M                  H
> 
> 
> In case A, all the OPPs left of M are dominated by M in terms
> of energy efficiency and normally they should be never used.
> Unless you are under thermal constraints and you still want to keep
> your code running even if at a lower rate and energy efficiency.
> At this point, however, you already invalidated all the OPPs right of
> M and, on the remaining, you still struggle do define the knee point.
> 
> In case B... I'm wondering it such a conf even makes sense ;)
> Is there really some platform out there with such a "non homogeneously
> distributed" set of available frequencies ?

Well, the curve is a second or third order polynomial (when V~f -> fV^2
-> f^3), so it shoots up at some point. There's not really anything you
can do about that. But if you're willing to put in active cooling and
lots of energy, you can make it go fast :-)

Therefore I was thinking:

> Maybe we can define a threshold
> for a "EE derivative ratio", but it will still be quite arbitrary.

Because up until de/df=.5 we gain more performance than we loose ee. But
I might not have appreciated the fact that when we work with imaginary
cost units that skews the .5.

