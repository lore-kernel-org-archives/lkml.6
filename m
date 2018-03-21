Return-Path: <juri.lelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521623075; cv=none;
        d=google.com; s=arc-20160816;
        b=zvt9SkrhMtYTMhczIY1PblCL/EkfOpdLQPCW4dnOo6xWyPF001j0y3u1BSFSCgO73O
         xCkgp7URWnbJ8ApHCjV8hUyW6rLyPgU8xQdzs/NeDpR4j1mRqCiHlIOhzkeuGlWGtkeJ
         IG6zEybv5e7yFrAE/sfmn4rYrzA9Y5RfWHHbaaoeH1ynklEmQ8bVlvfkSVYwE/alj41O
         WUuixOW5Rwikevj2FRP83IU5rZwA3YaOnhi4rLb1+D2CFnxtz/DmvtZ1QUYub3jGF6+V
         2w4Ghbh7Z1e2uNzBtLaBPzr/mxnEG4ANTd82r7IebnQB9QHY6vO/rquYKEjcwpEt8Alb
         iJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=yAlxNNXdaEbV2qnnJSgN6cLkcsUSiZ15OTd38v53xSg=;
        b=XNJtLCOFChXtpYta+X3+HB0Nrgr7bpnmLXE4FVMNeXFzHpqY2q3p3YQC2ookMwWFM+
         EFJB7QieFL8qCwuCmF8mvlG+kRQTENMEkINmJTFd+zlYQWyezDqYmamaiercWmkQsyXr
         dY3pt4O//J8m78ujlxqw/WL3u/mb3n2MpbRNTA3idqZPGQD5mJu0J+LggEMwBXWG0xF9
         1eljR5Ad5/VoJUai0ikmmE5KABaI4rVTovnOlNpuxlTI0c8px9TfdcOF5fKo4OVfkgVL
         ftjBHjvSfDPnRnKVDaIz2KvKz5eZPjHV3zQ1WMg+xqs1ELqugIoAQRTIrTecqQDPDxds
         U9iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vI4OJxSd;
       spf=pass (google.com: domain of juri.lelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vI4OJxSd;
       spf=pass (google.com: domain of juri.lelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuNQdOTHjHkTL7iLoyzotlq9tZ1MT4kqCOxnSvAsy0Tq6niLQWSL37kXobJ8ACcyeOc/Mo93w==
Date: Wed, 21 Mar 2018 10:04:30 +0100
From: Juri Lelli <juri.lelli@gmail.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180321090430.GA6913@localhost.localdomain>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320094312.24081-5-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595537437597869344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 20/03/18 09:43, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>
> 
> In preparation for the definition of an energy-aware wakeup path, a
> helper function is provided to estimate the consequence on system energy
> when a specific task wakes-up on a specific CPU. compute_energy()
> estimates the OPPs to be reached by all frequency domains and estimates
> the consumption of each online CPU according to its energy model and its
> percentage of busy time.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6c72a5e7b1b0..76bd46502486 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6409,6 +6409,30 @@ static inline int cpu_overutilized(int cpu)
>  }
>  
>  /*
> + * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
> + */
> +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> +{
> +	unsigned long util = cpu_rq(cpu)->cfs.avg.util_avg;

What about other classes? Shouldn't we now also take into account
DEADLINE (as schedutil does)?

BTW, we now also have a getter method in sched/sched.h; it takes
UTIL_EST into account, though. Do we need to take that into account when
estimating energy consumption?

> +	unsigned long capacity = capacity_orig_of(cpu);
> +
> +	/*
> +	 * If p is where it should be, or if it has no impact on cpu, there is
> +	 * not much to do.
> +	 */
> +	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
> +		goto clamp_util;
> +
> +	if (dst_cpu == cpu)
> +		util += task_util(p);
> +	else
> +		util = max_t(long, util - task_util(p), 0);
> +
> +clamp_util:
> +	return (util >= capacity) ? capacity : util;
> +}
> +
> +/*
>   * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
>   * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
>   *
> @@ -6432,6 +6456,63 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
>  	return !util_fits_capacity(task_util(p), min_cap);
>  }
>  
> +static struct capacity_state *find_cap_state(int cpu, unsigned long util)
> +{
> +	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
> +	struct capacity_state *cs = NULL;
> +	int i;
> +
> +	/*
> +	 * As the goal is to estimate the OPP reached for a specific util
> +	 * value, mimic the behaviour of schedutil with a 1.25 coefficient
> +	 */
> +	util += util >> 2;

What about other governors (ondemand for example). Is this supposed to
work only when schedutil is in use (if so we should probably make it
conditional on that)?

Also, even when schedutil is in use, shouldn't we ask it for a util
"computation" instead of replicating its _current_ heuristic? I fear
the two might diverge in the future.

Best,

- Juri
