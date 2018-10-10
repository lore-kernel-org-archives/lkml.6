Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD879C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1ED20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1ED20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJJVKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:10:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52520 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbeJJVKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:10:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EC9B1596;
        Wed, 10 Oct 2018 06:48:01 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F41EB3F5D3;
        Wed, 10 Oct 2018 06:47:58 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:47:57 +0100
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
Message-ID: <20181010134755.jrigtogbxwaz2izb@queper01-lin>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010130549.hzpkaskvlgifbdrp@queper01-lin>
 <CAKfTPtA=GYaiKcJ9N5zEnzxJTKBATG41c0xDjhbA21G-Cv6LvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA=GYaiKcJ9N5zEnzxJTKBATG41c0xDjhbA21G-Cv6LvA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 Oct 2018 at 15:27:57 (+0200), Vincent Guittot wrote:
> On Wed, 10 Oct 2018 at 15:05, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Wednesday 10 Oct 2018 at 14:04:40 (+0200), Vincent Guittot wrote:
> > > This patchset doesn't touch cpu_capacity_orig and doesn't need to  as
> > > it assume that the max capacity is unchanged but some capacity is
> > > momentary stolen by thermal.
> > >  If you want to reflect immediately all thermal capping change, you
> > > have to update this field and all related fields and struct around
> >
> > I don't follow you here. I never said I wanted to change
> > cpu_capacity_orig. I don't think we should do that actually. Changing
> > capacity_of (which is updated during LB IIRC) is just fine. The question
> > is about what you want to do there: reflect an averaged value or the
> > instantaneous one.
> 
> Sorry I though your were speaking about updating this cpu_capacity_orig.

N/p, communication via email can easily become confusing :-)

> With using instantaneous max  value in capacity_of(), we are back to
> the problem raised by Thara that  the value will most probably not
> reflect the current capping value when it is used in LB, because LB
> period can quite long on busy CPU (default max value is 32*sd_weight
> ms)

But averaging the capping value over time doesn't make LB happen more
often ... That will help you account for capping that happened in the
past, but it's not obvious this is actually a good thing. Probably not
all the time anyway.

Say a CPU was capped at 50% of it's capacity, then the cap is removed.
At that point it'll take 100ms+ for the thermal signal to decay and let
the scheduler know about the newly available capacity. That can probably
be a performance hit in some use cases ... And the other way around, it
can also take forever for the scheduler to notice that a CPU has a
reduced capacity before reacting to it.

If you want to filter out very short transient capping events to avoid
over-reacting in the scheduler (is this actually happening ?), then
maybe the average should be done on the cooling device side or something
like that ?

Thanks,
Quentin
