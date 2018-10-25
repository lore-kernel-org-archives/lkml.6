Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75DAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741532064C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBMhyx2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741532064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeJYSQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:16:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40638 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJYSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:16:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so814919wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B85qrK7rgmYqNRQBtxSboSjjAk37SWB3mwYHTbmf9Ug=;
        b=dBMhyx2A9G+uKUgVt5Aap64zQGpNpltkgYzptCFMRMK7J/SpUumiTkTyoc2d1b0lXE
         N1GfLwnrNo6LjqfAJdIeD4Fwws0GUbo874vmxK954SAixLWKpD854mZG6YO4ggVv+45C
         yerNRTz0uLd2X1n6TJJo8iWxiwre0b/PJsNBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B85qrK7rgmYqNRQBtxSboSjjAk37SWB3mwYHTbmf9Ug=;
        b=qTgS/fWRb6jLwk1eg2gnW9LFcQ0N85DSuYRMG9nLZUm1GZFgPdQO2BuPC5FRFnGGVb
         FIbckyxobPOrujr+cGepLZ/x0Sd3Pr5YyI7hV3le0uxwdvYiNVffrS5PtG/zj+45GoiN
         VkdHcdmfswEuJnOAutHt66XkwOgcOy7GJVfq16NX2pg7At4sY3e2QvEr1hK4TLT6AZit
         mJxscUJsfQJ5MD1TtFViz63erLoqfgpL9WMECmxVJabDfJsbh5nVVZcF79i5uWkiQXfC
         XGXCnQ1HeQ+Nd1qWhrMxj+OmOcQlF/EipHh22xAZIAvu2Y2C3kbj91kMaag/Sn5RVh7e
         LzeA==
X-Gm-Message-State: AGRZ1gI9Yv0WP1cT9q3QhqfjabVSjXfFUvTThKAuL58rApyzGHkFDtL6
        qmh4kTRs0qT+R0tzBzdLQtUlog==
X-Google-Smtp-Source: AJdET5dAA6hkl/yT6531Mi9WUIom4mmxgUnWVXdFtORB/5cdYUzW4X42RAROzNSRmbGwOvaUIFBNlw==
X-Received: by 2002:a1c:91cd:: with SMTP id t196-v6mr1035373wmd.63.1540460673537;
        Thu, 25 Oct 2018 02:44:33 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id y76-v6sm701356wmd.37.2018.10.25.02.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:44:32 -0700 (PDT)
Date:   Thu, 25 Oct 2018 10:44:30 +0100
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
Subject: Re: [PATCH v4 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20181025094430.GQ4939@dell>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1539853324-29051-2-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob: please grep your name for some feedback.

On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:

> From: pascal paillet <p.paillet@st.com>

Please use `git send-email` to send patches.

Please capitalise your name: Pascal Paillet

> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10

"STPMIC1"
"PMIC"

> regulators , 3 switches, a watchdog and an input for a power on key.

Whitespace.

What is a switch?

> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v4:
> * remove interrupt-parent description
> * pmic1@33 renamed to pmic@33
> * fix indentation
> 
>  .../devicetree/bindings/mfd/st,stpmic1.txt         | 131 +++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               |  46 ++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.txt b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
> new file mode 100644
> index 0000000..bb19cc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
> @@ -0,0 +1,131 @@
> +* STMicroelectronics STPMIC1 Power Management IC
> +
> +Required parent device properties:
> +- compatible:			"st,stpmic1"
> +- reg:				The I2C slave address for the STPMIC1 chip.
> +- interrupts:			The interrupt line the device is connected to.
> +- #interrupt-cells:		Should be 1.
> +- interrupt-controller: 	Describes the STPMIC1 as an interrupt

Tabbing (this could just be a patch quirk).

Either use full-stops or don't - please be consistent.

> +  controller (has its own domain). Interrupt number are the following:

"numbers"

Actually consider rewording - sounds funny.

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

Do you really need these in here?  I suspect not.

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

I'm surprised Rob allowed you to add register bits in a DT property?

> +STPMIC1 consists in a varied group of sub-devices.
> +Each sub-device binding is be described in own documentation file.
> +
> +Device			 Description
> +------			------------
> +st,stpmic1-onkey	: Power on key, see ../input/st,stpmic1-onkey.txt
> +st,stpmic1-regulators	: Regulators, see ../regulator/st,stpmic1-regulator.txt
> +st,stpmic1-wdt		: Watchdog, see ../watchdog/st,stpmic1-wdt.txt
> +
> +Example:
> +
> +pmic: pmic@33 {
> +	compatible = "st,stpmic1";
> +	reg = <0x33>;
> +	interrupt-parent = <&gpioa>;
> +	interrupts = <0 2>;
> +	st,main-control-register=<0x0c>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +
> +	onkey {
> +		compatible = "st,stpmic1-onkey";
> +		interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
> +		interrupt-names = "onkey-falling", "onkey-rising";
> +		power-off-time-sec = <10>;
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
> index 0000000..b2d6c83
> --- /dev/null
> +++ b/include/dt-bindings/mfd/st,stpmic1.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> + * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> + * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> + */
> +
> +#ifndef __DT_BINDINGS_STPMIC1_H__
> +#define __DT_BINDINGS_STPMIC1_H__
> +
> +/* IRQ definitions */
> +#define IT_PONKEY_F	0
> +#define IT_PONKEY_R	1
> +#define IT_WAKEUP_F	2
> +#define IT_WAKEUP_R	3
> +#define IT_VBUS_OTG_F	4
> +#define IT_VBUS_OTG_R	5
> +#define IT_SWOUT_F	6
> +#define IT_SWOUT_R	7
> +
> +#define IT_CURLIM_BUCK1	8
> +#define IT_CURLIM_BUCK2	9
> +#define IT_CURLIM_BUCK3	10
> +#define IT_CURLIM_BUCK4	11
> +#define IT_OCP_OTG	12
> +#define IT_OCP_SWOUT	13
> +#define IT_OCP_BOOST	14
> +#define IT_OVP_BOOST	15
> +
> +#define IT_CURLIM_LDO1	16
> +#define IT_CURLIM_LDO2	17
> +#define IT_CURLIM_LDO3	18
> +#define IT_CURLIM_LDO4	19
> +#define IT_CURLIM_LDO5	20
> +#define IT_CURLIM_LDO6	21
> +#define IT_SHORT_SWOTG	22
> +#define IT_SHORT_SWOUT	23
> +
> +#define IT_TWARN_F	24
> +#define IT_TWARN_R	25
> +#define IT_VINLOW_F	26
> +#define IT_VINLOW_R	27
> +#define IT_SWIN_F	30
> +#define IT_SWIN_R	31
> +
> +#endif /* __DT_BINDINGS_STPMIC1_H__ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
