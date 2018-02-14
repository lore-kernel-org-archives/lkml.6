Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032602AbeBNQbw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:31:52 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44508 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032316AbeBNQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:31:50 -0500
X-Google-Smtp-Source: AH8x227nr3dUMJVC9JHn7GdEIhLqdg75YC49Ybs0maFktWGp2RswlXLLR+KdY0AgI7CN96LAidaDWQ==
Date: Wed, 14 Feb 2018 17:31:45 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        "luca.abeni" <luca.abeni@santannapisa.it>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 04/10] sched/core: Prevent race condition between
 cpuset and __sched_setscheduler()
Message-ID: <20180214163145.GV12979@localhost.localdomain>
References: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
 <1518553967-20656-5-git-send-email-mathieu.poirier@linaro.org>
 <20180214103639.GR12979@localhost.localdomain>
 <20180214104935.GS12979@localhost.localdomain>
 <20180214112721.GT12979@localhost.localdomain>
 <CANLsYkwPo-uHOWwLZDdvhykx1EU2O--uphJ9KbZYAnD--nFoVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwPo-uHOWwLZDdvhykx1EU2O--uphJ9KbZYAnD--nFoVg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/18 08:33, Mathieu Poirier wrote:
> On 14 February 2018 at 04:27, Juri Lelli <juri.lelli@redhat.com> wrote:
> > On 14/02/18 11:49, Juri Lelli wrote:
> >> On 14/02/18 11:36, Juri Lelli wrote:
> >> > Hi Mathieu,
> >> >
> >> > On 13/02/18 13:32, Mathieu Poirier wrote:
> >> > > No synchronisation mechanism exist between the cpuset subsystem and calls
> >> > > to function __sched_setscheduler().  As such it is possible that new root
> >> > > domains are created on the cpuset side while a deadline acceptance test
> >> > > is carried out in __sched_setscheduler(), leading to a potential oversell
> >> > > of CPU bandwidth.
> >> > >
> >> > > By making available the cpuset_mutex to the core scheduler it is possible
> >> > > to prevent situations such as the one described above from happening.
> >> > >
> >> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> > > ---
> >> >
> >> > [...]
> >> >
> >> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> > > index f727c3d0064c..0d8badcf1f0f 100644
> >> > > --- a/kernel/sched/core.c
> >> > > +++ b/kernel/sched/core.c
> >> > > @@ -4176,6 +4176,13 @@ static int __sched_setscheduler(struct task_struct *p,
> >> > >   }
> >> > >
> >> > >   /*
> >> > > +  * Make sure we don't race with the cpuset subsystem where root
> >> > > +  * domains can be rebuilt or modified while operations like DL
> >> > > +  * admission checks are carried out.
> >> > > +  */
> >> > > + cpuset_lock();
> >> > > +
> >> > > + /*
> >> >
> >> > Mmm, I'm afraid we can't do this. __sched_setscheduler might be called
> >> > from interrupt contex by normalize_rt_tasks().
> >>
> >> Maybe conditionally grabbing it if pi is true could do? I guess we don't
> >> care much about domains when sysrq.
> >
> > Ops.. just got this. :/
> 
> 
> Arrghhh... Back to the drawing board.
> 

Eh.. even though the warning simply happens because unlocking of
cpuset lock is missing

--->8---
@@ -4312,6 +4312,7 @@ static int __sched_setscheduler(struct task_struct *p,                                                            
        /* Avoid rq from going away on us: */                       
        preempt_disable();        
        task_rq_unlock(rq, p, &rf);                                 
+       cpuset_unlock();          
                                  
        if (pi)                   
                rt_mutex_adjust_pi(p);
--->8---

Still grabbing it is a no-go, as do_sched_setscheduler calls
sched_setscheduler from inside an RCU read-side critical section.

So, back to the drawing board indeed. :/

Thanks,

- Juri
