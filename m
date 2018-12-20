Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8663EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E47E21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8oGAKky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbeLTNLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:11:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56160 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731948AbeLTNLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:11:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so1954781wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ig7wGYUNzjsLT7kF425ff0qq/YN+nkbjFy7aNFOFU58=;
        b=J8oGAKkyLJWDIDvWEzlXaHy4TtAUTdn3ZbncMuoLL6UkSUjL90GyQ3NapOVpJtUDSL
         cXFiaUtzJeB1sRz9fbh3cnv6YvzDOV8QUvI44pWOk6TqNvcsOK3q2gwobD0OAYEKNzZ5
         meJVNQLiL9az6wIDMvMak6mch4w/0htRu2Zr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ig7wGYUNzjsLT7kF425ff0qq/YN+nkbjFy7aNFOFU58=;
        b=aLP/CaqT1v7ybErjnM0nR6O2btXiIGaMg5ykdvm5U2thx3ybpTFDlpKoMK2tjKyqSa
         DAe/cM+wZ9pchF41NRLNvgMi/PUFPVWtyYomwKK7wzROq5qn7xA6L3Qik9ANkEjo9n4a
         I0+oHkatNvqdOPaGotmyP+fSIhFNQzBA3u1dAn6SQ9zI2CzSd+5e30DEY39EIzfRNSxw
         cKxIUmUTWaxA2ox9zYB2erCRnQF+AolvS82xXBTp97BBUMSdubCJKpYsASIDPqxsHu9Z
         x8XuxzLgOqwyJyJerwhxuBp1kV2eyi4oIkIJhaLQe+1QCW7giBuSu9zBGgWgGKPsykvA
         5/kA==
X-Gm-Message-State: AA+aEWbMjKpiaihNlRLNHQjo2+MEJU82WrGgv/uBzb2p7pNl8HwEQGdq
        H9LiKS2kKAoRhSysQu2qVRHoGtj8Sdo=
X-Google-Smtp-Source: AFSGD/XUf3arFVOnOwe5ZBcV2T9oh2ze8OHXHCVm/oeGeOL5IyLuhobkfIsFqo/skIyuhceOxw5A4g==
X-Received: by 2002:a1c:70b:: with SMTP id 11mr11924728wmh.74.1545311463087;
        Thu, 20 Dec 2018 05:11:03 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
        by smtp.googlemail.com with ESMTPSA id y8sm9874493wmg.13.2018.12.20.05.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:11:02 -0800 (PST)
Subject: Re: [PATCH v10 15/27] drivers: firmware: psci: Announce support for
 OS initiated suspend mode
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-16-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b333c9db-9ef0-cdba-093e-6735a23ec5f6@linaro.org>
Date:   Thu, 20 Dec 2018 14:11:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-16-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> PSCI firmware v1.0+, supports two different modes for CPU_SUSPEND. The
> Platform Coordinated mode, which is the default and mandatory mode, while
> support for the OS initiated mode is optional.
> 
> This change introduces initial support for the OS initiated mode, in way
> that it adds the related PSCI bits from the spec and prints a message in
> the log to inform whether the mode is supported by the PSCI FW.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changes in v10:
> 	- None.
> 
> ---
>  drivers/firmware/psci/psci.c | 21 ++++++++++++++++++++-
>  include/uapi/linux/psci.h    |  5 +++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 6bfa47cbd174..4f0cbc95e41b 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -95,6 +95,11 @@ static inline bool psci_has_ext_power_state(void)
>  				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
>  }
>  
> +static inline bool psci_has_osi_support(void)
> +{
> +	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
> +}
> +
>  static inline bool psci_power_state_loses_context(u32 state)
>  {
>  	const u32 mask = psci_has_ext_power_state() ?
> @@ -659,10 +664,24 @@ static int __init psci_0_1_init(struct device_node *np)
>  	return 0;
>  }
>  
> +static int __init psci_1_0_init(struct device_node *np)
> +{
> +	int err;
> +
> +	err = psci_0_2_init(np);
> +	if (err)
> +		return err;
> +
> +	if (psci_has_osi_support())
> +		pr_info("OSI mode supported.\n");
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id psci_of_match[] __initconst = {
>  	{ .compatible = "arm,psci",	.data = psci_0_1_init},
>  	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
> -	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
> +	{ .compatible = "arm,psci-1.0",	.data = psci_1_0_init},
>  	{},
>  };
>  
> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> index b3bcabe380da..581f72085c33 100644
> --- a/include/uapi/linux/psci.h
> +++ b/include/uapi/linux/psci.h
> @@ -49,6 +49,7 @@
>  
>  #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
>  #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
> +#define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
>  
>  #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
>  
> @@ -97,6 +98,10 @@
>  #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
>  			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
>  
> +#define PSCI_1_0_OS_INITIATED			BIT(0)
> +#define PSCI_1_0_SUSPEND_MODE_PC		0
> +#define PSCI_1_0_SUSPEND_MODE_OSI		1
> +
>  /* PSCI return values (inclusive of all PSCI versions) */
>  #define PSCI_RET_SUCCESS			0
>  #define PSCI_RET_NOT_SUPPORTED			-1
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

