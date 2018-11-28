Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8EEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5515920832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wshh2HqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5515920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeK1UIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:08:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37361 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeK1UIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:08:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so25450661wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+r5YBJKegb/atC64RdZ0cK/TN2Rbadx6BPLfCojvL4U=;
        b=Wshh2HqNU6dil4pE1RYcQP/1jPdDeu1IyT2Ka47LSDl8dDaE2rHNX5iCe99gNxkzuP
         1nG615niccR+stjNvfX3H0QXBEOsbAA3sMXL/WezctYnOaUw3CBmHnD8eJUTsaFuL50n
         Rs7SIYJlGg03IecxRRKkKkQW9AR7OY4yTzixk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+r5YBJKegb/atC64RdZ0cK/TN2Rbadx6BPLfCojvL4U=;
        b=ocLpkQYOD6p5GYbS1yR7e1UqC8d4/huJfiBN1nxrfOVVeDApaN6uEd/wYSd5OhmQHp
         FrLN08xhD0gql2nLGShWoVbi9oQYKRawumcolxNC+YdcW9nUMPoYZNpQq9klQFe96GYu
         tamM1JYqqgcwuSnOWmY/8VMd4ZRoZKLEQU+GPHpIpC5i23qRYD08+QiYwmgG59dQVRI2
         7nLTQ5zsbSV6GW2eUzg2z7s6/tEiyPRYAo+RVeo9VABQN/2t1II10UII2nZcQmVc4mUc
         ECrgUQrDLBBfKVtchUXy308DAIN9jjOsE1qBVg2qNxFjwv/dckefF9SNJlyKhNvnWMzz
         abQQ==
X-Gm-Message-State: AA+aEWYadRtZy7AE5RVpO6MFJ7P1MkAKfL3vMQ3c9y1cVE3ay3FzDPVK
        OMsdPXBZjtDbRczAbeTTrfG/dg==
X-Google-Smtp-Source: AFSGD/XYdP4y6lF+ab4ajxkVOLmvAezb/d5DJ7GJ+sw4oPR6517ekrVHfGQREnYFqvznLjlY3PNWxg==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr32101772wrq.182.1543396049137;
        Wed, 28 Nov 2018 01:07:29 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id 125sm1446808wml.35.2018.11.28.01.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:07:28 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:07:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: ti_am335x_tscadc: Provide unique name for child
 mfd cells
Message-ID: <20181128090726.GS4272@dell>
References: <20181119064236.28902-1-vigneshr@ti.com>
 <20181119064236.28902-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119064236.28902-2-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Vignesh R wrote:

> Provide unique names for child mfd cells, this is required in order to
> support registering of multiple instances of same ti_am335x_tscadc IP.

I don't think it is.  What is the error you are receiving?

> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index c2d47d78705b..ee08af34f81d 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -248,7 +248,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (tsc_wires > 0) {
>  		tscadc->tsc_cell = tscadc->used_cells;
>  		cell = &tscadc->cells[tscadc->used_cells++];
> -		cell->name = "TI-am335x-tsc";
> +		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
> +					    dev_name(&pdev->dev), "tsc");
>  		cell->of_compatible = "ti,am3359-tsc";
>  		cell->platform_data = &tscadc;
>  		cell->pdata_size = sizeof(tscadc);
> @@ -258,7 +259,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (adc_channels > 0) {
>  		tscadc->adc_cell = tscadc->used_cells;
>  		cell = &tscadc->cells[tscadc->used_cells++];
> -		cell->name = "TI-am335x-adc";
> +		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
> +					    dev_name(&pdev->dev), "adc");
>  		cell->of_compatible = "ti,am3359-adc";
>  		cell->platform_data = &tscadc;
>  		cell->pdata_size = sizeof(tscadc);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
