Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D2FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8F720671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdfGxrtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8F720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeGZT7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:59:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38151 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbeGZT7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:59:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so1681763pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yk5e62ysGPUJo7nY3lUkpM1H+ez4pnW8tmDHWTGtWMQ=;
        b=WdfGxrtWzfTHVCzUFnsSBg+y0K+op8YAdyApbgQnzmA7bEfJiiGvffIeEw8t3VEnt8
         UtUKXyYEqeI+rw64JEK5Ff8F1IQxJeO0YuxleM+SrJOokfFgWiPN4gVtNAecpckeIYGM
         d8AHTdtaPEZGPe1AYLyrnUHILhPuV2ILGHkWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yk5e62ysGPUJo7nY3lUkpM1H+ez4pnW8tmDHWTGtWMQ=;
        b=IFlaNeXQF3/NIrN7EKi0AtA3J6tndbnooHOtz4khty9UA1xVlyzRgNHcf8Qw4p8fgT
         N141ityVBD/MplqwswAiTj4UVJrU9xWiPm13Gb0NXzvfcgcgZLUou/bIO3fLtyARARuK
         Ke4jPfqu62D3v6yOlu3CJKfh8RqFa6eJq+7H6jGdQqG2bGBURpGeRPjqdK+dxOHYiNg1
         dySiVQoT4KYn4HWCpVFlOJfNQNrwJ3ItKCvs02mUOZ/gskAlZCmBwrT92S0LQq869IJa
         G8L1IkzKE7c5a0f4wvVyvmBDjJ8GrJmhqG4kE0Hrf+QGhIo+EInGOG+MLxTWdJG5KRNw
         bjaw==
X-Gm-Message-State: AOUpUlF5e/QCLlyot6m+x6O1KjQSBYuqQY/8stee1MrTsIFfyQbhN4bW
        3IxkJY8+AMAo0kxSPI/r9/2I
X-Google-Smtp-Source: AAOMgpcoPnf7WjmjmBZFdWeDUMWwRMN4EJ0sD9Eu1sIbyKHE0HwN6bN3rEZIuo09R9Fyf1na2hRUCw==
X-Received: by 2002:a62:da07:: with SMTP id c7-v6mr3272916pfh.106.1532630458951;
        Thu, 26 Jul 2018 11:40:58 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id h24-v6sm4097947pfk.113.2018.07.26.11.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 11:40:58 -0700 (PDT)
Date:   Fri, 27 Jul 2018 00:10:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
Subject: Re: [PATCH 5/5] arm64: dts: actions: Add pinctrl node for Actions
 Semi S700
Message-ID: <20180726184048.GG5220@Mani-XPS-13-9360>
References: <20180722163601.28346-1-sravanhome@gmail.com>
 <20180722163601.28346-6-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722163601.28346-6-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 22, 2018 at 06:36:01PM +0200, Saravanan Sekar wrote:
> Add pinctrl nodes for Actions Semi S700 SoC
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 59d29e4ca404..88edac21e03f 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -179,5 +179,11 @@
>  			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "timer1";
>  		};
> +
> +		pinctrl: pinctrl@e01b0000 {
> +			compatible = "actions,s700-pinctrl";
> +			reg = <0x0 0xe01b0000 0x0 0x1000>;
> +			clocks = <&cmu CLK_GPIO>;
> +		};

Driver/binding/dts are inconsistent. Driver seems to support pinctrl +
gpio + irq but there is no gpio/irq property in dts patch.

Please correct it.

Thanks,
Mani

>  	};
>  };
> -- 
> 2.18.0
> 
