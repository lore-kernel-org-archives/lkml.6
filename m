Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx4/Mg+npo5yMKqy0lUdPp8iIfDmoxPlP+DnVa+7mPblm1xqcUeJt6rOtoxLKmU+bnwGTU5DL
ARC-Seal: i=1; a=rsa-sha256; t=1523364677; cv=none;
        d=google.com; s=arc-20160816;
        b=T+vOgDbHZQFuSJShph6noMJHIl+m2LznNhLQ9w6tQTyN+uaun27fQdslbca0XYQ6zL
         UiN0vZKKOfXhLHl9Yq+P7mOFmb5J4k0b1ktypEBPBagFsRcXPJlfpURJ9w6Uql0Gv92e
         yP8Fn9SDrdRicGdkX/Eg2RPh3eebBNGYLBt/JBmvB8uFsPTuWjPYpyEXBIkPq+54d9Wn
         XQqcWC2h5m3TvEN5XrRZJqEHB36CfuipNbnWobzcMJ+vwu06MOYKKleXJlywZydO4QPt
         n7tq4MpgKB8VurepM4aDWf9GhlHuAaalx21ZTdv2gYOmjP2/0P5ZuAYrWeGgfUkr+pwJ
         2lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=OxWo1IavWEsr0GohNXYjuAYQxL6FF9E3AstdyXvjVRc=;
        b=Y+vXwSuh66VKQEqtChxn95yeDd+08+nl7L/zHk0b7jvC4rvex1WzdQ0dyDC+2m9S3W
         0nNSaS586vMHqPWwLIIZ9KgVS34pjPgLwkWtDW40Q7K0TVNtnCrPC98bTFl29hI30ndv
         IVXM4JRhpYHFSwhFjXERXN6wN1Mi8t6b4RgS3G6YQPalws6tn4XLeNTzytcHyw3HX/3j
         l+fnSUq7CDLegWVSXh5WDyElWO650skGK1vB9zeFpQ+eKoKCdhCkBA3iDLvqRtodpuSq
         Q5fhbo0U7VKGmIM8pjSOQx23yUbZzfHJo/gzt7XM99QNgTRnKSTMsJbeDMdY0akzCVcs
         /ISQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=TPEYXcqi;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=TPEYXcqi;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 10 Apr 2018 14:51:05 +0200
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
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180410125105.GC4043@hirez.programming.kicks-ass.net>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-5-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1597363639480687885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:36:05PM +0100, Dietmar Eggemann wrote:
> +static inline
> +struct capacity_state *find_cap_state(int cpu, unsigned long util)
> +{
> +	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
> +	struct capacity_state *cs = NULL;
> +	int i;
> +
> +	util += util >> 2;
> +
> +	for (i = 0; i < em->nr_cap_states; i++) {
> +		cs = &em->cap_states[i];
> +		if (cs->cap >= util)
> +			break;
> +	}
> +
> +	return cs;
> +}

So in the last thread there was some discussion about this; in
particular on how this related to schedutil and if we should tie it into
that.

I think for starters tying it to schedutil is not a bad idea; ideally
people _should_ migrate towards using that.

Also; I think it makes sense to better integrate cpufreq and the
energy-model values like what rjw already suggested, such that maybe we
can have cpufreq_driver_resolve_freq() return a structure containing the
relevant information for the selected frequency.

But implementing the frequency selection thing in multiple places like
now sounds like a very bad idea to me.
