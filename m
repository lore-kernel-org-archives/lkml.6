Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8680BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B0C20658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B0C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIEPPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:15:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53183 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIEPPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:15:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so7408717wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 03:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tOd4GvYrnhdUj6fEO4RnJiJRvggt3OirbLP9E2UErwc=;
        b=OcD2wDAVZzX6JQHy3P0++bl7AO+jMF9OzA+nt254YiQaFoMQx8PcMsL/33DUQEqD2Q
         Drt7jG9EgDC4jg+CPWggEssoj00IXBT6cyU91V0ChAT7KKos6mHSCnz6vGgTPGA0tBhf
         2p9Y45oeoHg8KPvRQFvL4MoXAADXdnvbTCjVi1rKFnPh7Z0ROk0Yc8gaAIIQj1rSmJRC
         x6H1HHizmBDp/AbXSm1kaqzh7JmAu0NDnWQiSKfDiNkoqfTQxX8T8YJIpR3yfncn31N7
         nN+4Clc+yoQgliirkw6xVZDddQa1ovwIQZfI/Qr7qzdoS49zxagnZsZAOmyNjXfvLZli
         c71g==
X-Gm-Message-State: APzg51AzE1Ydaons78xwZhkUWsl4t3x1+CdA95turKnrXywa4g8vFWzW
        /QhykNMa9kowo6KpHOwdgRM16Q==
X-Google-Smtp-Source: ANB0VdZ9ufvWerfiWLipMcVLQEp6A27VV0UGBehGY2HuAH6ff9NSj2lR4ecJTcM47t2jsSlez63WBQ==
X-Received: by 2002:a1c:3906:: with SMTP id g6-v6mr9157wma.50.1536144350492;
        Wed, 05 Sep 2018 03:45:50 -0700 (PDT)
Received: from localhost.localdomain ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id 127-v6sm1635959wmb.30.2018.09.05.03.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 03:45:48 -0700 (PDT)
Date:   Wed, 5 Sep 2018 12:45:45 +0200
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
Message-ID: <20180905104545.GB20267@localhost.localdomain>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/08/18 14:53, Patrick Bellasi wrote:

[...]

>  static inline int __setscheduler_uclamp(struct task_struct *p,
>  					const struct sched_attr *attr)
>  {
> -	if (attr->sched_util_min > attr->sched_util_max)
> -		return -EINVAL;
> -	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
> -		return -EINVAL;
> +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> +	int lower_bound, upper_bound;
> +	struct uclamp_se *uc_se;
> +	int result = 0;
>  
> -	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> -	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> +	mutex_lock(&uclamp_mutex);

This is going to get called from an rcu_read_lock() section, which is a
no-go for using mutexes:

 sys_sched_setattr ->
   rcu_read_lock()
   ...
   sched_setattr() ->
     __sched_setscheduler() ->
       ...
       __setscheduler_uclamp() ->
         ...
	 mutex_lock()

Guess you could fix the issue by getting the task struct after find_
process_by_pid() in sys_sched_attr() and then calling sched_setattr()
after rcu_read_lock() (putting the task struct at the end). Peter
actually suggested this mod to solve a different issue.

Best,

- Juri
