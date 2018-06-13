Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B8A4FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC98208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fF3B5D/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC98208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935797AbeFMWx2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:53:28 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46856 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935432AbeFMWxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:53:25 -0400
Received: by mail-pg0-f68.google.com with SMTP id d2-v6so1958931pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=di4sob8CZAEp+h9G6WuBO3mjkXdwCMxHjNoV2I/WLBU=;
        b=fF3B5D/8BEx7HO/BPEyk8LiR39sRlWqDwvEWakqxVelWb8eoAhn6NwCZBL3gVuud2r
         2I5JvM+MPHRtkeATgH3mo3Ch1pGEG8luBXGtY8UX2VujOYFDMj9YAF0N5jV4xAizuuLN
         N/AHo259VUFUAKJJqpub229/NtqzEnuhhq8ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=di4sob8CZAEp+h9G6WuBO3mjkXdwCMxHjNoV2I/WLBU=;
        b=cAugTi3HQCrDZFSAVmU9CPJGk1dRLw+RYnWE5zrK6Sc/yVEVxTCaXPecYnqXW14Jys
         0nE6gVQBVEZ/RrshxNMr81wgHH8mGQfWDbevauJOwX5rATXUYcAjbXqey6PpDWDCtCKM
         GDss3rMcOh/c+N993tu7qlgnkbnbYZ6CA1TrJnbDa7yH3Buuoyg4msb8XiHqTWlY7QSX
         /l6QU/u2n9Q1e/wPqtXox11KvNLZx4esqRi7MD+c9Y9PzvY7wT8JLRG3WoOjMBdAkAhl
         o/wm/QUr9u4b61JJFQgABrJ6KKjQd1IFQ53P9U5EZ8jiiqcbF+wWqnMmKFlb7IQ8KGaT
         xRpA==
X-Gm-Message-State: APt69E23sYwY/WkLThcdpLlDSseEhEAIlmVyMKRg5+quRJqVdUxGYof/
        nn738WrZo/8Poj4HypOgzAxQIoo53L0=
X-Google-Smtp-Source: ADUXVKKAia3h+O8Fzyvb2kG/7ANQL7rrMLD5Bncvm88LUAAh0B1eDFlLWJiuwopRMkTFKgrBu6BXtw==
X-Received: by 2002:a65:4389:: with SMTP id m9-v6mr68534pgp.383.1528930405184;
        Wed, 13 Jun 2018 15:53:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id v85-v6sm8408992pgb.50.2018.06.13.15.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 15:53:24 -0700 (PDT)
Date:   Wed, 13 Jun 2018 15:53:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Message-ID: <20180613225323.GM88063@google.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180613160643.12638-1-ctatlor97@gmail.com>
 <20180613160643.12638-3-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613160643.12638-3-ctatlor97@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry if you receive two variants of this mail, I sent one earlier
today but for some reason it didn't make it to the lists)

On Wed, Jun 13, 2018 at 05:06:24PM +0100, Craig Tatlor wrote:
> Add bindings for the Qualcomm Battery Monitoring system.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
> 
> * Changes from v5:
>   Mentions which values are 8 bit.
> 
> * Changes from v4:
>   Uses proper units and expands some definitions,
>   along with changing vadc@ to adc@.
>  .../bindings/power/supply/qcom_bms.txt        | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> new file mode 100644
> index 000000000000..9a29a2eb9f04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> @@ -0,0 +1,92 @@
> +Qualcomm Battery Monitoring System
> +
> +The Qualcomm Battery Monitoring System is found inside of Qualcomm PM8941
> +PMICs. It provides open circuit voltage (OCV) and coulomb counter registers
> +that allow the OS to infer a capacity level.
> +
> +Required properties:
> +- compatible:                   Should contain "qcom,pm8941-bms".
> +- reg:                          Specifies the SPMI address and length of the
> +				controller's registers.
> +- interrupts:                   OCV threshold interrupt.
> +- io-channels:                  Should contain IIO channel specifier for the
> +				ADC channel that reports battery temperature.
> +- io-channel-names:             Should contain "temp".
> +- qcom,fcc-temp-legend-celcius: An 8 bit array containing the temperature,
> +				in degC, for each column of the full charge
> +				capacity lookup table.

s/celcius/celsius/

same for qcom,ocv-temp-legend-celcius

> +- qcom,fcc-lut-microamp-hours:  An array of full charge capacity values in uah,
> +				one entry for each temperature defined in in

nit: s/uah/uAh/

Thanks

Matthias
