Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214DDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE93620657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0vxKmtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfAOA2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:28:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38266 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbfAOA2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:28:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so415893pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j3hVL4M/AT6Mpd1VsVr9ey74dDgcQmy4fKF9Id9biOA=;
        b=e0vxKmtpx9W8jgs4ER6sUNXY2sFU4KNWksBenPoTtQp8F0fJ2holTfVwBG/jICBBOq
         qAXqfYk9r67NRcAcut81qI4r6tT2KeYSxpxX5U0eIscle081uuTULb4xTnKcpC9NmTii
         7xEQR5JreTfUzM+EOZpWZzQAfHlGNltbJqhGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j3hVL4M/AT6Mpd1VsVr9ey74dDgcQmy4fKF9Id9biOA=;
        b=EOO/0fjCOKfOUfUP54H/XJnj9tnIja4oj8OzPYMg0o3eHSQYJMdOsRJZZdSRjhvwHN
         o6atke/tEi9pJoIHLQnzkpqeBk4O46xRWE2fbllDLoIHpP4pTQZqAP/bWzwsR33OMuZV
         87HLQrNY9rolsX2hYh86OFu8pZ7RXCjD+8Ocj8GehbwBwUIwAeCuY1j6SN+oWsIi+a+J
         7ImWuiA+ASoXsVhCdjrupnOnlaUkMa2Ayik0db+tiazs2FGYSSfYUBJtf3jfeXtVePSo
         5d9fjS7i65+F5hSmvxgnj+VdrUYkMa0sVpnt9hCsPyzVBik8j62uYMqo0GJEyK2tmE7p
         AaZQ==
X-Gm-Message-State: AJcUukcVag/ugC0GeDNc61bXZM6IReoignA64RkfjIEJm/R48c8O2Eqy
        CtgAWCgsfMi1qFM6TzaxCmmUtA==
X-Google-Smtp-Source: ALg8bN6AeuPnIvstQS6lCAkeAiT5klQUb821pPOsU5Kon4Rpz1ydkc1GbtMQ8LiGxbjZVJ6PXCp3ig==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr1141741pfb.55.1547512122218;
        Mon, 14 Jan 2019 16:28:42 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j21sm1751907pfn.175.2019.01.14.16.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:28:41 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:28:39 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 02/14] pinctrl: qcom: spmi-gpio: add support for three
 new variants
Message-ID: <20190115002839.GI9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-3-masneyb@onstation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 Jan 07:47 PST 2019, Brian Masney wrote:

> Add support for qcom,pm8005-gpio, qcom,pm8998-gpio, and
> qcom,pmi8998-gpio. These three variants are already in use in some
> arm64 dtsi files. Those boards work since the generic binding
> qcom,spmi-gpio is also specified.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> This is a new patch introduced in V4.
> 
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index 4458d44dfcf6..5f2977982ef1 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -1063,10 +1063,13 @@ static int pmic_gpio_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id pmic_gpio_of_match[] = {
> +	{ .compatible = "qcom,pm8005-gpio" },	/* 4 GPIO's */
>  	{ .compatible = "qcom,pm8916-gpio" },	/* 4 GPIO's */
>  	{ .compatible = "qcom,pm8941-gpio" },	/* 36 GPIO's */
>  	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
>  	{ .compatible = "qcom,pmi8994-gpio" },  /* 10 GPIO's */
> +	{ .compatible = "qcom,pm8998-gpio" },	/* 26 GPIO's */
> +	{ .compatible = "qcom,pmi8998-gpio" },	/* 14 GPIO's */
>  	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
>  	{ .compatible = "qcom,pms405-gpio" },	/* 12 GPIO's, holes on 1 9 10 */
>  	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
> -- 
> 2.17.2
> 
