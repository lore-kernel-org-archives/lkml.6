Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1126EC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5D320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MmbLcFJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5D320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbeGZAJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:09:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46648 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbeGZAJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:09:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so6220749pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wDKjzkPhtv3Vsj1tPZsn2Uyr1PgRiq2fnKr5O1DV66M=;
        b=MmbLcFJSKLSqZI//VZ4SvYyInO3YjTdNHivqBdZ+uvrRfbhsCJ7xXPr2EzBTSq7Pij
         /WviGG4HQKB9fbfZZUREjgXy9uAtaBfprSQQ05puWZKaW4/l9oYHAmOoOkWUnUWUS4HA
         B5uR1xJtrnmlC0i3Qa4rA0IuEItBQZmti1Q0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wDKjzkPhtv3Vsj1tPZsn2Uyr1PgRiq2fnKr5O1DV66M=;
        b=fB8WL150UR0VklHkiuGkowVSgLb5lPcHWGkiiwiFJ+kLGfSs8+oxzi6eLgYoHQrRsI
         BBQfraM6YPNeCEITIzN2NFCsN+vyVxjdcmHmHX6L2lJeYw4tRihS1oIh+qerb1mMq3iX
         8eqoo6tEtufrgFn31Zv17hQSyZccqCbLXOScVAqyvpO1+hLekX6O6p0Wa7ENFe2h86Rm
         KJMo2zKX5DjKlKiBOTp/bBQ+/AQcj5z3sbjwtAFf8EUH9AojRgHonqwXq/0YEV81Wa+3
         RWWrj5fqLvmi8MiHK+GK+Mr80SRsNXRx/PBNgZMoAgBkaNczSmKBtssVNpw3YwPj/iBa
         4n6g==
X-Gm-Message-State: AOUpUlHwxvgXjFyfSCddzb2bHaMn9dEpqla5KGhvuuouCYyxBL22G+ox
        T0vulo1Ap92vSpPbDoF0bGABvw==
X-Google-Smtp-Source: AAOMgpfeg6V6uUDSdn91iCSyOJSWmAJYOIIXpzgeVdohR8dYf4o4VmxJQr4d8GzFpeoUTai3/7qeUQ==
X-Received: by 2002:a62:d41a:: with SMTP id a26-v6mr403437pfh.142.1532559366620;
        Wed, 25 Jul 2018 15:56:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23091463pfq.81.2018.07.25.15.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 15:56:06 -0700 (PDT)
Date:   Wed, 25 Jul 2018 15:56:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/3] thermal: tsens: switch from of_iomap() to
 devm_ioremap_resource()
Message-ID: <20180725225605.GS129942@google.com>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
 <4dd9f01c2b5d6988c5329062c25ae61747b42a32.1531898088.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dd9f01c2b5d6988c5329062c25ae61747b42a32.1531898088.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:55:02PM +0530, Amit Kucheria wrote:
> devm_ioremap_resources() automatically requests resources (so that the I/O
> region shows up in /proc/iomem) and devm_ wrappers do better error handling
> and unmapping of the I/O region when needed.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 25e7f24..6207d8d 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -127,13 +127,11 @@ static const struct regmap_config tsens_config = {
>  int __init init_common(struct tsens_device *tmdev)
>  {
>  	void __iomem *base;
> +	struct resource *res;
>  	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>  
>  	if (!op)
>  		return -EINVAL;
> -	base = of_iomap(tmdev->dev->of_node, 0);
> -	if (!base)
> -		return -EINVAL;
>  
>  	/* The driver only uses the TM register address space for now */
>  	if (op->num_resources > 1) {
> @@ -143,11 +141,14 @@ int __init init_common(struct tsens_device *tmdev)
>  		tmdev->tm_offset = 0x1000;
>  	}
>  
> +	res = platform_get_resource(op, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&op->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
>  	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
> -	if (IS_ERR(tmdev->map)) {
> -		iounmap(base);
> +	if (IS_ERR(tmdev->map))
>  		return PTR_ERR(tmdev->map);
> -	}
>  
>  	return 0;
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
