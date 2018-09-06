Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73311C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364AC206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364AC206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeIFSYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:24:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46024 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbeIFSYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:24:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1099B80D;
        Thu,  6 Sep 2018 06:48:52 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41A9B3F614;
        Thu,  6 Sep 2018 06:48:49 -0700 (PDT)
Date:   Thu, 6 Sep 2018 14:48:46 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
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
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180906134846.GB25636@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180905104545.GB20267@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905104545.GB20267@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri!

On 05-Sep 12:45, Juri Lelli wrote:
> Hi,
> 
> On 28/08/18 14:53, Patrick Bellasi wrote:
> 
> [...]
> 
> >  static inline int __setscheduler_uclamp(struct task_struct *p,
> >  					const struct sched_attr *attr)
> >  {
> > -	if (attr->sched_util_min > attr->sched_util_max)
> > -		return -EINVAL;
> > -	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
> > -		return -EINVAL;
> > +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > +	int lower_bound, upper_bound;
> > +	struct uclamp_se *uc_se;
> > +	int result = 0;
> >  
> > -	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> > -	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> > +	mutex_lock(&uclamp_mutex);
> 
> This is going to get called from an rcu_read_lock() section, which is a
> no-go for using mutexes:
> 
>  sys_sched_setattr ->
>    rcu_read_lock()
>    ...
>    sched_setattr() ->
>      __sched_setscheduler() ->
>        ...
>        __setscheduler_uclamp() ->
>          ...
> 	 mutex_lock()

Rightm, great catch, thanks!

> Guess you could fix the issue by getting the task struct after find_
> process_by_pid() in sys_sched_attr() and then calling sched_setattr()
> after rcu_read_lock() (putting the task struct at the end). Peter
> actually suggested this mod to solve a different issue.

I guess you mean something like this ?

---8<---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5792,10 +5792,15 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
        rcu_read_lock();
        retval = -ESRCH;
        p = find_process_by_pid(pid);
-       if (p != NULL)
-               retval = sched_setattr(p, &attr);
+       if (likely(p))
+               get_task_struct(p);
        rcu_read_unlock();
 
+       if (likely(p)) {
+               retval = sched_setattr(p, &attr);
+               put_task_struct(p);
+       }
+
        return retval;
 }
---8<---

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
