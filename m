Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D522EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992C820881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992C820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbeGWQTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:19:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388115AbeGWQTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:19:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A21D18A;
        Mon, 23 Jul 2018 08:17:29 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFF763F237;
        Mon, 23 Jul 2018 08:17:26 -0700 (PDT)
Date:   Mon, 23 Jul 2018 16:17:24 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Message-ID: <20180723151724.GE2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <CAJuCfpE4FbtrwbXNCjj=pXAvTiTLw7z1aLS4+-28X=y4V+SJ-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE4FbtrwbXNCjj=pXAvTiTLw7z1aLS4+-28X=y4V+SJ-Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-Jul 19:37, Suren Baghdasaryan wrote:
> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > +#ifdef CONFIG_UCLAMP_TASK_GROUP
> > +static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
> > +                                 struct cftype *cftype, u64 min_value)
> > +{
> > +       struct task_group *tg;
> > +       int ret = -EINVAL;
> > +
> > +       if (min_value > SCHED_CAPACITY_SCALE)
> > +               return -ERANGE;
> > +
> > +       mutex_lock(&uclamp_mutex);
> > +       rcu_read_lock();
> > +
> > +       tg = css_tg(css);
> > +       if (tg->uclamp[UCLAMP_MIN].value == min_value) {
> > +               ret = 0;
> > +               goto out;
> > +       }
> > +       if (tg->uclamp[UCLAMP_MAX].value < min_value)
> > +               goto out;
> > +
> 
> + tg->uclamp[UCLAMP_MIN].value = min_value;
> + ret = 0;
> 
> Are these assignments missing or am I missing something? Same for
> cpu_util_max_write_u64().

They are introduced in the following patch, to keep this one focus
just on CGroups integration.

I'm also returning -EINVAL at this stage since, with just this patch
in, we are not really providing any good service to user-space, i.e.
it's like clamp groups not being available...

Maybe I can call this out better in the change log ;)

> > +out:
> > +       rcu_read_unlock();
> > +       mutex_unlock(&uclamp_mutex);
> > +
> > +       return ret;
> > +}

[...]

-- 
#include <best/regards.h>

Patrick Bellasi
