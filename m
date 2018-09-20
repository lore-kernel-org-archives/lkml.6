Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41945C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7162150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxPfRDvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7162150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbeITHdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:33:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35127 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeITHdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:33:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id 205-v6so2666566pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fdN8Z3bLyJKVphXW3qSQkvA8aPpn/l1r74ra7JPdc8Y=;
        b=BxPfRDvftVZkxdpxe0dug6jOrI9cuE1ruNdVVV9EGxc4WsFvLlMmNJyh1YD/mJ9KNL
         uq77L6budBmco0HDcCudqviAX5auK57B7WG+goEQ0AntQoAwJF+3oWnGZXPFHP8rl0r1
         wJKqjncst8C5z2vfo+TfXqFxD3oFLVhVwtawc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fdN8Z3bLyJKVphXW3qSQkvA8aPpn/l1r74ra7JPdc8Y=;
        b=JVugTArOzlluvuBKygz81p2gY9M8FEZGURHFIhBK/r0eKoLTvKaswEy156gUlvoTw1
         GQD17bLYFZpAImt+FFuaa0xhFdsTmP7Nidxd5uatcsfQUcrYUjUPNxi1ZRC2OFIbF8wu
         21VFRwe+ct9rAuABhsQcZGzv1y/YJOmYepUddpkVP8VfSO6w5GZcnJM6dpWL5FeJ7tfb
         wPXy+7cOqMBRQrlZFHP9+ZizrswFSnlhdIUO0S3pWaVMpUkR7n1i4/lNrUt3iQgT8GBD
         9xkoHuJc1FWTd/AugWNQf+i9GtzxhCYhh9crLn6G73KfKVL943qDlTTbtrtkx254Gk89
         kIWQ==
X-Gm-Message-State: APzg51AqujGvsZcNXr4jXo9ZnQ0D0f8Ii5mAfCWPdATh4XNOkKTK62id
        KPQxx7dyS8yb8ZMWZgF9sqxlmA==
X-Google-Smtp-Source: ANB0VdY6B9/qR1/2TKiax8LKWJ6xFMYi71lhOlwaTvZxYxbxZaWhOxvQSzRdzE4R9YUtGUoM7KxXjQ==
X-Received: by 2002:a63:2d86:: with SMTP id t128-v6mr4341355pgt.128.1537408338299;
        Wed, 19 Sep 2018 18:52:18 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q25-v6sm28783980pfh.113.2018.09.19.18.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 18:52:17 -0700 (PDT)
Date:   Wed, 19 Sep 2018 18:56:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: Add pms405 gpio support
Message-ID: <20180920015627.GB1367@tuxbook-pro>
References: <20180920014705.15144-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920014705.15144-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Sep 18:47 PDT 2018, Bjorn Andersson wrote:

> From: Vinod Koul <vkoul@kernel.org>
> 
> Update the binding and driver for pms405-gpios
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> index ffd4345415f3..ab4000eab07d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> @@ -19,6 +19,7 @@ PMIC's from Qualcomm.
>  		    "qcom,pm8998-gpio"
>  		    "qcom,pma8084-gpio"
>  		    "qcom,pmi8994-gpio"
> +		    "qcom,pms405-gpio"
>  
>  		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
>  		    if the device is on an spmi bus or an ssbi bus respectively
> @@ -91,6 +92,7 @@ to specify in a pin configuration subnode:
>  		    gpio1-gpio26 for pm8998
>  		    gpio1-gpio22 for pma8084
>  		    gpio1-gpio10 for pmi8994
> +		    gpio1-gpio11 for pms405
>  
>  - function:
>  	Usage: required
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index a29efbe08f48..b54891998caa 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -1055,6 +1055,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
>  	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
>  	{ .compatible = "qcom,pmi8994-gpio" },  /* 10 GPIO's */
>  	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
> +	{ .compatible = "qcom,pms405-gpio" }, /* 11 GPIO's */
>  	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
>  	{ },
>  };
> -- 
> 2.18.0
> 
