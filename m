Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeB1HOP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:14:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46253 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751031AbeB1HON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:14:13 -0500
X-UUID: 692475f191634af6ba81d8a929dc388b-20180228
Message-ID: <1519802048.8089.17.camel@mtkswgap22>
Subject: Re: [PATCH v2 3/4] pinctrl: add mt2712 pinctrl driver
From: Sean Wang <sean.wang@mediatek.com>
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
CC: <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <hongkun.cao@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-gpio@vger.kernel.org>,
        <biao.huang@mediatek.com>, <erin.lo@mediatek.com>,
        <liguo.zhang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <hongzhou.yang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Date: Wed, 28 Feb 2018 15:14:08 +0800
In-Reply-To: <1519634042-12063-4-git-send-email-zhiyong.tao@mediatek.com>
References: <1519634042-12063-1-git-send-email-zhiyong.tao@mediatek.com>
         <1519634042-12063-4-git-send-email-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Zhiyong

all seems better than v1, but some nitpicking is addressed as below 

	Sean

On Mon, 2018-02-26 at 16:34 +0800, Zhiyong Tao wrote:
> The commit includes mt2712 pinctrl driver.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig              |    7 +
>  drivers/pinctrl/mediatek/Makefile             |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mt2712.c     |  639 ++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h | 1973 +++++++++++++++++++++++++
>  4 files changed, 2620 insertions(+)
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2712.c
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 3e59874..b24bc76 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -32,6 +32,13 @@ config PINCTRL_MT8127
>  	select PINCTRL_MTK
>  
>  # For ARMv8 SoCs
> +config PINCTRL_MT2712
> +	bool "Mediatek MT2712 pin control"


should be MediaTek for normal

> +	depends on OF
> +	depends on ARM64 || COMPILE_TEST
> +	default ARM64 && ARCH_MEDIATEK
> +	select PINCTRL_MTK
> +
>  config PINCTRL_MT7622
>  	bool "MediaTek MT7622 pin control"
>  	depends on OF
> diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
> index ed7d2b2..7959e77 100644
> --- a/drivers/pinctrl/mediatek/Makefile
> +++ b/drivers/pinctrl/mediatek/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_MTK)	+= pinctrl-mtk-common.o
>  
>  # SoC Drivers
>  obj-$(CONFIG_PINCTRL_MT2701)	+= pinctrl-mt2701.o
> +obj-$(CONFIG_PINCTRL_MT2712)	+= pinctrl-mt2712.o
>  obj-$(CONFIG_PINCTRL_MT8135)	+= pinctrl-mt8135.o
>  obj-$(CONFIG_PINCTRL_MT8127)	+= pinctrl-mt8127.o
>  obj-$(CONFIG_PINCTRL_MT7622)	+= pinctrl-mt7622.o
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
> new file mode 100644
> index 0000000..b6ae71b
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
> @@ -0,0 +1,639 @@
> +/*
> + * Copyright (c) 2014-2015 MediaTek Inc.
> + * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +

suggest to consider more on using SPDX identifiers and
using right data for both fields Copyright and Author

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/regmap.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <dt-bindings/pinctrl/mt65xx.h>
> +
> +#include "pinctrl-mtk-common.h"
> +#include "pinctrl-mtk-mt2712.h"
> +

<...>

> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
> new file mode 100644
> index 0000000..71f4190
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
> @@ -0,0 +1,1973 @@
> +/*
> + * Copyright (C) 2015 MediaTek Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */

Ditto 

> +#ifndef PINCTRL_MTK_MT2712_H
> +#define PINCTRL_MTK_MT2712_H
> +

<...>

> +
> +#endif /* __PINCTRL_MTK_MT2712_H */
