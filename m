Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DDBC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECD620882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECD620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeILR4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:56:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59022 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeILR4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:56:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC1E780D;
        Wed, 12 Sep 2018 05:51:38 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 098F53F703;
        Wed, 12 Sep 2018 05:51:35 -0700 (PDT)
Date:   Wed, 12 Sep 2018 13:51:33 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
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
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
Message-ID: <20180912125133.GE1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-9-patrick.bellasi@arm.com>
 <CAJuCfpHaqNzgpbPCAUxsv+E4HL6vSDKem+sFh2njK1e9dX5ONA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHaqNzgpbPCAUxsv+E4HL6vSDKem+sFh2njK1e9dX5ONA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-Sep 20:02, Suren Baghdasaryan wrote:
> On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > +  cpu.util.min.effective
> > +        A read-only single value file which exists on non-root cgroups and
> > +        reports minimum utilization clamp value currently enforced on a task
> > +        group.
> > +
> > +        The actual minimum utilization in the range [0, 1023].
> > +
> > +        This value can be lower then cpu.util.min in case a parent cgroup
> > +        is enforcing a more restrictive clamping on minimum utilization.
> 
> IMHO if cpu.util.min=0 means "no restrictions" on UCLAMP_MIN then
> calling parent's lower cpu.util.min value "more restrictive clamping"
> is confusing. I would suggest to rephrase this to smth like "...in
> case a parent cgroup requires lower cpu.util.min clamping."

Right, it's slightly confusing... still I would like to call out that
a parent group can enforce something on its children. What about:

   "... a parent cgroup allows only smaller minimum utilization values."

Is that less confusing ?

Otherwise I think your proposal could work too.

[...]

> >  #ifdef CONFIG_UCLAMP_TASK_GROUP
> > +/**
> > + * cpu_util_update_hier: propagete effective clamp down the hierarchy
> 
> typo: propagate

+1

[...]

> > +                * Skip the whole subtrees if the current effective clamp is
> > +                * alredy matching the TG's clamp value.
> 
> typo: already

+1


Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
