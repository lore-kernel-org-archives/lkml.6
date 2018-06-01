Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbeFAHaa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:30:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42825 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbeFAHa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:30:28 -0400
Date: Fri, 1 Jun 2018 09:30:25 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, benjamin.lindqvist@endian.se,
        pgaikwad@nvidia.com, dev@lynxeye.de, mirza.krak@gmail.com,
        richard@nod.at, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org,
        krzk@kernel.org, jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org,
        digetx@gmail.com
Subject: Re: [PATCH v3 3/6] mtd: rawnand: tegra: add devicetree binding
Message-ID: <20180601093025.2817ff30@bbrezillon>
In-Reply-To: <20180531221637.6017-4-stefan@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-4-stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jun 2018 00:16:34 +0200
Stefan Agner <stefan@agner.ch> wrote:

> This adds the devicetree binding for the Tegra 2 NAND flash
> controller.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../bindings/mtd/nvidia-tegra20-nand.txt      | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> new file mode 100644
> index 000000000000..5cd984ef046b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> @@ -0,0 +1,64 @@
> +NVIDIA Tegra NAND Flash controller
> +
> +Required properties:
> +- compatible: Must be one of:
> +  - "nvidia,tegra20-nand"

As discussed previously, I prefer "nvidia,tegra20-nand-controller" or
"nvidia,tegra20-nfc".

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
> +
> +Optional children node properties:
> +- nand-ecc-mode: String, operation mode of the NAND ecc mode. Currently only
> +		 "hw" is supported.
> +- nand-ecc-algo: string, algorithm of NAND ECC.
> +		 Supported values with "hw" ECC mode are: "rs", "bch".
> +- nand-bus-width : See nand.txt
> +- nand-on-flash-bbt: See nand.txt
> +- nand-ecc-strength: integer representing the number of bits to correct
> +		     per ECC step (always 512). Supported strength using HW ECC
> +		     modes are:
> +		     - RS: 4, 6, 8
> +		     - BCH: 4, 8, 14, 16
> +- nand-ecc-maximize: See nand.txt
> +- nand-is-boot-medium: Makes sure only ECC strengths supported by the boot ROM
> +		       are choosen.
> +- wp-gpios: GPIO specifier for the write protect pin.
> +
> +Optional child node of NAND chip nodes:
> +Partitions: see partition.txt
> +
> +  Example:
> +	nand@70008000 {

	nand-controller@70008000 {

> +		compatible = "nvidia,tegra20-nand";

		compatible = "nvidia,tegra20-nand-controller";

or

		compatible = "nvidia,tegra20-nfc";

> +		reg = <0x70008000 0x100>;
> +		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
> +		clock-names = "nand";
> +		resets = <&tegra_car 13>;
> +		reset-names = "nand";
> +
> +		nand-chip@0 {

		nand@0 {

> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			nand-bus-width = <8>;
> +			nand-on-flash-bbt;
> +			nand-ecc-algo = "bch";
> +			nand-ecc-strength = <8>;
> +			wp-gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;
> +		};
> +	};

With this addressed,

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
