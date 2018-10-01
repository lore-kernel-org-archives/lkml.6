Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E43C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3AA206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iws60QKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3AA206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeJAMdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:33:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34501 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbeJAMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:33:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so8392599pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 22:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BTe0ut8M/73bIDitbXKLPX4PdhLOX2Y10+kntExtAJI=;
        b=iws60QKvAWO92svfA3VQZbsctJql3MvAkoHgTHqrdq6jOgnHi92YfGwgfA38zW2UIz
         y7Sl5/kB/MXviXJ6WP84/ZTlFIbDyDA8wbZ1zzgEhajZkVPteBdSubdMKxUFY+1qD8+i
         ZFyUy/NUjWx6n2KlI4PLeThKFWSvO+MthhUcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BTe0ut8M/73bIDitbXKLPX4PdhLOX2Y10+kntExtAJI=;
        b=m1fd9LVgjkz0TRNsAxbNLnfEx3BE/9D8jKCV8afMGqKJ8GLNgw9NTejghLhVKsl+JN
         ObfHHdu/sMz+NS1M8hHq5bZRpR1lSig51rCY+vX9zS6dHnZHV4g6mtF5I+Mvpj/Fiiqs
         lvo2kyvqagZlXY9RZlu2ZGbRrYDAqjdX9waKgSCQtz81p9vPwrpk6sdvZTsR2mwHBQgz
         UA3MezY+VYpah+eSUMfehFQZIjl/4XDrHCTFWTpHODlzsaaZADZxG2zJ/jRJy/SggfDy
         smYNE8dA7C/+VByj/M+5ZlBOVKKyrREwtXJ8OnshmwadWRGPdpnF1vIEOJPfuk7N2uV4
         WlOw==
X-Gm-Message-State: ABuFfoh1mg+pwzPcZHeLZtL/YBtkmm0KmgjFaev2m171oUJmx0qhVJbn
        bB+Tp/RTfDZapLzT9PEKh5wjoQ==
X-Google-Smtp-Source: ACcGV633RnuJb1h/D2bMsDJI/gHtacK9+69sRU0f0dVwd97/8ys+vu2OgX5GqxXhFp2f9U4+kCHDBw==
X-Received: by 2002:a63:2541:: with SMTP id l62-v6mr8681247pgl.343.1538373467061;
        Sun, 30 Sep 2018 22:57:47 -0700 (PDT)
Received: from localhost ([122.172.136.196])
        by smtp.gmail.com with ESMTPSA id j5-v6sm16101352pff.139.2018.09.30.22.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 22:57:46 -0700 (PDT)
Date:   Mon, 1 Oct 2018 11:27:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/2] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Message-ID: <20181001055744.a3caymeppg3ttayw@vireshk-i7>
References: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
 <1537154264-23252-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537154264-23252-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-09-18, 11:17, Anson Huang wrote:
> On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because
> the ocotp clock needs to be enabled first. Add support for reading
> OCOTP through the nvmem API, and keep the old method there to
> support old dtb.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	add old dtb support.
>  drivers/cpufreq/imx6q-cpufreq.c | 52 +++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index b2ff423..518386c4 100644
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
> +		if (!base) {
> +			dev_err(dev, "failed to map ocotp\n");
> +			of_node_put(np);
> +			return -EFAULT;
> +		}
>  
> -	base = of_iomap(np, 0);
> -	if (!base) {
> -		dev_err(dev, "failed to map ocotp\n");
> -		goto put_node;
> +		val = readl_relaxed(base + OCOTP_CFG3);
> +		iounmap(base);

Don't you need to put the node np here ?

-- 
viresh
