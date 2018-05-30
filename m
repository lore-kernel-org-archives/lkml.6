Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753726AbeE3PLF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:11:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46354 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752773AbeE3PLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:11:00 -0400
Date: Wed, 30 May 2018 17:10:57 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com, han.xu@nxp.com,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] ARM: dts: Reflect change of FSL QSPI driver and
 remove unused properties
Message-ID: <20180530171057.39f1a2be@bbrezillon>
In-Reply-To: <1527686082-15142-6-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-6-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018 15:14:34 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> The FSL QSPI driver was moved to the SPI framework and it now
> acts as a SPI controller. Therefore the subnodes need to set
> spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.

We should try to keep the current behavior even when
spi-[rx/tx]-bus-width are not defined. How about considering
spi-[rx/tx]-bus-width as board constraints and then let the core pick
the best mode based on these constraints plus the SPI NOR chip
limitations.

> 
> Also the properties 'bus-num', 'fsl,spi-num-chipselects' and
> 'fsl,spi-flash-chipselects' were never read by the driver and
> can be removed.
> 
> The 'reg' properties are adjusted to reflect the what bus and
> chipselect the flash is connected to, as the new driver needs
> this information.
> 
> The property 'fsl,qspi-has-second-chip' is not needed anymore
> and will be removed after the old driver was disabled to avoid
> breaking ls1021a-moxa-uc-8410a.dts.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> ---
>  arch/arm/boot/dts/imx6sx-sdb-reva.dts       | 8 ++++++--
>  arch/arm/boot/dts/imx6sx-sdb.dts            | 8 ++++++--
>  arch/arm/boot/dts/imx6ul-14x14-evk.dtsi     | 2 ++
>  arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 5 ++---
>  4 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> index e3533e7..1a6f680 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> @@ -131,13 +131,17 @@
>  		#size-cells = <1>;
>  		compatible = "spansion,s25fl128s", "jedec,spi-nor";
>  		spi-max-frequency = <66000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
>  	};
>  
> -	flash1: s25fl128s@1 {
> -		reg = <1>;
> +	flash1: s25fl128s@2 {
> +		reg = <2>;

Hm, you're breaking backward compat here. Can we try to re-use the
old numbering scheme instead of patching all DTs?
