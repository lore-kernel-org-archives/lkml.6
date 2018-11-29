Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF40AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9969B2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9969B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeK2SJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:09:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32946 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeK2SJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:09:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so721949wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 23:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VC4OQueP/Y5G4+DbcsKb4W0KnI4r7GJ6guny11nOFqg=;
        b=QuFp5glmxBTS6nwCYblMtVVZruqLgYWNoSiJstEx9Bk1lTE3xRWCgtKqlfNpKgh3vx
         bktdW6WinsrMFijDen1BPd0NeOhEwIzvI+f9yzm7dFkioJQ7ElFCtldAfu9ZFIxT5z97
         iDyfCaLAWKoR18iA7uEDGRHm8+NpmGk84Ui3TleQNTdHEFTmMwx5STU/s7SpCMNUfU02
         mTNuXmkC4STtEh4m/6uI9ru9sOFTGiih6SVPYCj1RPMiiL47oMubnSEy4mkYRI4ZVIgY
         HngWHGgrzgFffiRwHnWgJEqAMvvZvxS5ONHG0lxn8lNw34+JCA59hHIDYlRQW8a+JLkG
         ly7g==
X-Gm-Message-State: AA+aEWa19HsVbYTjKCA/bMWvzGOdyrBLhLGWjfzksv4YfDKytI2EN5MM
        4GTvRsTilk/x2K+nW5KldAgo58W6sys=
X-Google-Smtp-Source: AFSGD/X1CXtWezLX7e0JlPb3OKQPldh7jQFmSM4pTsIYjYgrw0Zi6oov9DYbzBNWth6wGUnpo9aZ4Q==
X-Received: by 2002:adf:94e4:: with SMTP id 91mr306775wrr.322.1543475080533;
        Wed, 28 Nov 2018 23:04:40 -0800 (PST)
Received: from localhost.localdomain ([151.15.226.84])
        by smtp.gmail.com with ESMTPSA id y34sm2444983wrd.68.2018.11.28.23.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 23:04:39 -0800 (PST)
Date:   Thu, 29 Nov 2018 08:04:37 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH V5 1/2] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
Message-ID: <20181129070437.GD4271@localhost.localdomain>
References: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
 <20181128114454.GC4271@localhost.localdomain>
 <17ecb59a-7647-ce56-0715-bfe8d520dd18@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ecb59a-7647-ce56-0715-bfe8d520dd18@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/18 18:54, Daniel Lezcano wrote:
> On 28/11/2018 12:44, Juri Lelli wrote:
> > Hi Daniel,
> > 
> > On 27/11/18 14:24, Daniel Lezcano wrote:
> >> The mutex protects a per_cpu variable access. The potential race can
> >> happen only when the cpufreq governor module is loaded and at the same
> >> time the cpu capacity is changed in the sysfs.
> >>
> >> There is no real interest of using a mutex to protect a variable
> >> assignation when there is no situation where a task can take the lock
> >> and block.
> >>
> >> Replace the mutex by READ_ONCE / WRITE_ONCE.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> ---
> >>  drivers/base/arch_topology.c  | 7 +------
> >>  include/linux/arch_topology.h | 2 +-
> >>  2 files changed, 2 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> >> index edfcf8d..fd5325b 100644
> >> --- a/drivers/base/arch_topology.c
> >> +++ b/drivers/base/arch_topology.c
> >> @@ -31,12 +31,11 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> >>  		per_cpu(freq_scale, i) = scale;
> >>  }
> >>  
> >> -static DEFINE_MUTEX(cpu_scale_mutex);
> >>  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> >>  
> >>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
> >>  {
> >> -	per_cpu(cpu_scale, cpu) = capacity;
> >> +	WRITE_ONCE(per_cpu(cpu_scale, cpu), capacity);
> >>  }
> >>  
> >>  static ssize_t cpu_capacity_show(struct device *dev,
> >> @@ -71,10 +70,8 @@ static ssize_t cpu_capacity_store(struct device *dev,
> >>  	if (new_capacity > SCHED_CAPACITY_SCALE)
> >>  		return -EINVAL;
> >>  
> >> -	mutex_lock(&cpu_scale_mutex);
> >>  	for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
> >>  		topology_set_cpu_scale(i, new_capacity);
> >> -	mutex_unlock(&cpu_scale_mutex);
> > 
> > IIRC this was meant to ensure atomic updates of all siblings with the new
> > capacity value. I actually now wonder if readers should not grab the
> > mutex as well (cpu_capacity_show()). Can't we get into a situation where
> > a reader might see siblings with intermediate values (while the loop
> > above is performing an update)?
> 
> With or without this patch, it is the case:
> 
>                 task1                      task2
>                   |                          |
>   read("/sys/.../cpu1/cpu_capacity)          |
>                   |                  write("/sys/.../cpu1/cpu_capacity")
>   read("/sys/.../cpu2/cpu_capacity)          |
> 
> 
> There is no guarantee userspace can have a consistent view of the
> capacity. As soon as it reads a capacity, it can be changed in its back.

True, but w/o the mutex task1 could read different cpu_capacity values
for a cluster (it actually can also with current implementation, we
should grab the mutex in the read path as well if we want to avoid
this). Just pointing this out, not sure it is a problem, though, as even
the notion of strictly equal capacities clusters is going to disappear
AFAIK.
