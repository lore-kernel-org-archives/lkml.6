Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeCGVLj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 16:11:39 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38175 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCGVLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 16:11:37 -0500
X-Google-Smtp-Source: AG47ELt9X3owHEPgNN33ruzBL0pKekmYuXkWqst6pbygK4/mUgo5ySup2aatRqCB+XZRVgusPJ0q/w==
Date: Wed, 7 Mar 2018 15:11:18 -0600
From: Rob Herring <robh@kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pengcheng Li <lpc.li@hisilicon.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: add bindings doc for HiSilicon INNO
 USB2 PHY
Message-ID: <20180307211118.su2vyfa4zyfh4w2t@rob-hp-laptop>
References: <1520217605-9312-1-git-send-email-shawn.guo@linaro.org>
 <1520217605-9312-2-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520217605-9312-2-git-send-email-shawn.guo@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 10:40:04AM +0800, Shawn Guo wrote:
> From: Pengcheng Li <lpc.li@hisilicon.com>
> 
> It adds device tree bindings document for HiSilicon INNO USB2 PHY.
> 
> Signed-off-by: Pengcheng Li <lpc.li@hisilicon.com>
> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
> new file mode 100644
> index 000000000000..4dbf87c70b96
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
> @@ -0,0 +1,72 @@
> +Device tree bindings for HiSilicon INNO USB2 PHY
> +
> +Required properties:
> +- compatible: Should be one of the following strings:
> +	"hisilicon,inno-usb2-phy",
> +	"hisilicon,hi3798cv200-usb2-phy".
> +- reg: Should be the address space for PHY configuration register in peripheral
> +  controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798CV200 SoC.
> +- clocks: The phandle and clock specifier pair for INNO USB2 PHY device
> +  reference clock.
> +- resets: The phandle and reset specifier pair for INNO USB2 PHY device reset
> +  signal.
> +- #address-cells: Must be 1.
> +- #size-cells: Must be 0.
> +
> +The INNO USB2 PHY device should be a child node of peripheral controller that
> +contains the PHY configuration register, and each device suppports up to 2 PHY
> +ports which are represented as child nodes of INNO USB2 PHY device.
> +
> +Required properties for PHY port node:
> +- reg: The PHY port instance number.
> +- #phy-cells: Defined by generic PHY bindings.  Must be 0.
> +- resets: The phandle and reset specifier pair for PHY port reset signal.
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> +
> +Example:
> +
> +perictrl: peripheral-controller@8a20000 {
> +	compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
> +		     "simple-mfd";

Is syscon needed here? Doesn't look like the phys need it.

Is there no dependency on the peri ctrl probing first for the phys to 
probe successfully? If there is some dependency, simple-mfd should not 
be used.

As for the phy binding,

Reviewed-by: Rob Herring <robh@kernel.org>

> +	reg = <0x8a20000 0x1000>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0x0 0x8a20000 0x1000>;
> +
> +	usb2_phy1: usb2-phy@120 {
> +		compatible = "hisilicon,hi3798cv200-usb2-phy";
> +		reg = <0x120 0x4>;
> +		clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
> +		resets = <&crg 0xbc 4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usb2_phy1_port0: phy@0 {
> +			reg = <0>;
> +			#phy-cells = <0>;
> +			resets = <&crg 0xbc 8>;
> +		};
> +
> +		usb2_phy1_port1: phy@1 {
> +			reg = <1>;
> +			#phy-cells = <0>;
> +			resets = <&crg 0xbc 9>;
> +		};
> +	};
> +
> +	usb2_phy2: usb2-phy@124 {
> +		compatible = "hisilicon,hi3798cv200-usb2-phy";
> +		reg = <0x124 0x4>;
> +		clocks = <&crg HISTB_USB2_PHY2_REF_CLK>;
> +		resets = <&crg 0xbc 6>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usb2_phy2_port0: phy@0 {
> +			reg = <0>;
> +			#phy-cells = <0>;
> +			resets = <&crg 0xbc 10>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
