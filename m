Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6A7C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A124213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDd49rhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A124213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeKTTMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:12:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42786 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTTMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:12:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so995333wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PrIlS5D2wUH5fhEtEQIrgjBmdxc+FdiMgJGK01G0FZM=;
        b=XDd49rhTEk1fL7Fe5MNcwjxtHRkFZ8Vqnp0Sc1CDffeirDS9yRfviyvg7CiGbexLAj
         ByA0wt7l1cgKYb2f6gQpzQygtWUTXXU/BosPT59AI7aJdfqMkzJ6swSuWASUncxYc4In
         n1xO5p/5DIsTTNoX/j+/j+DQYCRHxUUMz1Lh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PrIlS5D2wUH5fhEtEQIrgjBmdxc+FdiMgJGK01G0FZM=;
        b=bxn+2MxwErxKYzpHisQoNFUMbf9S5r4lSfMGdgzDnr+LYiF2BNJHpCcoDaaMhMAwMH
         F4T2ybUZ0I9cuw7FPIS5BRX/qIXAJLZHvc/lM5WO8ymUeLBtvEnLHApsz5iq2/4H/PgL
         cpTHoPMmHkrMdzzXbSTRocD4hFmDhLQsB6oCqXBiGeDcdcY5g9LnGJZqBzFF0YKIiCwo
         eAXi9Hr7J3YpfZZklwLWuwLjaCn5xxX3L/69VYq3+keI9Cu5TmBTONhddLfDhG9KoQzW
         vGf40uXKuRkCwOqHQ+3G+mzeIWjH1dvy0uMDXW6LnXlvU3ucaM5ScFuPtrZNuIFjwrW6
         h7MA==
X-Gm-Message-State: AA+aEWaEOMZoYvxmvY2Uxez9ubBIX+eHNyLNXnB7GiXmmPaQd9Zcn9qf
        PgeURkehhCyE/5HY94afw2bXvg==
X-Google-Smtp-Source: AFSGD/U/UzTI/sVmsmL7q1PZ/wD+EOLjCOPs0ncQRhfkJQr3qkY1QiM+KJapeVX67S+VFAs5yYxguQ==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr1061902wrq.225.1542703474838;
        Tue, 20 Nov 2018 00:44:34 -0800 (PST)
Received: from [192.168.0.40] (98.242.136.77.rev.sfr.net. [77.136.242.98])
        by smtp.googlemail.com with ESMTPSA id l15sm19507865wrw.4.2018.11.20.00.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 00:44:34 -0800 (PST)
Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <28d501b1-8016-cc1a-3f7c-ac485ab81aa2@linaro.org>
Date:   Tue, 20 Nov 2018 09:44:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2018 08:39, Anson Huang wrote:
> The thermal driver is a standalone driver for monitoring SoC temperature
> by enabling thermal sensor, so it can be enabled even when CONFIG_CPU_FREQ
> is NOT set. So remove the dependency with CPU_THERMAL.
> 
> Add CONFIG_CPU_FREQ check for cpu-freq related operation in thermal
> driver to make thermal driver probe successfully when CONFIG_CPU_FREQ
> is NOT set.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Why not simply kill this legacy code ?



>  drivers/thermal/Kconfig       | 2 +-
>  drivers/thermal/imx_thermal.c | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 1775d44..c8a6352 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -212,7 +212,7 @@ config HISI_THERMAL
>  
>  config IMX_THERMAL
>  	tristate "Temperature sensor driver for Freescale i.MX SoCs"
> -	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
> +	depends on ARCH_MXC || COMPILE_TEST
>  	depends on NVMEM || !NVMEM
>  	depends on MFD_SYSCON
>  	depends on OF
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 1566154..87386d1 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -648,6 +648,7 @@ static const struct of_device_id of_imx_thermal_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>  
> +#ifdef CONFIG_CPU_FREQ
>  /*
>   * Create cooling device in case no #cooling-cells property is available in
>   * CPU node
> @@ -668,6 +669,7 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>  
>  	return 0;
>  }
> +#endif
>  
>  static int imx_thermal_probe(struct platform_device *pdev)
>  {
> @@ -743,6 +745,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
>  		     data->socdata->power_down_mask);
>  
> +#ifdef CONFIG_CPU_FREQ
>  	data->policy = cpufreq_cpu_get(0);
>  	if (!data->policy) {
>  		pr_debug("%s: CPUFreq policy not found\n", __func__);
> @@ -755,6 +758,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  			"failed to register cpufreq cooling device: %d\n", ret);
>  		return ret;
>  	}
> +#endif
>  
>  	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(data->thermal_clk)) {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

