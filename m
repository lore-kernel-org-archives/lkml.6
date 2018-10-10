Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477492085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477492085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeJJRQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:16:30 -0400
Received: from foss.arm.com ([217.140.101.70]:49592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJJRQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:16:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2424380D;
        Wed, 10 Oct 2018 02:55:06 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FC173F5BC;
        Wed, 10 Oct 2018 02:55:03 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:55:01 +0100
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
Message-ID: <20181010095459.orw2gse75klpwosx@queper01-lin>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wednesday 10 Oct 2018 at 10:50:05 (+0200), Vincent Guittot wrote:
> The problem with reflecting directly the capping is that it happens
> far more often than the pace at which cpu_capacity_orig is updated in
> the scheduler.

Hmm, how can you be so sure ? That most likely depends on the workload,
the platform and the thermal governor. Some platforms heat up slowly,
some quickly. The pace at which the thermal governor will change things
should depend on that I assume.

> This means that at the moment when scheduler uses the
> value, it might not be correct anymore.

And OTOH, when you remove a cap for example, it will take time before
the scheduler can see the newly available capacity if you need to wait
for the signal to decay. So you are using a wrong information too in
that scenario.

> Then, this value are also used
> when building the sched_domain and setting max_cpu_capacity which
> would also implies the rebuilt the sched_domain topology ...

Wait what ? I thought the thermal cap was reflected in capacity_of, not
capacity_orig_of ... You need to rebuild the sched_domain in case of
thermal pressure ?

Hmm, let me have a closer look at the patches, I must have missed
something ...

> The pace of changing the capping is to fast to reflect that in the
> whole scheduler topology

That's probably true in some cases, but it'd be cool to have numbers to
back up that statement, I think.

Now, if you do need to rebuild the sched domain topology every time you
update the thermal pressure, I think the PELT HL is _way_ too short for
that ... You can't rebuild the whole thing every 32ms or so. Or am I
misunderstanding something ?

> > Thara, have you tried to experiment with a simpler implementation as
> > suggested by Ingo ?
> >
> > Also, assuming that we do want to average things, do we actually want to
> > tie the thermal ramp-up time to the PELT half life ? That provides
> > nice maths properties wrt the other signals, but it's not obvious to me
> > that this thermal 'constant' should be the same on all platforms. Or
> > maybe it should ?
> 
> The main interest of using PELT signal is that thermal pressure will
> evolve at the same pace as other signals used in the scheduler.

Right, I think this is a nice property too (assuming that we actually
want to average things out).

> With
> thermal pressure, we have the exact same problem as with RT tasks. The
> thermal will cap the max frequency which will cap the utilization of
> the tasks running on the CPU

Well, the nature of the signal is slightly different IMO. Yes it's
capacity, but you're no actually measuring time spent on the CPU. All
other PELT signals are based on time, this thermal thing isn't, so it is
kinda different in a way. And I'm still wondering if it could be helpful
to be able to have a different HL for that thermal signal. That would
'break' the nice maths properties we have, yes, but is it a problem or is
it actually helpful to cope with the thermal characteristics of
different platforms ?

Thanks,
Quentin
