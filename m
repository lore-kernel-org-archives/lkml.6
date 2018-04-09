Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx49OHk1vM9gSDcBicb0/o5h4p5rOsqWsUd/Ws8BAQNKF36684rnbivczDnd7v4XCWym6LAM6
ARC-Seal: i=1; a=rsa-sha256; t=1523266810; cv=none;
        d=google.com; s=arc-20160816;
        b=pjxp0DkKEn53nWdh1HIgaEDfPg+RkbZgz+P8yI7Z9LuXNKs/RcZROTvc6WVgyKUSly
         BnBs9GTM14DX+jRkbahAMpBJt7qviifZDrpFFvdtsZP3oSwXxJ13ItDu2wnBOZPquOkf
         zEkOgfdx8tRLq/MZawzwyhy1gx9QUD6GcfUPEnVZ1Q5mHO4YXTEUlBNxwRaEQc62P0Ju
         XE4X4A1q+EF9fJVahUnhnXfxcT/ck7kcY4eX/wgL+H5YPTY0sJQ0re/eXw8saiZ8vbc7
         zeLkbqhwy51Vn4ybZ/eUUdxV6ze7krrpIzkbctO9vXt1tbmHEvX/WW2uf33pDgMXHr+Y
         U9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=s6O388VxLcL/++C0fw5Hah0Hp2lKq1/DP6wK8lNFC50=;
        b=Og0xdlr6nWpxSJhNZPneoTmuTIxXSo/i9hcwEzOtmqz5dG6Ptdjk0SoJBPjTpxHGLM
         br6gaxCbaTjFISd0iE22np+wSTwDA+N6zjfITofNonwUworrjMfT1MW+VGBGpqGrIZ5x
         QPx80mw//9dNvhebdCwYlOAvmimDXVScvU8yhcupsW3QQmSZLTRtMa2e7y/4Ho3HRQm+
         CiUOdxslhTwMLxCPVMof708rA6ZqkZmUXWUL6JrCsY9+K5+XGP7shR9h/mSY7aHsBe7I
         oEZocqOLo7SVJTu9JsIcRpMALMB0XqBp0ZvgW4uL7xSHsvh0qtj0/MjXYu10vowouoQl
         RM9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=j1XL3ihf;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=j1XL3ihf;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 9 Apr 2018 11:40:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
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
Subject: Re: [RFC PATCH 3/6] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180409094001.GZ4043@hirez.programming.kicks-ass.net>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320094312.24081-4-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449336588138126?=
X-GMAIL-MSGID: =?utf-8?q?1597261019009990863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


(I know there is a new version out; but I was reading through this to
catch up with the discussion)

On Tue, Mar 20, 2018 at 09:43:09AM +0000, Dietmar Eggemann wrote:
> +static inline int sd_overutilized(struct sched_domain *sd)
> +{
> +	return READ_ONCE(sd->shared->overutilized);
> +}
> +
> +static inline void update_overutilized_status(struct rq *rq)
> +{
> +	struct sched_domain *sd;
> +
> +	rcu_read_lock();
> +	sd = rcu_dereference(rq->sd);
> +	if (sd && !sd_overutilized(sd) && cpu_overutilized(rq->cpu))
> +		WRITE_ONCE(sd->shared->overutilized, 1);
> +	rcu_read_unlock();
> +}
> +#else

I think you ought to go have a look at the end of
kernel/sched/topology.c:sd_init(), where it says:

	/*
	 * For all levels sharing cache; connect a sched_domain_shared
	 * instance.
	 */
	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
		atomic_inc(&sd->shared->ref);
		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
	}

Because if I read all this correctly, your code assumes sd->shared
exists unconditionally, while the quoted bit only ensures it does so <=
LLC.
