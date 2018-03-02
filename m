Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428416AbeCBSEt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:04:49 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40809 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426543AbeCBSEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:04:47 -0500
X-Google-Smtp-Source: AG47ELvcgzvQMXZT1rLuM4kwiwLchj9sgVspL5vWXaqTCCHzsgM9ppAJbT4PNO7kOMwhzvKm42HkYg==
Date: Fri, 2 Mar 2018 12:04:39 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/8] arm64: zynqmp: Add support for Xilinx zcu111-revA
Message-ID: <20180302180439.bzl6zmnpkvaqnekb@rob-hp-laptop>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <db4b958c2280352939de0e7e55bc00d416b694e9.1519396753.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db4b958c2280352939de0e7e55bc00d416b694e9.1519396753.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:40:28PM +0100, Michal Simek wrote:
> Xilinx zcu111 is a customer board. It is reusing some parts from zcu102.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Remove i2c mw u-boot commands
> - Use i2c-mux instead of i2cswitch
> - Use clock generator without numbers.
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt  |   3 +
>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 446 ++++++++++++++++++++++
>  3 files changed, 450 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index 8503fabf90ee..c2bc75774010 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -32,3 +32,6 @@ Additional compatible strings:
>  
>  - Xilinx evaluation board zcu106
>    "xlnx,zynqmp-zcu106-revA", "xlnx,zynqmp-zcu106"
> +
> +- Xilinx evaluation board zcu111
> +  "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111"
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index 922c5da39600..d15c9dc1d8f2 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> new file mode 100644
> index 000000000000..f07f6dafb417
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -0,0 +1,446 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dts file for Xilinx ZynqMP ZCU111
> + *
> + * (C) Copyright 2017 - 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "zynqmp.dtsi"
> +#include "zynqmp-clk.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "ZynqMP ZCU111 RevA";
> +	compatible = "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111", "xlnx,zynqmp";
> +
> +	aliases {
> +		ethernet0 = &gem3;
> +		gpio0 = &gpio;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		mmc0 = &sdhci1;
> +		rtc0 = &rtc;
> +		serial0 = &uart0;
> +		serial1 = &dcc;
> +		usb0 = &usb0;

Same comments on aliases.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
