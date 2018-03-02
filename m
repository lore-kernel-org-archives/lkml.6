Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423528AbeCBQsK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:48:10 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41879 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935744AbeCBQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:48:05 -0500
X-Google-Smtp-Source: AG47ELs7khTj+nFk9yYLCRoYL/wGc7uI82A+fdJsM6BxBaSGz3P2fp6QgHNeXHTF6YMrYPFGYnbhUQ==
Date: Fri, 2 Mar 2018 10:48:03 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/8] arm64: zynqmp: Add support for Xilinx zcu102
Message-ID: <20180302164803.nb45aqgqvnzxuyn5@rob-hp-laptop>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <dd5933d6a49247de4b3b7516ed7fab55d1b3eb90.1519396753.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5933d6a49247de4b3b7516ed7fab55d1b3eb90.1519396753.git.michal.simek@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:40:25PM +0100, Michal Simek wrote:
> This patch is adding revA, revB and rev1.0. There are also other
> revisions between which should be backward compatible with previous
> versions. Unfortunately all revs are still in use.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Remove i2c mw u-boot commands
> - Use i2c-mux instead of i2cswitch
> - Use clock generator without numbers.
> - Use dash in node name zcu102 rev1.0
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt   |   5 +
>  arch/arm64/boot/dts/xilinx/Makefile                |   3 +
>  .../arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts |  36 ++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  | 550 +++++++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts  |  42 ++
>  5 files changed, 636 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts

Reviewed-by: Rob Herring <robh@kernel.org> 

but...


> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> new file mode 100644
> index 000000000000..ed3cc684931f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dts file for Xilinx ZynqMP ZCU102 RevB
> + *
> + * (C) Copyright 2016 - 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +#include "zynqmp-zcu102-revA.dts"
> +
> +/ {
> +	model = "ZynqMP ZCU102 RevB";
> +	compatible = "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
> +};
> +
> +&gem3 {
> +	phy-handle = <&phyc>;
> +	phyc: phy@c {
> +		reg = <0xc>;
> +		ti,rx-internal-delay = <0x8>;
> +		ti,tx-internal-delay = <0xa>;
> +		ti,fifo-depth = <0x1>;
> +	};
> +	/* Cleanup from RevA */
> +	/delete-node/ phy@21;
> +};
> +
> +/* Different qspi 512Mbit version */

Stray comment

> +
> +/* Fix collision with u61 */
> +&i2c0 {
> +	i2cswitch@75 {

Missed this name.

This probably creates a new node rather than going into the existing 
tree. If this compiles, we should fix it to not allow the same 
unit-address twice.

> +		i2c@2 {
> +			max15303@1b { /* u8 */
> +				compatible = "maxim,max15303";
> +				reg = <0x1b>;
> +			};
> +			/delete-node/ max15303@20;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
