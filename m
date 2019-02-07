Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C475C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC05E2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmocZc7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBGE5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:57:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34028 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfBGE5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:57:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so4240183pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 20:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u6WiCMKwISCpmZcBrhgNTgWJl8aql0X7p1MXMIxaG/M=;
        b=qmocZc7+OpLv0eADHLv1xXQqC8i2tEsUdQNRWn9W+Ggp4FEubua1E7qyrqgElumRpL
         aG7/sUsPDwl9vKFi/CcIEgy977hzTrhnYBbGy7t8mLdXRKRozADA8xIK9hP0JXWlh34Y
         DEEy9B9ZqjQOCLHaMInhDqaonHKIpXosXlwZS1i/5u0R9/0sg/iDS9J7OcnAQ21FKQQ2
         Jqnpg1+t8I3czTMosKsUJBuwTVnWe+vy9XifcGSwTfLwYWfQys3pv1ATyTH8WCacJl4k
         IiPu8AkLKChHSNnRSV8KBIuALWKeVXBCbzH+fomdLH1kowiTATOFC3HkSbIGHw5aLgyx
         QJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u6WiCMKwISCpmZcBrhgNTgWJl8aql0X7p1MXMIxaG/M=;
        b=eoBP6/s7M3AtcTMxq2vUdLqxm6TX5xEmOQoBMbFX/QyEEGuFlHZPPPoOuk7eIvPmNH
         0h0HaTszGhU4og6V44oYjS943C4Y1xxmC60FEnbtoJ/jG+8GlNffXL6x32qDO63lrdQN
         yfbZqcegMFavZPsbCf05KuUsGknWs7EuITMn8dtGx/Dkr0JlSyrC41w69FcMDo0ooxf9
         2Sli1gmJrNvLEtowFqIPLFTEumdrAzZDr+MgQ5xJoRo+IeBlF2vJb+TrHP6y09sV3H5n
         cnnXfdjpLjX0cdyZBahDVweUMFpNrc7LIcFzsFVclkiJcq6cEV0LMXXZP3Rmbb5NxTvE
         FrZw==
X-Gm-Message-State: AHQUAuYiEZbg3CTvdZjPsmGCgu4TcFik4eG0Joc/g0+aZq86KY3c1gcM
        rYhm5V5Nu/Vu74+iEi0c7m0xvQ==
X-Google-Smtp-Source: AHgI3IargbZi1/A5JuoN7T/ESWge2VONzHkcZdXZ0FTCtn7d0m6y9B7OTuCHEias7CyW7hVJ2j2WLA==
X-Received: by 2002:aa7:8714:: with SMTP id b20mr2217900pfo.214.1549515425214;
        Wed, 06 Feb 2019 20:57:05 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id o8sm12632224pfa.42.2019.02.06.20.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 20:57:03 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:27:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, quentin.perret@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: imx6q: Register an Energy Model
Message-ID: <20190207045701.uckm5uvxqhyfgjld@vireshk-i7>
References: <20190207043420.3838-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207043420.3838-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-19, 23:34, Yangtao Li wrote:
> Try and register an Energy Model from imx6q-cpufreq to allow
> interested subsystems like the task scheduler to use the provided
> information.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 9fedf627e000..73bfd5bc3087 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -210,6 +210,7 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->clk = clks[ARM].clk;
>  	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
>  	policy->suspend_freq = max_freq;
> +	dev_pm_opp_of_register_em(policy->cpus);
>  
>  	return ret;
>  }

Applied both. Thanks.

-- 
viresh
