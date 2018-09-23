Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE20C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929D421568
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBM+6vK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929D421568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeIWTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:16:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52256 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:16:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id l7-v6so2316262wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dfW1h1pqIZHfIe/cU3pGNRuBByM2fji2W8AcxuShSgg=;
        b=dBM+6vK45PSZgB7TaX8XL5GtD4zTxVbxrXwwiAaJpUNeoHjR6pf8EVtTEY+5IhoZkz
         WhTsrK4aabXalamirpXMUNtqgwHc2Txm0KGL0psZhLT34RdqdLPA0ato8PCUUhaqq7nm
         xAT9fC2iFdHi39I1ezTVOJu+hZ55uVar3TL0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dfW1h1pqIZHfIe/cU3pGNRuBByM2fji2W8AcxuShSgg=;
        b=RvyX5MyLqTmUiJQ/akPvFY/xDpk+nzZFJh+Q/nIoAZh6wvoA5MDJERV2lh4WdC/0yi
         CSrxKJYxiykhQ3n9mBGfn8vhTH5RtZjBliHhAa4igaAdy3LIV/Ov5f5zUVpnsNKh2pkk
         i9v5bol8kene6d30J85FgIM9pJujzBkbRfIrQXzKqr+4EsI9d5T6mdV0BD+54VkLO10m
         pxqee6DXKsydz9lGhWyZjnfkYUT5GKJXaDBRId41x6h1muaeMg5wWqhfdYpGhXl3nebk
         7QFYKTtjLL6FsWXlOQSIWQTL1MkPuW6P7q2fAAIblp3S93lBA5MKu732lmiNimVych9x
         H/yA==
X-Gm-Message-State: ABuFfogQXIEdfhL+V/n3rYlW91saMmW4XoXBkQyLs3G2Bb4kJUT9ozBf
        7b8tHoUOuUjUZavcSaTfX12z8w==
X-Google-Smtp-Source: ANB0VdYxRmx0bkfqJf0HO5ZF8Hq0vIGA61LMQHiW/9uFaJL8R1Zcg50KWpvH+7Dcyysf6x3aoVlKHg==
X-Received: by 2002:a1c:6185:: with SMTP id v127-v6mr3962091wmb.151.1537708762253;
        Sun, 23 Sep 2018 06:19:22 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id g129-v6sm15766842wmf.42.2018.09.23.06.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:19:21 -0700 (PDT)
Date:   Sun, 23 Sep 2018 14:19:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH V2 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20180923131919.GC11050@dell>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536325173-16617-2-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Sep 2018, Pascal PAILLET-LME wrote:

> From: pascal paillet <p.paillet@st.com>
> 
> stpmic1 is a pmic from STMicroelectronics. The stpmic1 integrates 10
> regulators and 3 switches with various capabilities.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v2:
> * the hardware component has been renamed from stpmu1 to stpmic1 !
> * replace _ with - in properties name
> * fix node names in example
> * remove regulator compatibles in example
> * add st,stpmic1.h to the patch
> 
> Rob, I did not change the usage of the properties because it would lead to a lot
> of st properties; for example st,main-control-register would be replaced by:
>   st,power_cycling_on_turn_off
>   st,pwrctrl_enabled
>   st,pwrctrl_active_high
> should I go this way ?
> 
> Rob, I did not found the standard property for st,onkey-press-seconds = <10>;
> 
>  .../devicetree/bindings/mfd/st,stpmic1.txt         | 137 +++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               |  46 +++++++
>  2 files changed, 183 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.txt b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
> new file mode 100644
> index 0000000..9f2c516
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
> @@ -0,0 +1,137 @@
> +* STMicroelectronics STPMIC1 Power Management IC
> +
> +Required parent device properties:
> +- compatible: "st,stpmic1"
> +- reg: the I2C slave address for the stpmic1 chip
> +- interrupts-extended: interrupt lines to use: second irq is for wakeup.
> +- #interrupt-cells: should be 2.
> +- interrupt-controller: describes the STPMIC1 as an interrupt

I always find these are easier to read when they are tab aligned.
While we're at it, let's throw some capital letters in there and
remove the '.', as it's only used on one of the lines:

- compatible: 		"st,stpmic1"
- reg:			The I2C slave address for the STPIC1 chip
- interrupts-extended:	Interrupt lines to use: second IRQ is for wakeup.
- #interrupt-cells:     Should be 2
- interrupt-controller:	Describes the STPMIC1 as an interrupt

Better, no?

> +  controller (has its own domain). interrupt number are the following:

Capital letters usually follow a '.'

> +	/* Interrupt Register 1 (0x50 for latch) */
> +	IT_SWOUT_R=0
> +	IT_SWOUT_F=1
> +	IT_VBUS_OTG_R=2
> +	IT_VBUS_OTG_F=3
> +	IT_WAKEUP_R=4
> +	IT_WAKEUP_F=5
> +	IT_PONKEY_R=6
> +	IT_PONKEY_F=7
> +	/* Interrupt Register 2 (0x51 for latch) */
> +	IT_OVP_BOOST=8
> +	IT_OCP_BOOST=9
> +	IT_OCP_SWOUT=10
> +	IT_OCP_OTG=11
> +	IT_CURLIM_BUCK4=12
> +	IT_CURLIM_BUCK3=13
> +	IT_CURLIM_BUCK2=14
> +	IT_CURLIM_BUCK1=15
> +	/* Interrupt Register 3 (0x52 for latch) */
> +	IT_SHORT_SWOUT=16
> +	IT_SHORT_SWOTG=17
> +	IT_CURLIM_LDO6=18
> +	IT_CURLIM_LDO5=19
> +	IT_CURLIM_LDO4=20
> +	IT_CURLIM_LDO3=21
> +	IT_CURLIM_LDO2=22
> +	IT_CURLIM_LDO1=23
> +	/* Interrupt Register 3 (0x52 for latch) */
> +	IT_SWIN_R=24
> +	IT_SWIN_F=25
> +	IT_RESERVED_1=26
> +	IT_RESERVED_2=27
> +	IT_VINLOW_R=28
> +	IT_VINLOW_F=29
> +	IT_TWARN_R=30
> +	IT_TWARN_F=31
> +
> +Optional parent device properties:
> +- st,main-control-register:
> +	-bit 1: Power cycling will be performed on turn OFF condition
> +	-bit 2: PWRCTRL is functional
> +	-bit 3: PWRCTRL active high
> +- st,pads-pull-register:
> +	-bit 1: WAKEUP pull down is not active
> +	-bit 2: PWRCTRL pull up is active
> +	-bit 3: PWRCTRL pull down is active
> +	-bit 4: WAKEUP detector is disabled
> +- st,vin-control-register:
> +	-bit 0: VINLOW monitoring is enabled
> +	-bit [1...3]: VINLOW rising threshold
> +		000 VINOK_f + 50mV
> +		001 VINOK_f + 100mV
> +		010 VINOK_f + 150mV
> +		011 VINOK_f + 200mV
> +		100 VINOK_f + 250mV
> +		101 VINOK_f + 300mV
> +		110 VINOK_f + 350mV
> +		111 VINOK_f + 400mV
> +	-bit [4...5]: VINLOW hyst
> +		00 100mV
> +		01 200mV
> +		10 300mV
> +		11 400mV
> +	-bit 6: SW_OUT detector is disabled
> +	-bit 7: SW_IN detector is enabled.
> +- st,usb-control-register:
> +	-bit 3: SW_OUT current limit
> +		0: 600mA
> +		1: 1.1A
> +	-bit 4: VBUS_OTG discharge is enabled
> +	-bit 5: SW_OUT discharge is enabled
> +	-bit 6: VBUS_OTG detection is enabled
> +	-bit 7: BOOST_OVP is disabled
> +
> +

Did you mean to add a double line space here?

> +stpmic1 consists is a varied group of sub-devices:

Should be STPMIC1, no?

> +Device			 Description
> +------			------------
> +st,stpmic1-onkey		: On key

Please describe this a "Power on key"

> +st,stpmic1-regulators	: Regulators
> +st,stpmic1-wdt		: Watchdog
> +
> +each sub-device bindings is be described in associated driver

"Each sub-device binding is described in own documentation file"

> +documentation section.

Please list them using relative paths e.g:

../../bindings/watchdog/st,stm32-iwdg.txt

Or 

../watchdog/st,stm32-iwdg.txt

> +Example:
> +
> +pmic: stpmic1@33 {
> +	compatible = "st,stpmic1";
> +	reg = <0x33>;
> +	interrupts = <0 2>;
> +	interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_NONE>,
> +			      <&exti 55 1>;
> +	st,version_status = <0x10>;
> +	st,main-control-register=<0x0c>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;

'\n' here.

> +	onkey {
> +		compatible = "st,stpmic1-onkey";
> +		interrupt-parent = <&pmic>;
> +		interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
> +		interrupt-names = "onkey-falling", "onkey-rising";
> +		st,onkey-pwroff-enabled;
> +		st,onkey-long-press-seconds = <10>;
> +	};
> +
> +	watchdog {
> +		compatible = "st,stpmic1-wdt";
> +	};
> +
> +	regulators {
> +		compatible = "st,stpmic1-regulators";
> +
> +		vdd_core: buck1 {
> +			regulator-name = "vdd_core";
> +			regulator-boot-on;
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +		vdd: buck3 {
> +			regulator-name = "vdd";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +			regulator-pull-down;
> +		};
> +	};
> diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings/mfd/st,stpmic1.h
> new file mode 100644
> index 0000000..e32ac8f
> --- /dev/null
> +++ b/include/dt-bindings/mfd/st,stpmic1.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> + * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> + * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.

 * Author(s): Philippe Peurichard <philippe.peurichard@st.com>,
 *            Pascal Paillet <p.paillet@st.com> for STMicroelectronics.

> + */
> +
> +#ifndef __DT_BINDINGS_STPMIC1_H__
> +#define __DT_BINDINGS_STPMIC1_H__
> +
> +/* IRQ definitions */
> +#define IT_PONKEY_F 0
> +#define IT_PONKEY_R 1
> +#define IT_WAKEUP_F 2
> +#define IT_WAKEUP_R 3
> +#define IT_VBUS_OTG_F 4
> +#define IT_VBUS_OTG_R 5
> +#define IT_SWOUT_F 6
> +#define IT_SWOUT_R 7

Please ensure these are all tab aligned for readability.

> +#define IT_CURLIM_BUCK1 8
> +#define IT_CURLIM_BUCK2 9
> +#define IT_CURLIM_BUCK3 10
> +#define IT_CURLIM_BUCK4 11
> +#define IT_OCP_OTG 12
> +#define IT_OCP_SWOUT 13
> +#define IT_OCP_BOOST 14
> +#define IT_OVP_BOOST 15
> +
> +#define IT_CURLIM_LDO1 16
> +#define IT_CURLIM_LDO2 17
> +#define IT_CURLIM_LDO3 18
> +#define IT_CURLIM_LDO4 19
> +#define IT_CURLIM_LDO5 20
> +#define IT_CURLIM_LDO6 21
> +#define IT_SHORT_SWOTG 22
> +#define IT_SHORT_SWOUT 23
> +
> +#define IT_TWARN_F 24
> +#define IT_TWARN_R 25
> +#define IT_VINLOW_F 26
> +#define IT_VINLOW_R 27
> +#define IT_SWIN_F 30
> +#define IT_SWIN_R 31
> +
> +#endif /* __DT_BINDINGS_STPMIC1_H__ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
