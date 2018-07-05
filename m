Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F0DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F432415C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbYjnZLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F432415C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeGEJYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:24:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37048 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeGEJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:24:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so9696485wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hxIVPUk/G7gh7fgpXN2LImPuenhH1GJDNf5DJFkP3lA=;
        b=NbYjnZLdas0QuHZYMt4IsCqkYBnZ7hj5vJHlgtO0JtxTsCJ4KeVuf3CksmZ0bN68XD
         96CqhxiQPFq7yZKjdjyxd4XSHxOzLB3hgYYgmHlWGahP1jTKVgagGWvSBPgtvzCoF23U
         utCNwJ2PUKcH5KO/kizS/KK/xFOrnun6gkHb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hxIVPUk/G7gh7fgpXN2LImPuenhH1GJDNf5DJFkP3lA=;
        b=gwuaWaJnbp7wKVzOYOVSsI5EFycXbrpcBTki5lFvwpgWgTw4x2kVASXSVCF9EaCzmx
         /Hdbpyrm4yWDtbR3BB3Grs5W35n/lAlKMNy1P4QMboFuZzZOYbP8DwiLHTfdvjUUnEBL
         K/rz4oIexCYIW6GWidTiW9NWSnktNX5onBvkVxRhPIZ5DRBqkxLId9V80MglFlqi0lkV
         3KE0e69ajOzAsuepYqVQ9mnfWEiGMHLQ17sNzSnwvwsys1bF2rqPt67+Fj6ip+FqA3/i
         QeCWraC56qre9Qd4F9YaOdx7tcV3mgHezKlRvfnWuOVzL0BXJFDo+2vkbYAHkoi6VXFI
         Xblw==
X-Gm-Message-State: APt69E0SQ9z+E5D9GiL7JzTVvZY6TV9ONs4HuhAukRu/CLVpxQVyh7IN
        raiV48SyUDDwp90SIWq50oqSBw==
X-Google-Smtp-Source: AAOMgpcEjGWib6Sr4xhU4Vt1O8JRvPCPH9fslnXeLvDMFAh6yKOAGENGNBk8MI9tfJGfVtIkBav+Fg==
X-Received: by 2002:adf:a86a:: with SMTP id l97-v6mr4036748wrc.164.1530782687581;
        Thu, 05 Jul 2018 02:24:47 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id u7-v6sm11548864wmd.3.2018.07.05.02.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 02:24:46 -0700 (PDT)
Date:   Thu, 5 Jul 2018 10:24:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org,
        chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v9 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180705092444.GL496@dell>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Matti Vaittinen wrote:

> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> new file mode 100644
> index 000000000000..67f2616288d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> @@ -0,0 +1,67 @@
> +* ROHM BD71837 Power Management Integrated Circuit bindings
> +
> +BD71837MWV is a programmable Power Management IC for powering single-core,
> +dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for

Nit: s/SOC's/SOCs/

> +low BOM cost and compact solution footprint. It integrates 8 Buck
> +egulators and 7 LDO’s to provide all the power rails required by the SoC and

Nit: s/LDO's/LDOs/

> +the commonly used peripherals.
> +
> +Datasheet for PMIC is available at:
> +https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
> +
> +Required properties:
> + - compatible		: Should be "rohm,bd71837".
> + - reg			: I2C slave address.
> + - interrupt-parent	: Phandle to the parent interrupt controller.
> + - interrupts		: The interrupt line the device is connected to.
> + - clocks		: The parent clock connected to PMIC. If this is missng

s/missng/missing/

> +			  32768 KHz clock is assumed.
> + - #clock-cells		: Should be 0
> + - regulators:		: List of child nodes that specify the regulators

By your convention, the bottom two entries are missing '.'s.

> +			  Please see ../regulator/rohm,bd71837-regulator.txt
> +
> +Optional properties:
> +- clock-output-names	: Should contain name for output clock.
> +
> +Example:
> +
> +	/* external oscillator node */

Uppercase character to start a sentence.

> +	osc: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <1>;
> +		clock-frequency  = <32768>;
> +		clock-output-names = "osc";
> +	};
> +
> +	/* PMIC node */

Is this comment really necessary?  The node is called "pmic".

> +	pmic: pmic@4b {
> +		compatible = "rohm,bd71837";
> +		reg = <0x4b>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <29 GPIO_ACTIVE_LOW>;
> +		interrupt-names = "irq";
> +		#clock-cells = <0>;
> +		clocks = <&osc 0>;
> +		clock-output-names = "bd71837-32k-out";
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "buck1";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +			/* ... */
> +		};
> +	};
> +
> +	/* Clock consumer node */
> +
> +	foo@0 {
> +		compatible = "bar,foo";
> +		/* ... */

No need for this line.  Additional properties are always expected.

> +		clock-names = "my-clock";
> +		clocks = <&pmic>;
> +	};

Do you have a real example to give?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
