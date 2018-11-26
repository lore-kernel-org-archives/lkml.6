Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4502B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmeru8UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4502B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeK0Cs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeK0Cs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:48:29 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 285D22086E;
        Mon, 26 Nov 2018 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543247637;
        bh=NDyOwjenmhCpe4z6io7aIuzsGueomkpDcPRCZYRbbsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dmeru8UHts9uI4U1brErLRVSNlW89/UHGhMC2V0xojW7Ixmtw5ZSCFxbILrzyEIei
         EpvetcKcrwJnLrz07dauTkhdI7fqM7PotfYEsayh01L3DLI87GrC+CSWqZWcN5vBuH
         NqDsZ7gVkp5kYAF3rAqGUxC+vdvFYOApXYSFTXOQ=
Date:   Mon, 26 Nov 2018 16:53:54 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 19/25] sched/vite: Handle nice updates under vtime
Message-ID: <20181126155352.GA18962@lerouge>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-20-git-send-email-frederic@kernel.org>
 <20181120141754.GW2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120141754.GW2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:17:54PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 14, 2018 at 03:46:03AM +0100, Frederic Weisbecker wrote:
> > On the vtime level, nice updates are currently handled on context
> > switches. When a task's nice value gets updated while it is sleeping,
> > the context switch takes into account the new nice value in order to
> > later record the vtime delta to the appropriate kcpustat index.
> 
> Urgh, so this patch should be folded into the previous one. On their own
> neither really makes sense.

Indeed, I overcut the patchset, some pieces need to be folded.

> 
> > We have yet to handle live updates: when set_user_nice() is called
> > while the target is running. We'll handle that on two sides:
> > 
> > * If the caller of set_user_nice() is the current task, we update the
> >   vtime state in place.
> > 
> > * If the target runs on a different CPU, we interrupt it with an IPI to
> >   update the vtime state in place.
> 
> *groan*... So what are the rules for vtime updates? Who can do that
> when?
> 
> So when we change nice, we'll have the respective rq locked and task
> effectively unqueued. It cannot schedule at such a point. Can
> 'concurrent' vtime updates still happen?

Yes but that's fine. The target vtime doesn't need to see the update immediately.
All we want is that it enters into nice mode at some near future, hence the use of
a non waiting IPI.

> 
> > The vtime update in question consists in flushing the pending vtime
> > delta to the task/kcpustat and resume the accounting on top of the new
> > nice value.
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f12225f..e8f0437 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3868,6 +3868,7 @@ void set_user_nice(struct task_struct *p, long nice)
> >  	int old_prio, delta;
> >  	struct rq_flags rf;
> >  	struct rq *rq;
> > +	long old_nice;
> >  
> >  	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
> >  		return;
> > @@ -3878,6 +3879,8 @@ void set_user_nice(struct task_struct *p, long nice)
> >  	rq = task_rq_lock(p, &rf);
> >  	update_rq_clock(rq);
> >  
> > +	old_nice = task_nice(p);
> > +
> >  	/*
> >  	 * The RT priorities are set via sched_setscheduler(), but we still
> >  	 * allow the 'normal' nice value to be set - but as expected
> > @@ -3913,6 +3916,7 @@ void set_user_nice(struct task_struct *p, long nice)
> >  	if (running)
> >  		set_curr_task(rq, p);
> >  out_unlock:
> > +	vtime_set_nice(rq, p, old_nice);
> >  	task_rq_unlock(rq, p, &rf);
> >  }
> 
> That's not sufficient; I think you want to hook set_load_weight() or
> something. Things like sys_sched_setattr() can also change the nice
> value.

Ah good point, I need to check that.

> 
> >  EXPORT_SYMBOL(set_user_nice);
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 07c2e7f..2b35132 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> 
> > @@ -937,6 +937,33 @@ void vtime_exit_task(struct task_struct *t)
> >  	local_irq_restore(flags);
> >  }
> >  
> > +void vtime_set_nice_local(struct task_struct *t)
> > +{
> > +	struct vtime *vtime = &t->vtime;
> > +
> > +	write_seqcount_begin(&vtime->seqcount);
> > +	if (vtime->state == VTIME_USER)
> > +		vtime_account_user(t, vtime, true);
> > +	else if (vtime->state == VTIME_GUEST)
> > +		vtime_account_guest(t, vtime, true);
> > +	vtime->nice = (task_nice(t) > 0) ? 1 : 0;
> > +	write_seqcount_end(&vtime->seqcount);
> > +}
> > +
> > +static void vtime_set_nice_func(struct irq_work *work)
> > +{
> > +	vtime_set_nice_local(current);
> > +}
> > +
> > +static DEFINE_PER_CPU(struct irq_work, vtime_set_nice_work) = {
> > +	.func = vtime_set_nice_func,
> > +};
> > +
> > +void vtime_set_nice_remote(int cpu)
> > +{
> > +	irq_work_queue_on(&per_cpu(vtime_set_nice_work, cpu), cpu);
> 
> What happens if you already had one pending? Do we loose updates?

No, if irq_work is already pending, it doesn't requeue iff the work hasn't
been executed yet and it's guaranteed it will see the freshest update.
(you should trust more the code you wrote ;-)

> 
> > +}
> > +
> >  u64 task_gtime(struct task_struct *t)
> >  {
> >  	struct vtime *vtime = &t->vtime;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 618577f..c7846ca 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1790,6 +1790,45 @@ static inline int sched_tick_offload_init(void) { return 0; }
> >  static inline void sched_update_tick_dependency(struct rq *rq) { }
> >  #endif
> >  
> > +static inline void vtime_set_nice(struct rq *rq,
> > +				  struct task_struct *p, long old_nice)
> > +{
> > +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
> > +	long nice;
> > +	int cpu;
> > +
> > +	if (!vtime_accounting_enabled())
> > +		return;
> > +
> > +	cpu = cpu_of(rq);
> > +
> > +	if (!vtime_accounting_enabled_cpu(cpu))
> > +		return;
> > +
> > +	/*
> > +	 * Task not running, nice update will be seen by vtime on its
> > +	 * next context switch.
> > +	 */
> > +	if (!task_current(rq, p))
> > +		return;
> > +
> > +	nice = task_nice(p);
> > +
> > +	/* Task stays nice, still accounted as nice in kcpustat */
> > +	if (old_nice > 0 && nice > 0)
> > +		return;
> > +
> > +	/* Task stays rude, still accounted as non-nice in kcpustat */
> > +	if (old_nice <= 0 && nice <= 0)
> > +		return;
> > +
> > +	if (p == current)
> > +		vtime_set_nice_local(p);
> > +	else
> > +		vtime_set_nice_remote(cpu);
> > +#endif
> > +}
> 
> That's _far_ too large for an inline I'm thinking. Also, changing nice
> really isn't a fast path or anything.

Agreed, I'll move that to sched/cputime.c

Thanks.
