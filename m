Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96CAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0F020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0F020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeGXQq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:46:28 -0400
Received: from foss.arm.com ([217.140.101.70]:54020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbeGXQq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:46:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29DC180D;
        Tue, 24 Jul 2018 08:39:25 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 761663F237;
        Tue, 24 Jul 2018 08:39:22 -0700 (PDT)
Date:   Tue, 24 Jul 2018 16:39:16 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Message-ID: <20180724153916.GA3275@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <20180723153040.GG1934745@devbig577.frc2.facebook.com>
 <20180723172215.GG2683@e110439-lin>
 <20180724132902.GI1934745@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724132902.GI1934745@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

I apologize in advance for the (yet another) long reply, however I did
my best hereafter to try to resume all the controversial points
discussed so far.

If you will have (one more time) the patience to go through the
following text you'll find a set of precise clarifications and
questions I have for you.

Thank you again for your time.

On 24-Jul 06:29, Tejun Heo wrote:

[...]

> > What I describe here is just an additional hint to the scheduler which
> > enrich the above described model. Provided A and B are already
> > satisfied, when a task gets a chance to run it will be executed at a
> > min/max configured frequency. That's really all... there is not
> > additional impact on "resources allocation".
> 
> So, if it's a cpufreq range controller.  It'd have sth like
> cpu.freq.min and cpu.freq.max, where min defines the maximum minimum
> cpufreq its descendants can get and max defines the maximum cpufreq
> allowed in the subtree.  For an example, please refer to how
> memory.min and memory.max are defined.

I think you are still looking at just one usage of this interface,
which is likely mainly my fault also because of the long time between
posting. Sorry for that...

Let me re-propose here an abstract of the cover letter with some
additional notes inline.

--- Cover Letter Abstract START ---

> > [...] utilization is a task specific property which is used by the scheduler
> > to know how much CPU bandwidth a task requires (under certain conditions).
> > Thus, the utilization clamp values defined either per-task or via the
> > CPU controller, can be used to represent tasks to the scheduler as
> > being bigger (or smaller) then what they really are.
          ^^^^^^^^^^^^^^^^^^^

This is a fundamental feature added by utilization clamping: this is a
task property which can be useful in many different ways to the
scheduler and not "just" to bias frequency selection.

> > Utilization clamping thus ultimately enable interesting additional
> > optimizations, especially on asymmetric capacity systems like Arm
> > big.LITTLE and DynamIQ CPUs, where:
> > 
> >  - boosting: small tasks are preferably scheduled on higher-capacity CPUs
> >    where, despite being less energy efficient, they can complete faster
> > 
> >  - clamping: big/background tasks are preferably scheduler on low-capacity CPUs
> >    where, being more energy efficient, they can still run but save power and
> >    thermal headroom for more important tasks.

These two point above are two examples of how we can use utilization
clamping which is not frequency selection.

> > This additional usage of the utilization clamping is not presented in this
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^

Is it acceptable to add a generic interface by properly and completely
describing, both in the cover letter and in the relative changelogs,
what will be the future bits we can add ?

> > series but it's an integral part of the Energy Aware Scheduler (EAS) feature
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The EAS scheduler, without the utilization clamping bits, does a great
job in scheduling tasks while saving energy. However, on every system,
we are interested also in other metrics, like for example: completion
time and power dissipation.

Whether certain tasks should be scheduled to optimize energy
efficiency, completion time and/or power dissipation is something we
can achieve only by:

1. adopting a proper tasks classification schema
   => that's why CGroups are of interest

2. using a generic enough mechanism to describe certain tasks
   properties which affect all the metrics above,
   i.e. energy, speed and power
   => that's why utilization and its clamping is of interest

> > set. A similar solution (SchedTune) is already used on Android kernels, which
                                           ^^^^^^^^^^^^^^^^^^^^^^^

This _complete support_ is already actively and successfully used on
many Android devices...

> > targets both frequency selection and task placement biasing.
            ^^^^                     ^^^^^^^^^^^^^^^^^^

... to support _not only_ frequency selections.

> > This series provides the foundation bits to add similar features in mainline
                             ^^^^^^^^^^^^^^^
> > and its first simple client with the schedutil integration.
            ^^^^^^^^^^^^^^^^^^^

The solution presented here shows only the integration with
cpufreq/schedutil. However, since we are adding a user-space
interface, we have to add this new interface in a generic way since
the beginning to support also the complete implementation we will have
at the end.

--- Cover Letter Abstract END ---


From my comments above I hope it's now more clear that "utilization
clamping" is not just a "cpufreq range controller" and, since we
will extend the internal usage of such interface, we cannot add now a
user-space interface which targets just frequency control.

To resume, here we are at proposing a generic interface which:

a) do not strictly enforce and/or grant any bandwidth to tasks and
   do not directly define how the CPU resource has to be partitioned
   among tasks

b) improves the way we can constraint bandwidth consumed by TGs, by
   specifying a min/max "MIPS range" (in scheduler terms: utilization)
   the bandwidth can be consumed at

c) it's based on a fundamental task scheduler metric: utilization
   since the "MIPS range" can be affected by the "type of CPUs" and
   not only by the "operating frequency"

d) can be used by the scheduler to bias "tasks placement" as well as
   "frequency selection"

e) do not provide the full implementation here not only to keep the
   initial patchset limited in size but also because of some
   dependencies on other EAS bits which are currently under discussion
   on LKML.
   These different EAS features can still be progressed independently.

f) at our best, it aims at providing a complete use-case description
   both in the cover-letter as well as in the relative changelogs

Going back to one of your previous comments, when you says:

> What's described is computation bandwidth control but what's
> implemented is just frequency clamping.

Do we agree now that:

1. what we propose is not a "computational bandwidth control"
   mechanism and/or interface

2. what we implement is freq clamping but that's just one use case to
   keep the series small enough

3. despite 2) we need to add an interface which is generic enough to
   accommodate the other use-cases

4. the basic metric exposed (i.e. utilization) is used now for
   frequency clamping but the same one will be used for task placement
   biasing

?

And again, when you say:

> So, there are fundamental discrepancies between
> description+interface vs. what it actually does.

Is it acceptable to have a new interface which fits a wider
description?

With such a description, our aim is also to demonstrate that we are
_not_ adding a special case new user-space interface but a generic
enough interface which can be properly extended in the future without
breaking existing functionalities but just by keep improving them.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
