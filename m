Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967302AbeBNKtl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:49:41 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55823 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967273AbeBNKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:49:39 -0500
X-Google-Smtp-Source: AH8x224p0vg52bof56Xi3/7WE10nsgLopUr8qqf53I+OLYtzKnVJQPWiGrIP1oLPAJ/r9AE3CiOHkg==
Date: Wed, 14 Feb 2018 11:49:35 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, lizefan@huawei.com, mingo@redhat.com,
        rostedt@goodmis.org, claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, luca.abeni@santannapisa.it,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 04/10] sched/core: Prevent race condition between
 cpuset and __sched_setscheduler()
Message-ID: <20180214104935.GS12979@localhost.localdomain>
References: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
 <1518553967-20656-5-git-send-email-mathieu.poirier@linaro.org>
 <20180214103639.GR12979@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214103639.GR12979@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/18 11:36, Juri Lelli wrote:
> Hi Mathieu,
> 
> On 13/02/18 13:32, Mathieu Poirier wrote:
> > No synchronisation mechanism exist between the cpuset subsystem and calls
> > to function __sched_setscheduler().  As such it is possible that new root
> > domains are created on the cpuset side while a deadline acceptance test
> > is carried out in __sched_setscheduler(), leading to a potential oversell
> > of CPU bandwidth.
> > 
> > By making available the cpuset_mutex to the core scheduler it is possible
> > to prevent situations such as the one described above from happening.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> 
> [...]
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f727c3d0064c..0d8badcf1f0f 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4176,6 +4176,13 @@ static int __sched_setscheduler(struct task_struct *p,
> >  	}
> >  
> >  	/*
> > +	 * Make sure we don't race with the cpuset subsystem where root
> > +	 * domains can be rebuilt or modified while operations like DL
> > +	 * admission checks are carried out.
> > +	 */
> > +	cpuset_lock();
> > +
> > +	/*
> 
> Mmm, I'm afraid we can't do this. __sched_setscheduler might be called
> from interrupt contex by normalize_rt_tasks().

Maybe conditionally grabbing it if pi is true could do? I guess we don't
care much about domains when sysrq.
