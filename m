Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B18C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93B5218A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0BaPCZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfAHACR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:02:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42864 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfAHACQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:02:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so921340plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ln94N+da8ENVieD6yKuVLNjWp3SfRs1G5ojl5uEkePU=;
        b=Z0BaPCZwvnZkPNPrA3X2mx/qYdF4QC2OrBYTHvp5P7YdUN8GJ8U/P/lT5CTGm9qJDA
         jIzmhLKh98Kf8s5pf8Z1CA3yGf2BESTmVlOeu3DJeuFYSisTRRQ5hVjGdr1Xyhtd4N7v
         MYfgrUpnR+sI7hk3httYaMj9DWkDuwRn2SIAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ln94N+da8ENVieD6yKuVLNjWp3SfRs1G5ojl5uEkePU=;
        b=EV/LJaI27QdougdrF9IcOj1NRvZkoCvFpjPtmxj38A0Ol8pZhLuHgBx3MFp8w1ClFX
         pRIdceTqMLS2nW1fT4ZwbJQaaulnTHGwzdgDAobeeLLDL9bYTSt2Sv1uQgBs6lq8hZNc
         ZMj853B7p1/MtdLaPYnWogE+51SOZB6qnlup55qXDH9unvavIi+OVU8r0eUCBz7yFYOs
         5GmngI6S1zgrjl5Qyy+pnHBv0nryMzlJPsbeHiQppypFyrcX1zHxavtwRg0B9ayS2Git
         /+1+60jCiKhzx9SNOVLhTAu2foGCwkra7OrCNF90lU64+i5BQeVodtFW63loJcCRSvP8
         lFRQ==
X-Gm-Message-State: AJcUuke70hjPYIUCJ84ESiHh8MibjP1cihV9h7vzqrEU7UiijRmF79Al
        +dd3k5+CPJIp5Hx/4UPJCChF9g==
X-Google-Smtp-Source: ALg8bN4ALg1iiFlAuSMsREYEw7XWWFpEhr7gt6Irpi3yZ6dvDtM6KYd6/n0JcK0SAQG/dnJP3bSAkA==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4mr53569654pls.5.1546905735941;
        Mon, 07 Jan 2019 16:02:15 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id m3sm82457490pfi.102.2019.01.07.16.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 16:02:15 -0800 (PST)
Date:   Mon, 7 Jan 2019 16:02:14 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
Message-ID: <20190108000214.GR261387@google.com>
References: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
 <20181221205752.GD261387@google.com>
 <2977f340-cd4e-86bc-da3a-8845676e39ed@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2977f340-cd4e-86bc-da3a-8845676e39ed@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya. 

On Mon, Dec 24, 2018 at 12:29:18AM +0530, Taniya Das wrote:

> Could you help validating with the patch below?

...

> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
> b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 7559b87..23338b2 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -81,7 +81,6 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>         u32 volt;
>         unsigned int max_cores = cpumask_weight(policy->cpus);
>         struct cpufreq_frequency_table  *table;
> -       unsigned long cpu_r;
> 
>         table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>         if (!table)
> @@ -110,6 +109,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>                         table[i].frequency = freq;
>                         dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
>                                 freq, core_count);
> +                       dev_pm_opp_add(get_cpu_device(policy->cpu),
> +                                       freq * 1000, volt);
>                 }
> 
>                 /*
> @@ -126,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>                         if (prev_cc != max_cores) {
>                                 prev->frequency = prev_freq;
>                                 prev->flags = CPUFREQ_BOOST_FREQ;
> +                               dev_pm_opp_add(get_cpu_device(policy->cpu),
> +                                               prev_freq * 1000, volt);
>                         }
> 
>                         break;
> @@ -133,12 +136,9 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
> 
>                 prev_cc = core_count;
>                 prev_freq = freq;
> -
> -               freq *= 1000;
> -               for_each_cpu(cpu_r, policy->cpus)
> -                       dev_pm_opp_add(get_cpu_device(cpu_r), freq, volt);
>         }
> 
> +       dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu),
> policy->cpus);
>         table[i].frequency = CPUFREQ_TABLE_END;
>         policy->freq_table = table;
> 
> @@ -245,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct
> cpufreq_policy *policy)
>  {
>         void __iomem *base = policy->driver_data - REG_PERF_STATE;
> 
> +       dev_pm_opp_cpumask_remove_table(policy->cpus);

Evan found that this doesn't actually remove dynamically added
OPPs. You'll have to use the shiny new dev_pm_opp_remove_all_dynamic()
(https://lore.kernel.org/patchwork/patch/1028942/) instead.

Cheers

Matthias
