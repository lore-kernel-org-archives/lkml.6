Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBE0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C18520684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o/TtZkm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfAVN46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:56:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60388 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfAVN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/yGAsqBQmq+378K3Ed7uGS+TjYfgRXBZD5L47WVukvY=; b=o/TtZkm3dr+ThaWKQ2MKXniZ/
        KJnSsK4snnd1r5dUNjTBoIfIVlMuzlf6usPlCCvKilz0MWzPbVl7HVTvVwOZYWVYKw10ZOkKV3xwg
        4B9XUg01CPPipJjK/Ah8865TK+YRWW9Lq8gqDSIcSehz+hyX1m/Z/MfeadkABp7U7HRc/hBgsV+qO
        cDsEuEAUfvgidb3eEnTvPysOVKXRkOahpl85BDIMyARJjgJeIbBVkFr0ljJJ+tsZLNlaCazNvbB7U
        99/qGuySnvTGb+NgkYRrbFY4D805uhjBVgimNJz4YStRDqqCjKOtwG0qEKiabgxAk7vs0ISKq0gyO
        xHV4FrFNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glwXm-00024M-Td; Tue, 22 Jan 2019 13:56:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B5462042CFC2; Tue, 22 Jan 2019 14:56:44 +0100 (CET)
Date:   Tue, 22 Jan 2019 14:56:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 07/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190122135644.GP27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-8-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-8-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:04AM +0000, Patrick Bellasi wrote:

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 84294925d006..c8f391d1cdc5 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -625,6 +625,11 @@ struct uclamp_se {
>  	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
>  	unsigned int mapped		: 1;
>  	unsigned int active		: 1;
> +	/* Clamp bucket and value actually used by a RUNNABLE task */
> +	struct {
> +		unsigned int value	: bits_per(SCHED_CAPACITY_SCALE);
> +		unsigned int bucket_id	: bits_per(UCLAMP_BUCKETS);
> +	} effective;

I am confuzled by this thing..  so uclamp_se already has a value,bucket,
which per the prior code is the effective one.

Now; I think I see why you want another value; you need the second to
store the original value for when the system limits change and we must
re-evaluate.

So why are you not adding something like:

	unsigned int orig_value : bits_per(SCHED_CAPACITY_SCALE);

> +unsigned int sysctl_sched_uclamp_util_min;

> +unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;

> +static inline void
> +uclamp_effective_get(struct task_struct *p, unsigned int clamp_id,
> +		     unsigned int *clamp_value, unsigned int *bucket_id)
> +{
> +	/* Task specific clamp value */
> +	*clamp_value = p->uclamp[clamp_id].value;
> +	*bucket_id = p->uclamp[clamp_id].bucket_id;
> +
> +	/* System default restriction */
> +	if (unlikely(*clamp_value < uclamp_default[UCLAMP_MIN].value ||
> +		     *clamp_value > uclamp_default[UCLAMP_MAX].value)) {
> +		/* Keep it simple: unconditionally enforce system defaults */
> +		*clamp_value = uclamp_default[clamp_id].value;
> +		*bucket_id = uclamp_default[clamp_id].bucket_id;
> +	}
> +}

That would then turn into something like:

	unsigned int high = READ_ONCE(sysctl_sched_uclamp_util_max);
	unsigned int low  = READ_ONCE(sysctl_sched_uclamp_util_min);

	uclamp_se->orig_value = value;
	uclamp_se->value = clamp(value, low, high);

And then determine bucket_id based on value.

> +int sched_uclamp_handler(struct ctl_table *table, int write,
> +			 void __user *buffer, size_t *lenp,
> +			 loff_t *ppos)
> +{
> +	int old_min, old_max;
> +	int result = 0;
> +
> +	mutex_lock(&uclamp_mutex);
> +
> +	old_min = sysctl_sched_uclamp_util_min;
> +	old_max = sysctl_sched_uclamp_util_max;
> +
> +	result = proc_dointvec(table, write, buffer, lenp, ppos);
> +	if (result)
> +		goto undo;
> +	if (!write)
> +		goto done;
> +
> +	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
> +	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
> +		result = -EINVAL;
> +		goto undo;
> +	}
> +
> +	if (old_min != sysctl_sched_uclamp_util_min) {
> +		uclamp_bucket_inc(NULL, &uclamp_default[UCLAMP_MIN],
> +				  UCLAMP_MIN, sysctl_sched_uclamp_util_min);
> +	}
> +	if (old_max != sysctl_sched_uclamp_util_max) {
> +		uclamp_bucket_inc(NULL, &uclamp_default[UCLAMP_MAX],
> +				  UCLAMP_MAX, sysctl_sched_uclamp_util_max);
> +	}

Should you not update all tasks?

