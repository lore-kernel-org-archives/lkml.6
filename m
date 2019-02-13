Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9B5C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B567E222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550090612;
	bh=G5ALqc5roA2rw+38f64kWpi9yReZYaDnrPZizI/E4UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qRlDWzTWLfHCa+GTIM7+F6HHpIRqQkXmK/pqQ1QbxC5imQvT8J/h7+3Ca1gTypNVU
	 /5ECfQ2n+8mKmE4yADGoPCsBQxgbl5Zna6FcBfhnnhjhIlEj3o8Wm3JJei9jQKlzgh
	 f0eV0g/TDbjHYwW52EUgpjhKTEBZia6mMzVDvqWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394629AbfBMUnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:43:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33212 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfBMUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:43:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so6738345otl.0;
        Wed, 13 Feb 2019 12:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aM456OQ5KH4UoJUTxRr5fsQjYGDLTT+2dhzlWlaElJo=;
        b=F2aMRkn58vYvA+DaSVlPkg4DsAvH3iWwWWT3WvH8HFu89+hXVvLYEPqbe0u7vvZU5i
         ELLJpI5UZeRlcAj8SI6yxdkBN+JKybiRioMptPn+Id+pHMBUlvhy3Y7kXJOPpjJz7Zme
         +WjVwvvuSk+6CqlBwyv93yBkKNmryzyTjSXGejPQvrTp7ej79kDq2EKt5C9J+iOF1xIy
         7I87/V+/iDlOFAXqEw6gEbpeqgZVl2vop9nOFPUDow+3PFv5VPI9X68kfeXgy4ffXINk
         V4dxcxUua6wkfXA+4SwGlNDel1XHzwlupwk3eoKiWQVXA/OOerVegpwyBzIhocHrQBr2
         yWZA==
X-Gm-Message-State: AHQUAubF3Te84d0QTC6/7RdsKu0WpAqspTRY9eVJgU2l2ochLGyAMbWS
        Le5BYg8E44qN/Y7pCaCBKw==
X-Google-Smtp-Source: AHgI3IYXk5BNsuI0itl0HuS4FLOO1l3E2AmElQkuJkCsrDQNVD3zjKP8sC4HAFn4iydiE4OP+llTyg==
X-Received: by 2002:aca:2803:: with SMTP id 3mr23579oix.85.1550090609726;
        Wed, 13 Feb 2019 12:43:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w17sm174060otk.12.2019.02.13.12.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 12:43:29 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:43:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 01/11] dt-bindings: mfd: add DT bindings for max77650
Message-ID: <20190213204328.GA26408@bogus>
References: <20190213134335.10838-1-brgl@bgdev.pl>
 <20190213134335.10838-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213134335.10838-2-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:43:25PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a DT binding document for max77650 ultra-low power PMIC. This
> describes the core mfd device and the GPIO module.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
> new file mode 100644
> index 000000000000..0a40e9c6aab8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max77650.txt
> @@ -0,0 +1,47 @@
> +MAX77650 ultra low-power PMIC from Maxim Integrated.
> +
> +Required properties:
> +-------------------
> +- compatible:		Must be "maxim,max77650"
> +- reg:			I2C device address.
> +- interrupts:		The interrupt on the parent the controller is
> +			connected to.
> +- interrupt-parent:	phandle of the parent interrupt controller.

This is implied (and may be in a parent node), so remove it.

> +- interrupt-controller: Marks the device node as an interrupt controller.
> +- #interrupt-cells:	Must be <2>.
> +
> +- gpio-controller : 	Marks the device node as a gpio controller.
> +- #gpio-cells : 	Must be <2>. The first cell is the pin number and

Some space before tabs here.

> +			the second cell is used to specify the gpio active
> +			state.
> +
> +Optional properties:
> +--------------------
> +gpio-line-names:	Single string containing the name of the GPIO line.
> +
> +The GPIO-controller module is represented as part of the top-level PMIC
> +node. The device exposes a single GPIO line.
> +
> +For device-tree bindings of other sub-modules (regulator, power supply,
> +LEDs and onkey) refer to the binding documents under the respective
> +sub-system directories.
> +
> +For more details on GPIO bindings, please refer to the generic GPIO DT
> +binding document <devicetree/bindings/gpio/gpio.txt>.
> +
> +Example:
> +--------
> +
> +	pmic: max77650@48 {

Hopefully some day this will stop.

pmic@48

> +		compatible = "maxim,max77650";
> +		reg = <0x48>;
> +
> +		interrupt-controller;
> +		interrupt-parent = <&gpio2>;
> +		#interrupt-cells = <2>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "max77650-charger";
> +	};
> -- 
> 2.20.1
> 
