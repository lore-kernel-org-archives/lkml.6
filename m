Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF65DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC37F20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5TAwlET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfAIKpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:45:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34610 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfAIKpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:45:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so3495288pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=67GrVLf7hFi9VONq8bTSm/8BTwQn+GCaptdda3hBrtA=;
        b=N5TAwlETy5C2HosyyXtrGopuNGBfWBLXK2DNG5mSSJxLOjJK8PRvwExsX3XUv4CLzM
         cY4UQc3nTBoEt5vOk2+ierhTQWTFnfH1IK1JCsHuO6bGoV7mgHaLeuul8RKpjortFRNz
         Agmt9sgnJKdSipg0jVWkhMN9u5mAzOUrgW0EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=67GrVLf7hFi9VONq8bTSm/8BTwQn+GCaptdda3hBrtA=;
        b=KEfZoh5rH83iePgxbyXf/OHz9Kf6kUy9sncW5H1QRwwfpxt1XPG9Y0gC71Uw3cwEBH
         DLvzugiARjRt+BBgJPScd8G2GQZZWR2JXpCjsnX8iTV4s4xeeg9i0rgtkmPVAHx+Bqzi
         8OUy1XDrwcYUMitexxfUO7txg5FqEXRTF/lyA8Gte2LsUB8L/6j73NtN1zRczZalhWQQ
         1owD3nf0Lv2wPaLdOaaDMLokhnTGNBMmiZSW0NmxGXgylmZ8OJ3NB6HdQcfV8+iCx27e
         VWwq+28guWHKIwHuKfRBIJghtlilm3UirHKu1AcdE3RKoviWlQTGOGxY3e1xccj9da3F
         8+EA==
X-Gm-Message-State: AJcUukeyv5YeLgBcHiWL1VUNl2DFuMGKpDKv+IGtinJuYpE4WxGwC4XS
        HEoU3RgPbUTq6Yo9X0Sz5oXS6GK8i4M=
X-Google-Smtp-Source: ALg8bN4S90W6A9tOkdCZTh7Jpa0HU0vimgVjXgqikQK3BpZn6qJnDfaBAwBFIrc4C4XDzTEjH3s+GA==
X-Received: by 2002:a62:cd44:: with SMTP id o65mr5435769pfg.222.1547030714197;
        Wed, 09 Jan 2019 02:45:14 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id a4sm81235549pgv.70.2019.01.09.02.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 02:45:13 -0800 (PST)
Date:   Wed, 9 Jan 2019 16:15:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     sudeep.holla@arm.com, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        qais.yousef@arm.com
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Message-ID: <20190109104511.mi3gtdcytkky4eyn@vireshk-i7>
References: <20190109104236.6532-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109104236.6532-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-19, 10:42, Quentin Perret wrote:
> The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> frequency changes to provide scale-invariant load-tracking signals to
> the scheduler. However, in the slow path, it does so while specifying
> the current and max frequencies in different units, hence resulting in a
> broken freq_scale factor.
> 
> Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> frequency table.
> 
> Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> message protocol")
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 50b1551ba894..3f0693439486 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	int ret;
>  	struct scmi_data *priv = policy->driver_data;
>  	struct scmi_perf_ops *perf_ops = handle->perf_ops;
> -	u64 freq = policy->freq_table[index].frequency * 1000;
> +	u64 freq = policy->freq_table[index].frequency;
>  
> -	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
> +	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
>  	if (!ret)
>  		arch_set_freq_scale(policy->related_cpus, freq,
>  				    policy->cpuinfo.max_freq);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
