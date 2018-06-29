Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7444C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C5827CFC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LgebAxM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C5827CFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935196AbeF2KP3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:15:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51360 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933581AbeF2KP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:15:26 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5TAEAXp096777;
        Fri, 29 Jun 2018 05:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530267250;
        bh=ogs6/xCd/Cgkz6R7T3R5lZddZNd/KG3la0te6oI8CdQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LgebAxM5aHPhFQUQ2XzjIlX5XlwP8Plh9w2NABepyVvjupuI077ZXjEpLFd1V4o2N
         k1gboXMDRSbWrT3hSiC66jbzcLpgYmq2k2ieQY4Md9DnIbSaVf5IbpVU5zirvTdqag
         oUFEYvSMLep6Zimf/Zry62lfbvY04lySOYHtuuR8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TAEAQl003168;
        Fri, 29 Jun 2018 05:14:10 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 29
 Jun 2018 05:14:09 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 29 Jun 2018 05:14:09 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TAE5NW021268;
        Fri, 29 Jun 2018 05:14:06 -0500
Subject: Re: [PATCH 5/8] remoteproc: new driver for TI PRU
To:     David Lechner <david@lechnology.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        <linux-kernel@vger.kernel.org>, "Anna, Suman" <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <20180623210810.21232-6-david@lechnology.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <ce87a7dc-ecf6-f3fd-9121-bf99216f7412@ti.com>
Date:   Fri, 29 Jun 2018 13:14:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180623210810.21232-6-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/06/18 00:08, David Lechner wrote:
> This adds a new remoteproc driver for TI Programmable Realtime Units
> (PRUs).
> 
> This has been tested working on AM1808 (LEGO MINDSTORMS EV3) using the
> sample rpmsg client driver.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  MAINTAINERS                       |   5 +
>  drivers/remoteproc/Kconfig        |   7 +
>  drivers/remoteproc/Makefile       |   1 +
>  drivers/remoteproc/ti_pru_rproc.c | 660 ++++++++++++++++++++++++++++++
>  4 files changed, 673 insertions(+)
>  create mode 100644 drivers/remoteproc/ti_pru_rproc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edf3cf5ea691..06dea089d9ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14288,6 +14288,11 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/ti/netcp*
>  
> +TI PRU REMOTEPROC DRIVER
> +R:	David Lechner <david@lechnology.com>
> +F:	Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> +F:	drivers/remoteproc/ti_pru_rproc.c
> +
>  TI TAS571X FAMILY ASoC CODEC DRIVER
>  M:	Kevin Cernekee <cernekee@chromium.org>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index cd1c168fd188..ae6e725e1755 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -158,6 +158,13 @@ config ST_REMOTEPROC
>  config ST_SLIM_REMOTEPROC
>  	tristate
>  
> +config TI_PRU_REMOTEPROC
> +	tristate "TI Programmable Realtime Unit"
> +	depends on ARCH_DAVINCI_DA8XX || SOC_AM33XX
> +	help
> +	  Say y here to support TI Programmable Runtime Units (PRUs) via the
> +	  remote processor framework.
> +
>  endif # REMOTEPROC
>  
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 02627ede8d4a..451efee5c8d3 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -23,3 +23,4 @@ qcom_wcnss_pil-y			+= qcom_wcnss.o
>  qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
> +obj-$(CONFIG_TI_PRU_REMOTEPROC)		+= ti_pru_rproc.o
> diff --git a/drivers/remoteproc/ti_pru_rproc.c b/drivers/remoteproc/ti_pru_rproc.c
> new file mode 100644
> index 000000000000..cd8302c318c9
> --- /dev/null
> +++ b/drivers/remoteproc/ti_pru_rproc.c
> @@ -0,0 +1,660 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 David Lechner <david@lechnology.com>
> + *
> + * Remoteproc driver for TI Programmable Realtime Unit
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_data/ti-pruss.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/remoteproc.h>
> +#include <linux/regmap.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
> +
> +#include "remoteproc_internal.h"
> +
> +#define SZ_12K 0x3000
> +
> +/* control/status registers */
> +#define TI_PRU_CS_CONTROL	0x0
> +#define TI_PRU_CS_STATUS	0x4
> +#define TI_PRU_CS_WAKEUP	0x8
> +#define TI_PRU_CS_CYCLECNT	0xc
> +
> +/* control register bits */
> +#define TI_PRU_CONTROL_PCRESETVAL	GENMASK(31, 16)
> +#define TI_PRU_CONTROL_RUNSTATE		BIT(15)
> +#define TI_PRU_CONTROL_SINGLESTEP	BIT(8)
> +#define TI_PRU_CONTROL_COUNTENABLE	BIT(3)
> +#define TI_PRU_CONTROL_SLEEPING		BIT(2)
> +#define TI_PRU_CONTROL_ENABLE		BIT(1)
> +#define TI_PRU_CONTROL_SOFTRESET	BIT(0)
> +
> +/* status bits */
> +#define TI_PRU_STATUS_PCOUNTER		GENMASK(15, 0)
> +
> +/* interrupt controller registers */
> +#define TI_PRU_INTC_GLBLEN		0x10
> +#define TI_PRU_INTC_STATIDXSET		0x20
> +#define TI_PRU_INTC_STATIDXCLR		0x24
> +#define TI_PRU_INTC_ENIDXSET		0x28
> +#define TI_PRU_INTC_HSTINTENIDXSET	0x34
> +#define TI_PRU_INTC_CHANMAP0		0x400
> +#define TI_PRU_INTC_POLARITY0		0xd00
> +#define TI_PRU_INTC_TYPE0		0xd80
> +#define TI_PRU_INTC_HOSTMAP0		0x800
> +
> +/* config registers */
> +#define TI_PRU_CFG_SYSCFG		0x4
> +
> +/* syscfg bits */
> +#define TI_PRU_SYSCFG_SUB_MWAIT			BIT(5)
> +#define TI_PRU_SYSCFG_STANDBY_INIT		BIT(4)
> +#define TI_PRU_SYSCFG_STANDBY_MODE_MASK		GENMASK(3, 2)
> +#define TI_PRU_SYSCFG_STANDBY_MODE_SMART	(2 << 2)
> +#define TI_PRU_SYSCFG_IDLE_MODE_MASK		GENMASK(1, 0)
> +#define TI_PRU_SYSCFG_IDLE_MODE_SMART		(2 << 0)
> +
> +enum ti_pru {
> +	TI_PRU0,
> +	TI_PRU1,
> +	NUM_TI_PRU
> +};
> +
> +enum ti_pru_type {
> +	TI_PRU_TYPE_AM18XX,
> +	TI_PRU_TYPE_AM335X,
> +	NUM_TI_PRU_TYPE
> +};
> +
> +enum ti_pru_evtout {
> +	TI_PRU_EVTOUT0,
> +	TI_PRU_EVTOUT1,
> +	TI_PRU_EVTOUT2,
> +	TI_PRU_EVTOUT3,
> +	TI_PRU_EVTOUT4,
> +	TI_PRU_EVTOUT5,
> +	TI_PRU_EVTOUT6,
> +	TI_PRU_EVTOUT7,
> +	NUM_TI_PRU_EVTOUT
> +};
> +
> +struct ti_pru_mem_region {
> +	off_t offset;
> +	size_t size;
> +};
> +
> +/**
> + * ti_pru_shared_info - common init info for the PRUSS
> + * @ram: shared RAM, if present
> + * @intc: interrupt controller
> + * @cfg: configuration registers, if present
> + */
> +struct ti_pru_shared_info {
> +	struct ti_pru_mem_region ram;
> +	struct ti_pru_mem_region intc;
> +	struct ti_pru_mem_region cfg;
> +};
> +
> +/**
> + * ti_pru_info - init info each individual PRU
> + * @ram: PRU RAM
> + * @ctrl: PRU control/status registers
> + * @dbg: PRU dbg registers
> + * @inst: instruction RAM
> + * @vq_arm_to_pru_event: The index of the PRU system event interrupt used
> + *                       used by the ARM for kicking the PRU
> + * @vq_pru_to_arm_event: The index of the PRU system event interrupt used
> + *                       used by the PRU for kicking the ARM
> + */
> +struct ti_pru_info {
> +	struct ti_pru_mem_region ram;
> +	struct ti_pru_mem_region ctrl;
> +	struct ti_pru_mem_region dbg;
> +	struct ti_pru_mem_region inst;
> +	int vq_arm_to_pru_event;
> +	int vq_pru_to_arm_event;
> +};
> +
> +struct ti_pru_device_info {
> +	struct ti_pru_shared_info shared;
> +	struct ti_pru_info pru[NUM_TI_PRU];
> +};
> +
> +static const struct ti_pru_device_info ti_pru_devices[NUM_TI_PRU_TYPE] = {
> +	[TI_PRU_TYPE_AM18XX] = {
> +		.shared = {
> +			.intc	= { .offset = 0x4000,	.size = SZ_12K,	},
> +		},
> +		.pru[TI_PRU0] = {
> +			.ram	= { .offset = 0x0000,	.size = SZ_512,	},
> +			.ctrl	= { .offset = 0x7000,	.size = SZ_1K,	},
> +			.dbg	= { .offset = 0x7400,	.size = SZ_1K,	},
> +			.inst	= { .offset = 0x8000,	.size = SZ_4K,	},
> +			.vq_arm_to_pru_event = 32,
> +			.vq_pru_to_arm_event = 33,
> +		},
> +		.pru[TI_PRU1] = {
> +			.ram	= { .offset = 0x2000,	.size = SZ_512,	},
> +			.ctrl	= { .offset = 0x7800,	.size = SZ_1K,	},
> +			.dbg	= { .offset = 0x7c00,	.size = SZ_1K,	},
> +			.inst	= { .offset = 0xc000,	.size = SZ_4K,	},
> +			.vq_arm_to_pru_event = 34,
> +			.vq_pru_to_arm_event = 35,
> +		},
> +	},
> +	[TI_PRU_TYPE_AM335X] = {
> +		.shared = {
> +			.ram	= { .offset = 0x10000,	.size = SZ_12K,	},
> +			.intc	= { .offset = 0x20000,	.size = SZ_8K,	},
> +			.cfg	= { .offset = 0x26000,	.size = SZ_8K,	},
> +		},
> +		.pru[TI_PRU0] = {
> +			.ram	= { .offset = 0x00000,	.size = SZ_8K,	},
> +			.ctrl	= { .offset = 0x22000,	.size = SZ_1K,	},
> +			.dbg	= { .offset = 0x22400,	.size = SZ_1K,	},
> +			.inst	= { .offset = 0x34000,	.size = SZ_8K,	},
> +			.vq_arm_to_pru_event = 16,
> +			.vq_pru_to_arm_event = 17,
> +		},
> +		.pru[TI_PRU1] = {
> +			.ram	= { .offset = 0x02000,	.size = SZ_8K,	},
> +			.ctrl	= { .offset = 0x24000,	.size = SZ_1K,	},
> +			.dbg	= { .offset = 0x24400,	.size = SZ_1K,	},
> +			.inst	= { .offset = 0x38000,	.size = SZ_8K,	},
> +			.vq_arm_to_pru_event = 18,
> +			.vq_pru_to_arm_event = 19,
> +		},
> +	},

All this information should really come from the DT.

> +};
> +
> +/**
> + * ti_pru_shared_data - private platform driver data
> + * @info: init info common to both PRU cores
> + * @dev: the platform device
> + * @base: the mapped memory region of the PRUSS
> + * @intc: regmap of the interrupt controller
> + * @cfg: regmap of configuration registers
> + * @pru: per-PRU core data
> + */
> +struct ti_pru_shared_data {
> +	const struct ti_pru_shared_info *info;
> +	struct device *dev;
> +	void __iomem *base;
> +	struct regmap *intc;
> +	struct regmap *cfg;
> +	struct rproc *pru[NUM_TI_PRU];
> +};
> +
> +/**
> + * ti_pru_data - private data for each PRU core
> + * @info: static init info
> + * @shared: pointer to the shared data struct
> + * @ctrl: regmap of the PRU control/status register
> + * @vq_irq: interrupt used for rpmsg
> + */
> +struct ti_pru_data {
> +	const struct ti_pru_info *info;
> +	struct ti_pru_shared_data *shared;
> +	struct regmap *ctrl;
> +	int vq_irq;
> +};
> +
> +static int ti_pru_rproc_start(struct rproc *rproc)
> +{
> +	struct ti_pru_data *pru = rproc->priv;
> +	u32 val;
> +
> +	val = (rproc->bootaddr >> 2) << (ffs(TI_PRU_CONTROL_PCRESETVAL) - 1);
> +	val |= TI_PRU_CONTROL_ENABLE;
> +
> +	return regmap_write(pru->ctrl, TI_PRU_CS_CONTROL, val);
> +}
> +
> +static int ti_pru_rproc_stop(struct rproc *rproc)
> +{
> +	struct ti_pru_data *pru = rproc->priv;
> +	u32 mask;
> +
> +	mask = TI_PRU_CONTROL_ENABLE;
> +
> +	return regmap_write_bits(pru->ctrl, TI_PRU_CS_CONTROL, mask, 0);
> +}
> +
> +static void ti_pru_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	struct ti_pru_data *pru = rproc->priv;
> +	struct ti_pru_shared_data *shared = pru->shared;
> +	u32 val;
> +
> +	val = pru->info->vq_arm_to_pru_event;
> +
> +	regmap_write(shared->intc, TI_PRU_INTC_STATIDXSET, val);
> +}
> +
> +static void *ti_pru_rproc_da_to_va(struct rproc *rproc, u64 da, int len, int map)
> +{
> +	struct ti_pru_data *pru = rproc->priv;
> +	struct ti_pru_shared_data *shared = pru->shared;
> +
> +	if (map == 0) {
> +		if (da + len > pru->info->inst.size)
> +			return ERR_PTR(-EINVAL);
> +
> +		return shared->base + pru->info->inst.offset + da;
> +	}
> +
> +	if (map == 1) {
> +		if (da + len > pru->info->ram.size)
> +			return ERR_PTR(-EINVAL);
> +
> +		return shared->base + pru->info->ram.offset + da;
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static const struct rproc_ops ti_pru_rproc_ops = {
> +	.start = ti_pru_rproc_start,
> +	.stop = ti_pru_rproc_stop,
> +	.kick = ti_pru_rproc_kick,
> +	.da_to_va = ti_pru_rproc_da_to_va,
> +};
> +
> +static struct regmap_config ti_pru_ctrl_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x2c,
> +};
> +
> +static struct regmap_config ti_pru_intc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x1500,
> +};
> +
> +static struct regmap_config ti_pru_cfg_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x40,
> +};
> +
> +static const struct of_device_id ti_pru_rproc_of_match[] = {
> +	{
> +		.compatible = "ti,da850-pru-rproc",
> +		.data = &ti_pru_devices[TI_PRU_TYPE_AM18XX]
> +	},
> +	{
> +		.compatible = "ti,am3352-pru-rproc",
> +		.data = &ti_pru_devices[TI_PRU_TYPE_AM335X]
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ti_pru_rproc_of_match);
> +
> +static irqreturn_t ti_pru_handle_vq_irq(int irq, void *p)
> +{
> +	struct rproc *rproc = p;
> +	struct ti_pru_data *pru = rproc->priv;
> +
> +	regmap_write(pru->shared->intc, TI_PRU_INTC_STATIDXCLR,
> +		     pru->info->vq_pru_to_arm_event);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t ti_pru_vq_irq_thread(int irq, void *p)
> +{
> +	struct rproc *rproc = p;
> +
> +	rproc_vq_interrupt(rproc, 0);
> +	rproc_vq_interrupt(rproc, 1);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void ti_pru_free_rproc(void *data)
> +{
> +	struct rproc *rproc = data;
> +
> +	rproc_free(rproc);
> +}
> +
> +static struct rproc *ti_pru_init_one_rproc(struct ti_pru_shared_data *shared,
> +					   const struct ti_pru_info *info,
> +					   enum ti_pru id)
> +{
> +	struct device *dev = shared->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	const char *name;
> +	char irq_name[16];
> +	struct rproc *rproc;
> +	struct ti_pru_data *pru;
> +	int err;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "pru%u", id);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rproc = rproc_alloc(dev, name, &ti_pru_rproc_ops, NULL, sizeof(*pru));
> +	if (!rproc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	devm_add_action(dev, ti_pru_free_rproc, rproc);
> +
> +	/* don't auto-boot for now - bad firmware can lock up the system */
> +	rproc->auto_boot = false;
> +
> +	pru = rproc->priv;
> +	pru->info = info;
> +	pru->shared = shared;
> +
> +	snprintf(irq_name, 16, "%s-vq", name);
> +
> +	pru->vq_irq = platform_get_irq_byname(pdev, irq_name);
> +	if (pru->vq_irq < 0) {
> +		dev_err(&rproc->dev, "failed to get vq IRQ\n");
> +		return ERR_PTR(pru->vq_irq);
> +	}
> +
> +	err = devm_request_threaded_irq(&rproc->dev, pru->vq_irq,
> +					ti_pru_handle_vq_irq,
> +					ti_pru_vq_irq_thread, 0, name, rproc);
> +	if (err < 0) {
> +		dev_err(&rproc->dev, "failed to request vq IRQ\n");
> +		return ERR_PTR(err);
> +	}
> +
> +	pru->ctrl = devm_regmap_init_mmio(&rproc->dev,
> +					  shared->base + info->ctrl.offset,
> +					  &ti_pru_ctrl_regmap_config);
> +	if (IS_ERR(pru->ctrl)) {
> +		dev_err(&rproc->dev, "failed to init ctrl regmap\n");
> +		return ERR_CAST(pru->ctrl);
> +	}
> +
> +	return rproc;
> +}
> +
> +/**
> + * ti_pru_init_intc_polarity - configure polarity interrupt event
> + * @intc: the interrtup controller regmap
> + * @event: the source event
> + */
> +static void ti_pru_init_intc_polarity(struct regmap *intc, int event)
> +{
> +	int offset, shift, mask;
> +
> +	/* 32 events per register */
> +	offset = event / 32 * 4;
> +	shift = event % 32;
> +	mask = 1 << shift;
> +
> +	/* polarity is always high (1) */
> +	regmap_write_bits(intc, TI_PRU_INTC_POLARITY0 + offset, mask, ~0);
> +}
> +
> +/**
> + * ti_pru_init_intc_type - configure type of interrupt event
> + * @intc: the interrtup controller regmap
> + * @event: the source event
> + */
> +static void ti_pru_init_intc_type(struct regmap *intc, int event)
> +{
> +	int offset, shift, mask;
> +
> +	/* 32 events per register */
> +	offset = event / 32 * 4;
> +	shift = event % 32;
> +	mask = 1 << shift;
> +
> +	/* type is always pulse (0) */
> +	regmap_write_bits(intc, TI_PRU_INTC_TYPE0 + offset, mask, 0);
> +}
> +
> +/**
> + * ti_pru_init_intc_channel_map - configure interrupt event to channel mapping
> + * @intc: the interrtup controller regmap
> + * @event: the source event
> + * @ch: the channel to be assigned to the event
> + */
> +static void ti_pru_init_intc_channel_map(struct regmap *intc, int event, int ch)
> +{
> +	int offset, shift, mask, val;
> +
> +	/* 4 channels per 32-bit register */
> +	offset = event / 4 * 4;
> +	shift = event % 4 * 8;
> +	mask = 0xff << shift;
> +	val = ch << shift;
> +
> +	regmap_write_bits(intc, TI_PRU_INTC_CHANMAP0 + offset, mask, val);
> +}
> +
> +/**
> + * ti_pru_init_intc_host_map - configure interrupt channel to host mapping
> + * @intc: the interrtup controller regmap
> + * @ch: the source channel
> + * @host: the host interrupt to be assigned to the channel
> + */
> +static void ti_pru_init_intc_host_map(struct regmap *intc, int ch, int host)
> +{
> +	int offset, shift, mask, val;
> +
> +	/* 4 hosts per 32-bit register */
> +	offset = ch / 4 * 4;
> +	shift = ch % 4 * 8;
> +	mask = 0xff << shift;
> +	val = host << shift;
> +
> +	regmap_write_bits(intc, TI_PRU_INTC_HOSTMAP0 + offset, mask, val);
> +}
> +
> +static void ti_pru_init_intc(struct regmap *intc,
> +			     const struct ti_pru_device_info *info)
> +{
> +	int arm_to_pru0 = info->pru[TI_PRU0].vq_arm_to_pru_event;
> +	int arm_to_pru1 = info->pru[TI_PRU1].vq_arm_to_pru_event;
> +	int pru0_to_arm = info->pru[TI_PRU0].vq_pru_to_arm_event;
> +	int pru1_to_arm = info->pru[TI_PRU1].vq_pru_to_arm_event;
> +
> +	/* set polarity of system events */
> +	ti_pru_init_intc_polarity(intc, arm_to_pru0);
> +	ti_pru_init_intc_polarity(intc, arm_to_pru1);
> +	ti_pru_init_intc_polarity(intc, pru0_to_arm);
> +	ti_pru_init_intc_polarity(intc, pru1_to_arm);
> +
> +	/* set type of system events */
> +	ti_pru_init_intc_type(intc, arm_to_pru0);
> +	ti_pru_init_intc_type(intc, arm_to_pru1);
> +	ti_pru_init_intc_type(intc, pru0_to_arm);
> +	ti_pru_init_intc_type(intc, pru1_to_arm);
> +
> +	/* map system events to channels */
> +	ti_pru_init_intc_channel_map(intc, arm_to_pru0, 0);
> +	ti_pru_init_intc_channel_map(intc, arm_to_pru1, 1);
> +	ti_pru_init_intc_channel_map(intc, pru0_to_arm, 2);
> +	ti_pru_init_intc_channel_map(intc, pru1_to_arm, 3);
> +
> +	/* map channels to host interrupts */
> +	ti_pru_init_intc_host_map(intc, 0, 0); /* ARM to PRU0 */
> +	ti_pru_init_intc_host_map(intc, 1, 1); /* ARM to PRU1 */
> +	ti_pru_init_intc_host_map(intc, 2, 2); /* PRU0 to ARM */
> +	ti_pru_init_intc_host_map(intc, 3, 3); /* PRU1 to ARM */
> +
> +	/* clear system interrupts */
> +	regmap_write(intc, TI_PRU_INTC_STATIDXCLR, arm_to_pru0);
> +	regmap_write(intc, TI_PRU_INTC_STATIDXCLR, arm_to_pru1);
> +	regmap_write(intc, TI_PRU_INTC_STATIDXCLR, pru0_to_arm);
> +	regmap_write(intc, TI_PRU_INTC_STATIDXCLR, pru1_to_arm);
> +
> +	/* enable host interrupts for kicking */
> +	regmap_write(intc, TI_PRU_INTC_HSTINTENIDXSET, 0); /* ARM to PRU0 */
> +	regmap_write(intc, TI_PRU_INTC_HSTINTENIDXSET, 1); /* ARM to PRU1 */
> +	regmap_write(intc, TI_PRU_INTC_HSTINTENIDXSET, 2); /* PRU0 to ARM */
> +	regmap_write(intc, TI_PRU_INTC_HSTINTENIDXSET, 3); /* PRU1 to ARM */
> +
> +	/* enable system events for kicking */
> +	regmap_write(intc, TI_PRU_INTC_ENIDXSET, arm_to_pru0);
> +	regmap_write(intc, TI_PRU_INTC_ENIDXSET, arm_to_pru1);
> +	regmap_write(intc, TI_PRU_INTC_ENIDXSET, pru0_to_arm);
> +	regmap_write(intc, TI_PRU_INTC_ENIDXSET, pru1_to_arm);
> +
> +	/* enable all interrupts */
> +	regmap_write_bits(intc, TI_PRU_INTC_GLBLEN, 1, 1);
> +}

We already have a working irq_chip implementation for INTC.
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pruss_intc.c

I think we can leverage directly from that.

This way pru_rproc or client device nodes can easily specify a pruss_intc interrupt parent and the
SYSEVENT number as the irq. Then device drivers can simply use request_irq().

example usage here
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/arch/arm/boot/dts/am33xx.dtsi#line986
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pru_rproc.c#line670


> +
> +static int ti_pru_rproc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ti_pruss_platform_data *pdata = dev_get_platdata(dev);
> +	const struct of_device_id *of_id;
> +	const struct ti_pru_device_info *info;
> +	struct ti_pru_shared_data *shared;
> +	struct resource *res;
> +	int err;
> +
> +	of_id = of_match_device(ti_pru_rproc_of_match, dev);
> +	if (!of_id || !of_id->data)
> +		return -EINVAL;
> +
> +	info = of_id->data;
> +
> +	shared = devm_kzalloc(dev, sizeof(*shared), GFP_KERNEL);
> +
> +	platform_set_drvdata(pdev, shared);
> +
> +	shared->info = &info->shared;
> +	shared->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	shared->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(shared->base)) {
> +		dev_err(dev, "failed to ioremap resource\n");
> +		return PTR_ERR(shared->base);
> +	}
> +
> +	shared->intc = devm_regmap_init_mmio(dev,
> +				shared->base + shared->info->intc.offset,
> +				&ti_pru_intc_regmap_config);
> +	if (IS_ERR(shared->intc)) {
> +		dev_err(dev, "failed to init intc regmap\n");
> +		return PTR_ERR(shared->intc);
> +	}
> +
> +	if (shared->info->cfg.size) {
> +		shared->cfg = devm_regmap_init_mmio(dev,
> +			shared->base + shared->info->cfg.offset,
> +			&ti_pru_cfg_regmap_config);
> +		if (IS_ERR(shared->cfg)) {
> +			dev_err(dev, "failed to init cfg regmap\n");
> +			return PTR_ERR(shared->cfg);
> +		}
> +	}
> +
> +	shared->pru[TI_PRU0] = ti_pru_init_one_rproc(shared, &info->pru[TI_PRU0],
> +						     TI_PRU0);
> +	if (IS_ERR(shared->pru[TI_PRU0]))
> +		return PTR_ERR(shared->pru[TI_PRU0]);
> +
> +	shared->pru[TI_PRU1] = ti_pru_init_one_rproc(shared, &info->pru[TI_PRU1],
> +						     TI_PRU1);
> +	if (IS_ERR(shared->pru[TI_PRU1]))
> +		return PTR_ERR(shared->pru[TI_PRU1]);
> +
> +	pm_runtime_enable(dev);
> +
> +	err = pm_runtime_get_sync(dev);
> +	if (err < 0)
> +		goto err_pm_runtime_disable;
> +
> +	if (pdata) {
> +		err = pdata->deassert_reset(pdev, pdata->reset_name);
> +		if (err < 0) {
> +			dev_err(dev, "Failed to reset pruss\n");
> +			goto err_pm_runtime_put;
> +		}
> +	}
> +
> +	if (shared->cfg) {
> +		int mask, val;
> +
> +		mask = TI_PRU_SYSCFG_IDLE_MODE_MASK | TI_PRU_SYSCFG_STANDBY_MODE_MASK;
> +		val = TI_PRU_SYSCFG_IDLE_MODE_SMART | TI_PRU_SYSCFG_STANDBY_MODE_SMART;
> +		regmap_write_bits(shared->cfg, TI_PRU_CFG_SYSCFG, mask, val);
> +
> +		mask = TI_PRU_SYSCFG_STANDBY_INIT;
> +		val = 0;
> +		regmap_write_bits(shared->cfg, TI_PRU_CFG_SYSCFG, mask, val);
> +
> +		err = regmap_read_poll_timeout(shared->cfg, TI_PRU_CFG_SYSCFG,
> +				val, !(val & TI_PRU_SYSCFG_SUB_MWAIT), 5, 50);
> +		if (err < 0) {
> +			dev_err(dev, "timeout while enabling pruss\n");
> +			goto err_pm_runtime_put;
> +		}
> +	}
> +
> +	ti_pru_init_intc(shared->intc, info);

This is using a static INTC map right?
This limits our possibility to use application based INTC mapping.
There needs to be a way to specify the INTC mapping in the DT and/or resource table.

> +
> +	err = rproc_add(shared->pru[TI_PRU0]);
> +	if (err < 0)
> +		goto err_assert_reset;
> +
> +	err = rproc_add(shared->pru[TI_PRU1]);
> +	if (err < 0)
> +		goto err_del_pru0;
> +
> +	return 0;
> +
> +err_del_pru0:
> +	rproc_del(shared->pru[TI_PRU0]);
> +err_assert_reset:
> +	if (pdata)
> +		pdata->assert_reset(pdev, pdata->reset_name);
> +err_pm_runtime_put:
> +	pm_runtime_put(dev);
> +err_pm_runtime_disable:
> +	pm_runtime_disable(dev);
> +
> +	return err;
> +}
> +
> +static int ti_pru_rproc_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ti_pruss_platform_data *pdata = dev_get_platdata(dev);
> +	struct ti_pru_shared_data *shared = platform_get_drvdata(pdev);
> +
> +	rproc_del(shared->pru[TI_PRU1]);
> +	rproc_del(shared->pru[TI_PRU0]);
> +	if (pdata)
> +		pdata->assert_reset(pdev, pdata->reset_name);
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ti_pru_rproc_driver = {
> +	.probe	= ti_pru_rproc_probe,
> +	.remove	= ti_pru_rproc_remove,
> +	.driver	= {
> +		.name = "ti-pru-rproc",
> +		.of_match_table = ti_pru_rproc_of_match,
> +	},
> +};
> +module_platform_driver(ti_pru_rproc_driver);
> +
> +MODULE_AUTHOR("David Lechner <david@lechnology.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Remoteproc driver for TI PRU");
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
