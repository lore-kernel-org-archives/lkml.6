Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4730C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FBF20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXFrIA8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FBF20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeIKRgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:36:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46783 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeIKRgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:36:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so25856898wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X+11wEUFWst/6AGQXv4LhbqlCoDiETb4RpebUDWIB9s=;
        b=NXFrIA8j3/nmIUE3sORHDLaxeKFE9eCQGM3a+SvC6BPBChX/LCzv7xHClamGcGNMPP
         4XBXjPQ9La4nutwJ5yoYcIxg0NzPfPrErzw8HyFv9RDhSC2xn6/4LYMIqbeHx0XU++2j
         /LeRx5Q2ALQdY43NqL6criPJao0WwivjiT5Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X+11wEUFWst/6AGQXv4LhbqlCoDiETb4RpebUDWIB9s=;
        b=eClQKlmZgtjvOAo6YZABJ9yFLJNjZtPiQOMMMJ6STvjnayvvenlA0TjUdK2VqE2ZuW
         mGjvN7CparvgovmtVme4xL6Y7eScN0QlVQM+L7DCuqKXzE6TfjiAdDl3Mg2ea2ggK86C
         GQa3NFLtVoAPNOMmDO9AXS+RetwQrTdmz6duBTabS559F5zRR5gnRob9AQOBXiTu+mN2
         +mPd9u14UD/gTPjT0xE3K5zqPdvf8Ic2zhAC4y+pmiil9pK/nkh6ldzVk0WXrQD5c2tY
         VA+U2suYSiO5VlLFCEcbRuBHzUC239FprCA5fPugHEdat19AAqyj75pv3HWoFxCjtuqb
         y5Ng==
X-Gm-Message-State: APzg51Dqgm3rjXY9Wg/5A1C52IGDG9UJ/mmZd+GeE3HGphLLrSS4Gzw5
        h9dDpUKpPYASK0meu+Zv+hdbAQ==
X-Google-Smtp-Source: ANB0VdYmToyf40sDB1r6AnwEzT0c24cvRy0tQE9jrT1md5YxxsCSfLkTVi9w8AY6J8rAXZ3OQqHwjQ==
X-Received: by 2002:a5d:50cf:: with SMTP id f15-v6mr19332493wrt.128.1536669442245;
        Tue, 11 Sep 2018 05:37:22 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id 144-v6sm1511980wma.19.2018.09.11.05.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 05:37:21 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:37:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 3/5] dt-bindings: mfd: rk808: Add binding information
 for RK809 and RK817.
Message-ID: <20180911123719.GM4185@dell>
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081441-20718-4-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535081441-20718-4-git-send-email-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018, Tony Xie wrote:

> Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mfd/rk808.txt | 56 +++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
> index 91b6522..c025a99 100644
> --- a/Documentation/devicetree/bindings/mfd/rk808.txt
> +++ b/Documentation/devicetree/bindings/mfd/rk808.txt
> @@ -3,11 +3,15 @@ RK8XX Power Management Integrated Circuit
>  The rk8xx family current members:
>  rk805
>  rk808
> +rk809
> +rk817
>  rk818
>  
>  Required properties:
>  - compatible: "rockchip,rk805"
>  - compatible: "rockchip,rk808"
> +- compatible: "rockchip,rk809"
> +- compatible: "rockchip,rk817"
>  - compatible: "rockchip,rk818"
>  - reg: I2C slave address
>  - interrupt-parent: The parent interrupt controller.
> @@ -46,6 +50,28 @@ Optional RK808 properties:
>    the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
>    very quickly with no slow ramp time.
>  
> +Optional RK809 properties:
> +- vcc1-supply:  The input supply for DCDC_REG1
> +- vcc2-supply:  The input supply for DCDC_REG2
> +- vcc3-supply:  The input supply for DCDC_REG3
> +- vcc4-supply:  The input supply for DCDC_REG4
> +- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
> +- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
> +- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
> +- vcc8-supply:  The input supply for SWITCH_REG1
> +- vcc9-supply:  The input supply for DCDC_REG5, SWITCH_REG2
> +
> +Optional RK817 properties:
> +- vcc1-supply:  The input supply for DCDC_REG1
> +- vcc2-supply:  The input supply for DCDC_REG2
> +- vcc3-supply:  The input supply for DCDC_REG3
> +- vcc4-supply:  The input supply for DCDC_REG4
> +- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
> +- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
> +- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
> +- vcc8-supply:  The input supply for BOOST
> +- vcc9-supply:  The input supply for OTG_SWITCH

I think I'd like to see these squashed down a bit.

Something like:

> +Optional shared RK809 and RK817 properties:
> +- vcc1-supply:  The input supply for DCDC_REG1
> +- vcc2-supply:  The input supply for DCDC_REG2
> +- vcc3-supply:  The input supply for DCDC_REG3
> +- vcc4-supply:  The input supply for DCDC_REG4
> +- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
> +- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
> +- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
> +
> +Optional RK809 properties:
> +- vcc8-supply:  The input supply for SWITCH_REG1
> +- vcc9-supply:  The input supply for DCDC_REG5, SWITCH_REG2
> +
> +Optional RK817 properties:
> +- vcc8-supply:  The input supply for BOOST
> +- vcc9-supply:  The input supply for OTG_SWITCH

That's if 1-7 are as identical as they look at first glance.

>  Optional RK818 properties:
>  - vcc1-supply:  The input supply for DCDC_REG1
>  - vcc2-supply:  The input supply for DCDC_REG2
> @@ -87,6 +113,28 @@ number as described in RK808 datasheet.
>  	- SWITCH_REGn
>  		- valid values for n are 1 to 2
>  
> +Following regulators of the RK809 PMIC block are supported. Note that
> +the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
> +number as described in RK808 datasheet.
> +
> +	- DCDC_REGn
> +		- valid values for n are 1 to 5.
> +	- LDO_REGn
> +		- valid values for n are 1 to 9.
> +	- SWITCH_REGn
> +		- valid values for n are 1 to 2.
> +
> +Following regulators of the RK817 PMIC block are supported. Note that
> +the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
> +number as described in RK818 datasheet.

Is there any need to keep saying the same thing over and over?

Especially for something fairly obvious.

> +	- DCDC_REGn
> +		- valid values for n are 1 to 4.
> +	- LDO_REGn
> +		- valid values for n are 1 to 9.
> +	- BOOST
> +	- OTG_SWITCH
> +
>  Following regulators of the RK818 PMIC block are supported. Note that
>  the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
>  number as described in RK818 datasheet.
> @@ -99,6 +147,14 @@ number as described in RK818 datasheet.
>  	- HDMI_SWITCH
>  	- OTG_SWITCH
>  
> +There are three pins needed to config for each of RK809 and RK817,
> +named "gpio_ts" "gpio_gt" "gpio_slp".
> +	The gpio_gt and gpio_ts pins support the gpio function.
> +	The gpio_slp pin is for controlling the pmic states, as below:
> +		- reset
> +		- power down
> +		- sleep
> +
>  Standard regulator bindings are used inside regulator subnodes. Check
>    Documentation/devicetree/bindings/regulator/regulator.txt
>  for more details

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
