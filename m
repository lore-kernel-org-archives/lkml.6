Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524043408; cv=none;
        d=google.com; s=arc-20160816;
        b=QqttXxKaDWfH/QnF3iOjHJP+MWHMAQaRydsGZm1WhNxfV9/pAZ5ZVKhQUyVUNIPc3k
         ekSTeFmzbVdDeRZQuaGkr2ezU/6sm+rxP9mpUIFOy+c2jIxOTdHsclmMap9zZX6URmMO
         DHTs+AuhYysXHvKWDTUNV9NuY+7jtGhWHMcoGnY5aRJCbO1m98Rei7Ge3nBOSsdHCFxA
         xBnhQAl1TO7pUdw8dvMaBEPJKD5B5gi3kjs8Dn4tIMzDS/K/0SwpSIx1JHveFKrSs/1K
         mq6oMS8sRTG8MU4ZuFN/+kpzw1OciwEOY8g/1gpNDWAOqujlKtupSxbhF6IDgG5KqHOM
         VbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=awxdJhR98ZM6kxnQU55R+Y1y1SxZ0+JMvUh7dthiwFU=;
        b=ouAGWnwKFNP2kcqKp3v18AMULKETZEhA83irf44gp1bdN31e7DuO4i3jABxT722txj
         DzZHLXN1Hyz1wwIm56fHUBvI3Piw4x7TJAe+uXa3xj5EhPOhUiYpzDsukilzq+ZaPBe7
         2oK4J3nhbcc3qM4b8oH6Ooo/DUdf09+IGntsRbHwQMIwhJ4TGi/h9S3bNb8cf3geoPYI
         j/ZzVyo0holLxo5/P6jCx9AmOkmwvE+gvToJe+jbGJ7sUXT7bgSVTcP6iWXbFruZ1W69
         xaTVXMomsoolP532Onece6ZGwVfTH0hCFYDo+8rkT0YUcDHU4uDTqE7pVu43umk+iR7o
         CsrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ife+0oK2;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ife+0oK2;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49p9H6cVYyS+o16hTICWEJQl/KHy0F5N6nMIlIr/XYyi8S/kehpTMqdtw/cjgsgYzkUAAuIUQ==
Date: Wed, 18 Apr 2018 17:23:16 +0800
From: Leo Yan <leo.yan@linaro.org>
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
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180418092316.GB15682@leoy-ThinkPad-X240s>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-5-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1598075340930793477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:36:05PM +0100, Dietmar Eggemann wrote:

[...]

> +/*
> + * Estimates the system level energy assuming that p wakes-up on dst_cpu.
> + *
> + * compute_energy() is safe to call only if an energy model is available for
> + * the platform, which is when sched_energy_enabled() is true.
> + */
> +static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> +{
> +	unsigned long util, max_util, sum_util;
> +	struct capacity_state *cs;
> +	unsigned long energy = 0;
> +	struct freq_domain *fd;
> +	int cpu;
> +
> +	for_each_freq_domain(fd) {
> +		max_util = sum_util = 0;
> +		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util += cpu_util_dl(cpu_rq(cpu));
> +			max_util = max(util, max_util);
> +			sum_util += util;
> +		}
> +
> +		/*
> +		 * Here we assume that the capacity states of CPUs belonging to
> +		 * the same frequency domains are shared. Hence, we look at the
> +		 * capacity state of the first CPU and re-use it for all.
> +		 */
> +		cpu = cpumask_first(freq_domain_span(fd));
> +		cs = find_cap_state(cpu, max_util);
> +		energy += cs->power * sum_util / cs->cap;

I am a bit worry about the resolution issue, especially when the
capacity value is a quite high value and sum_util is a minor value.

> +	}
> +
> +	return energy;
> +}
