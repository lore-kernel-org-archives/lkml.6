Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF1EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8252098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzRUFXfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8252098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeHVP0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:26:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34083 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbeHVP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:26:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so1403589wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ssHHzhLiN6/VguYPy9B8Xfr8tnluVVNb4KHNerASRk=;
        b=dzRUFXfW6ducW/edr1YTNZZDC6nxMGNS7oRxDDHTwxR+etnOcmpE0ycNNYiG0OuBIW
         Z3AoxBnQCUN2jQxX0DgimZy30a2ZmeCFeSgIKirL5YT6Fk2QTFYP4x9zj900t8ecjYnR
         B3b93006YTMXEVz2TwTrBazj+MwG/EZDYo6DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ssHHzhLiN6/VguYPy9B8Xfr8tnluVVNb4KHNerASRk=;
        b=suQpNraU16ZjjS2oOfYfaWPrMJgnJBvdJpgEVXi0/xRvSqkfwvx30+O5PdHBdS4A0g
         O/Wv4+02tGGYWFCoCoqNEOpSiU/eMEMUSisGUSNsqds4FSmBX/mRXmDHcn8J2uMnCywj
         6DQtJQf8UBm8036vCmNqj/I8XkmAqN4QFGU5xm6+UTYTv+Z0qtP9gzdoct9kTF04/pEZ
         6jPEekUWkt2vj6TnLp1Zq/286kBRJDYgJtniWlhhykUsb7ANEMrU/3giKTlM6SbA1qNR
         6jUlH/uFeoSORvVF9ceP4SxgCyg2OaD1JQWpoSQ8vLupSOSLXAnThZ7OxuOqktC2UIXC
         722w==
X-Gm-Message-State: APzg51DdPcFUyxxCGcChWtit+U34NnxqXZINzhLmDCpw6OtClcwEcj/p
        txflk1o3l7aq9l1KLynuN+DzPQ==
X-Google-Smtp-Source: ANB0VdYoFcsaRwvd8szPcA4YU/iNNIQT+0jU+FKc0IoMKnFWjC4QbJl75ealPOf5nhXd4SewSlgG4A==
X-Received: by 2002:a5d:66d2:: with SMTP id k18-v6mr3919987wrw.154.1534939327864;
        Wed, 22 Aug 2018 05:02:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id j133-v6sm3005677wmd.12.2018.08.22.05.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 05:02:07 -0700 (PDT)
Date:   Wed, 22 Aug 2018 20:02:00 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
Message-ID: <20180822120200.GA8949@leoy-ThinkPad-X240s>
References: <34910476.pgRhNDWo5t@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34910476.pgRhNDWo5t@aspire.rjw.lan>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 10:44:10AM +0200, Rafael J . Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The case addressed by commit 5ef499cd571c (cpuidle: menu: Handle
> stopped tick more aggressively) in the stopped tick case is present
> when the tick has not been stopped yet too.  Namely, if only two CPU
> idle states, shallow state A with target residency significantly
> below the tick boundary and deep state B with target residency
> significantly above it, are available and the predicted idle
> duration is above the tick boundary, but below the target residency
> of state B, state A will be selected and the CPU may spend indefinite
> amount of time in it, which is not quite energy-efficient.
> 
> However, if the tick has not been stopped yet and the governor is
> about to select a shallow idle state for the CPU even though the idle
> duration predicted by it is above the tick boundary, it should be
> fine to wake up the CPU early, so the tick can be retained then and
> the governor will have a chance to select a deeper state when it runs
> next time.
> 
> [Note that when this really happens, it will make the idle duration
>  predictor believe that the CPU might be idle longer than predicted,
>  which will make it more likely to predict longer idle durations going
>  forward, but that will also cause deeper idle states to be selected
>  going forward, on average, which is what's needed here.]
> 
> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Commit 5ef499cd571c (cpuidle: menu: Handle stopped tick more aggressively) is
> in linux-next only at this point.
> 
> ---
>  drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -379,9 +379,20 @@ static int menu_select(struct cpuidle_dr
>  		if (idx == -1)
>  			idx = i; /* first enabled state */
>  		if (s->target_residency > data->predicted_us) {
> -			if (!tick_nohz_tick_stopped())
> +			if (data->predicted_us < TICK_USEC)

With this change, for tick has been stopped, it might introduce
regression to select a shallow state and it's conflict with the effect
of patch "cpuidle: menu: Handle stopped tick more aggressively".

>  				break;
>  
> +			if (!tick_nohz_tick_stopped()) {
> +				/*
> +				 * If the state selected so far is shallow,
> +				 * waking up early won't hurt, so retain the
> +				 * tick in that case and let the governor run
> +				 * again in the next iteration of the loop.
> +				 */
> +				expected_interval = drv->states[idx].target_residency;
> +				break;
> +			}
> +

This is reliable, how we can rely on a shallow idle state target
residency to decide if need to stop a tick or not?

>  			/*
>  			 * If the state selected so far is shallow and this
>  			 * state's target residency matches the time till the
> 
