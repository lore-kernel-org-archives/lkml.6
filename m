Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5644C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AC02238D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AC02238D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeHIWg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:36:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44748 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbeHIWg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:36:28 -0400
Received: from p5b127c76.dip0.t-ipconnect.de ([91.18.124.118] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fnrFf-0002vB-SS; Thu, 09 Aug 2018 22:09:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Caesar Wang <wxt@rock-chips.com>
Cc:     dianders@chromium.org, linux-rockchip@lists.infradead.org,
        cf@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        tony.xie@rock-chips.com, dbasehore@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Xing Zheng <zhengxing@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Wu <david.wu@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add idle-states to device tree for rk3399
Date:   Thu, 09 Aug 2018 22:09:42 +0200
Message-ID: <5620784.b19SH5PkdR@phil>
In-Reply-To: <1467793254-10808-1-git-send-email-wxt@rock-chips.com>
References: <1467793254-10808-1-git-send-email-wxt@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 6. Juli 2016, 10:20:54 CEST schrieb Caesar Wang:
> As the rk3399 ATF had been supported on ARM github [0], so we can add
> idle-states for rk3399.
> This patch adds idle-states bindings data collected through tests
> experiments (latency and energy consumption) on rk3399 evb2 board.
> 
> You can see detail idle-states definitions on document [1].
> 
> * arm,psci-suspend-param: power_state parameter to pass to the PSCI
>   suspend call.
> * entry-latency: Worst case latency required to enter the idle state. The
>   exit-latency may be guaranteed only after entry-latency has passed.
> * min-residency: Minimum period, including preparation and entry, for a
>   given idle state to be worthwhile energywise
> * min-residency: Minimum period, including preparation and entry, for a
>   given idle state to be worthwhile energywise.
> 
> [0]:
> https://github.com/ARM-software/arm-trusted-firmware
> [1]:
> Documentation/devicetree/bindings/arm/psci.txt
> Documentation/devicetree/bindings/arm/idle-states.txt
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Looks like this patch slipped through the cracks and nobody reposted
them over time.


>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index a6dd623..12ce265 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -101,6 +101,18 @@
>  			};
>  		};
>  
> +		idle-states {
> +			entry-method = "psci";
> +			cpu_sleep: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <350>;
> +				exit-latency-us = <600>;
> +				min-residency-us = <1150>;

Looking at the chromeos kernel, there are some more patches adapting
this idle-state to use different timings.

There also was a cluster-idle state added for a while but that seems to
cause audio issues according to the CrOS history.

In any case, I'll try to look at this shortly.


Heiko


