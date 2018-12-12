Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FC8C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEABE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEABE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeLLRtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:49:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeLLRtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:49:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85004A4058;
        Wed, 12 Dec 2018 17:49:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
        by smtp.corp.redhat.com (Postfix) with SMTP id B19F75D73F;
        Wed, 12 Dec 2018 17:49:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 12 Dec 2018 18:49:05 +0100 (CET)
Date:   Wed, 12 Dec 2018 18:49:02 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 4/7] cgroup: cgroup v2 freezer
Message-ID: <20181212174902.GA30309@redhat.com>
References: <20181207201531.1665-1-guro@fb.com>
 <20181207201531.1665-5-guro@fb.com>
 <20181211162632.GB8504@redhat.com>
 <20181211184033.GA8971@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211184033.GA8971@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 12 Dec 2018 17:49:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11, Roman Gushchin wrote:
>
> On Tue, Dec 11, 2018 at 05:26:32PM +0100, Oleg Nesterov wrote:
> > On 12/07, Roman Gushchin wrote:
> > >
> > > Cgroup v2 freezer tries to put tasks into a state similar to jobctl
> > > stop. This means that tasks can be killed, ptraced (using
> > > PTRACE_SEIZE*), and interrupted. It is possible to attach to
> > > a frozen task, get some information (e.g. read registers) and detach.
> >
> > I fail to understand how this all supposed to work.
> >
> > > @@ -368,6 +369,8 @@ static inline int signal_pending_state(long state, struct task_struct *p)
> > >  		return 0;
> > >  	if (!signal_pending(p))
> > >  		return 0;
> > > +	if (unlikely(cgroup_task_frozen(p) && p->jobctl == JOBCTL_TRAP_FREEZE))
> > > +		return __fatal_signal_pending(p);
> >
> > I think I will never agree with this change ;) and I don't think it actually helps.
>
> See below.
>
> >
> > > +void cgroup_enter_frozen(void)
> > > +{
> > > +	if (!current->frozen) {
> > > +		spin_lock_irq(&css_set_lock);
> > > +		current->frozen = true;
> > > +		cgroup_inc_frozen_cnt(task_dfl_cgroup(current), false, true);
> > > +		spin_unlock_irq(&css_set_lock);
> > > +	}
> > > +
> > > +	__set_current_state(TASK_INTERRUPTIBLE);
> > > +	schedule();
> >
> > So once again, suppose it races with PTRACE_INTERRUPT, or SIGSTOP, or something
> > else which should be handled by get_signal() before do_freezer_trap().
> >
> > If (say) PTRACE_INTERRUPT comes before schedule it will be lost. Otherwise
> > the frozen task will react. This can't be right. Or I am totally confused.
>
> Why?
> PTRACE_INTERRUPT will set JOBCTL_TRAP_STOP, so signal_pending_state()
> will return true, schedule() will return immediately, and we'll handle the trap.

OK, I misread the JOBCTL_TRAP_FREEZE check as "jobctl & JOBCTL_TRAP_FREEZE".

But p->jobctl == JOBCTL_TRAP_FREEZE doesn't look right too. For example,
JOBCTL_STOP_DEQUEUED can be set. You probably need something like

	jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE) == JOBCTL_TRAP_FREEZE

And you need a barrier in between, iow you need set_current_state(TASK_INTERRUPTIBLE).

But this doesn't really matter. I don't think you need to modify signal_pending_state()
and penalize schedule(). You can do something like

	spin_lock_irq(sigllock);
	if (jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE) == JOBCTL_TRAP_FREEZE &&
	    !__fatal_signal_pending())
	{
		__set_current_state(TASK_INTERRUPTIBLE);
		clear_thread_flag(TIF_SIGPENDING);
	}
	spin_unlock_irq(siglock);

	schedule();
	// recalc_sigpending() is not needed

in cgroup_enter_frozen() with the same effect. Which looks equally ugly and
suboptimal, but at least this doesn't touch the sched code.

> > and btw.... what about suspend? try_to_freeze_tasks() will obviously fail
> > if there is a ->frozen thread?
>
> I have to think a bit more here, but something like this will probably work:
>
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index b162b74611e4..590ac4d10b02 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -134,7 +134,7 @@ bool freeze_task(struct task_struct *p)
>                 return false;
>
>         spin_lock_irqsave(&freezer_lock, flags);
> -       if (!freezing(p) || frozen(p)) {
> +       if (!freezing(p) || frozen(p) || cgroup_task_frozen()) {
>                 spin_unlock_irqrestore(&freezer_lock, flags);
>                 return false;
>         }
>
> --
>
> If the task is already frozen by the cgroup freezer, we don't have to do
> anything additionally.

I don't think so. A cgroup_task_frozen() task can be killed after
try_to_freeze_tasks() succeeds, and the exiting task can close files,
do IO, etc. Or it can be thawed by cgroup_freeze_task(false).

In short, if try_to_freeze_tasks() succeeds, the caller has all rights
to assume that nobody can escape from __refrigerator().


And what about TASK_STOPPED/TASK_TRACED tasks? They can not be frozen
or thawed, right? This doesn't look good, and this differs from the
current freezer controller...

Oleg.

