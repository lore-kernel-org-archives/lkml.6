Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D85C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2592086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iT1WY0eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2592086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeIJWjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:39:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36386 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeIJWji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:39:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so10845250pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vSSUBA3VEa5+seeUsL3eYtvQ/xTqGUtnFdGeyZNQUc=;
        b=iT1WY0egmhemtlEzKMx0ST0WquYthYsqnjE3rujHpVGqhrNUD/fh+DB9rthMgpCMzl
         nYF+xlRDJrjs+3mEiTSOcRIH/rYwaFHJNpE8+gQ7KR+C93hE+AtNizlG63CpdBa6FzMf
         Z6q+eXfHN1V01ulTj/UElvREIg2kuuGc05Aa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vSSUBA3VEa5+seeUsL3eYtvQ/xTqGUtnFdGeyZNQUc=;
        b=ecOlJ3Xwzivq91NQD7qNy6HkCDFSgD1nExDB3weDQFBQxUmUsw3YzHl0EVz8HzlX/m
         ys16Oxs3s2dWG7UqxsvHI+s+INxfFg1GfUIS51ANmfmK+/wZiSG0hWqe8+e09SSToD25
         zLLrfJoZFZjSsnl6zg4DT73KCSERnjQRLyKYf9kEGAd6CKubRPJsgD4xXyI7/jdwW8vP
         z4B5jCvU8Gpw1t6l2tF2sZ68R7M6u8cGFskEzv6PSCRm1OdodOT1fn/1YucW6/b5WHrh
         QKpoyFDpy9J4MwQiU5QFFdACGQ6BiCegTx0iSb+Su3k7uu3xPVjnatuaNmUvfpDdssUx
         pHDQ==
X-Gm-Message-State: APzg51AocrjEgJ9O/5DSMYgaIbLUyuTFB9t2UKidCMv7v6docLj2XQje
        RRlPHL4fxr2rqkngXzNsVhy7CA==
X-Google-Smtp-Source: ANB0VdaGxDioeSzQgVfmUwcQReR6kgZpl81/salhd399pp8l5MXM0rBcqFf88MRUyFv/WpZ6clKWWQ==
X-Received: by 2002:a63:ad07:: with SMTP id g7-v6mr24072814pgf.19.1536601466098;
        Mon, 10 Sep 2018 10:44:26 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m20-v6sm38496384pfg.61.2018.09.10.10.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:44:25 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:44:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, swboyd@chromium.org,
        tfiga@chromium.org, Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sdm845: Add USB-related nodes
Message-ID: <20180910174423.GA2523@minitux>
References: <20180822173629.202885-1-dianders@chromium.org>
 <20180822173629.202885-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822173629.202885-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Aug 10:36 PDT 2018, Douglas Anderson wrote:

> From: Manu Gautam <mgautam@codeaurora.org>
> 
> This adds nodes for USB and related PHYs.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> [dianders: reworked quite a bit]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> Changes in v3:
> - Don't just fix qfprom unit address, fix the reg too (Stephen).
> - Rebased to next-20180822
> 
> Changes in v2:
> - Use "0x784000" for qfprom rather than "0x780000" as per docs.
> - Add calibration for 2nd USB port too
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 196 +++++++++++++++++++++++++++
>  1 file changed, 196 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 627e8c181c20..8c2088de3a8d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
>  / {
> @@ -249,6 +250,23 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		qfprom@784000 {
> +			compatible = "qcom,qfprom";
> +			reg = <0x784000 0x8ff>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			qusb2p_hstx_trim: hstx-trim-primary@1eb {
> +				reg = <0x1eb 0x1>;
> +				bits = <1 4>;
> +			};
> +
> +			qusb2s_hstx_trim: hstx-trim-secondary@1eb {
> +				reg = <0x1eb 0x2>;
> +				bits = <6 4>;
> +			};
> +		};
> +
>  		qupv3_id_0: geniqup@8c0000 {
>  			compatible = "qcom,geni-se-qup";
>  			reg = <0x8c0000 0x6000>;
> @@ -962,6 +980,184 @@
>  			};
>  		};
>  
> +		usb_1_hsphy: phy@88e2000 {
> +			compatible = "qcom,sdm845-qusb2-phy";
> +			reg = <0x88e2000 0x400>;
> +			status = "disabled";
> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "cfg_ahb", "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +
> +			nvmem-cells = <&qusb2p_hstx_trim>;
> +		};
> +
> +		usb_2_hsphy: phy@88e3000 {
> +			compatible = "qcom,sdm845-qusb2-phy";
> +			reg = <0x88e3000 0x400>;
> +			status = "disabled";
> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "cfg_ahb", "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
> +
> +			nvmem-cells = <&qusb2s_hstx_trim>;
> +		};
> +
> +		usb_1_qmpphy: phy@88e9000 {
> +			compatible = "qcom,sdm845-qmp-usb3-phy";
> +			reg = <0x88e9000 0x18c>,
> +			      <0x88e8000 0x10>;
> +			reg-names = "reg-base", "dp_com";
> +			status = "disabled";
> +			#clock-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
> +
> +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			reset-names = "phy", "common";
> +
> +			usb_1_ssphy: lane@88e9200 {
> +				reg = <0x88e9200 0x128>,
> +				      <0x88e9400 0x200>,
> +				      <0x88e9c00 0x218>,
> +				      <0x88e9a00 0x100>;
> +				#phy-cells = <0>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
> +		};
> +
> +		usb_2_qmpphy: phy@88eb000 {
> +			compatible = "qcom,sdm845-qmp-usb3-uni-phy";
> +			reg = <0x88eb000 0x18c>;
> +			status = "disabled";
> +			#clock-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
> +				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
> +				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
> +
> +			resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
> +				 <&gcc GCC_USB3_PHY_SEC_BCR>;
> +			reset-names = "phy", "common";
> +
> +			usb_2_ssphy: lane@88eb200 {
> +				reg = <0x88eb200 0x128>,
> +				      <0x88eb400 0x1fc>,
> +				      <0x88eb800 0x218>,
> +				      <0x88e9600 0x70>;
> +				#phy-cells = <0>;
> +				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_uni_phy_pipe_clk_src";
> +			};
> +		};
> +
> +		usb_1: usb@a6f8800 {
> +			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
> +			reg = <0xa6f8800 0x400>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
> +				      "sleep";
> +
> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <150000000>;
> +
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hs_phy_irq", "ss_phy_irq",
> +					  "dm_hs_phy_irq", "dp_hs_phy_irq";
> +
> +			power-domains = <&gcc USB30_PRIM_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
> +
> +			usb_1_dwc3: dwc3@a600000 {
> +				compatible = "snps,dwc3";
> +				reg = <0xa600000 0xcd00>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +			};
> +		};
> +
> +		usb_2: usb@a8f8800 {
> +			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
> +			reg = <0xa8f8800 0x400>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
> +				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
> +				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_SEC_SLEEP_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
> +				      "sleep";
> +
> +			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <150000000>;
> +
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hs_phy_irq", "ss_phy_irq",
> +					  "dm_hs_phy_irq", "dp_hs_phy_irq";
> +
> +			power-domains = <&gcc USB30_SEC_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_SEC_BCR>;
> +
> +			usb_2_dwc3: dwc3@a800000 {
> +				compatible = "snps,dwc3";
> +				reg = <0xa800000 0xcd00>;
> +				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				phys = <&usb_2_hsphy>, <&usb_2_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +			};
> +		};
> +
>  		tsens0: thermal-sensor@c263000 {
>  			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>  			reg = <0xc263000 0x1ff>, /* TM */
> -- 
> 2.18.0.1017.ga543ac7ca45-goog
> 
