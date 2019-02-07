Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AD1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB122147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oeItV7Oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBGLQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:16:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50788 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGLQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:16:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17BGFCT090211;
        Thu, 7 Feb 2019 05:16:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549538175;
        bh=LZGQUI8778U99WU69VM/Jpjo4IN9HrH2mbMO8T2vdrA=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=oeItV7Oov8D2cfSdjVjfg8YkXYkb6NGj1iN3ldw8LeIIQobiE0knGsBOpX3xj0EGC
         fSS2lU4aFg8K3naFCeWJT7OjO/ZtRxr5LWxUDH5A6jmoQM2Ff1sdWI+HoNug4zvYC7
         7c+XqgTl0DsekXR9CWwZ9CKtxTa4gpqPKKKpme5g=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17BGFfS005435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 05:16:15 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 05:16:14 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 05:16:14 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17BGD8m013988;
        Thu, 7 Feb 2019 05:16:13 -0600
Subject: Re: [PATCH v2 4/4] phy: ti: Add a new SERDES driver for TI's AM654x
 SoC
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20190206110753.28738-1-kishon@ti.com>
 <20190206110753.28738-5-kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C5C137C.2040109@ti.com>
Date:   Thu, 7 Feb 2019 13:16:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190206110753.28738-5-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/02/19 13:07, Kishon Vijay Abraham I wrote:
> Add a new SERDES driver for TI's AM654x SoC which configures
> the SERDES only for PCIe. Support fo USB3 will be added later.
> 
> SERDES in am654x has three input clocks (left input, externel reference
> clock and right input) and two output clocks (left output and right
> output) in addition to a PLL mux clock which the SERDES uses for Clock
> Multiplier Unit (CMU refclock).
> 
> The PLL mux clock can select from one of the three input clocks.
> The right output can select between left input and external reference
> clock while the left output can select between the right input and
> external reference clock.
> 
> The driver has support to select PLL mux and left/right output mux as
> specified in device tree.
> 
> [rogerq@ti.com: Fix boot lockup caused by accessing a structure member
> (hw->init) allocated in stack of probe() and accessed in get_parent]
> [rogerq@ti.com: Fix "Failed to find the parent" warnings]
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/ti/Kconfig            |  11 +
>  drivers/phy/ti/Makefile           |   1 +
>  drivers/phy/ti/phy-am654-serdes.c | 539 ++++++++++++++++++++++++++++++
>  3 files changed, 551 insertions(+)
>  create mode 100644 drivers/phy/ti/phy-am654-serdes.c
> 
> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
> index f137e0107764..6357c32de115 100644
> --- a/drivers/phy/ti/Kconfig
> +++ b/drivers/phy/ti/Kconfig
> @@ -20,6 +20,17 @@ config PHY_DM816X_USB
>  	help
>  	  Enable this for dm816x USB to work.
>  
> +config PHY_AM654_SERDES
> +	tristate "TI AM654 SERDES support"
> +	depends on OF && ARCH_K3 || COMPILE_TEST
> +	select GENERIC_PHY
> +	select MULTIPLEXER
> +	select REGMAP_MMIO
> +	select MUX_MMIO
> +	help
> +	  This option enables support for TI AM654 SerDes PHY used for
> +	  PCIe.
> +
>  config OMAP_CONTROL_PHY
>  	tristate "OMAP CONTROL PHY Driver"
>  	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
> index bea8f25a137a..bff901eb0ecc 100644
> --- a/drivers/phy/ti/Makefile
> +++ b/drivers/phy/ti/Makefile
> @@ -6,4 +6,5 @@ obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>  obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
>  obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
>  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
> +obj-$(CONFIG_PHY_AM654_SERDES)		+= phy-am654-serdes.o
>  obj-$(CONFIG_PHY_TI_GMII_SEL)		+= phy-gmii-sel.o
> diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
> new file mode 100644
> index 000000000000..dfbd2d48503d
> --- /dev/null
> +++ b/drivers/phy/ti/phy-am654-serdes.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * PCIe SERDES driver for AM654x SoC
> + *
> + * Copyright (C) 2018 Texas Instruments

2018-2019.

> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + */
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mux/consumer.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +

<snip>

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
