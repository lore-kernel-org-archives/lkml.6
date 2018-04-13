Return-Path: <viresh.kumar@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523592177; cv=none;
        d=google.com; s=arc-20160816;
        b=Mm/tlDHs/ATsYvGi7KmG6TWQUE3nVGhLhpMEvpf3QpkCS2PcNISIJB0Ci7K4xrWvQT
         Cjl367iN3EX/5LQtm6NNuTHjGF0HuPZpm8QveNqbXV88Uy5LNfbKmKzxNdUm9RGVeBWf
         EQ61XDMNxQCZJsfTOKhlARcNXegu552XDjlbCNGsVDZCWjxEbVqvNLnAGjSIofO+AWdP
         Aq7ZLJvvtCCPgjSjyhZYJC3UYp75lphVu3n2IgrI5aps1qQmQ9DU5qVLVHl8ITxYpntM
         itIBXP+j8xW8ICVKDnEHnfb/6TCqU0qDKSAi6tFgLf53AARLZT+DujtKINs7b4uV3mgS
         j2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=9Kew/G/+L5+QjnxV4zrakBWb9+84DEvv+EQR153zxzk=;
        b=qsySIx+dKOAH5xTwqVSRfwJb9DMjaD9iWBAmvIYDh+4u7sQrmKG1h7WKcXt5B1/CLx
         1Zj2gB8HK0a3d7tF4dlhE7xgLJMAJXchUU9BpKfo7gDey1Vq0IY8GWPYXeuYcQRMH2YG
         hV/5+uE3ES6qIRNo9QVKKq5ClndFoTikQoO0nhzAkmcAYsFtPGOa5OmEdEnm1JKq090t
         AyXs/uauJuC8zg1cKaz9XfC4wAAqdOuy4DuA2bGkPJVrDV/W6bDXb+WCr4oNJOnmco45
         7hXjwSqoIMs7sE9X4r/x3D5NQGHIV3IYALs88IdQuhHyb+4jqGK/Zr96Nn4cHvdBIJ15
         IRxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dX6SGO3y;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dX6SGO3y;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/w9ocyh6M4x9uOQaCRAAV+gY+/3O9e9jtGp7hLIPq07EIfl4pwvmwpG33LrxOtdDF3Fnrtqw==
Date: Fri, 13 Apr 2018 09:32:53 +0530
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
Subject: Re: [RFC PATCH v2 2/6] sched: Introduce energy models of CPUs
Message-ID: <20180413040253.GW7671@vireshk-i7>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-3-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011681114649781?=
X-GMAIL-MSGID: =?utf-8?q?1597602191480184852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06-04-18, 16:36, Dietmar Eggemann wrote:
> diff --git a/include/linux/sched/energy.h b/include/linux/sched/energy.h

> +#if defined(CONFIG_SMP) && defined(CONFIG_PM_OPP)
> +extern struct sched_energy_model ** __percpu energy_model;
> +extern struct static_key_false sched_energy_present;
> +extern struct list_head sched_freq_domains;
> +
> +static inline bool sched_energy_enabled(void)
> +{
> +	return static_branch_unlikely(&sched_energy_present);
> +}
> +
> +static inline struct cpumask *freq_domain_span(struct freq_domain *fd)
> +{
> +	return &fd->span;
> +}
> +
> +extern void init_sched_energy(void);
> +
> +#define for_each_freq_domain(fdom) \
> +	list_for_each_entry(fdom, &sched_freq_domains, next)
> +
> +#else
> +struct freq_domain;
> +static inline bool sched_energy_enabled(void) { return false; }
> +static inline struct cpumask
> +*freq_domain_span(struct freq_domain *fd) { return NULL; }
> +static inline void init_sched_energy(void) { }
> +#define for_each_freq_domain(fdom) for (; fdom; fdom = NULL)

I am not sure if this is correct. fdom would normally be a local
uninitialized variable and with above we may end up running the loop
once with an invalid pointer. Maybe rewrite it as:

for (fdom = NULL; fdom; )


And for the whole OPP discussion, perhaps we should have another
architecture specific callback which the scheduler can call to get a
ready-made energy model with all the structures filled in. That way
the OPP specific stuff will move to the architecture specific
callback.

-- 
viresh
