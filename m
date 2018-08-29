Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BEBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B60C2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJiMTQRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B60C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeH2Tsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:48:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44928 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeH2Tsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:48:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so2448564pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XW+W10N2nTfRkfD3cxnqXmr5W8kfNRIjc3yget8eRNo=;
        b=HJiMTQRLyr6PcQjk8dyFyrR/o9MlNrX8l9+9MEwJTckVBOs8hvTlXKingQZn0QKA4f
         +OwdYu1E1pdPxjm5EaqkTRHtoDWNkxHMYGPEaVAIclM3f33yauzbXi48SeC3TfPKp0Je
         LHhLpKRGUm2/w5l1WNAvOQTYeobjo7GW9EoVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XW+W10N2nTfRkfD3cxnqXmr5W8kfNRIjc3yget8eRNo=;
        b=S2Y/X+m/6VtHZQ7Boxb3WVAHCBjrNeTk8uNuRhQfGsdX7vA10X5/dssm7J2tPwSeFO
         JY+LUYPVqKTutK5KKDZMRo1LNiudY9MpVcNldlolT2d0UV2gfRZLaFaXT/yz8k6Jb3gA
         6zCO2HAs4ZGae8RlyWUlV848EsPLO0XrUqIOqnn3CmmUA1qGy0lAr4a1vDOc8XaZy0qw
         fJqtWliWR97+8tpokO+3JEpo6Tddv3jVUd7xWHOyyn0zRzhJAHJYYOGjE8k19tXFoh0j
         Cc4uQzTsF/MtJwaBtD6jE0mDEM2DIRItoFyOREpvwxz1vMTKUqzZaCphcPSap/nxAdJY
         Idew==
X-Gm-Message-State: APzg51AgvjF9SIWIFjg1KRpyeMPxaUmX2lZYseLdvnNtsz3uXIGCq26I
        xp1J7xSLGXpA3y111Da3TX4BcVk8hA==
X-Google-Smtp-Source: ANB0VdYFgmlx1YMWqwF18K8sggG2q0H6PZRYAZMrN3O1L6h/jrk/rAmdQ93jHuM5jQPhbybwaUy0yA==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr6359326pgt.164.1535557856914;
        Wed, 29 Aug 2018 08:50:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6384:6a6:70b9:a288:9cdc:3e44])
        by smtp.gmail.com with ESMTPSA id g5-v6sm14560714pgn.73.2018.08.29.08.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 08:50:56 -0700 (PDT)
Date:   Wed, 29 Aug 2018 21:20:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
Subject: Re: [PATCH v5 3/5] dt-bindings: pinctrl: Add bindings for Actions
 Semi S700 SoC
Message-ID: <20180829155044.GC21136@Mani-XPS-13-9360>
References: <20180829082413.2512005-1-sravanhome@gmail.com>
 <20180829082413.2512005-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829082413.2512005-4-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:24:11AM +0200, Saravanan Sekar wrote:
> Add pinctrl and pio bindings for Actions Semi S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pinctrl/actions,s700-pinctrl.txt      | 170 +++++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
> new file mode 100644
> index 000000000000..ceed32e836b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
> @@ -0,0 +1,170 @@
> +Actions Semi S700 Pin Controller
> +
> +This binding describes the pin controller found in the S700 SoC.
> +
> +Required Properties:
> +
> +- compatible:   Should be "actions,s700-pinctrl"
> +- reg:          Should contain the register base address and size of
> +		the pin controller.
> +- clocks:       phandle of the clock feeding the pin controller
> +- gpio-controller: Marks the device node as a GPIO controller.
> +- gpio-ranges: Specifies the mapping between gpio controller and
> +               pin-controller pins.
> +- #gpio-cells: Should be two. The first cell is the gpio pin number
> +		and the second cell is used for optional parameters.
> +- interrupt-controller: Marks the device node as an interrupt controller.
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +		interrupt.  Shall be set to 2.  The first cell
> +		defines the interrupt number, the second encodes
> +		the trigger flags described in
> +		bindings/interrupt-controller/interrupts.txt
> +- interrupts: The interrupt outputs from the controller. There is one GPIO
> +              interrupt per GPIO bank. The number of interrupts listed depends
> +              on the number of GPIO banks on the SoC. The interrupts must be
> +              ordered by bank, starting with bank 0.
> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices, including the meaning of the
> +phrase "pin configuration node".
> +
> +The pin configuration nodes act as a container for an arbitrary number of
> +subnodes. Each of these subnodes represents some desired configuration for a
> +pin, a group, or a list of pins or groups. This configuration can include the
> +mux function to select on those group(s), and various pin configuration
> +parameters, such as pull-up, drive strength, etc.
> +
> +PIN CONFIGURATION NODES:
> +
> +The name of each subnode is not important; all subnodes should be enumerated
> +and processed purely based on their content.
> +
> +Each subnode only affects those parameters that are explicitly listed. In
> +other words, a subnode that lists a mux function but no pin configuration
> +parameters implies no information about any pin configuration parameters.
> +Similarly, a pin subnode that describes a pullup parameter implies no
> +information about e.g. the mux function.
> +
> +Pinmux functions are available only for the pin groups while pinconf
> +parameters are available for both pin groups and individual pins.
> +
> +The following generic properties as defined in pinctrl-bindings.txt are valid
> +to specify in a pin configuration subnode:
> +
> +Required Properties:
> +
> +- pins:		An array of strings, each string containing the name of a pin.
> +		These pins are used for selecting the pull control and schmitt
> +		trigger parameters. The following are the list of pins
> +		available:
> +
> +		eth_txd0, eth_txd1, eth_txd2, eth_txd3, eth_txen, eth_rxer,
> +		eth_crs_dv, eth_rxd1, eth_rxd0, eth_rxd2, eth_rxd3, eth_ref_clk,
> +		eth_mdc, eth_mdio, sirq0, sirq1, sirq2, i2s_d0, i2s_bclk0,
> +		i2s_lrclk0, i2s_mclk0, i2s_d1, i2s_bclk1, i2s_lrclk1, i2s_mclk1,
> +		pcm1_in, pcm1_clk, pcm1_sync, pcm1_out, ks_in0, ks_in1, ks_in2,
> +		ks_in3, ks_out0, ks_out1, ks_out2, lvds_oep, lvds_oen, lvds_odp,
> +		lvds_odn, lvds_ocp, lvds_ocn, lvds_obp, lvds_obn, lvds_oap,
> +		lvds_oan, lvds_eep, lvds_een, lvds_edp, lvds_edn, lvds_ecp,
> +		lvds_ecn, lvds_ebp, lvds_ebn, lvds_eap, lvds_ean, lcd0_d18,
> +		lcd0_d2, dsi_dp3, dsi_dn3, dsi_dp1, dsi_dn1, dsi_cp, dsi_cn,
> +		dsi_dp0, dsi_dn0, dsi_dp2, dsi_dn2, sd0_d0, sd0_d1, sd0_d2,
> +		sd0_d3, sd1_d0, sd1_d1, sd1_d2, sd1_d3, sd0_cmd, sd0_clk,
> +		sd1_cmd, sd1_clk, spi0_ss, spi0_miso, uart0_rx, uart0_tx,
> +		uart2_rx, uart2_tx, uart2_rtsb, uart2_ctsb, uart3_rx, uart3_tx,
> +		uart3_rtsb, uart3_ctsb, i2c0_sclk, i2c0_sdata, i2c1_sclk,
> +		i2c1_sdata, i2c2_sdata, csi_dn0, csi_dp0, csi_dn1, csi_dp1,
> +		csi_cn, csi_cp, csi_dn2, csi_dp2, csi_dn3, csi_dp3,
> +		sensor0_pclk, sensor0_ckout, dnand_d0, dnand_d1, dnand_d2,
> +		dnand_d3, dnand_d4, dnand_d5, dnand_d6, dnand_d7, dnand_wrb,
> +		dnand_rdb, dnand_rdbn, dnand_dqs, dnand_dqsn, dnand_rb0,
> +		dnand_ale, dnand_cle, dnand_ceb0, dnand_ceb1, dnand_ceb2,
> +		dnand_ceb3, porb, clko_25m, bsel, pkg0, pkg1, pkg2, pkg3
> +
> +- groups:       An array of strings, each string containing the name of a pin
> +                group. These pin groups are used for selecting the pinmux
> +                functions.
> +		rgmii_txd23_mfp, rgmii_rxd2_mfp, rgmii_rxd3_mfp, lcd0_d18_mfp,
> +		rgmii_txd01_mfp, rgmii_txd0_mfp, rgmii_txd1_mfp, rgmii_txen_mfp,
> +		rgmii_rxen_mfp, rgmii_rxd1_mfp, rgmii_rxd0_mfp, rgmii_ref_clk_mfp,
> +		i2s_d0_mfp, i2s_pcm1_mfp, i2s0_pcm0_mfp, i2s1_pcm0_mfp,
> +		i2s_d1_mfp, ks_in2_mfp, ks_in1_mfp, ks_in0_mfp, ks_in3_mfp,
> +		ks_out0_mfp, ks_out1_mfp, ks_out2_mfp, lvds_o_pn_mfp, dsi_dn0_mfp,
> +		dsi_dp2_mfp, lcd0_d2_mfp, dsi_dp3_mfp, dsi_dn3_mfp, dsi_dp0_mfp,
> +		lvds_ee_pn_mfp, uart2_rx_tx_mfp, spi0_i2c_pcm_mfp, dsi_dnp1_cp_d2_mfp,
> +		dsi_dnp1_cp_d17_mfp, lvds_e_pn_mfp, dsi_dn2_mfp, uart2_rtsb_mfp,
> +		uart2_ctsb_mfp, uart3_rtsb_mfp, uart3_ctsb_mfp, sd0_d0_mfp, sd0_d1_mfp,
> +		sd0_d2_d3_mfp, sd1_d0_d3_mfp, sd0_cmd_mfp, sd0_clk_mfp, sd1_cmd_mfp,
> +		uart0_rx_mfp, clko_25m_mfp, csi_cn_cp_mfp, sens0_ckout_mfp, uart0_tx_mfp,
> +		i2c0_mfp, csi_dn_dp_mfp, sen0_pclk_mfp, pcm1_in_mfp, pcm1_clk_mfp,
> +		pcm1_sync_mfp, pcm1_out_mfp, dnand_data_wr_mfp, dnand_acle_ce0_mfp,
> +		nand_ceb2_mfp, nand_ceb3_mfp
> +
> +		These pin groups are used for selecting the drive strength
> +		parameters.
> +
> +		sirq_drv, rgmii_txd23_drv, rgmii_rxd23_drv, rgmii_txd01_txen_drv,
> +		rgmii_rxer_drv, rgmii_crs_drv, rgmii_rxd10_drv, rgmii_ref_clk_drv,
> +		smi_mdc_mdio_drv, i2s_d0_drv, i2s_bclk0_drv, i2s3_drv, i2s13_drv,
> +		pcm1_drv, ks_in_drv, ks_out_drv, lvds_all_drv, lcd_d18_d2_drv,
> +		dsi_all_drv, sd0_d0_d3_drv, sd0_cmd_drv, sd0_clk_drv, spi0_all_drv,
> +		uart0_rx_drv, uart0_tx_drv, uart2_all_drv, i2c0_all_drv, i2c12_all_drv,
> +		sens0_pclk_drv, sens0_ckout_drv, uart3_all_drv
> +
> +- function:	An array of strings, each string containing the name of the
> +		pinmux functions. These functions can only be selected by
> +		the corresponding pin groups. The following are the list of
> +		pinmux functions available:
> +
> +		nor, eth_rgmii, eth_sgmii, spi0, spi1, spi2, spi3, seNs0, sens1,
> +		uart0, uart1, uart2, uart3, uart4, uart5, uart6, i2s0, i2s1,
> +		pcm1, pcm0, ks, jtag, pwm0, pwm1, pwm2, pwm3, pwm4, pwm5, p0,
> +		sd0, sd1, sd2, i2c0, i2c1, i2c2, i2c3, dsi, lvds, usb30,
> +		clko_25m, mipi_csi, nand, spdif, sirq0, sirq1, sirq2, bt, lcd0
> +
> +Optional Properties:
> +
> +- bias-pull-down: No arguments. The specified pins should be configured as
> +		pull down.
> +- bias-pull-up:   No arguments. The specified pins should be configured as
> +		pull up.
> +- input-schmitt-enable: No arguments: Enable schmitt trigger for the specified
> +		pins
> +- input-schmitt-disable: No arguments: Disable schmitt trigger for the specified
> +		pins
> +- drive-strength: Integer. Selects the drive strength for the specified
> +		pins in mA.
> +		Valid values are:
> +		<2>
> +		<4>
> +		<8>
> +		<12>
> +
> +Example:
> +
> +	pinctrl: pinctrl@e01b0000 {
> +		compatible = "actions,s700-pinctrl";
> +		reg = <0x0 0xe01b0000 0x0 0x1000>;
> +		clocks = <&cmu CLK_GPIO>;
> +		gpio-controller;
> +		gpio-ranges = <&pinctrl 0 0 136>;

Not sure about this pin count. As per my datasheet, only 122 pins
are available. More justification will be provided in driver patch.

> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +                interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>

Missing semicolon.

Regards,
Mani

> +
> +		uart3-default: uart3-default {
> +			pinmux {
> +				groups = "uart3_rtsb_mfp", "uart3_ctsb_mfp";
> +				function = "uart3";
> +			};
> +			pinconf {
> +				groups = "uart3_all_drv";
> +				drive-strength = <2>;
> +			};
> +		};
> +	};
> -- 
> 2.14.4
> 
