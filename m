Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A7FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAE42081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kOvZzuVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAE42081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbeKHAH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:07:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKHAH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/aj/EsArb9CEadFCqv2LDpL/Pm+9u6CBNIGhuzGKnoc=; b=kOvZzuVfWuZjw2L8RWjDUfRC/
        1jj8Rdc5spnWoSghouMRnwmGNRY1rYNbRrRyatSioSzwff+vOH6mvYe7bK2JTsE6CGCHe4DngcHgM
        cXxTKkas2POYsuq5mSVDHfZ/4vZcrFyo48U40rAL+7fMB0+USS1baelfuphThB5cZ9+RngRkPz0xJ
        IMPCe8ETobiCX/uviP6BJBmDbCuMmsxbQtDEjcLIj4EYNGbyqPnYx7OnlrV1wrrS1wH0X4sCpEmvu
        smY+wpj+0N5+azPfpq6Dmcz9IggunP170wnmOU5b1eLlCTifowkAAbkV4aCaCRX0kpjjsQPEoAqxb
        toDhq58mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKOxH-0003kn-NO; Wed, 07 Nov 2018 14:37:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 498312029F883; Wed,  7 Nov 2018 15:37:13 +0100 (CET)
Date:   Wed, 7 Nov 2018 15:37:13 +0100
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
Message-ID: <20181107143713.GS9781@hirez.programming.kicks-ass.net>
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
> +static int __setscheduler_uclamp(struct task_struct *p,
> +				 const struct sched_attr *attr)
> +{
> +	unsigned int lower_bound = p->uclamp[UCLAMP_MIN].value;
> +	unsigned int upper_bound = p->uclamp[UCLAMP_MAX].value;
> +	int result = 0;
> +
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> +		lower_bound = attr->sched_util_min;
> +
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> +		upper_bound = attr->sched_util_max;
> +
> +	if (lower_bound > upper_bound ||
> +	    upper_bound > SCHED_CAPACITY_SCALE)
>  		return -EINVAL;
>  
> +	mutex_lock(&uclamp_mutex);
>  
> +	/* Update each required clamp group */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +		uclamp_group_get(&p->uclamp[UCLAMP_MIN],
> +				 UCLAMP_MIN, lower_bound);
> +	}
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +		uclamp_group_get(&p->uclamp[UCLAMP_MAX],
> +				 UCLAMP_MAX, upper_bound);
> +	}
> +
> +	mutex_unlock(&uclamp_mutex);
> +
> +	return result;
> +}

I'm missing where we error due to lack of groups.
