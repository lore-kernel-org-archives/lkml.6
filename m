Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7DEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A832086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A832086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbeKHA07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:26:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52256 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388031AbeKHA07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:26:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DC8715AB;
        Wed,  7 Nov 2018 06:56:17 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0CB13F5BD;
        Wed,  7 Nov 2018 06:56:14 -0800 (PST)
Date:   Wed, 7 Nov 2018 14:56:12 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20181107145612.GJ14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107121908.GO9781@hirez.programming.kicks-ass.net>
 <20181107141949.GF14309@e110439-lin>
 <20181107144252.GG9761@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107144252.GG9761@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Nov 15:42, Peter Zijlstra wrote:
> On Wed, Nov 07, 2018 at 02:19:49PM +0000, Patrick Bellasi wrote:
> > On 07-Nov 13:19, Peter Zijlstra wrote:
> > > On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> > > > +struct uclamp_se {
> > > > +	unsigned int value		: SCHED_CAPACITY_SHIFT + 1;
> > > > +	unsigned int group_id		: order_base_2(UCLAMP_GROUPS);
> > > 
> > > Are you sure about ob2() ? seems weird we'll end up with 0 for
> > > UCLAMP_GROUPS==1.
> > 
> > So, we have:
> > 
> >    #define UCLAMP_GROUPS (CONFIG_UCLAMP_GROUPS_COUNT + 1)
> > 
> > because one clamp group is always reserved for defaults.
> > Thus, ob2(in) is always called with n>=2.
> > 
> > ... should be safe no ?
> 
> +config UCLAMP_GROUPS_COUNT
> +       int "Number of different utilization clamp values supported"
> +       range 0 32
> +       default 5
> 
> 0+1 == 1

Seems so... :)

> Increase the min range and you should be good I think.

... dunno why I was absolutely convinced that was already 1, since 0
group does not make a lot of sense. :/

-- 
#include <best/regards.h>

Patrick Bellasi
