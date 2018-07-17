Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C246120684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HZ3YAMQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C246120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbeGQSYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:24:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44513 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbeGQSYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:24:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id k21-v6so861987pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tvt9ppZG2rZlQez9Ne/c9S/PBwF6s+W0FzZLh36ksyU=;
        b=HZ3YAMQDKtJmM77YmqJr+ZhDaJ7aZ7elIgq3eih1pz7n2+nu3J7pH7qO0kzz9TFjrb
         52gUuccMt8bLyJIqFSJ15DhNb0djPZJ8kwoJGVAVePxNVEUthkr1LcC+0T6sJZ4HquWE
         1zq9gutOTc2ALQR0lWQB8uOYpHfs6ulPC0Gys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tvt9ppZG2rZlQez9Ne/c9S/PBwF6s+W0FzZLh36ksyU=;
        b=GRLA43bPWrDx/3WWufKAWwIUlAF7r4EsQEe2BMRFOgIJOzLMc7XKwsT5bupyUX2Vu6
         HdK/zy4kFJmpqvtKWIRYd0M+sQckyWzGCJ1DJ6FLEB63W+P3QH6PyEsmm9jm/P/KyQR2
         3xUl86PVtz5gkQ2z+ZhMWvuHPaLk8UvjUPpkZC6Bp+DfJsqd45daxDg1+l86lF/ZOuKD
         Hvv8dKp/4IjgN809iiPBJ0GtvaWGeW2AcxZdS73swm3YMyBYUblhiyPQAlCrHNfZFq28
         cGxJSk+sN4pDqnWrD0bw6MXzldlgH/2rfy2jKIWUOqZdAk8KNNnmVMqj9VRcjEDRLw3M
         TO1w==
X-Gm-Message-State: AOUpUlG6wpPcCaRZSoaAjfEKUxvMkHHQ/yIyY6KjnAQ75UYk/W1e+QNM
        Tz5au4qsH4rp6yrD0WfPacZQk1Sub1E=
X-Google-Smtp-Source: AAOMgpc1fBz07UK+kC4BN3z8X3ibFXfYE4b7SboEjyA33DROsQTEBms7kChbxBlYGg3OkjUBSfvQ7Q==
X-Received: by 2002:a63:b213:: with SMTP id x19-v6mr2499752pge.393.1531849826052;
        Tue, 17 Jul 2018 10:50:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id g23-v6sm2133401pgv.26.2018.07.17.10.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 10:50:25 -0700 (PDT)
Date:   Tue, 17 Jul 2018 10:50:25 -0700
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
Message-ID: <20180717175025.GA150378@joelaf.mtv.corp.google.com>
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
> +
>  #ifdef CONFIG_PREEMPT_NOTIFIERS
>  	/* List of struct preempt_notifier: */
>  	struct hlist_head		preempt_notifiers;
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 22627f80063e..c27d6e81517b 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -50,9 +50,11 @@
>  #define SCHED_FLAG_RESET_ON_FORK	0x01
>  #define SCHED_FLAG_RECLAIM		0x02
>  #define SCHED_FLAG_DL_OVERRUN		0x04
> +#define SCHED_FLAG_UTIL_CLAMP		0x08
>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>  			 SCHED_FLAG_RECLAIM		| \
> -			 SCHED_FLAG_DL_OVERRUN)
> +			 SCHED_FLAG_DL_OVERRUN		| \
> +			 SCHED_FLAG_UTIL_CLAMP)
>  
>  #endif /* _UAPI_LINUX_SCHED_H */
> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
> index 10fbb8031930..7421cd25354d 100644
> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h
> @@ -21,8 +21,33 @@ struct sched_param {
>   * the tasks may be useful for a wide variety of application fields, e.g.,
>   * multimedia, streaming, automation and control, and many others.
>   *
> - * This variant (sched_attr) is meant at describing a so-called
> - * sporadic time-constrained task. In such model a task is specified by:
> + * This variant (sched_attr) allows to define additional attributes to
> + * improve the scheduler knowledge about task requirements.
> + *
> + * Scheduling Class Attributes
> + * ===========================
> + *
> + * A subset of sched_attr attributes specifies the
> + * scheduling policy and relative POSIX attributes:
> + *
> + *  @size		size of the structure, for fwd/bwd compat.
> + *
> + *  @sched_policy	task's scheduling policy
> + *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
> + *  @sched_priority	task's static priority (SCHED_FIFO/RR)
> + *
> + * Certain more advanced scheduling features can be controlled by a
> + * predefined set of flags via the attribute:
> + *
> + *  @sched_flags	for customizing the scheduler behaviour
> + *
> + * Sporadic Time-Constrained Tasks Attributes
> + * ==========================================
> + *
> + * A subset of sched_attr attributes allows to describe a so-called
> + * sporadic time-constrained task.
> + *
> + * In such model a task is specified by:
>   *  - the activation period or minimum instance inter-arrival time;
>   *  - the maximum (or average, depending on the actual scheduling
>   *    discipline) computation time of all instances, a.k.a. runtime;
> @@ -34,14 +59,8 @@ struct sched_param {
>   * than the runtime and must be completed by time instant t equal to
>   * the instance activation time + the deadline.
>   *
> - * This is reflected by the actual fields of the sched_attr structure:
> + * This is reflected by the following fields of the sched_attr structure:
>   *
> - *  @size		size of the structure, for fwd/bwd compat.
> - *
> - *  @sched_policy	task's scheduling policy
> - *  @sched_flags	for customizing the scheduler behaviour
> - *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
> - *  @sched_priority	task's static priority (SCHED_FIFO/RR)
>   *  @sched_deadline	representative of the task's deadline
>   *  @sched_runtime	representative of the task's runtime
>   *  @sched_period	representative of the task's period
> @@ -53,6 +72,28 @@ struct sched_param {
>   * As of now, the SCHED_DEADLINE policy (sched_dl scheduling class) is the
>   * only user of this new interface. More information about the algorithm
>   * available in the scheduling class file or in Documentation/.
> + *
> + * Task Utilization Attributes
> + * ===========================
> + *
> + * A subset of sched_attr attributes allows to specify the utilization which
> + * should be expected by a task. These attributes allows to inform the
> + * scheduler about the utilization boundaries within which is safe to schedule
> + * the task. These utilization boundaries are valuable information to support
> + * scheduler decisions on both task placement and frequencies selection.
> + *
> + *  @sched_util_min	represents the minimum utilization
> + *  @sched_util_max	represents the maximum utilization
> + *
> + * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE] which
> + * represents the percentage of CPU time used by a task when running at the
> + * maximum frequency on the highest capacity CPU of the system. Thus, for
> + * example, a 20% utilization task is a task running for 2ms every 10ms.
> + *
> + * A task with a min utilization value bigger then 0 is more likely to be
> + * scheduled on a CPU which can provide that bandwidth.
> + * A task with a max utilization value smaller then 1024 is more likely to be
> + * scheduled on a CPU which do not provide more then the required bandwidth.
>   */
>  struct sched_attr {
>  	__u32 size;
> @@ -70,6 +111,11 @@ struct sched_attr {
>  	__u64 sched_runtime;
>  	__u64 sched_deadline;
>  	__u64 sched_period;
> +
> +	/* Utilization hints */
> +	__u32 sched_util_min;
> +	__u32 sched_util_max;
> +
>  };
>  
>  #endif /* _UAPI_LINUX_SCHED_TYPES_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 041f3a022122..1d45a6877d6f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -583,6 +583,25 @@ config HAVE_UNSTABLE_SCHED_CLOCK
>  config GENERIC_SCHED_CLOCK
>  	bool
>  
> +menu "Scheduler features"
> +
> +config UCLAMP_TASK
> +	bool "Enable utilization clamping for RT/FAIR tasks"
> +	depends on CPU_FREQ_GOV_SCHEDUTIL

Does it make sense to depend on this? One could turn off schedutil and then
uclamp can't be used for any other purpose (big.LITTLE task placement etc)?

thanks,

- Joel

