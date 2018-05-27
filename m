Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeE0WYA convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:24:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57002 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbeE0WX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:23:58 -0400
Date: Mon, 28 May 2018 00:23:54 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, dev@lynxeye.de,
        richard@nod.at, marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mtd: rawnand: tegra: add devicetree binding
Message-ID: <20180528002354.45025afd@xps13>
In-Reply-To: <20180527215442.14760-3-stefan@agner.ch>
References: <20180527215442.14760-3-stefan@agner.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Sun, 27 May 2018 23:54:38 +0200, Stefan Agner <stefan@agner.ch>
wrote:

> From: Lucas Stach <dev@lynxeye.de>
> 
> This adds the devicetree binding for the Tegra 2 NAND flash
> controller.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../bindings/mtd/nvidia,tegra20-nand.txt      | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> new file mode 100644
> index 000000000000..49e472af1b39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> @@ -0,0 +1,62 @@
> +NVIDIA Tegra NAND Flash controller
> +
> +Required properties:
> +- compatible: Must be one of:

Nitpick: just put the compatible here as there is only one?

> +  - "nvidia,tegra20-nand"
> +- reg: MMIO address range
> +- interrupts: interrupt output of the NFC controller
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - nand
> +- resets: Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names: Must include the following entries:
> +  - nand
> +
> +Optional children nodes:
> +Individual NAND chips are children of the NAND controller node. Currently
> +only one NAND chip supported.
> +
> +Required children node properties:
> +- reg: An integer ranging from 1 to 6 representing the CS line to use.

>From 1? It usually starts at 0.

> +
> +Optional children node properties:
> +- nand-ecc-mode: String, operation mode of the NAND ecc mode. "hw" by default
> +- nand-ecc-algo: string, algorithm of NAND ECC.
> +		 Supported values are: "rs", "bch".
> +- nand-bus-width : 8 or 16 bus width if not present 8
> +- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
> +- nand-ecc-strength: integer representing the number of bits to correct
> +		     per ECC step. Supported strength using HW ECC modes are:
> +		     - RS: 4, 6, 8
> +		     - BCH: 4, 8, 14, 16
> +- nand-ecc-step-size: integer representing the number of data bytes
> +		      that are covered by a single ECC step. Must be 512.

Please don't re-explain nand generic DT properties, point to nand.txt
instead.

> +- wp-gpios: GPIO specifier for the write protect pin.
> +
> +Optional child node of NAND chip nodes:
> +Partitions: see partition.txt
> +
> +  Example:
> +	nand@70008000 {
> +		compatible = "nvidia,tegra20-nand";
> +		reg = <0x70008000 0x100>;
> +		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
> +		clock-names = "nand";
> +		resets = <&tegra_car 13>;
> +		reset-names = "nand";
> +
> +		nand-chip@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			nand-bus-width = <8>;
> +			nand-on-flash-bbt;
> +			nand-ecc-algo = "bch";
> +			nand-ecc-step-size = <512>;

In the driver you only refer to step sizes of 512 B, you can remove the
property from the bindings.

> +			nand-ecc-strength = <8>;
> +			wp-gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;
> +		};
> +	};



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
