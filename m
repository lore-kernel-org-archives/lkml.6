Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8D9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7604B20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7604B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbeGWQEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:04:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35306 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388410AbeGWQEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:04:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0E2818A;
        Mon, 23 Jul 2018 08:02:54 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21BC43F5D0;
        Mon, 23 Jul 2018 08:02:51 -0700 (PDT)
Date:   Mon, 23 Jul 2018 16:02:49 +0100
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
Subject: Re: [PATCH v2 07/12] sched/core: uclamp: enforce last task UCLAMP_MAX
Message-ID: <20180723150249.GD2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-8-patrick.bellasi@arm.com>
 <CAJuCfpH6CsDVG35Z3NV87mUgJW9TmoCuOs8GeW2TEqkP0K0f9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH6CsDVG35Z3NV87mUgJW9TmoCuOs8GeW2TEqkP0K0f9g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-Jul 18:23, Suren Baghdasaryan wrote:
> Hi Patrick,

Hi Sure,
thank!

> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > @@ -977,13 +991,21 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
> >         uc_grp = &rq->uclamp.group[clamp_id][0];
> >         uc_grp[group_id].tasks += 1;
> >
> > +       /* Force clamp update on idle exit */
> > +       uc_cpu = &rq->uclamp;
> > +       clamp_value = p->uclamp[clamp_id].value;
> > +       if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
> 
> The condition below is not needed because UCLAMP_FLAG_IDLE is set only
> for UCLAMP_MAX clamp_id, therefore the above condition already covers
> the one below.

Not really, this function is called two times, the first time to
update UCLAMP_MIN and a second time to update UCLAMP_MAX.

For both clamp_id we want to force update uc_cpu->value[clamp_id],
thus the UCLAMP_FLAG_IDLE flag has to be cleared only the second time.

Maybe I can had the following comment to better explain the reason of
the check:

		/*
		 * This function is called for both UCLAMP_MIN (before) and
		 * UCLAMP_MAX (after). Let's reset the flag only the when
		 * we know that UCLAMP_MIN has been already updated.
		 */

> > +               if (clamp_id == UCLAMP_MAX)
> > +                       uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
> > +               uc_cpu->value[clamp_id] = clamp_value;
> > +               return;
> > +       }

[...]

-- 
#include <best/regards.h>

Patrick Bellasi
