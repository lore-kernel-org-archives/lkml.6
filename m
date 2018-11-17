Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203C4C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 23:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2DF2080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 23:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQvwL4dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2DF2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeKRJ3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 04:29:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41845 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeKRJ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 04:29:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so1932827plm.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 15:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhDUrBKIKL67W3Kulv3NZ8twu2irptkhsB4jIfRYTac=;
        b=NQvwL4dcvvDz6K3S9TxZqFD8XU04leAngJOH15QNKV2EVTul/G1qf0STVlNuN/HxcX
         7OL+3gyS0Z5yc5BBH2JMNzCYnyYRC6BNDKywa8WIGrinjoHflzgytWeZ4kKf+3qMO9TZ
         /NtRZefYn6Oz/yHs4jFfw38Hqw9G73dVGXvJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhDUrBKIKL67W3Kulv3NZ8twu2irptkhsB4jIfRYTac=;
        b=pE7xyaYSJO6ZNWaW5I5dGWGKO9BCtX1ToAd5yKHuSfi49ZphFbqYmJkRY8s2JCP7jI
         h9dCcUAH+zkKmhMSFzGoJA3QXFFXNCiKvYB7MNBcnACPtpH3lCEfOBWqPS9yKmMI8YXY
         yFfRwHGk/1WAlAftuxeszsvpgjPQo9FMQCi60MPb7SZVK90Nq/jcwviZ+wm5z4zJri/G
         74/FAXjCuSWQCT4u6idWseXNfP2kyQLYkNh8LOciwMLxDNtSpaE2XkUYCj7BKyvqQXYC
         D33HynJWB4Hgs9MwaiWyy+UnBclgc5iVEowbordezWRZSgr+xV8kG9ImKldbGJDtMlsJ
         GtyA==
X-Gm-Message-State: AGRZ1gIKfQkoaioAiqnYEgggOR01L+i/60ocVKlZwQeCEgwo/1nYF96J
        i8pApeRT1oACfAQ0yX59AKhgzg==
X-Google-Smtp-Source: AJdET5dXy2y4Hixb4VMkV3c4Ixuw+Sw0JRjCh95ac4+kMUvi/l4H+TlD37Y3K+NhSM0OIiv7qvrMgQ==
X-Received: by 2002:a17:902:a81:: with SMTP id 1-v6mr16672333plp.20.1542496250774;
        Sat, 17 Nov 2018 15:10:50 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 64sm503850pff.101.2018.11.17.15.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 15:10:49 -0800 (PST)
Date:   Sat, 17 Nov 2018 15:10:47 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 01/18] arm64: dts: qcom: qcs404: add base dts files
Message-ID: <20181117231047.GA2225@minitux>
References: <20181109094417.12109-1-vkoul@kernel.org>
 <20181109094417.12109-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109094417.12109-2-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Nov 01:44 PST 2018, Vinod Koul wrote:

> Add base dts files for QCS404 chipset along with cpu, timer,
> gcc and uart2 nodes.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 175 +++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs404.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> new file mode 100644
> index 000000000000..91abcdc78505
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU1: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x101>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU2: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x102>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU3: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x103>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0 0x80000000 0 0>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	soc: soc@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +		compatible = "simple-bus";
> +
> +		gcc: clock-controller@1800000 {
> +			compatible = "qcom,gcc-qcs404";
> +			reg = <0x01800000 0x80000>;
> +			#clock-cells = <1>;
> +
> +			assigned-clocks = <&gcc GCC_APSS_AHB_CLK_SRC>;
> +			assigned-clock-rates = <19200000>;
> +		};
> +
> +		blsp1_uart2: serial@78b1000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078b1000 0x200>;
> +			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "okay";
> +		};
> +
> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = <0x0b000000 0x1000>,
> +			      <0x0b002000 0x1000>;
> +		};
> +
> +		timer@b120000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0b120000 0x1000>;
> +			clock-frequency = <19200000>;
> +
> +			frame@b121000 {
> +				frame-number = <0>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b121000 0x1000>,
> +				      <0x0b122000 0x1000>;
> +			};
> +
> +			frame@b123000 {
> +				frame-number = <1>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b123000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b124000 {
> +				frame-number = <2>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b124000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b125000 {
> +				frame-number = <3>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b125000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b126000 {
> +				frame-number = <4>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b126000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b127000 {
> +				frame-number = <5>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0xb127000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b128000 {
> +				frame-number = <6>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b128000 0x1000>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 0xff08>,
> +			     <GIC_PPI 3 0xff08>,
> +			     <GIC_PPI 4 0xff08>,
> +			     <GIC_PPI 1 0xff08>;
> +	};
> +};
> -- 
> 2.14.4
> 
