Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81495C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D28A2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wtfvn/Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfBDWbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:31:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39455 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfBDWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:31:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so557542pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B+scVtE/cqWTynYFvfhgj52JjCnNRds1E26emfBfBKw=;
        b=Wtfvn/JejmsviTajSFPTGqp83oXvoP8rHWdf421YaWLO9TcQK3EjHaoX3+0oVTgj4p
         l0ItuechzB51Rj0IzCZe32P40d1gJn1pPWymsauZTZVPw1Yp25CJZVClHWclBSa9PA/A
         j2zIXf+XYkKHGTo5fYPrl7RAd1GSaZrUI3xDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+scVtE/cqWTynYFvfhgj52JjCnNRds1E26emfBfBKw=;
        b=kayheffwGOWPwrLHZyDZCekERCQPbshrTa11aKfQ9WKSa2aT+YuAQGTUvcAtW5vd+V
         sQ6OFmcajT9N3HRmUPuN2vi3F9S+/vYPLUZ3NQY2IuXbONjJ/7snOsqdeRLIk3vGyX5K
         r4K9D2I6dY40h2ei+3ccu08CK4IErjX3+ViYPw1oUTmv1ypk7K9153/qZ8PZaxxbuKn/
         ZUeyqqX52M8YQmE3ppd1+dUvP3ltThzS5pTUVvjJpI7WQWxSJuO7C8mrT0r7gIEBMlv8
         w8OMk5NLDF8Y1eoNq+i/5c20/WyP+YADLp4x7JrvMpKYDog5fVMYHzipXdJys9bZ9rez
         C12A==
X-Gm-Message-State: AHQUAuaOPC9fQfgjuEz2erXwISQ5o/PlD6iVAR+vGcxvRs24EYo34M4+
        QwZDFrAkH2G4BomqqxpVUx675ypLRV8=
X-Google-Smtp-Source: AHgI3IZ+JPZ8t8j24qIp4QLVXNduMLIJwId+NWI5FCT4eZk8NuRaIR6+xQ60HvmJO7pfR43E054r/w==
X-Received: by 2002:a63:2bc4:: with SMTP id r187mr1555852pgr.306.1549319492848;
        Mon, 04 Feb 2019 14:31:32 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v89sm1526736pfj.164.2019.02.04.14.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 14:31:32 -0800 (PST)
Date:   Mon, 4 Feb 2019 14:31:31 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: stats: Fix concurrency issues while
 resetting stats
Message-ID: <20190204223131.GF117604@google.com>
References: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
 <927dcc1de6acad3dd2cfae4e300e6fee4f665101.1549001732.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <927dcc1de6acad3dd2cfae4e300e6fee4f665101.1549001732.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:45:45AM +0530, Viresh Kumar wrote:
> It is possible for cpufreq_stats_clear_table() and
> cpufreq_stats_record_transition() to get called concurrently and they
> will try to update same variables simultaneously and may lead to
> corruption of data.
> 
> Prevent that with the help of existing spinlock.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 941e63e3e652..e2db5581489a 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -31,20 +31,20 @@ static void cpufreq_stats_update(struct cpufreq_stats *stats)
>  {
>  	unsigned long long cur_time = get_jiffies_64();
>  
> -	spin_lock(&cpufreq_stats_lock);
>  	stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
>  	stats->last_time = cur_time;
> -	spin_unlock(&cpufreq_stats_lock);
>  }
>  
>  static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
>  {
>  	unsigned int count = stats->max_state;
>  
> +	spin_lock(&cpufreq_stats_lock);
>  	memset(stats->time_in_state, 0, count * sizeof(u64));
>  	memset(stats->trans_table, 0, count * count * sizeof(int));
>  	stats->last_time = get_jiffies_64();
>  	stats->total_trans = 0;
> +	spin_unlock(&cpufreq_stats_lock);
>  }
>  
>  static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
> @@ -62,7 +62,10 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  	if (policy->fast_switch_enabled)
>  		return 0;
>  
> +	spin_lock(&cpufreq_stats_lock);
>  	cpufreq_stats_update(stats);
> +	spin_unlock(&cpufreq_stats_lock);
> +
>  	for (i = 0; i < stats->state_num; i++) {
>  		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
>  			(unsigned long long)
> @@ -239,9 +242,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
>  	if (old_index == -1 || new_index == -1 || old_index == new_index)
>  		return;
>  
> +	spin_lock(&cpufreq_stats_lock);
>  	cpufreq_stats_update(stats);
>  
>  	stats->last_index = new_index;
>  	stats->trans_table[old_index * stats->max_state + new_index]++;
>  	stats->total_trans++;
> +	spin_unlock(&cpufreq_stats_lock);
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
