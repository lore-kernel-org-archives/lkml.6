Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBC9C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D420206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHeuvkwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D420206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeILIPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:15:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42437 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeILIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:15:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so258757pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JH716dNskZcJ60hFuMfHVjUBG0EsATRtVFgrjRZpYvw=;
        b=IHeuvkwyMTcKh+czt0v/3trRKuEKsVIkKqOSC3mljXcSZ4b02S1R0+4WANCjRkxQq/
         x2K3F9zo8qqRb6AI5CL1jum0Dh6U9xzWDTVzAwxrbQZMnWbdr6hmc9NiNvCDVUCYtKvE
         tMVg0TxUML2Pve89ZU3w7n9Dvm+hvLfPxpyhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JH716dNskZcJ60hFuMfHVjUBG0EsATRtVFgrjRZpYvw=;
        b=cq2UV74bznrPk7VIcmYGT2SSc71Oe5lBsdKyNxC7ZgKpcAToCKwm7Gs1aPVskIWUbE
         KNbdvjJpDdFGUK+BlDCU+xmQ6kTbe/+Qtj8WSP3bvn2Tsx5Ll5Tkib91YGm2sW95uaXc
         E1zCjp9Ows+5oG8il08wC16O/G1CGx+wHdRj0Zy+VqE/Acy4X3n21FX7fLGGO6a6Vz9K
         UqFg9AIjXRjWE/LVld3nTU5u6KQ/3zPbnmFuR/hCjLwIYg2GqO2YUlY+sq8tHQyknC48
         TspC+Q37ao0hYtQs9BYW/vAvbo9hjFkyC0YNuqhcYvRqUWBqqC3hXIafeWfu+uOWiiab
         YTug==
X-Gm-Message-State: APzg51DBkZCbvW0NGVQ31ZQTPoTSdFG2Jeqnj4P1ey0xzJQiSaoXl9Mf
        tj+veWk8A+ZN6R/qw05IH0ER
X-Google-Smtp-Source: ANB0VdZZA3Qobq8j0i+1wwjm3gPGdrMQK32HSylc/JVEgXn3yDWicD1rkaPr5xjwkvc4cbTN8P26Qg==
X-Received: by 2002:a65:608b:: with SMTP id t11-v6mr31917197pgu.259.1536721978615;
        Tue, 11 Sep 2018 20:12:58 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:89e:33f6:c566:c752:9b3c:11bf])
        by smtp.gmail.com with ESMTPSA id s9-v6sm27036814pgc.16.2018.09.11.20.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 20:12:58 -0700 (PDT)
Date:   Wed, 12 Sep 2018 08:42:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, vicencb@gmail.com,
        shawn.lin@rock-chips.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: Split out common nodes for
 Rock960 based boards
Message-ID: <20180912031248.GA4880@Mani-XPS-13-9360>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
 <20180911023031.4892-2-manivannan.sadhasivam@linaro.org>
 <9e1868684ed851dfa19300ac2e648cfea7bf3eb9.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1868684ed851dfa19300ac2e648cfea7bf3eb9.camel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Tue, Sep 11, 2018 at 04:40:29PM -0300, Ezequiel Garcia wrote:
> On Tue, 2018-09-11 at 08:00 +0530, Manivannan Sadhasivam wrote:
> > Since the same family members of Rock960 boards (Rock960 and Ficus)
> > share the same configuration, split out the common nodes into a common
> > dtsi file for reducing code duplication. The board specific nodes for
> > Ficus boards are then placed in corresponding board DTS file.
> > 
> 
> I think it should be possible to move the common USB nodes to the dtsi file,
> and keep the board-specific (phy-supply property) in the dts files:
> 
> &u2phy0_host {
>         phy-supply = <&vcc5v0_host>;
> };
> 
> &u2phy1_host {
>         phy-supply = <&vcc5v0_host>;
> };
> 

We can do that but my intention was to entirely partition the nodes
which are not common. So that it would be less confusing when someone
looks at it (please correct me if I'm wrong).

> Also, I believe it would be good to have some more details
> in this commit log. The information on the cover letter is great,
> so I'd just repeat some of that here.
> 

Sure, will add it in next iteration.

> Other than that, for the ficus bits:
> 
> Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
> 

Thanks a lot for the review!

Regards,
Mani

> Thanks very much for this work!
> Ezequiel
> 
> 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 429 +----------------
> >  .../boot/dts/rockchip/rk3399-rock960.dtsi     | 439 ++++++++++++++++++
> >  2 files changed, 440 insertions(+), 428 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > index 8978d924eb83..7f6ec37d5a69 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > @@ -7,8 +7,7 @@
> >   */
> >  
> >  /dts-v1/;
> > -#include "rk3399.dtsi"
> > -#include "rk3399-opp.dtsi"
> > +#include "rk3399-rock960.dtsi"
> >  
> >  / {
> >  	model = "96boards RK3399 Ficus";
> > @@ -25,31 +24,6 @@
> >  		#clock-cells = <0>;
> >  	};
> >  
> > -	vcc1v8_s0: vcc1v8-s0 {
> > -		compatible = "regulator-fixed";
> > -		regulator-name = "vcc1v8_s0";
> > -		regulator-min-microvolt = <1800000>;
> > -		regulator-max-microvolt = <1800000>;
> > -		regulator-always-on;
> > -	};
> > -
> > -	vcc_sys: vcc-sys {
> > -		compatible = "regulator-fixed";
> > -		regulator-name = "vcc_sys";
> > -		regulator-min-microvolt = <5000000>;
> > -		regulator-max-microvolt = <5000000>;
> > -		regulator-always-on;
> > -	};
> > -
> > -	vcc3v3_sys: vcc3v3-sys {
> > -		compatible = "regulator-fixed";
> > -		regulator-name = "vcc3v3_sys";
> > -		regulator-min-microvolt = <3300000>;
> > -		regulator-max-microvolt = <3300000>;
> > -		regulator-always-on;
> > -		vin-supply = <&vcc_sys>;
> > -	};
> > -
> >  	vcc3v3_pcie: vcc3v3-pcie-regulator {
> >  		compatible = "regulator-fixed";
> >  		enable-active-high;
> > @@ -75,46 +49,6 @@
> >  		regulator-always-on;
> >  		vin-supply = <&vcc_sys>;
> >  	};
> > -
> > -	vdd_log: vdd-log {
> > -		compatible = "pwm-regulator";
> > -		pwms = <&pwm2 0 25000 0>;
> > -		regulator-name = "vdd_log";
> > -		regulator-min-microvolt = <800000>;
> > -		regulator-max-microvolt = <1400000>;
> > -		regulator-always-on;
> > -		regulator-boot-on;
> > -		vin-supply = <&vcc_sys>;
> > -	};
> > -
> > -};
> > -
> > -&cpu_l0 {
> > -	cpu-supply = <&vdd_cpu_l>;
> > -};
> > -
> > -&cpu_l1 {
> > -	cpu-supply = <&vdd_cpu_l>;
> > -};
> > -
> > -&cpu_l2 {
> > -	cpu-supply = <&vdd_cpu_l>;
> > -};
> > -
> > -&cpu_l3 {
> > -	cpu-supply = <&vdd_cpu_l>;
> > -};
> > -
> > -&cpu_b0 {
> > -	cpu-supply = <&vdd_cpu_b>;
> > -};
> > -
> > -&cpu_b1 {
> > -	cpu-supply = <&vdd_cpu_b>;
> > -};
> > -
> > -&emmc_phy {
> > -	status = "okay";
> >  };
> >  
> >  &gmac {
> > @@ -133,263 +67,6 @@
> >  	status = "okay";
> >  };
> >  
> > -&hdmi {
> > -	ddc-i2c-bus = <&i2c3>;
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&hdmi_cec>;
> > -	status = "okay";
> > -};
> > -
> > -&i2c0 {
> > -	clock-frequency = <400000>;
> > -	i2c-scl-rising-time-ns = <168>;
> > -	i2c-scl-falling-time-ns = <4>;
> > -	status = "okay";
> > -
> > -	vdd_cpu_b: regulator@40 {
> > -		compatible = "silergy,syr827";
> > -		reg = <0x40>;
> > -		fcs,suspend-voltage-selector = <1>;
> > -		regulator-name = "vdd_cpu_b";
> > -		regulator-min-microvolt = <712500>;
> > -		regulator-max-microvolt = <1500000>;
> > -		regulator-ramp-delay = <1000>;
> > -		regulator-always-on;
> > -		regulator-boot-on;
> > -		vin-supply = <&vcc_sys>;
> > -		status = "okay";
> > -
> > -		regulator-state-mem {
> > -			regulator-off-in-suspend;
> > -		};
> > -	};
> > -
> > -	vdd_gpu: regulator@41 {
> > -		compatible = "silergy,syr828";
> > -		reg = <0x41>;
> > -		fcs,suspend-voltage-selector = <1>;
> > -		regulator-name = "vdd_gpu";
> > -		regulator-min-microvolt = <712500>;
> > -		regulator-max-microvolt = <1500000>;
> > -		regulator-ramp-delay = <1000>;
> > -		regulator-always-on;
> > -		regulator-boot-on;
> > -		vin-supply = <&vcc_sys>;
> > -		regulator-state-mem {
> > -			regulator-off-in-suspend;
> > -		};
> > -	};
> > -
> > -	rk808: pmic@1b {
> > -		compatible = "rockchip,rk808";
> > -		reg = <0x1b>;
> > -		interrupt-parent = <&gpio1>;
> > -		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> > -		pinctrl-names = "default";
> > -		pinctrl-0 = <&pmic_int_l>;
> > -		rockchip,system-power-controller;
> > -		wakeup-source;
> > -		#clock-cells = <1>;
> > -		clock-output-names = "xin32k", "rk808-clkout2";
> > -
> > -		vcc1-supply = <&vcc_sys>;
> > -		vcc2-supply = <&vcc_sys>;
> > -		vcc3-supply = <&vcc_sys>;
> > -		vcc4-supply = <&vcc_sys>;
> > -		vcc6-supply = <&vcc_sys>;
> > -		vcc7-supply = <&vcc_sys>;
> > -		vcc8-supply = <&vcc3v3_sys>;
> > -		vcc9-supply = <&vcc_sys>;
> > -		vcc10-supply = <&vcc_sys>;
> > -		vcc11-supply = <&vcc_sys>;
> > -		vcc12-supply = <&vcc3v3_sys>;
> > -		vddio-supply = <&vcc_1v8>;
> > -
> > -		regulators {
> > -			vdd_center: DCDC_REG1 {
> > -				regulator-name = "vdd_center";
> > -				regulator-min-microvolt = <750000>;
> > -				regulator-max-microvolt = <1350000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-off-in-suspend;
> > -				};
> > -			};
> > -
> > -			vdd_cpu_l: DCDC_REG2 {
> > -				regulator-name = "vdd_cpu_l";
> > -				regulator-min-microvolt = <750000>;
> > -				regulator-max-microvolt = <1350000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-off-in-suspend;
> > -				};
> > -			};
> > -
> > -			vcc_ddr: DCDC_REG3 {
> > -				regulator-name = "vcc_ddr";
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -				};
> > -			};
> > -
> > -			vcc_1v8: DCDC_REG4 {
> > -				regulator-name = "vcc_1v8";
> > -				regulator-min-microvolt = <1800000>;
> > -				regulator-max-microvolt = <1800000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -					regulator-suspend-microvolt = <1800000>;
> > -				};
> > -			};
> > -
> > -			vcc1v8_dvp: LDO_REG1 {
> > -				regulator-name = "vcc1v8_dvp";
> > -				regulator-min-microvolt = <1800000>;
> > -				regulator-max-microvolt = <1800000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -					regulator-suspend-microvolt = <1800000>;
> > -				};
> > -			};
> > -
> > -			vcca1v8_hdmi: LDO_REG2 {
> > -				regulator-name = "vcca1v8_hdmi";
> > -				regulator-min-microvolt = <1800000>;
> > -				regulator-max-microvolt = <1800000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -					regulator-suspend-microvolt = <1800000>;
> > -				};
> > -			};
> > -
> > -			vcca_1v8: LDO_REG3 {
> > -				regulator-name = "vcca_1v8";
> > -				regulator-min-microvolt = <1800000>;
> > -				regulator-max-microvolt = <1800000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -					regulator-suspend-microvolt = <1800000>;
> > -				};
> > -			};
> > -
> > -			vcc_sd: LDO_REG4 {
> > -				regulator-name = "vcc_sd";
> > -				regulator-min-microvolt = <1800000>;
> > -				regulator-max-microvolt = <3300000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -					regulator-suspend-microvolt = <3300000>;
> > -				};
> > -			};
> > -
> > -			vcc3v0_sd: LDO_REG5 {
> > -				regulator-name = "vcc3v0_sd";
> > -				regulator-min-microvolt = <3000000>;
> > -				regulator-max-microvolt = <3000000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -					regulator-suspend-microvolt = <3000000>;
> > -				};
> > -			};
> > -
> > -			vcc_1v5: LDO_REG6 {
> > -				regulator-name = "vcc_1v5";
> > -				regulator-min-microvolt = <1500000>;
> > -				regulator-max-microvolt = <1500000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -					regulator-suspend-microvolt = <1500000>;
> > -				};
> > -			};
> > -
> > -			vcca0v9_hdmi: LDO_REG7 {
> > -				regulator-name = "vcca0v9_hdmi";
> > -				regulator-min-microvolt = <900000>;
> > -				regulator-max-microvolt = <900000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -					regulator-suspend-microvolt = <900000>;
> > -				};
> > -			};
> > -
> > -			vcc_3v0: LDO_REG8 {
> > -				regulator-name = "vcc_3v0";
> > -				regulator-min-microvolt = <3000000>;
> > -				regulator-max-microvolt = <3000000>;
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -					regulator-suspend-microvolt = <3000000>;
> > -				};
> > -			};
> > -
> > -			vcc3v3_s3: SWITCH_REG1 {
> > -				regulator-name = "vcc3v3_s3";
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -				};
> > -			};
> > -
> > -			vcc3v3_s0: SWITCH_REG2 {
> > -				regulator-name = "vcc3v3_s0";
> > -				regulator-always-on;
> > -				regulator-boot-on;
> > -				regulator-state-mem {
> > -					regulator-on-in-suspend;
> > -				};
> > -			};
> > -		};
> > -	};
> > -};
> > -
> > -&i2c1 {
> > -	status = "okay";
> > -};
> > -
> > -&i2c2 {
> > -	status = "okay";
> > -};
> > -
> > -&i2c3 {
> > -	status = "okay";
> > -};
> > -
> > -&i2c4 {
> > -	status = "okay";
> > -};
> > -
> > -&io_domains {
> > -	bt656-supply = <&vcc1v8_s0>; /* bt656_gpio2ab_ms */
> > -	audio-supply = <&vcc1v8_s0>; /* audio_gpio3d4a_ms */
> > -	sdmmc-supply = <&vcc_sd>; /* sdmmc_gpio4b_ms */
> > -	gpio1830-supply = <&vcc_3v0>; /* gpio1833_gpio4cd_ms */
> > -	status = "okay";
> > -};
> > -
> >  &pcie_phy {
> >  	status = "okay";
> >  };
> > @@ -403,11 +80,6 @@
> >  	status = "okay";
> >  };
> >  
> > -&pmu_io_domains {
> > -	pmu1830-supply = <&vcc_1v8>;
> > -	status = "okay";
> > -};
> > -
> >  &pinctrl {
> >  	gmac {
> >  		rgmii_sleep_pins: rgmii-sleep-pins {
> > @@ -416,31 +88,6 @@
> >  		};
> >  	};
> >  
> > -	sdmmc {
> > -		sdmmc_bus1: sdmmc-bus1 {
> > -			rockchip,pins =
> > -				<4 8 RK_FUNC_1 &pcfg_pull_up_8ma>;
> > -		};
> > -
> > -		sdmmc_bus4: sdmmc-bus4 {
> > -			rockchip,pins =
> > -				<4 8 RK_FUNC_1 &pcfg_pull_up_8ma>,
> > -				<4 9 RK_FUNC_1 &pcfg_pull_up_8ma>,
> > -				<4 10 RK_FUNC_1 &pcfg_pull_up_8ma>,
> > -				<4 11 RK_FUNC_1 &pcfg_pull_up_8ma>;
> > -		};
> > -
> > -		sdmmc_clk: sdmmc-clk {
> > -			rockchip,pins =
> > -				<4 12 RK_FUNC_1 &pcfg_pull_none_18ma>;
> > -		};
> > -
> > -		sdmmc_cmd: sdmmc-cmd {
> > -			rockchip,pins =
> > -				<4 13 RK_FUNC_1 &pcfg_pull_up_8ma>;
> > -		};
> > -	};
> > -
> >  	pcie {
> >  		pcie_drv: pcie-drv {
> >  			rockchip,pins =
> > @@ -448,23 +95,6 @@
> >  			};
> >  	};
> >  
> > -	pmic {
> > -		pmic_int_l: pmic-int-l {
> > -			rockchip,pins =
> > -				<1 21 RK_FUNC_GPIO &pcfg_pull_up>;
> > -		};
> > -
> > -		vsel1_gpio: vsel1-gpio {
> > -			rockchip,pins =
> > -				<1 17 RK_FUNC_GPIO &pcfg_pull_down>;
> > -		};
> > -
> > -		vsel2_gpio: vsel2-gpio {
> > -			rockchip,pins =
> > -				<1 14 RK_FUNC_GPIO &pcfg_pull_down>;
> > -		};
> > -	};
> > -
> >  	usb2 {
> >  		host_vbus_drv: host-vbus-drv {
> >  			rockchip,pins =
> > @@ -473,37 +103,6 @@
> >  	};
> >  };
> >  
> > -&pwm2 {
> > -	status = "okay";
> > -};
> > -
> > -&pwm3 {
> > -	status = "okay";
> > -};
> > -
> > -&sdhci {
> > -	bus-width = <8>;
> > -	mmc-hs400-1_8v;
> > -	mmc-hs400-enhanced-strobe;
> > -	non-removable;
> > -	status = "okay";
> > -};
> > -
> > -&sdmmc {
> > -	bus-width = <4>;
> > -	cap-mmc-highspeed;
> > -	cap-sd-highspeed;
> > -	clock-frequency = <100000000>;
> > -	clock-freq-min-max = <100000 100000000>;
> > -	disable-wp;
> > -	sd-uhs-sdr104;
> > -	vqmmc-supply = <&vcc_sd>;
> > -	card-detect-delay = <800>;
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> > -	status = "okay";
> > -};
> > -
> >  &tcphy0 {
> >  	status = "okay";
> >  };
> > @@ -538,16 +137,6 @@
> >  	status = "okay";
> >  };
> >  
> > -&uart0 {
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&uart0_xfer &uart0_cts>;
> > -	status = "okay";
> > -};
> > -
> > -&uart2 {
> > -	status = "okay";
> > -};
> > -
> >  &usb_host0_ehci {
> >  	status = "okay";
> >  };
> > @@ -581,19 +170,3 @@
> >  	status = "okay";
> >  	dr_mode = "host";
> >  };
> > -
> > -&vopb {
> > -	status = "okay";
> > -};
> > -
> > -&vopb_mmu {
> > -	status = "okay";
> > -};
> > -
> > -&vopl {
> > -	status = "okay";
> > -};
> > -
> > -&vopl_mmu {
> > -	status = "okay";
> > -};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > new file mode 100644
> > index 000000000000..5a5d8e28ef55
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > @@ -0,0 +1,439 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2018 Collabora Ltd.
> > + * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
> > + * Copyright (c) 2018 Linaro Ltd.
> > + */
> > +
> > +#include "rk3399.dtsi"
> > +#include "rk3399-opp.dtsi"
> > +
> > +/ {
> > +	vcc1v8_s0: vcc1v8-s0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc1v8_s0";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	vcc_sys: vcc-sys {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_sys";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	vcc3v3_sys: vcc3v3-sys {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc3v3_sys";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-always-on;
> > +		vin-supply = <&vcc_sys>;
> > +	};
> > +
> > +	vdd_log: vdd-log {
> > +		compatible = "pwm-regulator";
> > +		pwms = <&pwm2 0 25000 0>;
> > +		regulator-name = "vdd_log";
> > +		regulator-min-microvolt = <800000>;
> > +		regulator-max-microvolt = <1400000>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		vin-supply = <&vcc_sys>;
> > +	};
> > +
> > +};
> > +
> > +&cpu_l0 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_l1 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_l2 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_l3 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_b0 {
> > +	cpu-supply = <&vdd_cpu_b>;
> > +};
> > +
> > +&cpu_b1 {
> > +	cpu-supply = <&vdd_cpu_b>;
> > +};
> > +
> > +&emmc_phy {
> > +	status = "okay";
> > +};
> > +
> > +&hdmi {
> > +	ddc-i2c-bus = <&i2c3>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&hdmi_cec>;
> > +	status = "okay";
> > +};
> > +
> > +&i2c0 {
> > +	clock-frequency = <400000>;
> > +	i2c-scl-rising-time-ns = <168>;
> > +	i2c-scl-falling-time-ns = <4>;
> > +	status = "okay";
> > +
> > +	vdd_cpu_b: regulator@40 {
> > +		compatible = "silergy,syr827";
> > +		reg = <0x40>;
> > +		fcs,suspend-voltage-selector = <1>;
> > +		regulator-name = "vdd_cpu_b";
> > +		regulator-min-microvolt = <712500>;
> > +		regulator-max-microvolt = <1500000>;
> > +		regulator-ramp-delay = <1000>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		vin-supply = <&vcc_sys>;
> > +		status = "okay";
> > +
> > +		regulator-state-mem {
> > +			regulator-off-in-suspend;
> > +		};
> > +	};
> > +
> > +	vdd_gpu: regulator@41 {
> > +		compatible = "silergy,syr828";
> > +		reg = <0x41>;
> > +		fcs,suspend-voltage-selector = <1>;
> > +		regulator-name = "vdd_gpu";
> > +		regulator-min-microvolt = <712500>;
> > +		regulator-max-microvolt = <1500000>;
> > +		regulator-ramp-delay = <1000>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		vin-supply = <&vcc_sys>;
> > +		regulator-state-mem {
> > +			regulator-off-in-suspend;
> > +		};
> > +	};
> > +
> > +	rk808: pmic@1b {
> > +		compatible = "rockchip,rk808";
> > +		reg = <0x1b>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pmic_int_l>;
> > +		rockchip,system-power-controller;
> > +		wakeup-source;
> > +		#clock-cells = <1>;
> > +		clock-output-names = "xin32k", "rk808-clkout2";
> > +
> > +		vcc1-supply = <&vcc_sys>;
> > +		vcc2-supply = <&vcc_sys>;
> > +		vcc3-supply = <&vcc_sys>;
> > +		vcc4-supply = <&vcc_sys>;
> > +		vcc6-supply = <&vcc_sys>;
> > +		vcc7-supply = <&vcc_sys>;
> > +		vcc8-supply = <&vcc3v3_sys>;
> > +		vcc9-supply = <&vcc_sys>;
> > +		vcc10-supply = <&vcc_sys>;
> > +		vcc11-supply = <&vcc_sys>;
> > +		vcc12-supply = <&vcc3v3_sys>;
> > +		vddio-supply = <&vcc_1v8>;
> > +
> > +		regulators {
> > +			vdd_center: DCDC_REG1 {
> > +				regulator-name = "vdd_center";
> > +				regulator-min-microvolt = <750000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdd_cpu_l: DCDC_REG2 {
> > +				regulator-name = "vdd_cpu_l";
> > +				regulator-min-microvolt = <750000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_ddr: DCDC_REG3 {
> > +				regulator-name = "vcc_ddr";
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_1v8: DCDC_REG4 {
> > +				regulator-name = "vcc_1v8";
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <1800000>;
> > +				};
> > +			};
> > +
> > +			vcc1v8_dvp: LDO_REG1 {
> > +				regulator-name = "vcc1v8_dvp";
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <1800000>;
> > +				};
> > +			};
> > +
> > +			vcca1v8_hdmi: LDO_REG2 {
> > +				regulator-name = "vcca1v8_hdmi";
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <1800000>;
> > +				};
> > +			};
> > +
> > +			vcca_1v8: LDO_REG3 {
> > +				regulator-name = "vcca_1v8";
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <1800000>;
> > +				};
> > +			};
> > +
> > +			vcc_sd: LDO_REG4 {
> > +				regulator-name = "vcc_sd";
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <3300000>;
> > +				};
> > +			};
> > +
> > +			vcc3v0_sd: LDO_REG5 {
> > +				regulator-name = "vcc3v0_sd";
> > +				regulator-min-microvolt = <3000000>;
> > +				regulator-max-microvolt = <3000000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <3000000>;
> > +				};
> > +			};
> > +
> > +			vcc_1v5: LDO_REG6 {
> > +				regulator-name = "vcc_1v5";
> > +				regulator-min-microvolt = <1500000>;
> > +				regulator-max-microvolt = <1500000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <1500000>;
> > +				};
> > +			};
> > +
> > +			vcca0v9_hdmi: LDO_REG7 {
> > +				regulator-name = "vcca0v9_hdmi";
> > +				regulator-min-microvolt = <900000>;
> > +				regulator-max-microvolt = <900000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <900000>;
> > +				};
> > +			};
> > +
> > +			vcc_3v0: LDO_REG8 {
> > +				regulator-name = "vcc_3v0";
> > +				regulator-min-microvolt = <3000000>;
> > +				regulator-max-microvolt = <3000000>;
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = <3000000>;
> > +				};
> > +			};
> > +
> > +			vcc3v3_s3: SWITCH_REG1 {
> > +				regulator-name = "vcc3v3_s3";
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc3v3_s0: SWITCH_REG2 {
> > +				regulator-name = "vcc3v3_s0";
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&i2c1 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c2 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c3 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c4 {
> > +	status = "okay";
> > +};
> > +
> > +&io_domains {
> > +	bt656-supply = <&vcc1v8_s0>; /* bt656_gpio2ab_ms */
> > +	audio-supply = <&vcc1v8_s0>; /* audio_gpio3d4a_ms */
> > +	sdmmc-supply = <&vcc_sd>; /* sdmmc_gpio4b_ms */
> > +	gpio1830-supply = <&vcc_3v0>; /* gpio1833_gpio4cd_ms */
> > +	status = "okay";
> > +};
> > +
> > +&pmu_io_domains {
> > +	pmu1830-supply = <&vcc_1v8>;
> > +	status = "okay";
> > +};
> > +
> > +&pinctrl {
> > +	sdmmc {
> > +		sdmmc_bus1: sdmmc-bus1 {
> > +			rockchip,pins =
> > +				<4 8 RK_FUNC_1 &pcfg_pull_up_8ma>;
> > +		};
> > +
> > +		sdmmc_bus4: sdmmc-bus4 {
> > +			rockchip,pins =
> > +				<4 8 RK_FUNC_1 &pcfg_pull_up_8ma>,
> > +				<4 9 RK_FUNC_1 &pcfg_pull_up_8ma>,
> > +				<4 10 RK_FUNC_1 &pcfg_pull_up_8ma>,
> > +				<4 11 RK_FUNC_1 &pcfg_pull_up_8ma>;
> > +		};
> > +
> > +		sdmmc_clk: sdmmc-clk {
> > +			rockchip,pins =
> > +				<4 12 RK_FUNC_1 &pcfg_pull_none_18ma>;
> > +		};
> > +
> > +		sdmmc_cmd: sdmmc-cmd {
> > +			rockchip,pins =
> > +				<4 13 RK_FUNC_1 &pcfg_pull_up_8ma>;
> > +		};
> > +	};
> > +
> > +	pmic {
> > +		pmic_int_l: pmic-int-l {
> > +			rockchip,pins =
> > +				<1 21 RK_FUNC_GPIO &pcfg_pull_up>;
> > +		};
> > +
> > +		vsel1_gpio: vsel1-gpio {
> > +			rockchip,pins =
> > +				<1 17 RK_FUNC_GPIO &pcfg_pull_down>;
> > +		};
> > +
> > +		vsel2_gpio: vsel2-gpio {
> > +			rockchip,pins =
> > +				<1 14 RK_FUNC_GPIO &pcfg_pull_down>;
> > +		};
> > +	};
> > +};
> > +
> > +&pwm2 {
> > +	status = "okay";
> > +};
> > +
> > +&pwm3 {
> > +	status = "okay";
> > +};
> > +
> > +&sdhci {
> > +	bus-width = <8>;
> > +	mmc-hs400-1_8v;
> > +	mmc-hs400-enhanced-strobe;
> > +	non-removable;
> > +	status = "okay";
> > +};
> > +
> > +&sdmmc {
> > +	bus-width = <4>;
> > +	cap-mmc-highspeed;
> > +	cap-sd-highspeed;
> > +	clock-frequency = <100000000>;
> > +	clock-freq-min-max = <100000 100000000>;
> > +	disable-wp;
> > +	sd-uhs-sdr104;
> > +	vqmmc-supply = <&vcc_sd>;
> > +	card-detect-delay = <800>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> > +	status = "okay";
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_xfer &uart0_cts>;
> > +	status = "okay";
> > +};
> > +
> > +&uart2 {
> > +	status = "okay";
> > +};
> > +
> > +&vopb {
> > +	status = "okay";
> > +};
> > +
> > +&vopb_mmu {
> > +	status = "okay";
> > +};
> > +
> > +&vopl {
> > +	status = "okay";
> > +};
> > +
> > +&vopl_mmu {
> > +	status = "okay";
> > +};
> 
