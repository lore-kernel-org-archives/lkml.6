Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2893EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBC22174C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBC22174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbeHGPk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:40:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56105 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388581AbeHGPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:40:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so17430541wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 06:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uEPiQtdPS0U88+B+mGvXuHnVlXEbwn22EegVG1v9c48=;
        b=o0E9PGfPG/DK2FgYLIkm5PYDEfdtjAiH01Kr5zCUBh2Ypk3nime/hOvIiXBP0wR7uf
         uk06qEmt+BQDLR0uaOUdhIQBRQu0qZ04PIapHiG332g4UTZ+CEdi6Jok3m33zfUP4q5d
         Auk/mPsm+MObj0+3GkU8C537dY2riNll0LHFZOCnheicx7vzABWmHIX5U2CBdt1sRllY
         VjNaRaX/3qhg5VxN8Rc8jLmHmdwTRiaaYva+QOd47um1ZIGtiG8q3Yn6R7d52U4Ak0fR
         SMzISo12NbOZ/5Je+RbI35fMvtj3PiafIErh+STEve8Mv3rqMB2Ki4TBNVOgfevx9z8T
         xrHg==
X-Gm-Message-State: AOUpUlHoRS5LT5qiChyVCyO9wGtQzNzBJLhN5UguglNplnunFGlgFoqt
        WLX0pnmRNXguMx7ly8FjWXlUhg==
X-Google-Smtp-Source: AA+uWPwzgGWxcCCJ28rJFf6RJhCVOjCPXgu64BN7imm7J17obMUe1OBLUbfy/inY2648LJcTHyPQjw==
X-Received: by 2002:a1c:f306:: with SMTP id q6-v6mr1695061wmq.111.1533648396803;
        Tue, 07 Aug 2018 06:26:36 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31703FE367972448AED7A.dip0.t-ipconnect.de. [2003:ef:2bd3:1703:fe36:7972:448a:ed7a])
        by smtp.gmail.com with ESMTPSA id e141-v6sm2719950wmd.32.2018.08.07.06.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 06:26:33 -0700 (PDT)
Date:   Tue, 7 Aug 2018 15:26:30 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Message-ID: <20180807132630.GB3062@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-7-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/08/18 17:39, Patrick Bellasi wrote:

[...]

> @@ -223,13 +224,25 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  	 * utilization (PELT windows are synchronized) we can directly add them
>  	 * to obtain the CPU's actual utilization.
>  	 *
> -	 * CFS utilization can be boosted or capped, depending on utilization
> -	 * clamp constraints configured for currently RUNNABLE tasks.
> +	 * CFS and RT utilizations can be boosted or capped, depending on
> +	 * utilization constraints enforce by currently RUNNABLE tasks.
> +	 * They are individually clamped to ensure fairness across classes,
> +	 * meaning that CFS always gets (if possible) the (minimum) required
> +	 * bandwidth on top of that required by higher priority classes.

Is this a stale comment written before UCLAMP_SCHED_CLASS was
introduced? It seems to apply to the below if branch only.

>  	 */
> -	util = cpu_util_cfs(rq);
> -	if (util)
> -		util = uclamp_util(cpu_of(rq), util);
> -	util += cpu_util_rt(rq);
> +	util_cfs = cpu_util_cfs(rq);
> +	util_rt  = cpu_util_rt(rq);
> +	if (sched_feat(UCLAMP_SCHED_CLASS)) {
> +		util = 0;
> +		if (util_cfs)
> +			util += uclamp_util(cpu_of(rq), util_cfs);
> +		if (util_rt)
> +			util += uclamp_util(cpu_of(rq), util_rt);
> +	} else {
> +		util  = cpu_util_cfs(rq);
> +		util += cpu_util_rt(rq);
> +		util  = uclamp_util(cpu_of(rq), util);
> +	}

Best,

- Juri
