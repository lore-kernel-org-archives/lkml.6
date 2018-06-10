Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OCNKDI5SHVvzcwAAmS7hNA
	; Sun, 10 Jun 2018 16:32:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4179B607BB; Sun, 10 Jun 2018 16:32:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B117F6032D;
	Sun, 10 Jun 2018 16:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B117F6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbeFJQcg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 12:32:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753407AbeFJQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 12:32:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5AGSlrH066904
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 12:32:33 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jh52s3akd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 12:32:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 10 Jun 2018 12:32:32 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 10 Jun 2018 12:32:27 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5AGWREf5832980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Jun 2018 16:32:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5F6EB2065;
        Sun, 10 Jun 2018 13:33:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C377FB2064;
        Sun, 10 Jun 2018 13:33:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.203.110])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 10 Jun 2018 13:33:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 46BCE16C2AC1; Sun, 10 Jun 2018 09:34:20 -0700 (PDT)
Date: Sun, 10 Jun 2018 09:34:20 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Shakeel Butt <shakeelb@google.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: fix race between kmem_cache destroy, create and
 deactivate
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180530001204.183758-1-shakeelb@google.com>
 <20180609102027.5vkqucnzvh6nfdxu@esperanza>
 <CALvZod7OrDrq571An-GHeWFNvARWsS+fvX1-G9=nYzxgq2N3UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7OrDrq571An-GHeWFNvARWsS+fvX1-G9=nYzxgq2N3UQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061016-0072-0000-0000-0000036B6937
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009164; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01045005; UDB=6.00535103; IPR=6.00824007;
 MB=3.00021565; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-10 16:32:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061016-0073-0000-0000-00004850583F
Message-Id: <20180610163420.GK3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806100201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 07:52:50AM -0700, Shakeel Butt wrote:
> On Sat, Jun 9, 2018 at 3:20 AM Vladimir Davydov <vdavydov.dev@gmail.com> wrote:
> >
> > On Tue, May 29, 2018 at 05:12:04PM -0700, Shakeel Butt wrote:
> > > The memcg kmem cache creation and deactivation (SLUB only) is
> > > asynchronous. If a root kmem cache is destroyed whose memcg cache is in
> > > the process of creation or deactivation, the kernel may crash.
> > >
> > > Example of one such crash:
> > >       general protection fault: 0000 [#1] SMP PTI
> > >       CPU: 1 PID: 1721 Comm: kworker/14:1 Not tainted 4.17.0-smp
> > >       ...
> > >       Workqueue: memcg_kmem_cache kmemcg_deactivate_workfn
> > >       RIP: 0010:has_cpu_slab
> > >       ...
> > >       Call Trace:
> > >       ? on_each_cpu_cond
> > >       __kmem_cache_shrink
> > >       kmemcg_cache_deact_after_rcu
> > >       kmemcg_deactivate_workfn
> > >       process_one_work
> > >       worker_thread
> > >       kthread
> > >       ret_from_fork+0x35/0x40
> > >
> > > To fix this race, on root kmem cache destruction, mark the cache as
> > > dying and flush the workqueue used for memcg kmem cache creation and
> > > deactivation.
> >
> > > @@ -845,6 +862,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
> > >       if (unlikely(!s))
> > >               return;
> > >
> > > +     flush_memcg_workqueue(s);
> > > +
> >
> > This should definitely help against async memcg_kmem_cache_create(),
> > but I'm afraid it doesn't eliminate the race with async destruction,
> > unfortunately, because the latter uses call_rcu_sched():
> >
> >   memcg_deactivate_kmem_caches
> >    __kmem_cache_deactivate
> >     slab_deactivate_memcg_cache_rcu_sched
> >      call_rcu_sched
> >                                             kmem_cache_destroy
> >                                              shutdown_memcg_caches
> >                                               shutdown_cache
> >       memcg_deactivate_rcufn
> >        <dereference destroyed cache>
> >
> > Can we somehow flush those pending rcu requests?
> 
> You are right and thanks for catching that. Now I am wondering if
> synchronize_sched() just before flush_workqueue() should be enough.
> Otherwise we might have to replace call_sched_rcu with
> synchronize_sched() in kmemcg_deactivate_workfn which I would not
> prefer as that would holdup the kmem_cache workqueue.
> 
> +Paul
> 
> Paul, we have a situation something similar to the following pseudo code.
> 
> CPU0:
> lock(l)
> if (!flag)
>   call_rcu_sched(callback);
> unlock(l)
> ------
> CPU1:
> lock(l)
> flag = true
> unlock(l)
> synchronize_sched()
> ------
> 
> If CPU0 has called already called call_rchu_sched(callback) then later
> if CPU1 calls synchronize_sched(). Is there any guarantee that on
> return from synchronize_sched(), the rcu callback scheduled by CPU0
> has already been executed?

No.  There is no such guarantee.

You instead want rcu_barrier_sched(), which waits for the callbacks from
all prior invocations of call_rcu_sched() to be invoked.

Please note that synchronize_sched() is -not- sufficient.  It is only
guaranteed to wait for a grace period, not necessarily for all prior
callbacks.  This goes both directions because if there are no callbacks
in the system, then rcu_barrier_sched() is within its rights to return
immediately.

So please make sure you use each of synchronize_sched() and
rcu_barrier_sched() to do the job that it was intended to do!  ;-)

If your lock(l) is shorthand for spin_lock(&l), it looks to me like you
actually only need rcu_barrier_sched():

	CPU0:
	spin_lock(&l);
	if (!flag)
	  call_rcu_sched(callback);
	spin_unlock(&l);

	CPU1:
	spin_lock(&l);
	flag = true;
	spin_unlock(&l);
	/* At this point, no more callbacks will be registered. */
	rcu_barrier_sched();
	/* At this point, all registered callbacks will have been invoked. */

On the other hand, if your "lock(l)" was instead shorthand for
rcu_read_lock_sched(), then you need -both- synchronize_sched() -and-
rcu_barrier().  And even then, you will be broken in -rt kernels.
(Which might or might not be a concern, depending on whether your code
matters to -rt kernels.

Make sense?

							Thanx, Paul
