Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F5EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4750C20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jUVQE7oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfAVPVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:21:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33044 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfAVPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GKSXAN5UUuzd6Lw6D1GSbt4cs3vPetKBVm8iyWRMxn4=; b=jUVQE7ohGU7mksg2A34z3l6Ls
        J7mnJ4velC2r5JfuDHZX8rF1vwMNyZspa6HxH0xwhtiPOtsy6deOk/Rk7ICPFSvCSSHyRnaxnfrYy
        gc9ibpEAMZ/duv88y2SGSVvsD+s1gSJM9s0nchMk2E9XDNMuc74neY8ShHP/RIJFkYWOxNHKULjtx
        YNqfAEcPpGVwUUMWBos1ruVljyBSBpoiB/trxqF7cdgEPXtf0prH3TN2g9uhcrK3tXc+dJw2AhQEO
        kGeQLTzkHuXEzMOJKpXKNRDy1c0gQvhBgIMZQrBMpbtEkIkOsYOFBg+gmfc+9eDl0RNOph2CvZIiU
        ssNPnfvCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glxrq-0003BE-DJ; Tue, 22 Jan 2019 15:21:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF9A22042CFC3; Tue, 22 Jan 2019 16:21:32 +0100 (CET)
Date:   Tue, 22 Jan 2019 16:21:32 +0100
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
Subject: Re: [PATCH v6 08/16] sched/cpufreq: uclamp: Add utilization clamping
 for FAIR tasks
Message-ID: <20190122152132.GR27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-9-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-9-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:05AM +0000, Patrick Bellasi wrote:
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -218,8 +218,15 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
>  	 * CFS tasks and we use the same metric to track the effective
>  	 * utilization (PELT windows are synchronized) we can directly add them
>  	 * to obtain the CPU's actual utilization.
> +	 *
> +	 * CFS utilization can be boosted or capped, depending on utilization
> +	 * clamp constraints requested by currently RUNNABLE tasks.
> +	 * When there are no CFS RUNNABLE tasks, clamps are released and
> +	 * frequency will be gracefully reduced with the utilization decay.
>  	 */
> -	util = util_cfs;
> +	util = (type == ENERGY_UTIL)
> +		? util_cfs
> +		: uclamp_util(rq, util_cfs);

That's pretty horrible; what's wrong with:

	util = util_cfs;
	if (type == FREQUENCY_UTIL)
		util = uclamp_util(rq, util);

That should generate the same code, but is (IMO) far easier to read.

>  	util += cpu_util_rt(rq);
>  
>  	dl_util = cpu_util_dl(rq);
