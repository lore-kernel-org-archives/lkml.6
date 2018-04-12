Return-Path: <viresh.kumar@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523516554; cv=none;
        d=google.com; s=arc-20160816;
        b=KwwULB1WxfIGNSnZkU7slZeePBMF+CKM21Ziu/QX9MAGVm+0PpdzUBe1BTDmHJsfv5
         wJAoWre7C2ahXw/0L3hahOq0EjbyJdqZh4Nx4E8d9bTLstPSr1z18bDt4bMFCTlL7gp0
         Q1ITjHB9HCai2vf1+57M6TtTPqcHGihjgpxXD4KjOmK08AJzAablIBl4zawFfNiM8xTT
         g7jkpTiLtLE/saRKo998Ze5LOFfYY78LPNT0RLJkq5mWsHV9PbrPkRLe8e7VzHrZsTeK
         6nsVmNVkjnRzxaEJlA2MM5ppXB9ztFOrJEnwUgsJU5xIGsLPqgBrpsoq9Uu/AaKT3N/o
         A7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Z/ZBE/6tKSk+2eBVs5Its+JcXKLbHBvstLYmzWKMl6U=;
        b=JEjfptZVvxHczgXVtkFDoDH33udcPH2aeHfg5PyCBliF4hToyqK0gm+cgBFiZWQA14
         46aAsD5hWpbFpU4R4hWhZiw7S2wtCxi3Fu5vVjDerF9H6JG4Q0lrjMu1NmHuLfUGeN/u
         KbiRhksYFmJR7ceNoJjNpz+pUFAhBLzruXBRZzONiBqlCo7TmbjBGHLRp/B2ANBQsSLT
         OrkXWluYwr+MFy2bk25W23jL3FXCzO9ZOwB6ZVFIJcXF+223V3Kqk7NuQa8ShmMQbl/O
         l+hWxiRvVkEMzRBVfVrNfGKO+WxXNs879euBGCY3yvYuw+lIBljKtbBQ3C4M7OlIfaMZ
         9+rg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Eh8VKYVa;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Eh8VKYVa;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/AhX8ZvXfIJ8vlYYPmiQYCynxvbl+0VX+WsCB26myuAKwYkFoqE+gaqTnPuSLg+1Hr/NNFOQ==
Date: Thu, 12 Apr 2018 12:32:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
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
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 1/6] sched/fair: Create util_fits_capacity()
Message-ID: <20180412070230.GV7671@vireshk-i7>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-2-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011678153302942?=
X-GMAIL-MSGID: =?utf-8?q?1597522894107911668?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06-04-18, 16:36, Dietmar Eggemann wrote:
> The functionality that a given utilization fits into a given capacity
> is factored out into a separate function.
> 
> Currently it is only used in wake_cap() but will be re-used to figure
> out if a cpu or a scheduler group is over-utilized.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0951d1c58d2f..0a76ad2ef022 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6574,6 +6574,11 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
>  	return min_t(unsigned long, util, capacity_orig_of(cpu));
>  }
>  
> +static inline int util_fits_capacity(unsigned long util, unsigned long capacity)
> +{
> +	return capacity * 1024 > util * capacity_margin;

This changes the behavior slightly compared to existing code. If that
wasn't intentional, perhaps you should use >= here.

> +}
> +
>  /*
>   * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
>   * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
> @@ -6595,7 +6600,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
>  	/* Bring task utilization in sync with prev_cpu */
>  	sync_entity_load_avg(&p->se);
>  
> -	return min_cap * 1024 < task_util(p) * capacity_margin;
> +	return !util_fits_capacity(task_util(p), min_cap);
>  }
>  
>  /*
> -- 
> 2.11.0

-- 
viresh
