Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22423C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1552087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1552087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJJU2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:28:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeJJU2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:28:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E90CED1;
        Wed, 10 Oct 2018 06:05:56 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629753F5BC;
        Wed, 10 Oct 2018 06:05:53 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:05:51 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181010130549.hzpkaskvlgifbdrp@queper01-lin>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 Oct 2018 at 14:04:40 (+0200), Vincent Guittot wrote:
> This patchset doesn't touch cpu_capacity_orig and doesn't need to  as
> it assume that the max capacity is unchanged but some capacity is
> momentary stolen by thermal.
>  If you want to reflect immediately all thermal capping change, you
> have to update this field and all related fields and struct around

I don't follow you here. I never said I wanted to change
cpu_capacity_orig. I don't think we should do that actually. Changing
capacity_of (which is updated during LB	IIRC) is just fine. The question
is about what you want to do there: reflect an averaged value or the
instantaneous one.

It's not obvious (to me) that the complex one (the averaged value) is
better than the other, simpler, one. All I'm saying from the beginning
is that it'd be nice to have numbers and use cases to discuss the pros
and cons of both approaches.

> > > > Hmm, let me have a closer look at the patches, I must have missed
> > > > something ...
> > > >
> > > > > The pace of changing the capping is to fast to reflect that in the
> > > > > whole scheduler topology
> > > >
> > > > That's probably true in some cases, but it'd be cool to have numbers to
> > > > back up that statement, I think.
> > > >
> > > > Now, if you do need to rebuild the sched domain topology every time you
> > > > update the thermal pressure, I think the PELT HL is _way_ too short for
> > > > that ... You can't rebuild the whole thing every 32ms or so. Or am I
> > > > misunderstanding something ?
> > > >
> > > > > > Thara, have you tried to experiment with a simpler implementation as
> > > > > > suggested by Ingo ?
> > > > > >
> > > > > > Also, assuming that we do want to average things, do we actually want to
> > > > > > tie the thermal ramp-up time to the PELT half life ? That provides
> > > > > > nice maths properties wrt the other signals, but it's not obvious to me
> > > > > > that this thermal 'constant' should be the same on all platforms. Or
> > > > > > maybe it should ?
> > > > >
> > > > > The main interest of using PELT signal is that thermal pressure will
> > > > > evolve at the same pace as other signals used in the scheduler.
> > > >
> > > > Right, I think this is a nice property too (assuming that we actually
> > > > want to average things out).
> > > >
> > > > > With
> > > > > thermal pressure, we have the exact same problem as with RT tasks. The
> > > > > thermal will cap the max frequency which will cap the utilization of
> > > > > the tasks running on the CPU
> > > >
> > > > Well, the nature of the signal is slightly different IMO. Yes it's
> > > > capacity, but you're no actually measuring time spent on the CPU. All
> > > > other PELT signals are based on time, this thermal thing isn't, so it is
> > > > kinda different in a way. And I'm still wondering if it could be helpful
> > >
> > > hmmm ... it is based on time too.
> >
> > You're not actually measuring the time spent on the CPU by the 'thermal
> > task'. There is no such thing as a 'thermal task'. You're just trying to
> > model things like that, but the thermal stuff isn't actually
> > interrupting running tasks to eat CPU cycles. It just makes thing run
> > slower, which isn't exactly the same thing IMO.
> >
> > But maybe that's a detail.
> >
> > > Both signals (current ones and thermal one) are really close. The main
> > > difference with other utilization signal is that instead of providing
> > > a running/not running boolean that is then weighted by the current
> > > capacity, the signal uses direclty the capped max capacity to reflect
> > > the amount of cycle that is stolen by thermal mitigation.
> > >
> > > > to be able to have a different HL for that thermal signal. That would
> > > > 'break' the nice maths properties we have, yes, but is it a problem or is
> > > > it actually helpful to cope with the thermal characteristics of
> > > > different platforms ?
> > >
> > > If you don't use the sign kind of signal with the same responsiveness,
> > > you will start to see some OPP toggles as an example when the thermal
> > > state change because one metrics will change faster than the other one
> > > and you can't have a correct view of the system. Same problem was
> > > happening with rt task.
> >
> > Well, that wasn't the problem with rt tasks. The problem with RT tasks
> > was that the time they spend on the CPU wasn't accounted _at all_ when
> > selecting frequency for CFS, not that the accounting was at a different
> > pace ...
> 
> The problem was the same with RT, the cfs utilization was lower than
> reality because RT steals soem cycle to CFS
> So schedutil was selecting a lower frequency when cfs was running
> whereas the CPU was fully used.
> The same can happen with thermal:
> cap the max freq because of thermal
> the utilization with decrease.
> remove the cap
> the utilization is still low and you will select a low OPP because you
> don't take into account cycle stolen by thermal like with RT

I'm not arguing with the fact that we need to reflect the thermal
pressure in the scheduler to see that a CPU is fully busy. I agree with
that.

I'm saying you don't necessarily have to update the thermal stuff and
the existing PELT signals *at the same pace*, because different
platforms have different thermal characteristics.

Thanks,*
Quentin
