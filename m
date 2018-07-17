Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5412ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8510020684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bdq+/tKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8510020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeGQSiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:38:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41500 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbeGQSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:38:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so774017pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2kjvYhcfHU5ri5jurY3UTz/7geCp52c47PKwrE9wDB4=;
        b=bdq+/tKuSzrMKzEBFLfzLq0HTIviHCcam5W4mUEbCvj2I7VW4Vit0DivJtfZtekTGL
         l1TUiVOUVEvAqYQZ2uWveadlfi3q1Iimvp5FXn6OmA6+OvvP50/Gy8fdM4vGfzINwE7K
         itMgBVpEEiS4npnXfE5tAfvhIzod4oHA+hSzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2kjvYhcfHU5ri5jurY3UTz/7geCp52c47PKwrE9wDB4=;
        b=jPUAOaDr6hc94UMFaHad34BNNf0akRrGGq00cJodQpXI4FD9mIzX9Z9SuPbk66zmr4
         F5uR+Btt7mFUTtnqETdLyKFtYk2keWTkBOOs4Wosy/UZJ8rj+Zfa4r3vRuZyQx3DrdaZ
         GFp1egqGanuJu1wlZK27uCyyY1HObEzCGX0yLKUE8a09xXZMkO8eBffViwNeXsydDfMq
         cmpK+s2CbQ3VSNb9ChOXZ0wJfMDNbLuEzL5VKRdr8SMPAbSVAOiT+4a64I5NwSDHdiqN
         Y+cBS08aotJktt4krPcAssmOQK/XviQDZ+CaXdNTbQ7gbwy6piBcFUe9W1uI78HpdPWA
         SjjA==
X-Gm-Message-State: AOUpUlH/BoTdlc5i0BmrSicn6U8CSvRdjbYnkUWovmI0sFt/qA+azYn/
        x/QZSf7h53Q6/l1BIqy8w8xOBg==
X-Google-Smtp-Source: AAOMgpfkynl/mQ7osVQ66OxTdD4FKG7Aun26ZzzOfY07x2T+dpoVFDmORTA1XUEhthJ0bgU4XxsM6w==
X-Received: by 2002:a65:660a:: with SMTP id w10-v6mr2526209pgv.366.1531850675760;
        Tue, 17 Jul 2018 11:04:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id 64-v6sm2935213pfi.89.2018.07.17.11.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 11:04:35 -0700 (PDT)
Date:   Tue, 17 Jul 2018 11:04:34 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH v2 01/12] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180717180434.GB150378@joelaf.mtv.corp.google.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716082906.6061-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:28:55AM +0100, Patrick Bellasi wrote:
> The SCHED_DEADLINE scheduling class provides an advanced and formal
> model to define tasks requirements which can be translated into proper
> decisions for both task placements and frequencies selections.
> Other classes have a more simplified model which is essentially based on
> the relatively simple concept of POSIX priorities.
> 
> Such a simple priority based model however does not allow to exploit
> some of the most advanced features of the Linux scheduler like, for
> example, driving frequencies selection via the schedutil cpufreq
> governor. However, also for non SCHED_DEADLINE tasks, it's still
> interesting to define tasks properties which can be used to better
> support certain scheduler decisions.
> 
> Utilization clamping aims at exposing to user-space a new set of
> per-task attributes which can be used to provide the scheduler with some
> hints about the expected/required utilization for a task.
> This will allow to implement a more advanced per-task frequency control
> mechanism which is not based just on a "passive" measured task
> utilization but on a more "active" approach. For example, it could be
> possible to boost interactive tasks, thus getting better performance, or
> cap background tasks, thus being more energy efficient.
> Ultimately, such a mechanism can be considered similar to the cpufreq's
> powersave, performance and userspace governor but with a much fine
> grained and per-task control.
> 
> Let's introduce a new API to set utilization clamping values for a
> specified task by extending sched_setattr, a syscall which already
> allows to define task specific properties for different scheduling
> classes.
> Specifically, a new pair of attributes allows to specify a minimum and
> maximum utilization which the scheduler should consider for a task.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Paul Turner <pjt@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Steve Muckle <smuckle@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  include/linux/sched.h            | 16 ++++++++
>  include/uapi/linux/sched.h       |  4 +-
>  include/uapi/linux/sched/types.h | 64 +++++++++++++++++++++++++++-----
>  init/Kconfig                     | 19 ++++++++++
>  kernel/sched/core.c              | 39 +++++++++++++++++++
>  5 files changed, 132 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 43731fe51c97..fd8495723088 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -279,6 +279,17 @@ struct vtime {
>  	u64			gtime;
>  };
>  
> +enum uclamp_id {
> +	/* No utilization clamp group assigned */
> +	UCLAMP_NONE = -1,
> +
> +	UCLAMP_MIN = 0, /* Minimum utilization */
> +	UCLAMP_MAX,     /* Maximum utilization */
> +
> +	/* Utilization clamping constraints count */
> +	UCLAMP_CNT
> +};
> +
>  struct sched_info {
>  #ifdef CONFIG_SCHED_INFO
>  	/* Cumulative counters: */
> @@ -649,6 +660,11 @@ struct task_struct {
>  #endif
>  	struct sched_dl_entity		dl;
>  
> +#ifdef CONFIG_UCLAMP_TASK
> +	/* Utlization clamp values for this task */
> +	int				uclamp[UCLAMP_CNT];
> +#endif

Seems a bit wasteful to me. Seems you need 2 values that are in the range
0..1024.  Can we not do better with task_struct space usage?

thanks!

 - Joel

