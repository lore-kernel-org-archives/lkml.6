Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10BDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DCC2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DCC2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeI1UTN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:19:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34091 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbeI1UTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:19:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4FE51208B7; Fri, 28 Sep 2018 15:55:17 +0200 (CEST)
Received: from localhost (nat-240.udc.es [193.144.61.240])
        by mail.bootlin.com (Postfix) with ESMTPSA id EB5DD206DE;
        Fri, 28 Sep 2018 15:55:16 +0200 (CEST)
Date:   Fri, 28 Sep 2018 15:55:16 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     jorik@kippendief.biz
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] dts: sun8i-h3: add sy8106a to orange pi plus
Message-ID: <20180928135516.jxhnsgaa3s2nagv7@flea>
References: <20180927083636.5415-1-jorik@kippendief.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180927083636.5415-1-jorik@kippendief.biz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Sep 27, 2018 at 10:36:36AM +0200, jorik@kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>

The prefix of your commit title should be "ARM: dts: ..."

> The Orange Pi Plus board lacks voltage scaling capabilities in its
> current form. This results in random freezes during boot when cpufreq is
> enabled, probably due to wrong voltages.
> 
> This patch (a copy/paste of 06139c) does the following things on this
> board:
> - enable r_i2c
> - add sy8106a to the r_i2c bus
> - have the sy8106a regulate VDD of cpu
> 
> I have tested this on two Orange Pi Plus boards, and they run stable
> across a range of voltages (and frequencies).

How was this tested?

> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> index b403e5d78..fd64b5c94 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> @@ -74,6 +74,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_vdd_cpux>;
> +};
> +
>  &ehci3 {
>  	status = "okay";
>  };
> @@ -119,6 +123,31 @@
>  	};
>  };
>  
> +&r_i2c {
> +	status = "okay";
> +
> +	reg_vdd_cpux: regulator@65 {
> +		compatible = "silergy,sy8106a";
> +		reg = <0x65>;
> +		regulator-name = "vdd-cpux";
> +		silergy,fixed-microvolt = <1200000>;
> +		/*
> +		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
> +		 * however both the Armbian DVFS table and the official one
> +		 * have operating points with voltage under 1.1V, and both
> +		 * DVFS table are known to work properly at the lowest
> +		 * operating point.
> +		 *
> +		 * Use 1.0V as the minimum voltage instead.
> +		 */

There's not much point to that comment, since it's been that way for
all the other SoCs from Allwinner. However, that would be great to
have it in the commit log.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
