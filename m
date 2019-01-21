Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCADC2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0138720870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0wIRjC58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfAUPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:05:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbfAUPFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MNFBIieM3i2G4zqwyYznhY3OnxSJLoY9SIW6yDsqk9c=; b=0wIRjC58qLrf0DRTzzEaDGQCL
        +7pFxhqJv7TXayeQZdqxh+Cira/5EsLB4TYvsGjVF0SntgbhQzS9UTj7bKyUNMwXk30OsSMRpLPsy
        KCdzYSS0FR9rEiSr84JbVB+i513aSMALND03XVcwFaD29gU0+fKY2aBSgJj/tMnRXfhPTq9anoFgM
        4KBmd5nYeAX0fqnAMNlOOSyKaIXsBlFrSKIaGld1MzeEqdzQI2oqwHBTp8YOcIntEwb+3vBY9L/TN
        oN4AtEaCbjaMQnexXaWs0bqnYT8wgKY5KShy521WVIIlF7irKfqhlaq+ea6kAI5emKdRESFpnr4ly
        QGay6XtvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glb8P-0006KU-LB; Mon, 21 Jan 2019 15:05:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48D402846D164; Mon, 21 Jan 2019 16:05:07 +0100 (CET)
Date:   Mon, 21 Jan 2019 16:05:07 +0100
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
Subject: Re: [PATCH v6 03/16] sched/core: uclamp: Map TASK's clamp values
 into CPU's clamp buckets
Message-ID: <20190121150507.GJ27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:00AM +0000, Patrick Bellasi wrote:
> +static inline unsigned int uclamp_bucket_value(unsigned int clamp_value)
> +{
> +#define UCLAMP_BUCKET_DELTA (SCHED_CAPACITY_SCALE / CONFIG_UCLAMP_BUCKETS_COUNT)
> +#define UCLAMP_BUCKET_UPPER (UCLAMP_BUCKET_DELTA * CONFIG_UCLAMP_BUCKETS_COUNT)
> +
> +	if (clamp_value >= UCLAMP_BUCKET_UPPER)
> +		return SCHED_CAPACITY_SCALE;
> +
> +	return UCLAMP_BUCKET_DELTA * (clamp_value / UCLAMP_BUCKET_DELTA);
> +}

> +static void uclamp_bucket_inc(struct uclamp_se *uc_se, unsigned int clamp_id,
> +			      unsigned int clamp_value)
> +{
> +	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
> +	unsigned int prev_bucket_id = uc_se->bucket_id;
> +	union uclamp_map uc_map_old, uc_map_new;
> +	unsigned int free_bucket_id;
> +	unsigned int bucket_value;
> +	unsigned int bucket_id;
> +
> +	bucket_value = uclamp_bucket_value(clamp_value);

Aahh!!

So why don't you do:

	bucket_id = clamp_value / UCLAMP_BUCKET_DELTA;
	bucket_value = bucket_id * UCLAMP_BUCKET_DELTA;

> +	do {
> +		/* Find the bucket_id of an already mapped clamp bucket... */
> +		free_bucket_id = UCLAMP_BUCKETS;
> +		for (bucket_id = 0; bucket_id < UCLAMP_BUCKETS; ++bucket_id) {
> +			uc_map_old.data = atomic_long_read(&uc_maps[bucket_id].adata);
> +			if (free_bucket_id == UCLAMP_BUCKETS && !uc_map_old.se_count)
> +				free_bucket_id = bucket_id;
> +			if (uc_map_old.value == bucket_value)
> +				break;
> +		}
> +
> +		/* ... or allocate a new clamp bucket */
> +		if (bucket_id >= UCLAMP_BUCKETS) {
> +			/*
> +			 * A valid clamp bucket must always be available.
> +			 * If we cannot find one: refcounting is broken and we
> +			 * warn once. The sched_entity will be tracked in the
> +			 * fast-path using its previous clamp bucket, or not
> +			 * tracked at all if not yet mapped (i.e. it's new).
> +			 */
> +			if (unlikely(free_bucket_id == UCLAMP_BUCKETS)) {
> +				SCHED_WARN_ON(free_bucket_id == UCLAMP_BUCKETS);
> +				return;
> +			}
> +			bucket_id = free_bucket_id;
> +			uc_map_old.data = atomic_long_read(&uc_maps[bucket_id].adata);
> +		}

And then skip all this?

> +
> +		uc_map_new.se_count = uc_map_old.se_count + 1;
> +		uc_map_new.value = bucket_value;
> +
> +	} while (!atomic_long_try_cmpxchg(&uc_maps[bucket_id].adata,
> +					  &uc_map_old.data, uc_map_new.data));
> +
> +	uc_se->value = clamp_value;
> +	uc_se->bucket_id = bucket_id;
> +
> +	if (uc_se->mapped)
> +		uclamp_bucket_dec(clamp_id, prev_bucket_id);
> +
> +	/*
> +	 * Task's sched_entity are refcounted in the fast-path only when they
> +	 * have got a valid clamp_bucket assigned.
> +	 */
> +	uc_se->mapped = true;
> +}
