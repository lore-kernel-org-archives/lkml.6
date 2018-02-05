Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeBEGH3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:07:29 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45324 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbeBEGHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:07:16 -0500
X-Google-Smtp-Source: AH8x225f4VKZSs2QDDJuUnp6kfIqwf5pj+wvLwncu6SHVQ5DlXJPHDOAv6NijBYjDnbmTfSYzbOlhw==
Date: Mon, 5 Feb 2018 00:07:13 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, mark.rutland@arm.com,
        shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] ARM: dts: imx7s: add temperature monitor support
Message-ID: <20180205060713.fis5uawasxhgsjd6@rob-hp-laptop>
References: <1516954180-26029-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516954180-26029-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 04:09:39PM +0800, Anson Huang wrote:
> Add i.MX7 temperature monitor support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> no changes since V1.
>  .../devicetree/bindings/thermal/imx-thermal.txt      |  5 +++--
>  arch/arm/boot/dts/imx7s.dtsi                         | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 28be51a..9575d45 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -1,8 +1,9 @@
>  * Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
>  
>  Required properties:
> -- compatible : "fsl,imx6q-tempmon" for i.MX6Q, "fsl,imx6sx-tempmon" for i.MX6SX.
> -  i.MX6SX has two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
> +- compatible : "fsl,imx6q-tempmon" for i.MX6Q, "fsl,imx6sx-tempmon" for i.MX6SX,
> +  "fsl,imx7-tempmon" for i.MX7S/D.

Please format as one valid compatible combination per line.

> +  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,

This belongs with the interrupt property.

>    when temperature is below than low threshold, IRQ_LOW will be triggered, when temperature
>    is higher than panic threshold, system will auto reboot by SRC module.
>  - fsl,tempmon : phandle pointer to system controller that contains TEMPMON
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 82ad26e..2e2eda53 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -497,9 +497,29 @@
>  			};
>  
>  			ocotp: ocotp-ctrl@30350000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
>  				compatible = "fsl,imx7d-ocotp", "syscon";
>  				reg = <0x30350000 0x10000>;
>  				clocks = <&clks IMX7D_OCOTP_CLK>;
> +
> +				tempmon_calib: calib@3c {
> +					reg = <0x3c 0x4>;
> +				};
> +
> +				tempmon_temp_grade: temp-grade@10 {
> +					reg = <0x10 0x4>;
> +				};
> +			};
> +
> +			tempmon: tempmon {
> +				compatible = "fsl,imx7-tempmon";
> +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +				fsl,tempmon =<&anatop>;
> +				nvmem-cells = <&tempmon_calib>,
> +					<&tempmon_temp_grade>;
> +				nvmem-cell-names = "calib", "temp_grade";
> +				clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
>  			};
>  
>  			anatop: anatop@30360000 {
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
