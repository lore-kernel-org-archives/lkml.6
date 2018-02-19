Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeBSBvM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 20:51:12 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39242 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeBSBvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 20:51:10 -0500
X-Google-Smtp-Source: AH8x227on7nYoqo9mfBX+VTisaWsj+PZ4TO42veSjyYoY78zziGlHDCUNKmUWoUJxdPI9/LSoSs/jg==
Date: Sun, 18 Feb 2018 19:51:08 -0600
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: add support for STM32 USB PHY
 Controller (USBPHYC)
Message-ID: <20180219015108.bxt6qn7tz53ydguv@rob-hp-laptop>
References: <1518438929-5254-1-git-send-email-amelie.delaunay@st.com>
 <1518438929-5254-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518438929-5254-2-git-send-email-amelie.delaunay@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 01:35:28PM +0100, Amelie Delaunay wrote:
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
> index 0000000..1e65e0a
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
> +  |_ PLL
> +  |
> +  |_ PHY port#1 _________________ HOST controller
> +  |                                      |
> +  |_ PHY port#2_______                   |
> +  |                   |_                 |
> +  |_ UTMI switch_____/ 1|________________|
> +                    |   |________________
> +                     \_0|                |
> +		                  OTG controller
> +
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
> +- st,port2-switch-to-host: select HOST controller on UTMI switch for port#2

This one seems very specific. If another device had the mux on a 
different port number you'd need a new property for example.

But really I think this should be determined by either a USB connector 
node (a binding is in the works) or cable detection.

> +
> +
> +Example:
> +		usbphyc: usbphyc@5a006000 {

usb-phy@...

> +			compatible = "st,stm32mp1-usbphyc";
> +			reg = <0x5a006000 0x1000>;
> +			clocks = <&rcc_clk USBPHY_K>;
> +			resets = <&rcc_rst USBPHY_R>;
> +			st,port2-switch-to-host;
> +			phy-supply = <&vdd_usb>;
> +			vdda1v1-supply = <&reg11>;
> +			vdda1v8-supply = <&reg18>
> +		};
> -- 
> 2.7.4
> 
