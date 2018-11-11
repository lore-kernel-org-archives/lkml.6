Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2A6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1427921104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MgVQdXM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1427921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeKLC6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:58:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56826 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbeKLC6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FwgF1NHpHYmMZCJ+9zD+84bgqqIR0BArF7vCKU69adI=; b=MgVQdXM9UyxJ4aaY+EWBeNC2v
        ABEtELyTWMr7zdWKRLISD+0KvDX4KC4FyjY95S8u8kqoBWZjB2sr7k+igjz2gMxyv89fqb64HbW89
        m4xvFkvOCG4A4IE3hwJpKGzBZJhRZLSfLNpUffLQa3bz24uWCjBqQyjrlv2iRsOksRRRJwH0J1tsO
        X1BdnsYpDG+RzMZYE0vBljknrMGMvHmm7o4fGFDTXkx0Hc39vTKPFyQK4ssSJi47yBO+sohrFe/su
        WeCUg2IZxMUhoYMXYWqo0nHAOSyK5sQwnY/b4hcIEAOwYcf9COMhIBE7AvrdEpToA31lZq9Exz6Y3
        XlydHGOvg==;
Received: from [64.114.255.97] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLtEA-0000Eo-Ff; Sun, 11 Nov 2018 17:08:51 +0000
Received: by worktop (Postfix, from userid 1000)
        id D0FD16E061A; Sun, 11 Nov 2018 18:08:48 +0100 (CET)
Date:   Sun, 11 Nov 2018 18:08:48 +0100
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
Subject: Re: [PATCH v5 06/15] sched/core: uclamp: enforce last task UCLAMP_MAX
Message-ID: <20181111170848.GB3038@worktop>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-8-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-8-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:33:01PM +0000, Patrick Bellasi wrote:
> When a util_max clamped task sleeps, its clamp constraints are removed
> from the CPU. However, the blocked utilization on that CPU can still be
> higher than the max clamp value enforced while that task was running.
> 
> The release of a util_max clamp when a CPU is going to be idle could
> thus allow unwanted CPU frequency increases while tasks are not
> running. This can happen, for example, when a frequency update is
> triggered from another CPU of the same frequency domain.
> In this case, when we aggregate the utilization of all the CPUs in a
> shared frequency domain, schedutil can still see the full not clamped
> blocked utilization of all the CPUs and thus, eventually, increase the
> frequency.

> @@ -810,6 +811,28 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id)
>  		if (max_value >= SCHED_CAPACITY_SCALE)
>  			break;
>  	}
> +
> +	/*
> +	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
> +	 * task, we want to keep the CPU clamped to the last task's clamp
> +	 * value. This is to avoid frequency spikes to MAX when one CPU, with
> +	 * an high blocked utilization, sleeps and another CPU, in the same
> +	 * frequency domain, do not see anymore the clamp on the first CPU.
> +	 *
> +	 * The UCLAMP_FLAG_IDLE is set whenever we detect, from the above
> +	 * loop, that there are no more RUNNABLE taks on that CPU.
> +	 * In this case we enforce the CPU util_max to that of the last
> +	 * dequeued task.
> +	 */
> +	if (max_value < 0) {
> +		if (clamp_id == UCLAMP_MAX) {
> +			rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
> +			max_value = last_clamp_value;
> +		} else {
> +			max_value = uclamp_none(UCLAMP_MIN);
> +		}
> +	}
> +
>  	rq->uclamp.value[clamp_id] = max_value;
>  }

*groan*, so it could be jet-lag, but I find the comment really hard to
understand.

Would not something like:

	/*
	 * Avoid blocked utilization pushing up the frequency when we go
	 * idle (which drops the max-clamp) by retaining the last known
	 * max-clamp.
	 */

Be more clear?
