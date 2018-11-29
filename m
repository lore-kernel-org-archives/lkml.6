Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C285C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225922081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ss0CrV6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225922081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeK2X7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:59:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeK2X7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K+COZvF9HrSOwZVna3Gq9ATJ61O/vDbbqu5cBO305ws=; b=ss0CrV6P96e2MIvqREtHsT+61
        x5htakmhuCMqrZC/C1kd90Q3xfrEIC6zUmL6EMZXEyo6W/ckiW/Tnea1EMSdVPAv2b7gY83nWD/Ji
        DcNxkhVCVbyewOFzy1h5nSFx780nni8WZymzvwMr3hK2Ttx25xY0rD0rLsQutYUM6caLQjVi/LsJ/
        bu/qKoyrRg8cRNGOFgYcLask3k4M/h6XsTxt09rclVche9IHmSSuJMAMeIgtoHxju8M27EX97ELFh
        WhOoQ7Ak2as87Q6uI+ICM9fHrtI3xySX77mmfcLc/Y4RQVVBXQY03ULuHa9jTDROVO/6JiTw8Q9Sb
        ztCRKGPTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSLpG-0008AQ-25; Thu, 29 Nov 2018 12:53:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFBE42029FD58; Thu, 29 Nov 2018 13:53:48 +0100 (CET)
Date:   Thu, 29 Nov 2018 13:53:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181129125348.GL2131@hirez.programming.kicks-ass.net>
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net>
 <20181128115336.GB23094@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128115336.GB23094@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:53:36AM +0000, Patrick Bellasi wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ac855b2f4774..93e0cf5d8a76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3661,6 +3661,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
>  	if (!task_sleep)
>  		return;
>  
> +	/* Skip samples which do not represent an actual utilization */
> +	if (unlikely(task_util(p) > capacity_of(task_cpu(p))))
> +		return;
> +
>  	/*
>  	 * If the PELT values haven't changed since enqueue time,
>  	 * skip the util_est update.

Would you not want something like:

	min(task_util(p), capacity_of(task_cpu(p)))

And is this the only place where we need this?

OTOH, if the task is always running, it will be always running
irrespective of where it runs.

Not storing these samples seems weird though; this is the exact
condition you want to record -- the task is very active, if we skip
these, we'll come back at a low frequency on the next wakeup.


