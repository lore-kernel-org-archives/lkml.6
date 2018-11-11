Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CA3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 06:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98BD20892
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 06:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8Rho5hE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98BD20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeKKQgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 11:36:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42520 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeKKQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 11:36:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id x21-v6so74006pln.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 22:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z0Ur9NkCKNnPgwVVxDuIzKPrf87Hta+OxVgfUKJDsQk=;
        b=j8Rho5hEuQcRWTNPx0gSzXNkjA52cC0OEKrnA9YlfRZ2c3KmCn/HPKo02p608HALCQ
         pyEL/bd8nLsB1tT05hwUQYKZJyWpomHhozCIt7BqOKk/J+jw69Q35SesAsPdKJFZV/k+
         qU/9+OPT2F22rb0jKXDQzQi9tW/yQK8AQH3/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z0Ur9NkCKNnPgwVVxDuIzKPrf87Hta+OxVgfUKJDsQk=;
        b=MJXKLsrvER98MC/Xr7ahC8eSncFu0TWH8v/BgCeTlmy/RWTnok3Zv1Q3IFs90LKTWf
         PB+4KtgGLgH/q6IG6j+vnSrjiKnOy/f6FkBWBBMQvtKVySRZi7MFkYKUssCX8/w6tWju
         YY9oOeiqph/mkazmhQ/dL1dE4B+rE4v9lGQNGpb6JJ363g24iBTDBMTsY6YWdr3rrisd
         6lAAadX60rTH8ffFpmILOMsogCtpWF3gGLUeBvNU6RAeSvyGJojAUkXydVumzvuFSzl9
         jDtHTKLoVXagO1RwyvTdaB2iNHBYzfbJITZirZQTbOe188XL4jNVIq+UzL4dfhF9DLS+
         wj1g==
X-Gm-Message-State: AGRZ1gLxaBSXnrT4JuB12Q8y8gzcS/wLGf3ZS2oAO1F6CGFXdGqWLkuq
        Z6CF2pRcMB3WJBXB9BWypEtTr1FvaxU=
X-Google-Smtp-Source: AJdET5e7vvyNQ0lAkEMypAJ8DWUn6ThLyg4d0ZC7f+vC/G/OVuPNQV6H9s5YI5iYWgJLoo4tLoWsjA==
X-Received: by 2002:a17:902:7784:: with SMTP id o4-v6mr15086924pll.292.1541918933589;
        Sat, 10 Nov 2018 22:48:53 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l63-v6sm9626098pfb.75.2018.11.10.22.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:48:52 -0800 (PST)
Date:   Sat, 10 Nov 2018 22:48:50 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: ssbi-gpio: fix gpio-hog related boot
 issues
Message-ID: <20181111064850.GA10088@minitux>
References: <20181111013411.14153-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111013411.14153-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10 Nov 17:34 PST 2018, Brian Masney wrote:

> When attempting to setup up a gpio hog, device probing will repeatedly
> fail with -EPROBE_DEFERED errors. It is caused by a circular dependency
> between the gpio and pinctrl frameworks. If the gpio-ranges property is
> present in device tree, then the gpio framework will handle the gpio pin
> registration and eliminate the circular dependency.
> 
> See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
> gpio-hog related boot issues") for a detailed commit message that
> explains the issue in much more detail. The code comment in this commit
> came from Christian's commit.
> 
> I did not test this change against any hardware supported by this
> particular driver, however I was able to validate this same fix works
> for pinctrl-spmi-gpio.c using a LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> For the patch and discussion regarding pinctrl-spmi-gpio.c, see
> https://lore.kernel.org/lkml/20181101001149.13453-6-masneyb@onstation.org/
> 
>  drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> index 6b30bef829ab..ded7d765af2e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
> @@ -762,12 +762,23 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = gpiochip_add_pin_range(&pctrl->chip,
> -				     dev_name(pctrl->dev),
> -				     0, 0, pctrl->chip.ngpio);
> -	if (ret) {
> -		dev_err(pctrl->dev, "failed to add pin range\n");
> -		goto unregister_gpiochip;
> +	/*
> +	 * For DeviceTree-supported systems, the gpio core checks the
> +	 * pinctrl's device node for the "gpio-ranges" property.
> +	 * If it is present, it takes care of adding the pin ranges
> +	 * for the driver. In this case the driver can skip ahead.
> +	 *
> +	 * In order to remain compatible with older, existing DeviceTree
> +	 * files which don't set the "gpio-ranges" property or systems that
> +	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
> +	 */
> +	if (!of_property_read_bool(pctrl->dev->of_node, "gpio-ranges")) {
> +		ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev),
> +					     0, 0, pctrl->chip.ngpio);
> +		if (ret) {
> +			dev_err(pctrl->dev, "failed to add pin range\n");
> +			goto unregister_gpiochip;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, pctrl);
> -- 
> 2.17.2
> 
