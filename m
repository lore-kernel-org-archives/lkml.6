Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BB2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B698620827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r26uwxHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B698620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeKGXFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:05:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeKGXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UdRM7sZEkLzi9qrA/ucHhsIu4W6/B5WCHW6x5gtjd6A=; b=r26uwxHC+jkfQisD4DxGb/H/e
        xvp8D0jrzwj1PCJ78Dan6IjB3fKydrGwNBDfbeZ6b9AuoW5vh38dfubYYOxnZhZ1s3/5lwPQWvXHa
        M2GLvhzkTFknQnxNCElJ/lU90zAsUVgtqTu8x7lCt50jhSok80jYvwoi2Y87dpPjTSjB5tpnM3t1J
        0LWz278ephPvQZUBJHg92cYQfIFKOKdUxJjO2pVocTmbbANE/rYEBEo98i6HmH99ZbYkszlpgaeoI
        y3UuK/BgrS5hzE86uun6iQux7FWlL8gqpjmRyh7wH8XYiwdmFFkuEDGiGfzXnaP/TCNbi/hvukldg
        bkarI+Lig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKNz9-0007Sg-9J; Wed, 07 Nov 2018 13:35:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6177020298C0C; Wed,  7 Nov 2018 14:35:04 +0100 (CET)
Date:   Wed, 7 Nov 2018 14:35:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20181107133504.GQ9781@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> +/**
> + * uclamp_group_get: increase the reference count for a clamp group
> + * @uc_se: the utilization clamp data for the task
> + * @clamp_id: the clamp index affected by the task
> + * @clamp_value: the new clamp value for the task
> + *
> + * Each time a task changes its utilization clamp value, for a specified clamp
> + * index, we need to find an available clamp group which can be used to track
> + * this new clamp value. The corresponding clamp group index will be used to
> + * reference count the corresponding clamp value while the task is enqueued on
> + * a CPU.
> + */
> +static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
> +			     unsigned int clamp_value)
> +{
> +	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
> +	unsigned int prev_group_id = uc_se->group_id;
> +	union uclamp_map uc_map_old, uc_map_new;
> +	unsigned int free_group_id;
> +	unsigned int group_id;
> +	unsigned long res;
> +
> +retry:
> +
> +	free_group_id = UCLAMP_GROUPS;
> +	for (group_id = 0; group_id < UCLAMP_GROUPS; ++group_id) {
> +		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> +		if (free_group_id == UCLAMP_GROUPS && !uc_map_old.se_count)
> +			free_group_id = group_id;
> +		if (uc_map_old.value == clamp_value)
> +			break;
> +	}
> +	if (group_id >= UCLAMP_GROUPS) {
> +#ifdef CONFIG_SCHED_DEBUG
> +#define UCLAMP_MAPERR "clamp value [%u] mapping to clamp group failed\n"
> +		if (unlikely(free_group_id == UCLAMP_GROUPS)) {
> +			pr_err_ratelimited(UCLAMP_MAPERR, clamp_value);
> +			return;
> +		}
> +#endif
> +		group_id = free_group_id;
> +		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> +	}

You forgot to check for refcount overflow here ;-)

And I'm not really a fan of hiding that error in a define like you keep
doing.

What's wrong with something like:

	if (SCHED_WARN(free_group_id == UCLAMP_GROUPS))
		return;

and

> +	uc_map_new.se_count = uc_map_old.se_count + 1;

	if (SCHED_WARN(!new.se_count))
		new.se_count = -1;

> +	uc_map_new.value = clamp_value;
> +	res = atomic_long_cmpxchg(&uc_maps[group_id].adata,
> +				  uc_map_old.data, uc_map_new.data);
> +	if (res != uc_map_old.data)
> +		goto retry;
> +
> +	/* Update SE's clamp values and attach it to new clamp group */
> +	uc_se->value = clamp_value;
> +	uc_se->group_id = group_id;
> +
> +	/* Release the previous clamp group */
> +	if (uc_se->mapped)
> +		uclamp_group_put(clamp_id, prev_group_id);
> +	uc_se->mapped = true;
> +}
