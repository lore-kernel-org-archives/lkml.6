Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752AAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495EF2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495EF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeKGX2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:28:14 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51264 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbeKGX2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:28:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25E41A78;
        Wed,  7 Nov 2018 05:57:44 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 573BA3F5CF;
        Wed,  7 Nov 2018 05:57:41 -0800 (PST)
Date:   Wed, 7 Nov 2018 13:57:38 +0000
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
Message-ID: <20181107135738.GE14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107131632.GP9781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107131632.GP9781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Nov 14:16, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> 
> > +static void uclamp_group_put(unsigned int clamp_id, unsigned int group_id)
> >  {
> > +	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
> > +	union uclamp_map uc_map_old, uc_map_new;
> > +	long res;
> > +
> > +retry:
> > +
> > +	uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> > +	uc_map_new = uc_map_old;
> > +	uc_map_new.se_count -= 1;
> > +	res = atomic_long_cmpxchg(&uc_maps[group_id].adata,
> > +				  uc_map_old.data, uc_map_new.data);
> > +	if (res != uc_map_old.data)
> > +		goto retry;
> > +}
> 
> Please write cmpxchg loops in the form:
> 
> 	atomic_long_t *ptr = &uclamp_maps[clamp_id][group_id].adata;
> 	union uclamp_map old, new;
> 
> 	old.data = atomic_long_read(ptr);
> 	do {
> 		new.data = old.data;
> 		new.se_cound--;
> 	} while (!atomic_long_try_cmpxchg(ptr, &old.data, new.data));
> 
> 
> (same for all the others of course)

Ok, I did that to save some indentation, but actually it's most
commonly used in a while loop... will update in v6.

Out of curiosity, apart from code consistency, is that required also
specifically for any possible compiler related (mis)behavior ?

-- 
#include <best/regards.h>

Patrick Bellasi
