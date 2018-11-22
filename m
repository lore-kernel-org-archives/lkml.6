Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B30C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEA520684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEA520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437909AbeKWCbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:31:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43501 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKWCbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:31:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so8389144otr.10;
        Thu, 22 Nov 2018 07:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuSV9OJwhkjuWYb/CMMYGcw2jnQMLw0icj+pdSKdxPg=;
        b=Y7gX44CERuDnxGUb/izYiw7gT9yt3PabpXOZoeWEgZweupQVjJHEJvRiMkTuIY3sRl
         wHa+VaofVFSCfjD9y+Tu7nW+hh4HlB8S6/CXs0IBDClazEYiqfsntMrP1mgfckYzvuhg
         I/cS4wWaUgWxPodJ70vd5EUFGz/VeiA3mZM7QEMO96uxnkOAJXVK3d36rhg98RANb4w9
         RCx3UAY+EQn0pR5uDr9icApBP1G+bu7MM2LZPcOs3tpR+rtAgu4XZIjWPu1+Q5x1z+yd
         /aIhW2T3LDxkglio7UEBSgBcTbAPZwF8+jzqoEALv9poEwdP35P52yog5m3cL3EPOhjI
         W9rQ==
X-Gm-Message-State: AA+aEWbAXd42GLolbkmeZYEb2/+RXA2cOGT1YSxBeMErhZQrJO8XXaY1
        CuKWUEv/IhWPdx9/uCKZ6ezARyyqz29bLtsFZjA=
X-Google-Smtp-Source: AFSGD/X2q4nammjBBYw9Tsa6erhODgZAdAMoQKk2cHqS95/qBuveIV8tOJ6AR8zK7EAcrtDHDDD2wXen5y6fftt2cKc=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr6286746otq.119.1542901909985;
 Thu, 22 Nov 2018 07:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20181119141857.8625-1-quentin.perret@arm.com> <20181119141857.8625-10-quentin.perret@arm.com>
 <20181121130822.GE2113@hirez.programming.kicks-ass.net> <20181121151444.t3zye5l5iycfni2s@queper01-lin>
 <20181122091715.6kvhcbgoqrd54nbs@queper01-lin> <20181122093237.goxmr4p5l4h2izid@queper01-lin>
 <20181122102545.GQ2131@hirez.programming.kicks-ass.net> <20181122152538.jvgh3uvuo5a6lfs7@queper01-lin>
In-Reply-To: <20181122152538.jvgh3uvuo5a6lfs7@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Nov 2018 16:51:41 +0100
Message-ID: <CAJZ5v0iV9oKVHjPdv4UzEJbZt0gumd3a2=cJtFw04FHGbi73kA@mail.gmail.com>
Subject: Re: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 4:25 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Thursday 22 Nov 2018 at 11:25:45 (+0100), Peter Zijlstra wrote:
> > On Thu, Nov 22, 2018 at 09:32:39AM +0000, Quentin Perret wrote:
> > > Hmm, I went too fast, that's totally broken. But there's still something
> > > we can do with static_branch_{inc,dec} I think. I'll come back later
> > > with a better solution.
> >
> > Right; if you count the rd's that have pd set, it should work-ish. Yes,
> > much cleaner if you can get it to work.
>
> So, I came up with the following code which seems to work OK. It's not
> as I clean as I'd like, though. The fact that free_pd() can be called in
> softirq context is annoying to manipulate the static key ...
>
> An alternative to this work item workaround is to do static_branch_dec()
> from build_perf_domains() and next to the three call sites of
> free_rootdomain() in order to avoid the call_rcu() context. Not very
> pretty either.
>
> Or we can just stick with your original suggestion to carry a boolean
> around.

What's problematic with carrying a boolean around?
