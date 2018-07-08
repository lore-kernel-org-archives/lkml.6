Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB211C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A23208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UC4vwK81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A23208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeGHOCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 10:02:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41465 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeGHOCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:02:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id c21-v6so7188828pfn.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e7hz7DPxhr+9YkGc57ic8+MkNOhLHQUfrhQfQB365YY=;
        b=UC4vwK81nUGlmM9Ue3M6de6jv5tMyRVNvt7XhvWbgBLO9wy0afXpYbeui8e3xX/QI+
         f7ZVBeQnGdP5dDmV9YwVGLgtUS7AD12up8nWsLVKS6P+QLpTNtbJF/jvUJ8xUs0bK4C9
         FjKFc+kTjLBUWmanDki3iuA9JyOM3oWB2HzEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e7hz7DPxhr+9YkGc57ic8+MkNOhLHQUfrhQfQB365YY=;
        b=UClqszh44Ev9G265rPk09flL1kqy+opfs73h/eWa8SG9O3UZ3H+hSqMTGgYDkWerDB
         Zfb5LsvpZFNXVUhg9Gmmfv3RsKZB3J7/INZCpE3buxUzLWoF1qJMlli7L4jWFpcsE7IK
         Ox3G7kHOSzMwfzCQmeGuKAntqZmPLj4KIT7zjdaumxsh5FKFNkfcavU9sG2ImEjGl7un
         zk+6YZ5MPCbmRFgsd08pUZVHbrYjlt67uUX02onMuHAy6/sCT+qassC8SRuMd1UgxRSd
         foxx+v7kc5YBe4U+j50oSC2wZyPcAZz9VsUfIhpyYW5wg82bO9BHOzzs5li92r0KIvFK
         YjdA==
X-Gm-Message-State: APt69E3tw7Tscqt0MLlaybCF8mOlsOrxx9T8kQlbaizYkZXrSm3ib2j9
        5S9R0ZpDp1oED7sztwSPyaoi2w==
X-Google-Smtp-Source: AAOMgpe63llponZgyRF+JnjATYBE17Xlt6seI3G5MJgusBMyeUub7owvlupsEs80fPojwc9uDK7+WQ==
X-Received: by 2002:a63:9902:: with SMTP id d2-v6mr15611879pge.343.1531058524228;
        Sun, 08 Jul 2018 07:02:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id z123-v6sm20885024pfz.16.2018.07.08.07.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 07:02:03 -0700 (PDT)
Date:   Sun, 8 Jul 2018 22:01:57 +0800
From:   leo.yan@linaro.org
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     xuwei5@hisilicon.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH] arm64: hikey960: update idle-states
Message-ID: <20180708140157.GA28878@leoy-ThinkPad-X240s>
References: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Fri, Jul 06, 2018 at 08:57:26AM +0200, Vincent Guittot wrote:
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
> A simple test with a task waking up every 11,111ms shows improvement:

Should s/11,111ms/11.111ms ?

> - 5% a lowest OPP
> - 22% at highest OPP
> 
> The period has been chosen:
> - to be shorter than old cluster residency time and longer than new
> residency time od cluster off C-state

Should s/od/of/ ?

Except these two minor typos, the patch is very good improvement.

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> - to prevent any sync with tick (4ms) when running tests that can add
> some variances between tests
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
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
> -- 
> 2.7.4
> 
