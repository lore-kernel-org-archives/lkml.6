Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8BAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45350206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45350206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeIFSsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:48:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51804 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeIFSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:48:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so11581860wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 07:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/lJjyLSLShu5S9woPjdJb/KurTvIUtx/3OlEN0Q8Rw=;
        b=Uop5mS/zogcX+xNjvlEqD2gAu4cro25gbaaEEpZAsu63PQZ8+lq5uWIc+2yOSg8X0F
         XevwmEpOo/ZFjm6AFy/W3m32Q5DwA0EgmCD27ajKPozgZhaJB1vM2wFOnsw2HzEw9Cjw
         wqAXDK6715EnNLRYjU5Ee8JzEQOAGnBwIkVbvpdsvvrTKqjFqKk5QNo5wPY4eE81R0Iv
         xRkmfcwL71y5egSPaWFwO9BwwDAXTkGY41m+tkLcQ9EQZRcFmB25/Syo24w0KhHZ1Z6C
         eN7NdeTvZVgcQLM8wn1BXacdQKupR/agvTLtfZQjNSdSTTE1NQvGnozYWZx+buFUdRjm
         /j3Q==
X-Gm-Message-State: APzg51A1jVNqa1pwcZqU3lhLyeAM0Kdnx5umJOFp0Sls+GVaEpwD6b92
        YzUrub5SLWTF9AEhGsVGsFKLWw==
X-Google-Smtp-Source: ANB0Vdbh8erorrJGD6feXYhu8ytsXmq/KQDCp6EHsH2KBc6qCB9vXPjv2pcbtMREPWT2WarCwbEKeQ==
X-Received: by 2002:a1c:bc86:: with SMTP id m128-v6mr2134052wmf.147.1536243186450;
        Thu, 06 Sep 2018 07:13:06 -0700 (PDT)
Received: from localhost.localdomain ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id a203-v6sm3625151wmh.31.2018.09.06.07.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 07:13:05 -0700 (PDT)
Date:   Thu, 6 Sep 2018 16:13:03 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20180906141303.GE27626@localhost.localdomain>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180905104545.GB20267@localhost.localdomain>
 <20180906134846.GB25636@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906134846.GB25636@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/18 14:48, Patrick Bellasi wrote:
> Hi Juri!
> 
> On 05-Sep 12:45, Juri Lelli wrote:
> > Hi,
> > 
> > On 28/08/18 14:53, Patrick Bellasi wrote:
> > 
> > [...]
> > 
> > >  static inline int __setscheduler_uclamp(struct task_struct *p,
> > >  					const struct sched_attr *attr)
> > >  {
> > > -	if (attr->sched_util_min > attr->sched_util_max)
> > > -		return -EINVAL;
> > > -	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
> > > -		return -EINVAL;
> > > +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > > +	int lower_bound, upper_bound;
> > > +	struct uclamp_se *uc_se;
> > > +	int result = 0;
> > >  
> > > -	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> > > -	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> > > +	mutex_lock(&uclamp_mutex);
> > 
> > This is going to get called from an rcu_read_lock() section, which is a
> > no-go for using mutexes:
> > 
> >  sys_sched_setattr ->
> >    rcu_read_lock()
> >    ...
> >    sched_setattr() ->
> >      __sched_setscheduler() ->
> >        ...
> >        __setscheduler_uclamp() ->
> >          ...
> > 	 mutex_lock()
> 
> Rightm, great catch, thanks!
> 
> > Guess you could fix the issue by getting the task struct after find_
> > process_by_pid() in sys_sched_attr() and then calling sched_setattr()
> > after rcu_read_lock() (putting the task struct at the end). Peter
> > actually suggested this mod to solve a different issue.
> 
> I guess you mean something like this ?
> 
> ---8<---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5792,10 +5792,15 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
>         rcu_read_lock();
>         retval = -ESRCH;
>         p = find_process_by_pid(pid);
> -       if (p != NULL)
> -               retval = sched_setattr(p, &attr);
> +       if (likely(p))
> +               get_task_struct(p);
>         rcu_read_unlock();
>  
> +       if (likely(p)) {
> +               retval = sched_setattr(p, &attr);
> +               put_task_struct(p);
> +       }
> +
>         return retval;
>  }
> ---8<---

This should do the job yes.
