Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FECC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D322064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7lJOjQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D322064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeJYSKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:10:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37810 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeJYSKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:10:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so798703wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+HnnKwjZQssUkWhx+voXqgMEfZW8Kz+WvT1CBBer8XI=;
        b=a7lJOjQhAqEFyJ+LTTccF0vyfUJcWHKSu8xpGg6Zy58Sj/6afJ1vONr5S5JYtIVUH/
         iDNhb0GT5pqufAsqh6l+sRONGio4BHyGZ0WK+6vMxN9TGF66HIV7wW+uQ3SVJeOOeQJk
         l/0QRVuRYOVxGlgIDRfXfiUl8WyT0suPEbfG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+HnnKwjZQssUkWhx+voXqgMEfZW8Kz+WvT1CBBer8XI=;
        b=fYuVp9RJA25YFmkcMTgyVyWKVGpFEPcZ26Nm2pNQqEprpojj0Yu0woi0VwFEnArFmw
         2Zqum0UTwKFx3fEwQ1I0gw73l0QIUVltmRZmfs8Dc4waVpoabwoZ7O2wDxci3xSLaHMm
         gqZYZhpc/zUI9W9VBFok/s/qoz/7KB1vSq/MhIFa91gu5JUS9WYEB8vYlI9C0RmtNzNi
         Euw1toMx+ZpKtEnzl2VZ7G8CW16Q6ez7y4W/4zjtTHfFWBc5hn+L8IfWotGoMDeEKV6T
         lDK4jtFaIZrnUTVb0aQx6HInYa2lVHCpM+wkBGEShTEcg0O0u009dffw25qM7rQCVtte
         ApxQ==
X-Gm-Message-State: AGRZ1gK0I6XCy0Ls1PtKUfo47+VKSOKi1ow8jbO47NLAlmixxuV3SXXG
        u9PzvYchW8Vm+2I9tuy3rwAWSQ==
X-Google-Smtp-Source: AJdET5dcrxQnLTyr6PNW9FquzlWa4TIvrm3JG12ofDpoZ9gxq2PEUaLU6v5y6kvba+hotIMHQ127iQ==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr1040460wma.69.1540460311058;
        Thu, 25 Oct 2018 02:38:31 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id b143-v6sm1318839wma.28.2018.10.25.02.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:38:30 -0700 (PDT)
Date:   Thu, 25 Oct 2018 10:38:27 +0100
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
Subject: Re: [PATCH v5 3/5] dt-bindings: mfd: rk808: Add binding information
 for RK809 and RK817.
Message-ID: <20181025093827.GP4939@dell>
References: <1540294467-25813-1-git-send-email-tony.xie@rock-chips.com>
 <1540294467-25813-4-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540294467-25813-4-git-send-email-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Tony Xie wrote:

> Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/rk808.txt | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
> index 91b6522..d575780 100644
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
> @@ -46,6 +50,23 @@ Optional RK808 properties:
>    the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
>    very quickly with no slow ramp time.
>  
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
> +
>  Optional RK818 properties:
>  - vcc1-supply:  The input supply for DCDC_REG1
>  - vcc2-supply:  The input supply for DCDC_REG2
> @@ -87,6 +108,21 @@ number as described in RK808 datasheet.
>  	- SWITCH_REGn
>  		- valid values for n are 1 to 2
>  
> +Following regulators of the RK809 and RK817 PMIC blocks are supported. Note that
> +the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
> +number as described in RK809 and RK817 datasheets.
> +
> +	- DCDC_REGn
> +		- valid values for n are 1 to 5 for RK809.
> +		- valid values for n are 1 to 4 for RK817.
> +	- LDO_REGn
> +		- valid values for n are 1 to 9 for RK809.
> +		- valid values for n are 1 to 9 for RK817.
> +	- SWITCH_REGn
> +		- valid values for n are 1 to 2 for RK809.
> +	- BOOST for RK817
> +	- OTG_SWITCH for RK817
> +
>  Following regulators of the RK818 PMIC block are supported. Note that
>  the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
>  number as described in RK818 datasheet.
> @@ -99,6 +135,14 @@ number as described in RK818 datasheet.
>  	- HDMI_SWITCH
>  	- OTG_SWITCH
>  
> +There are three pins needed to config for each of RK809 and RK817,

Nit: "configure" in full please.

Actually: "It is necessary to configure three pins for both the RK809 and RK817"

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

Once that's fixed, please apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
