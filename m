Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B981AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB092133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZfwZoJs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAWNdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:33:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43472 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfAWNdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2yUaeo/dnZnzfg7QEtal6rNxNpe5Yqn6qYqkT3FexpQ=; b=ZfwZoJs3sWnDchQ67flFRtMkO
        BeKQO2gKEgqJmYfmAnx2+5Wt/uf1Y7dGpxO0JRavgUBv2neKjwM6OCGOc2N8JzZe8ZhR/+OsJLfia
        jaF0nlwWaaCmC1AQiQ/v8w++dGy4tvbVI5sZxtgLAAV3dtZ77ACbcCtb5NtizBUJHez6ymbeDcUJ3
        khdjZEElQOvNV5G3boyg/gvP5xwFfuVbD+cdyyhkQy9LTNtXnu31+0YzhFWH5yYtiSGOiS9CvQ7dy
        DfbZaBaRwlJ91OyYIO2wFCqghTehr7hNqd7c4SLrgFC0XtgoHPYJgdZry0/APYDu7gxal27/n34AY
        6c4oLpw+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmIem-000379-00; Wed, 23 Jan 2019 13:33:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7053C201EC168; Wed, 23 Jan 2019 14:33:24 +0100 (CET)
Date:   Wed, 23 Jan 2019 14:33:24 +0100
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
Subject: Re: [PATCH v6 10/16] sched/core: Add uclamp_util_with()
Message-ID: <20190123133324.GY27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-11-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-11-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:07AM +0000, Patrick Bellasi wrote:
> +static __always_inline
> +unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
> +			      struct task_struct *p)
>  {
>  	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
>  	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
>  
> +	if (p) {
> +		min_util = max(min_util, uclamp_effective_value(p, UCLAMP_MIN));
> +		max_util = max(max_util, uclamp_effective_value(p, UCLAMP_MAX));
> +	}
> +

Like I think you mentioned earlier; this doesn't look right at all.

Should that not be something like:

	lo = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
	hi = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);

	min_util = clamp(uclamp_effective(p, UCLAMP_MIN), lo, hi);
	max_util = clamp(uclamp_effective(p, UCLAMP_MAX), lo, hi);


