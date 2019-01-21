Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C26DC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB0F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lfMXZm5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfAUO7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:59:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfAUO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+XkP6BjBOoguOx02ypGLg2Qbad4YbXufumxqfvbyOgo=; b=lfMXZm5hjEwlCw+4TqCeYF5mM
        kvenuIAuRzFYsU/vhChWqDhCjjEpHQZ7xOPkUtsYKMtnughlRpUAogubV+1uSmTEbZg0Hi5jR4lmg
        u2wO7Sx15bYX2/qw3Izqapybq0LC4o9QPoVidVURmrBP8qb9OPcO3ynW9h5wZDiBxj/vhko0AlskK
        vHq1CE9Pzb8PSI4ZAF1Lo8O1MeTKE6zz0VgT/F98qZup3ZfeuDTqbbGAIH4sJLM0GQUJ+tL83eZuv
        R1S3UD9J8AQZ+U2U3q/CONzYTaTfp8M93v4lGzJrO23Fht72zoMKUNMqWZhbu6YwV8asnBm9Oi9Zq
        5WiFWnLIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glb2y-00063P-6z; Mon, 21 Jan 2019 14:59:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91FF8284706C0; Mon, 21 Jan 2019 15:59:29 +0100 (CET)
Date:   Mon, 21 Jan 2019 15:59:29 +0100
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
Subject: Re: [PATCH v6 04/16] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190121145929.GI27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-5-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-5-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:01AM +0000, Patrick Bellasi wrote:
> @@ -835,6 +954,28 @@ static void uclamp_bucket_inc(struct uclamp_se *uc_se, unsigned int clamp_id,
>  	} while (!atomic_long_try_cmpxchg(&uc_maps[bucket_id].adata,
>  					  &uc_map_old.data, uc_map_new.data));
>  
> +	/*
> +	 * Ensure each CPU tracks the correct value for this clamp bucket.
> +	 * This initialization of per-CPU variables is required only when a
> +	 * clamp value is requested for the first time from a slow-path.
> +	 */

I'm confused; why is this needed?

> +	if (unlikely(!uc_map_old.se_count)) {
> +		for_each_possible_cpu(cpu) {
> +			struct uclamp_cpu *uc_cpu =
> +				&cpu_rq(cpu)->uclamp[clamp_id];
> +
> +			/* CPU's tasks count must be 0 for free buckets */
> +			SCHED_WARN_ON(uc_cpu->bucket[bucket_id].tasks);
> +			if (unlikely(uc_cpu->bucket[bucket_id].tasks))
> +				uc_cpu->bucket[bucket_id].tasks = 0;
> +
> +			/* Minimize cache lines invalidation */
> +			if (uc_cpu->bucket[bucket_id].value == bucket_value)
> +				continue;
> +			uc_cpu->bucket[bucket_id].value = bucket_value;
> +		}
> +	}
> +
>  	uc_se->value = clamp_value;
>  	uc_se->bucket_id = bucket_id;
>  
