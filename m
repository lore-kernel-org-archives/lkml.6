Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DCCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2FA218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8aD/Kvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeLSMLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:11:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35941 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeLSMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:11:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so5899719wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 04:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MJgigoAEMRh0bL7kvRBa2oK6duFi0d/HTVCR+ewvWPY=;
        b=B8aD/Kvm88qVdxu7bJxpA4AspuneOKh8r9RPhZ17P3b0JYxbxLbyJ3D3k5OUkVbn69
         VLudeH0ZKSB8AwyYo/BZ3d9EbyVwhB3dyJLqWI2GOuNZVvNRfS6xgnFv0TJSLtkYcQUi
         3BUnmkKIIMGva2hL5M0J+yuuD6lef/JZv8BOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJgigoAEMRh0bL7kvRBa2oK6duFi0d/HTVCR+ewvWPY=;
        b=Qq8ZjCFoSCY1XwfcIZpyxqqoYERF8sk9X0cKgE7a0kWAPTTxtIsyAXgUzFrqpOErx9
         dubJxebToWXPNu5lUkkXjy5S0UQBIy0UrToJRm9UdXzGU094h+2dSQwJesGBcpesDgZQ
         5cMaNyTWqeSakrJMgPtVBdnUeal+SiAMlqf4bMAA6DLwVDbHW/qK9n3pnI6ND76c7iCU
         Bdw0glHsvrl2p3jadF5fJN5oKDeRgmzjMpWCQTV+1EDMdmhR3qldHx4lWAzjO4gSBIVC
         +X5hbvbYCyA8K1vpE1rl8Woh7IBk960SjSTK5hMjhSeI7C2RWb7iPSzomF01tZUNDOv9
         4Blw==
X-Gm-Message-State: AA+aEWabjwakt5XQzsD+c87O6a4efrJf6fNiT2vz4vqMGeoXZwvJ3MKX
        oGc3wQ8u9mbl+4Roh1ChwqNXtQ==
X-Google-Smtp-Source: AFSGD/WI3XwES6zzsqUn8GajK1G3BL3BuKDgDhDMsBWbvF+jjWkWk890aDsfxgI0Rb/5uxE9HynD/w==
X-Received: by 2002:a1c:aad2:: with SMTP id t201mr6831123wme.148.1545221472026;
        Wed, 19 Dec 2018 04:11:12 -0800 (PST)
Received: from [192.168.0.40] (197.26.136.77.rev.sfr.net. [77.136.26.197])
        by smtp.googlemail.com with ESMTPSA id l19sm5411096wme.21.2018.12.19.04.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 04:11:11 -0800 (PST)
Subject: Re: [PATCH v10 13/27] drivers: firmware: psci: Support hierarchical
 CPU idle states
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-14-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a5c19c01-31d5-f703-663c-3d5bd2ea8201@linaro.org>
Date:   Wed, 19 Dec 2018 13:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-14-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
> 
> Currently CPU's idle states are represented in a flattened model, via the
> "cpu-idle-states" binding from within the CPU's device nodes.
> 
> Support the hierarchical layout, simply by converting to calling the new OF
> helper, of_get_cpu_state_node().
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Fold it with 07/27 ?

> 
> Changes in v10:
> 	- None.
> 
> ---
>  drivers/firmware/psci/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index cbfc936d251c..631e20720a22 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -300,7 +300,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  		return -ENOMEM;
>  
>  	for (i = 0; i < num_state_nodes; i++) {
> -		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		state_node = of_get_cpu_state_node(cpu_node, i);
>  		if (!state_node)
>  			break;
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

