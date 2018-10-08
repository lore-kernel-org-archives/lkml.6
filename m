Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2E6C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670FA2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiQwL1y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670FA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeJHNZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:25:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36380 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeJHNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:25:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so6413759plt.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7AczjVSBVXSfEJRlIkztormd1ae1gicGeDFVPgGKZ4=;
        b=LiQwL1y5V1/Ak5IjFLIL11umx0chjxgE6uZ0Ui+HQh651IM63NBEDNiSqIop3ECX9N
         2PlywzNreqPmYHBppsqG8p9ZoIERlKsTHc53lyMzOFOWeobxDFPFfoulR9YGc9HD5y1X
         /MWUm83fWxWrqHhGnIoPi4vMwK2cNLeNnunUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7AczjVSBVXSfEJRlIkztormd1ae1gicGeDFVPgGKZ4=;
        b=OaanvsxahfLpyKO6Zl5hkDW6l1H5OUp7v3sFIkHtLdHs7br9M6TtbQasR1uDkZ1rFu
         FFwIH/Nuy1IfdogSZYkB0n1TIf2lUjMl9r8ifQltFL6TUsLf9kUw2RqIvVqmCa6eQKsY
         ulJEQpDMcN7z0DidYXOEF51UGTRdNyNDyhs7o7lLR6U0jPVSx/9dhJzeq3kgomA3hdmc
         /VbtLAskO7Rg7+Wy64LrJeMVUzLVg1jQyHiVMm2ylKWCCWQ/885nHiIjD+vofmHlw+HU
         WRZ534ue0e7DLcTi/1goWpUL2ZjlaIJlfPpiSYxvOSBaPi7i2siJa5nBHWGjWNwhbh4e
         HLoQ==
X-Gm-Message-State: ABuFfogE2t1RBQlVPdmkHjU9UlnzrVafH1vxhth5QlQKAziUgW+CPUWv
        26MSdztJ1aU+KZY1L1zFVL0KjA==
X-Google-Smtp-Source: ACcGV6153UBKdp8p7YO3jok9gcuBqJLBBlsROvKpVsOJsnZkNlFk+mTUW6dyI5UMJKCcVShD/2E3xQ==
X-Received: by 2002:a17:902:8606:: with SMTP id f6-v6mr22494593plo.271.1538979310957;
        Sun, 07 Oct 2018 23:15:10 -0700 (PDT)
Received: from localhost ([122.172.112.137])
        by smtp.gmail.com with ESMTPSA id i21-v6sm25977031pgj.55.2018.10.07.23.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 23:15:10 -0700 (PDT)
Date:   Mon, 8 Oct 2018 11:45:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V4] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Message-ID: <20181008061508.m3u7acg2q76jljay@vireshk-i7>
References: <1538978854-9678-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538978854-9678-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-18, 14:07, Anson Huang wrote:
> On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because
> the ocotp clock needs to be enabled first. Add support for reading
> OCOTP through the nvmem API, and keep the old method there to
> support old dtb.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V3:
> 	put node earlier to save one line code.
>  drivers/cpufreq/imx6q-cpufreq.c | 52 +++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index b2ff423..8cfee0a 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -12,6 +12,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/pm_opp.h>
> @@ -290,20 +291,32 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
>  #define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
>  #define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
>  
> -static void imx6ul_opp_check_speed_grading(struct device *dev)
> +static int imx6ul_opp_check_speed_grading(struct device *dev)
>  {
> -	struct device_node *np;
> -	void __iomem *base;
>  	u32 val;
> +	int ret = 0;
>  
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> -	if (!np)
> -		return;
> +	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
> +		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
> +		if (ret)
> +			return ret;
> +	} else {
> +		struct device_node *np;
> +		void __iomem *base;
> +
> +		np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> +		if (!np)
> +			return -ENOENT;
> +
> +		base = of_iomap(np, 0);
> +		of_node_put(np);
> +		if (!base) {
> +			dev_err(dev, "failed to map ocotp\n");
> +			return -EFAULT;
> +		}
>  
> -	base = of_iomap(np, 0);
> -	if (!base) {
> -		dev_err(dev, "failed to map ocotp\n");
> -		goto put_node;
> +		val = readl_relaxed(base + OCOTP_CFG3);
> +		iounmap(base);
>  	}
>  
>  	/*
> @@ -314,7 +327,6 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
>  	 * 2b'11: 900000000Hz on i.MX6ULL only;
>  	 * We need to set the max speed of ARM according to fuse map.
>  	 */
> -	val = readl_relaxed(base + OCOTP_CFG3);
>  	val >>= OCOTP_CFG3_SPEED_SHIFT;
>  	val &= 0x3;
>  
> @@ -334,9 +346,7 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
>  				dev_warn(dev, "failed to disable 900MHz OPP\n");
>  	}
>  
> -	iounmap(base);
> -put_node:
> -	of_node_put(np);
> +	return ret;
>  }
>  
>  static int imx6q_cpufreq_probe(struct platform_device *pdev)
> @@ -394,10 +404,18 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	}
>  
>  	if (of_machine_is_compatible("fsl,imx6ul") ||
> -	    of_machine_is_compatible("fsl,imx6ull"))
> -		imx6ul_opp_check_speed_grading(cpu_dev);
> -	else
> +	    of_machine_is_compatible("fsl,imx6ull")) {
> +		ret = imx6ul_opp_check_speed_grading(cpu_dev);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +		if (ret) {
> +			dev_err(cpu_dev, "failed to read ocotp: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	} else {
>  		imx6q_opp_check_speed_grading(cpu_dev);
> +	}
>  
>  	/* Because we have added the OPPs here, we must free them */
>  	free_opp = true;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
