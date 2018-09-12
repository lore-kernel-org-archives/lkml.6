Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D655CC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C262087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BZhQR3DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C262087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeILV35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:29:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Lks6pZ72TXPOV0M611gEvH/TdS6H5aMizLe3D2jQtc=; b=BZhQR3DPq8sdNB/kbsCmisU/l
        20J14vxl1BvzJNCbX+j5Nv3xHKN7Kd0+HfHltZaH+9roS8aBZ1V0K5T0ESvQULH8/B/5yoKDD7WRr
        JzAXwJmwY4kPIOcVgDOBNs0xKV4l3S/23OAcsjUW3TXcatDg3SDNPrpJfecD8CDe0HthPSW6mdt3r
        fgQuci1socdBHs1VptR7AHAxi2RFKnPZ2exfDxBqJXth42J5WOQWt3cBlwkWyZo70oSEesg4kG+fW
        jNCO9OgilE18fTva0gaeTHaAndVvlgloV2FPAfFlIi4EjsIZOodK5ipatsG3nwkUo5eY++mnnXC2M
        BrMmdNxGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g07wL-0001gK-F2; Wed, 12 Sep 2018 16:24:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85DA5202C1A09; Wed, 12 Sep 2018 18:24:27 +0200 (CEST)
Date:   Wed, 12 Sep 2018 18:24:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180912162427.GA24106@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:
>  static inline int __setscheduler_uclamp(struct task_struct *p,
>  					const struct sched_attr *attr)

But large for inline now.

>  {
> +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> +	int lower_bound, upper_bound;
> +	struct uclamp_se *uc_se;
> +	int result = 0;

I think the thing would become much more readable if you set
lower/upper_bound right here.
>  
> +	mutex_lock(&uclamp_mutex);
>  
> +	/* Find a valid group_id for each required clamp value */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +		upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> +			? attr->sched_util_max
> +			: p->uclamp[UCLAMP_MAX].value;
> +
> +		if (upper_bound == UCLAMP_NOT_VALID)
> +			upper_bound = SCHED_CAPACITY_SCALE;
> +		if (attr->sched_util_min > upper_bound) {
> +			result = -EINVAL;
> +			goto done;
> +		}
> +
> +		result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
> +		if (result == -ENOSPC) {
> +			pr_err(UCLAMP_ENOSPC_FMT, "MIN");

AFAICT this is an unpriv part of the syscall; and you can spam the log
without limits. Not good.

> +			goto done;
> +		}
> +		group_id[UCLAMP_MIN] = result;
> +	}
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +		lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> +			? attr->sched_util_min
> +			: p->uclamp[UCLAMP_MIN].value;
> +
> +		if (lower_bound == UCLAMP_NOT_VALID)
> +			lower_bound = 0;
> +		if (attr->sched_util_max < lower_bound ||
> +		    attr->sched_util_max > SCHED_CAPACITY_SCALE) {
> +			result = -EINVAL;
> +			goto done;
> +		}
> +
> +		result = uclamp_group_find(UCLAMP_MAX, attr->sched_util_max);
> +		if (result == -ENOSPC) {
> +			pr_err(UCLAMP_ENOSPC_FMT, "MAX");
> +			goto done;
> +		}
> +		group_id[UCLAMP_MAX] = result;
> +	}
> +
> +	/* Update each required clamp group */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +		uc_se = &p->uclamp[UCLAMP_MIN];
> +		uclamp_group_get(UCLAMP_MIN, group_id[UCLAMP_MIN],
> +				 uc_se, attr->sched_util_min);
> +	}
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +		uc_se = &p->uclamp[UCLAMP_MAX];
> +		uclamp_group_get(UCLAMP_MAX, group_id[UCLAMP_MAX],
> +				 uc_se, attr->sched_util_max);
> +	}
> +
> +done:
> +	mutex_unlock(&uclamp_mutex);
> +
> +	return result;
> +}
