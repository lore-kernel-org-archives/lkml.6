Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F07ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B79E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B79E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbeGTPfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:35:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50410 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbeGTPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:35:13 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so15017068ita.0;
        Fri, 20 Jul 2018 07:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJm2PFDb6Z/IQNk+y/u4me7y2e5tJwZjkkq6UlMRv8k=;
        b=lz0MN698bfZrKLUX5JLT14/o0vsHfGBNGBfoX6GidxWy3iI/2g/IYLrqFfZ5xXoeja
         eazkSE8jNAMrtmyt9roOYPLBIAOCTiOn5VFDF/ZoeVm0EUoGd2Rvy8gaCHDKkSRdyrtS
         uLOsLZVEq7FTfJrxmmRT7IknFpqgcQgFHzZFfoH+WUiUk9XGS1h1dlTk5ZrAHT1eGNqD
         zc0d18HwxgrNfcM8cq0OYr5hD2mbXnDGwITnTLc9B5krCkaZo+JssdTD5Tz//n02xibQ
         OYrlc2MylCimWvTk1VxRXD5Km4e7qap13V+JNrZPN1SItwSaWIki3mfsAjth43/J4U45
         HK/w==
X-Gm-Message-State: AOUpUlEP7LLJOqyhb3jgKIuD9I7t77fxk5gYzDPxDMAIV0u7/qVwLDWx
        TUwTAUkiAdpy5UfXuWGRAQ==
X-Google-Smtp-Source: AAOMgpdMX4/8KULOssHT7WeeTMoI0frCGsEzOjUto34dIrkNpERMiPgAH1PS+69aMilGM0ZMrUDKJg==
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr2020999itf.121.1532097995762;
        Fri, 20 Jul 2018 07:46:35 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id p134-v6sm1527969ita.20.2018.07.20.07.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 07:46:35 -0700 (PDT)
Date:   Fri, 20 Jul 2018 08:46:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio:adxl372: Add FIFO and interrupts support
Message-ID: <20180720144634.GB25713@rob-hp-laptop>
References: <1531409760-20070-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531409760-20070-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:36:00PM +0300, Stefan Popa wrote:
> This patch adds support for the adxl372 FIFO. In order to accomplish this,
> triggered buffers were used.
> 
> The number of FIFO samples which trigger the watermark interrupt can be
> configured by using the buffer watermark, while the format depends on the
> selected channels.The FIFO data along with the timestamp is pushed to the
> IIO device's buffer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adxl372.txt      |   7 +

This belongs in patch 2. Bindings should reflect the h/w, not driver 
features.

>  drivers/iio/accel/adxl372.c                        | 346 ++++++++++++++++++++-
>  2 files changed, 352 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> index fea4baf..73d7e03 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> @@ -7,10 +7,17 @@ Required properties:
>   - reg: SPI chip select number for the device
>   - spi-max-frequency: Max SPI frequency to use
>  
> +Optional properties:
> + - interrupt-parent: phandle to the parent interrupt controller

Don't need to put this in the binding. 

> + - interrupts: interrupt mapping for GPIO IRQ, it should by configured with
> + 		flag IRQ_TYPE_EDGE_FALLING
> +
>  Example:
>  
>  	accelerometer@0 {
>  		compatible = "adi,adxl372";
>  		reg = <0>;
>  		spi-max-frequency = <1000000>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>  	};
