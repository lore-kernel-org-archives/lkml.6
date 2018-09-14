Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68B7ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85129206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85129206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeINS4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:56:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeINS4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:56:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 454DA18A;
        Fri, 14 Sep 2018 06:41:34 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75A6A3F703;
        Fri, 14 Sep 2018 06:41:31 -0700 (PDT)
Date:   Fri, 14 Sep 2018 14:41:28 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups
 accounting
Message-ID: <20180914134128.GP1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-4-patrick.bellasi@arm.com>
 <20180913191209.GY24082@hirez.programming.kicks-ass.net>
 <20180914090751.GN1413@e110439-lin>
 <20180914115217.GI24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914115217.GI24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Sep 13:52, Peter Zijlstra wrote:
> On Fri, Sep 14, 2018 at 10:07:51AM +0100, Patrick Bellasi wrote:
> > On 13-Sep 21:12, Peter Zijlstra wrote:
> > > On Tue, Aug 28, 2018 at 02:53:11PM +0100, Patrick Bellasi wrote:
> > > > +static inline void uclamp_cpu_get_id(struct task_struct *p,
> > > > +				     struct rq *rq, int clamp_id)
> > > > +{
> > > > +	struct uclamp_group *uc_grp;
> > > > +	struct uclamp_cpu *uc_cpu;
> > > > +	int clamp_value;
> > > > +	int group_id;
> > > > +
> > > > +	/* Every task must reference a clamp group */
> > > > +	group_id = p->uclamp[clamp_id].group_id;
> > > 
> > > > +}
> > > > +
> > > > +static inline void uclamp_cpu_put_id(struct task_struct *p,
> > > > +				     struct rq *rq, int clamp_id)
> > > > +{
> > > > +	struct uclamp_group *uc_grp;
> > > > +	struct uclamp_cpu *uc_cpu;
> > > > +	unsigned int clamp_value;
> > > > +	int group_id;
> > > > +
> > > > +	/* New tasks don't have a previous clamp group */
> > > > +	group_id = p->uclamp[clamp_id].group_id;
> > > > +	if (group_id == UCLAMP_NOT_VALID)
> > > > +		return;
> > > 
> > > *confused*, so on enqueue they must have a group_id, but then on dequeue
> > > they might no longer have?
> > 
> > Why not ?
> 
> That's what it says on the tin, right? enqueue: "every task must reference clamp
> group" while on dequeue: "new tasks don't have a (previous) clamp group"
> and we check for NOT_VALID.

Oh, right... I've got confused me too since I was looking @enqueue.

You right, @dequeue we always a group_id. The check @dequeue time was
required only before v3 because of the way defaults (i.e. no clamps)
was tracked. Will remove it in v5, thanks!

BTW, my previous explanation was also incorrect, since the logic for
init_task initialization is:

   uc_se->group_id = UCLAMP_NOT_VALID;
   uclamp_group_get(value)

where the first assignment is required just to inform uclamp_group_get()
that we don't need to uclamp_group_put() a previous (non existing at
init time) clamp group.

Thus, at the end of the two instructions above we end up with an
init_task which has a !UCLAMP_NOT_VALID group id, which is then
cloned by forked tasks.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
