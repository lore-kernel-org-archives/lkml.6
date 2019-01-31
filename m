Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36668C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0996E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJ29kCcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfAaIaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:30:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37842 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfAaIaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:30:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so1166851plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 00:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XSX9BpWZw471zYraRwQzenWXaVO5pigJGakf0envdnI=;
        b=fJ29kCcRPFDSgHi6GqctdlTjY1E4WtdWvTwTHJPUBzkKnO/I31+jknwabuxDIggE11
         hF3YwCSL4cFrG9PJa6RDEDyblzi6L8c5I4FyT1m2jjHMaUqTT5VMgcHX6pshTOq+Nvwz
         hDP3/QtDTIqgiMro/h2Z8RDxAwmuBby7WMSA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSX9BpWZw471zYraRwQzenWXaVO5pigJGakf0envdnI=;
        b=eViqXTMOpwO9CADiIX6Gfoz5Geej8bz0qsIioGj6suZGDuGfFVnhRPbvxXJ6xFOD3d
         9Drj/ObrItKMQbABJFEfj7r/6GzYN25auAHeFE2Z0vVCmVZSTubU0YtX7rTXt6d5Wu+f
         0MSJtBw+2j39En5b5U1Wbd6+fB5dQpkdZ52gSMjQghNLURAOxwx8GGP6jTX1o/7/6TBe
         55OSUc0FgR9uILGZye2wX463WofbJRP0mn9ksb4Ng5DdgqMnVkFGYpVSMqo82KyB1ZnR
         4dXHznU6BG1+aksRki7pt9llXkF/dhOqaPGeBzkKRN2owDQzFGlH4Ehmn7fIUPSrtd6A
         f2Gg==
X-Gm-Message-State: AJcUukcze8Q90AfmGggaUSWJjX/UkIZziB9X8BJBjAdqeaYBGlkttp9Y
        le+6sgKUg6mTJy6CJHjw1q9F3w==
X-Google-Smtp-Source: ALg8bN7xxcBDrwhpVAFjQN+fmr9wGfCebB8zP+KMfYuQBFeQvxj3mguHOMnX9lKAMaJZSXcmhvKlLw==
X-Received: by 2002:a17:902:4324:: with SMTP id i33mr33115764pld.227.1548923407120;
        Thu, 31 Jan 2019 00:30:07 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id b9sm5711166pfi.118.2019.01.31.00.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 00:30:06 -0800 (PST)
Date:   Thu, 31 Jan 2019 14:00:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
Message-ID: <20190131083004.rkxehycu4pbbx52s@vireshk-i7>
References: <20190131015139.126890-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131015139.126890-1-mka@chromium.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-01-19, 17:51, Matthias Kaehlcke wrote:
> When fast switching is enabled currently no cpufreq stats are
> recorded and the corresponding sysfs attributes appear empty (see
> also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
> non-modular")).
> 
> Record the stats after a successful fast switch and re-enable access
> through sysfs when fast switching is enabled. Since
> cpufreq_stats_update() can now be called in interrupt context (during
> a fast switch) disable local IRQs while holding the stats spinlock.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> The change is so simple that I wonder if I'm missing some important
> reason why the stats can't/shouldn't be updated during/after a fast
> switch ...
> 
> I would expect that holding the stats spinlock briefly in
> cpufreq_stats_update() shouldn't be a problem. In theory it would
> also be an option to have a per stats lock, though it seems overkill
> from my (possibly ignorant) point of view.
> ---
>  drivers/cpufreq/cpufreq.c       |  8 +++++++-
>  drivers/cpufreq/cpufreq_stats.c | 11 +++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bcf..63aadb0bbddfe 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  					unsigned int target_freq)
>  {
> +	unsigned int freq;
> +
>  	target_freq = clamp_val(target_freq, policy->min, policy->max);
>  
> -	return cpufreq_driver->fast_switch(policy, target_freq);
> +	freq = cpufreq_driver->fast_switch(policy, target_freq);
> +	if (freq)
> +		cpufreq_stats_record_transition(policy, freq);
> +
> +	return freq;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>  
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 1572129844a5b..21b919bfaeccf 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -30,11 +30,12 @@ struct cpufreq_stats {
>  static void cpufreq_stats_update(struct cpufreq_stats *stats)
>  {
>  	unsigned long long cur_time = get_jiffies_64();
> +	unsigned long flags;
>  
> -	spin_lock(&cpufreq_stats_lock);
> +	spin_lock_irqsave(&cpufreq_stats_lock, flags);
>  	stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
>  	stats->last_time = cur_time;
> -	spin_unlock(&cpufreq_stats_lock);
> +	spin_unlock_irqrestore(&cpufreq_stats_lock, flags);
>  }

The only problem that I can think of (or recall) is that this routine
also gets called when time_in_state sysfs file is read and that can
end up taking lock which the scheduler's hotpath will wait for.

-- 
viresh
