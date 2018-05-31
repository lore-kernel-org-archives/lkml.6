Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbeEaDBd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:01:33 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:32877 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeEaDBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:01:31 -0400
X-Google-Smtp-Source: ADUXVKJ2mH5sUgCUALPnqrX79FZ3VBQ2+Pfd9BepvxlGSJKaMemU5StjSykIKrgTVpQ6W4dPU1xcJw==
Date: Wed, 30 May 2018 22:01:29 -0500
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 2/6] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180531030129.GA16122@rob-hp-laptop>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <3b05ca98a671a762013c312f8b70543402ee7556.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b05ca98a671a762013c312f8b70543402ee7556.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:42:03AM +0300, Matti Vaittinen wrote:
> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> new file mode 100644
> index 000000000000..bbc46d38b162
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> @@ -0,0 +1,52 @@
> +* ROHM BD71837 Power Management Integrated Circuit bindings
> +
> +BD71837MWV is a programmable Power Management IC for powering single-core,
> +dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
> +low BOM cost and compact solution footprint. It integrates 8 Buck
> +egulators and 7 LDO’s to provide all the power rails required by the SoC and
> +the commonly used peripherals.
> +
> +Required properties:
> + - compatible		: Should be "rohm,bd71837".
> + - reg			: I2C slave address.
> + - interrupt-parent	: Phandle to the parent interrupt controller.
> + - interrupts		: The interrupt line the device is connected to.
> + - interrupt-controller	: Marks the device node as an interrupt controller.

What sub blocks have interrupts?

> + - #interrupt-cells	: The number of cells to describe an IRQ, should be 1 or 2.
> +			    The first cell is the IRQ number.
> +			    The second cell if present is the flags, encoded as trigger
> +			    masks from ../interrupt-controller/interrupts.txt.
> + - regulators:		: List of child nodes that specify the regulators
> +			  Please see ../regulator/rohm,bd71837-regulator.txt
> + - clock:		: Please see ../clock/rohm,bd71837-clock.txt
> +
> +Example:
> +
> +	pmic: bd71837@4b {

Node names should be generic ideally. So "pmic@4b"

> +		compatible = "rohm,bd71837";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x4b>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <29 GPIO_ACTIVE_LOW>;
> +		interrupt-names = "irq";
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "buck1";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +			...
> +		};
> +		clk: bd71837-32k-out {

clock-controller {

> +			compatible = "rohm,bd71837-clk";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;

Can this be anything else?

> +			clock-output-names = "bd71837-32k-out";
> +		};
> +	};
> -- 
> 2.14.3
> 
