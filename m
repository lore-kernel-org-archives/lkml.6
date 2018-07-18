Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D586ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA2C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA2C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeGRQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:12:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731144AbeGRQMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:12:39 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 123539CAF4EF4;
        Wed, 18 Jul 2018 23:33:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Wed, 18 Jul 2018
 23:33:54 +0800
Subject: Re: [PATCH v2] arm64: hikey960: update idle-states
To:     Vincent Guittot <vincent.guittot@linaro.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1531298086-8375-1-git-send-email-vincent.guittot@linaro.org>
CC:     <leo.yan@linaro.org>, <daniel.lezcano@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B4F5DDC.1060802@hisilicon.com>
Date:   Wed, 18 Jul 2018 16:33:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1531298086-8375-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 2018/7/11 9:34, Vincent Guittot wrote:
> Update entry/exit latency and residency time of hikey960 to use more
> realistic figures based on unitary tests done on the platform.
> 
> The complete results (in us) :
>                   big cluster
>                   cluster  CPU
> max entry latency     800  400
> max exit latency     2900  550
> residency  903Mhz    5000 1500
> residency 2363Mhz       0 1500
> 
>                   little cluster
>                   cluster  CPU
> max entry latency     500  400
> max exit latency     1600  650
> residency  533Mhz    8000 4500
> residency 1844Mhz       0 1500
> 
> We can see that the residency time depends of the running OPP which is not
> handled for now. Then we also have to take into account the constraint of
> a residency time shorter than the tick to get full advantage of idle loop
> reordering(tick is stopped if idle duration is higher than tick period).
> Finally the selected residency value are :
>                  big cluster
>                   cluster  CPU
> residency            3700 1500
> 
>                   little cluster
>                   cluster  CPU
> residency            3500 1500
> 
> A simple test with a task waking up every 11.111ms shows improvement:
> - 5% a lowest OPP
> - 22% at highest OPP
> 
> The period has been chosen:
> - to be shorter than old cluster residency time and longer than new
> residency time of cluster off C-state
> - to prevent any sync with tick (4ms) when running tests that can add
> some variances between tests
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 45 ++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 421d454..890d23e 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -61,7 +61,7 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> @@ -75,7 +75,7 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> @@ -87,7 +87,7 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> @@ -99,7 +99,7 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> @@ -111,7 +111,7 @@
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
>  			next-level-cache = <&A73_L2>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
> +			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> @@ -125,7 +125,7 @@
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
>  			next-level-cache = <&A73_L2>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
> +			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> @@ -137,7 +137,7 @@
>  			reg = <0x0 0x102>;
>  			enable-method = "psci";
>  			next-level-cache = <&A73_L2>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
> +			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> @@ -149,7 +149,7 @@
>  			reg = <0x0 0x103>;
>  			enable-method = "psci";
>  			next-level-cache = <&A73_L2>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
> +			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> @@ -158,31 +158,40 @@
>  		idle-states {
>  			entry-method = "psci";
>  
> -			CPU_SLEEP: cpu-sleep {
> +			CPU_SLEEP_0: cpu-sleep-0 {
>  				compatible = "arm,idle-state";
>  				local-timer-stop;
>  				arm,psci-suspend-param = <0x0010000>;
> -				entry-latency-us = <40>;
> -				exit-latency-us = <70>;
> -				min-residency-us = <3000>;
> +				entry-latency-us = <400>;
> +				exit-latency-us = <650>;
> +				min-residency-us = <1500>;
>  			};
> -
>  			CLUSTER_SLEEP_0: cluster-sleep-0 {
>  				compatible = "arm,idle-state";
>  				local-timer-stop;
>  				arm,psci-suspend-param = <0x1010000>;
>  				entry-latency-us = <500>;
> -				exit-latency-us = <5000>;
> -				min-residency-us = <20000>;
> +				exit-latency-us = <1600>;
> +				min-residency-us = <3500>;
> +			};
> +
> +
> +			CPU_SLEEP_1: cpu-sleep-1 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <400>;
> +				exit-latency-us = <550>;
> +				min-residency-us = <1500>;
>  			};
>  
>  			CLUSTER_SLEEP_1: cluster-sleep-1 {
>  				compatible = "arm,idle-state";
>  				local-timer-stop;
>  				arm,psci-suspend-param = <0x1010000>;
> -				entry-latency-us = <1000>;
> -				exit-latency-us = <5000>;
> -				min-residency-us = <20000>;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <2900>;
> +				min-residency-us = <3500>;
>  			};
>  		};
>  
> 

