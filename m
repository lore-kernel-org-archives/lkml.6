Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF248C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8154B208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBWTDWHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8154B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeGaGDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:03:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46653 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeGaGDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:03:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so5499533pfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 21:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AunL0iKAhpZEw0ea1JOB1dKrFUg0uZftpw+zyfTg9Cs=;
        b=LBWTDWHetcygB7D8qnyiWYs5YpmmYg5TLbAV+/NruCYOfkYL18ELgI0X0tpQ491lAz
         7R68x84sj4VnUc+Kj8rijJ0V5cAOjkc+jY/FXiQAuvBNuFbbqZmmhmM8szWqGX7OFCGC
         /x8u3ajXHq/TcmknmwLuWMBUI/OQuwXdueTz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AunL0iKAhpZEw0ea1JOB1dKrFUg0uZftpw+zyfTg9Cs=;
        b=iRZ/sjn8EXItKp7Hq6RFNwpN0b13t3DWQPaWzBU/yv/Cku7YwdYQU8yggx3r8gFqpb
         +yp3/AIGlfHIR2zWB/Q775Ggkg3k6J1Im38Ew9ViCvS/3zIVy9c8CPIgo7Dzj+sAOJAQ
         8TtOd9XmNda6svdM8EXHiPRMmPVnGcvnWc1INtuuvclBHB7en23D4eYZW6qR4wKixenC
         jq69zPDe/hVsXPNs9DYkZpJTmMHCofWRSHglMNG3swL+Yvczb3IdPBXWyJzLabpfAmZC
         FpjB2oEiX/mCtZbVbxC54sjyjc8+iEcwdP6wi+g5jvQrCQp0CprJSt2ZeYmkrTEj/iLk
         EllA==
X-Gm-Message-State: AOUpUlFCE2lRaQbCSj3Mzfys0MKTDUu7dZAFoP0CQMEuBOfxA0DiwVCv
        yTNy0s19bdXj5+91SWmJ4qze6A==
X-Google-Smtp-Source: AAOMgpc07AjFAxE546klA8KeqPacbO+fkRmNVrEVcqSuM4vjZw4mp/cQh/LNSdG8/k71yVIxvjbRKA==
X-Received: by 2002:a63:ff4d:: with SMTP id s13-v6mr18896969pgk.150.1533011091582;
        Mon, 30 Jul 2018 21:24:51 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h7-v6sm22307827pfd.155.2018.07.30.21.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 21:24:50 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:25:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 1/4] remoteproc/davinci: use the reset framework
Message-ID: <20180731042539.GE5090@builder>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <20180621073706.22812-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621073706.22812-2-brgl@bgdev.pl>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Jun 00:37 PDT 2018, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Switch to using the reset framework instead of handcoded reset routines
> we used so far.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 34 +++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index b668e32996e2..76c06b70a1c6 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -20,8 +21,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  
> -#include <mach/clock.h>   /* for davinci_clk_reset_assert/deassert() */
> -
>  #include "remoteproc_internal.h"
>  
>  static char *da8xx_fw_name;
> @@ -72,6 +71,7 @@ struct da8xx_rproc {
>  	struct da8xx_rproc_mem *mem;
>  	int num_mems;
>  	struct clk *dsp_clk;
> +	struct reset_control *dsp_reset;
>  	void (*ack_fxn)(struct irq_data *data);
>  	struct irq_data *irq_data;
>  	void __iomem *chipsig;
> @@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  	struct device *dev = rproc->dev.parent;
>  	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>  	struct clk *dsp_clk = drproc->dsp_clk;
> +	struct reset_control *dsp_reset = drproc->dsp_reset;
>  	int ret;
>  
>  	/* hw requires the start (boot) address be on 1KB boundary */
> @@ -155,7 +156,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  		return ret;
>  	}
>  
> -	davinci_clk_reset_deassert(dsp_clk);
> +	ret = reset_control_deassert(dsp_reset);
> +	if (ret) {
> +		dev_err(dev, "reset_control_deassert() failed: %d\n", ret);
> +		clk_disable_unprepare(dsp_clk);
> +		return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -163,8 +169,15 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  static int da8xx_rproc_stop(struct rproc *rproc)
>  {
>  	struct da8xx_rproc *drproc = rproc->priv;
> +	struct device *dev = rproc->dev.parent;
> +	int ret;
> +
> +	ret = reset_control_assert(drproc->dsp_reset);
> +	if (ret) {
> +		dev_err(dev, "reset_control_assert() failed: %d\n", ret);
> +		return ret;
> +	}
>  
> -	davinci_clk_reset_assert(drproc->dsp_clk);
>  	clk_disable_unprepare(drproc->dsp_clk);
>  
>  	return 0;
> @@ -232,6 +245,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	struct resource *bootreg_res;
>  	struct resource *chipsig_res;
>  	struct clk *dsp_clk;
> +	struct reset_control *dsp_reset;
>  	void __iomem *chipsig;
>  	void __iomem *bootreg;
>  	int irq;
> @@ -268,6 +282,15 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  		return PTR_ERR(dsp_clk);
>  	}
>  
> +	dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(dsp_reset)) {
> +		if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
> +			dev_err(dev, "unable to get reset control: %ld\n",
> +				PTR_ERR(dsp_reset));
> +
> +		return PTR_ERR(dsp_reset);
> +	}
> +
>  	if (dev->of_node) {
>  		ret = of_reserved_mem_device_init(dev);
>  		if (ret) {
> @@ -287,6 +310,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	drproc = rproc->priv;
>  	drproc->rproc = rproc;
>  	drproc->dsp_clk = dsp_clk;
> +	drproc->dsp_reset = dsp_reset;
>  	rproc->has_iommu = false;
>  
>  	ret = da8xx_rproc_get_internal_memories(pdev, drproc);
> @@ -309,7 +333,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
>  	 * held in reset at the time it is called.
>  	 */
> -	ret = davinci_clk_reset_assert(drproc->dsp_clk);
> +	ret = reset_control_assert(dsp_reset);
>  	if (ret)
>  		goto free_rproc;
>  
> -- 
> 2.17.1
> 
