Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935855AbeCBGD1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 01:03:27 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:42590 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932310AbeCBGDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 01:03:25 -0500
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add support for STM32 USB PHY
 Controller (USBPHYC)
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <1519918245-17333-1-git-send-email-amelie.delaunay@st.com>
 <1519918245-17333-2-git-send-email-amelie.delaunay@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <bac8ba1a-dd66-4df6-1976-c6144e35040c@ti.com>
Date: Fri, 2 Mar 2018 11:32:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1519918245-17333-2-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 01 March 2018 09:00 PM, Amelie Delaunay wrote:
> This patch adds the device tree bindings description for STM32 USBPHYC
> (USB PHY Controller).
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/phy/phy-stm32-usbphyc.txt  | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
> new file mode 100644
> index 0000000..1ad3893
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
> @@ -0,0 +1,46 @@
> +STMicroelectronics STM32 USB HS PHY controller
> +
> +The STM32 USBPHYC block contains a dual port High Speed UTMI+ PHY and a UTMI
> +switch. It controls PHY configuration and status, and the UTMI+ switch that
> +selects either OTG or HOST controller for the second PHY port. It also sets
> +PLL configuration.
> +
> +USBPHYC
> +      |_ PLL
> +      |
> +      |_ PHY port#1 _________________ HOST controller
> +      |                    _                 |
> +      |                  / 1|________________|
> +      |_ PHY port#2 ----|   |________________
> +      |                  \_0|                |
> +      |_ UTMI switch_______|          OTG controller
> +
> +

This should be modeled as a phy provider node with two separate sub-nodes for
each of the PHYs.

Thanks
Kishon

> +Required properties:
> +- compatible: must be "st,stm32mp1-usbphyc"
> +- reg: address and length of the usb phy control register set
> +- clocks: phandle + clock specifier for the PLL phy clock
> +- phy-supply: from the generic phy bindings, phandle to the regulator
> +  providing 3V3 power to the PHY, see phy-bindings.txt
> +- vdda1v1-supply: phandle to the regulator providing 1V1 power to the PHY
> +- vdda1v8-supply: phandle to the regulator providing 1V8 power to the PHY
> +
> +Optional properties:
> +- assigned-clocks: phandle + clock specifier for the PLL phy clock
> +- assigned-clock-parents: the PLL phy clock parent
> +- resets: phandle + reset specifier
> +- st,utmi-switch: should be <0> or <1>, to select USB controller for PHY
> +  port#2. If not specified, 0 is the default selection.
> +
> +
> +Example:
> +		usbphyc: usb-phy@5a006000 {
> +			compatible = "st,stm32mp1-usbphyc";
> +			reg = <0x5a006000 0x1000>;
> +			clocks = <&rcc_clk USBPHY_K>;
> +			resets = <&rcc_rst USBPHY_R>;
> +			st,utmi-switch = <1>;
> +			phy-supply = <&vdd_usb>;
> +			vdda1v1-supply = <&reg11>;
> +			vdda1v8-supply = <&reg18>
> +		};
> 
