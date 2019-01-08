Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC04C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213482173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="O5tLMmti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfAHKmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:42:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54784 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfAHKmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:42:12 -0500
Received: from zn.tnic (p200300EC2BD0650048668EBE8B573E4E.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:6500:4866:8ebe:8b57:3e4e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6715B1EC00E5;
        Tue,  8 Jan 2019 11:42:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1546944130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=spQcjUwKmtvqoVPjSRmMS64BEoETXZ+5n/ZOig8lSZU=;
        b=O5tLMmtiQqw3G2hHJtG/crVerOZcpiJCGiRI5Ocuca/qpB6NzjM0o6NRul7ZrJEvhH2SmM
        tNNi0RgogR3rVn4ZWRx+FtQQR7pmjdTHRybauaF7b7UdYWEk/7a1JYg/VEJYmT4aLSMXHm
        CiLoD0MFHHkeDMKZDY14NRG/hRKuj7o=
Date:   Tue, 8 Jan 2019 11:42:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>,
        James Morse <james.morse@arm.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Message-ID: <20190108104204.GA14243@zn.tnic>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ James and leaving in the rest for reference.

So the first thing to figure out here is how generic is this and if
so, to make it a cortex_a15_edac.c driver which contains all the RAS
functionality for A15. Definitely not an EDAC driver per functional unit
but rather per vendor or even ARM core.

James?

On Tue, Jan 08, 2019 at 08:10:45AM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
> This driver adds support for L2 internal asynchronous error detection
> caused by L2 RAM double-bit ECC error or illegal writes to the
> Interrupt Controller memory-map region on the Cortex A15.
> 
> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
>  MAINTAINERS                             |   1 +
>  drivers/edac/Kconfig                    |  11 +++
>  drivers/edac/Makefile                   |   1 +
>  drivers/edac/cortex_a15_l2_async_edac.c | 134 ++++++++++++++++++++++++++++++++
>  4 files changed, 147 insertions(+)
>  create mode 100644 drivers/edac/cortex_a15_l2_async_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0796ad6e6490..84dc501b2582 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1100,6 +1100,7 @@ L:	linux-edac@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
> +F:	drivers/edac/cortex_a15_l2_async_edac.c
>  
>  ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
>  M:	Linus Walleij <linus.walleij@linaro.org>
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 41c9ccdd20d6..8722203948e0 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -475,4 +475,15 @@ config EDAC_QCOM
>  	  For debugging issues having to do with stability and overall system
>  	  health, you should probably say 'Y' here.
>  
> +config EDAC_CORTEX_A15_L2_ASYNC
> +	tristate "Cortex A15 ASYNC L2 & illegal GIC write error detection"
> +	depends on ARM
> +	help
> +	  Support for L2 internal asynchronous error detection caused by L2 RAM
> +	  double-bit ECC error or illegal writes to the Interrupt Controller
> +	  memory-map region on the Cortex A15.
> +
> +	  This driver works in interrupt mode triggered by the nINTERRIRQ and
> +	  reports only uncorrectable errors.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 716096d08ea0..12d15cf5ff4e 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
> +obj-$(CONFIG_EDAC_CORTEX_A15_L2_ASYNC)	+= cortex_a15_l2_async_edac.o
> diff --git a/drivers/edac/cortex_a15_l2_async_edac.c b/drivers/edac/cortex_a15_l2_async_edac.c
> new file mode 100644
> index 000000000000..26252568e961
> --- /dev/null
> +++ b/drivers/edac/cortex_a15_l2_async_edac.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Nokia Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +
> +#include "edac_module.h"
> +
> +#define DRIVER_NAME "cortex_a15_l2_async_edac"
> +
> +#define L2ECTLR_L2_ASYNC_ERR BIT(30)
> +
> +static irqreturn_t cortex_a15_l2_async_edac_err_handler(int irq, void *dev_id)
> +{
> +	struct edac_device_ctl_info *dci = dev_id;
> +	u32 status = 0;
> +
> +	/*
> +	 * Read and clear L2ECTLR L2 ASYNC error bit caused by INTERRIRQ.
> +	 * Reason could be a L2 RAM double-bit ECC error or illegal writes
> +	 * to the Interrupt Controller memory-map region.
> +	 */
> +	asm("mrc p15, 1, %0, c9, c0, 3" : "=r" (status));
> +	if (status & L2ECTLR_L2_ASYNC_ERR) {
> +		status &= ~L2ECTLR_L2_ASYNC_ERR;
> +		asm("mcr p15, 1, %0, c9, c0, 3" : : "r" (status));
> +		edac_printk(KERN_EMERG, DRIVER_NAME,
> +			    "L2 internal asynchronous error occurred!\n");
> +		edac_device_handle_ue(dci, 0, 0, dci->ctl_name);
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int cortex_a15_l2_async_edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci;
> +	struct device_node *np = pdev->dev.of_node;
> +	char *ctl_name = (char *)np->name;
> +	int i = 0, ret = 0, err_irq = 0, irq_count = 0;
> +
> +	/* We can have multiple CPU clusters with one INTERRIRQ per cluster */
> +	irq_count = platform_irq_count(pdev);
> +	if (irq_count < 0) {
> +		edac_printk(KERN_ERR, DRIVER_NAME,
> +			    "No L2 ASYNC error IRQ found!\n");
> +		return -EINVAL;
> +	}
> +
> +	dci = edac_device_alloc_ctl_info(0, ctl_name, 1, ctl_name,
> +					 irq_count, 0, NULL, 0,
> +					 edac_device_alloc_index());
> +	if (!dci)
> +		return -ENOMEM;
> +
> +	dci->dev = &pdev->dev;
> +	dci->mod_name = DRIVER_NAME;
> +	dci->ctl_name = ctl_name;
> +	dci->dev_name = dev_name(&pdev->dev);
> +	platform_set_drvdata(pdev, dci);
> +
> +	if (edac_device_add_device(dci))
> +		goto err;
> +
> +	for (i = 0; i < irq_count; i++) {
> +		err_irq = platform_get_irq(pdev, i);
> +		ret = devm_request_irq(&pdev->dev, err_irq,
> +				       cortex_a15_l2_async_edac_err_handler, 0,
> +				       dev_name(&pdev->dev), dci);
> +
> +		if (ret < 0) {
> +			edac_printk(KERN_ERR, DRIVER_NAME,
> +				    "Failed to register L2 ASYNC error IRQ %d\n",
> +				     err_irq);
> +			goto err2;
> +		}
> +	}
> +
> +	return 0;
> +err2:
> +	edac_device_del_device(&pdev->dev);
> +err:
> +	edac_device_free_ctl_info(dci);
> +
> +	return ret;
> +}
> +
> +static int cortex_a15_l2_async_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
> +
> +	edac_device_del_device(&pdev->dev);
> +	edac_device_free_ctl_info(dci);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id cortex_a15_l2_async_edac_of_match[] = {
> +	{ .compatible = "arm,cortex-a15-l2-async-edac", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cortex_a15_l2_async_edac_of_match);
> +
> +static struct platform_driver cortex_a15_l2_async_edac_driver = {
> +	.probe = cortex_a15_l2_async_edac_probe,
> +	.remove = cortex_a15_l2_async_edac_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = cortex_a15_l2_async_edac_of_match,
> +	},
> +};
> +module_platform_driver(cortex_a15_l2_async_edac_driver);
> +
> +MODULE_AUTHOR("Wladislav Wiebe <wladislav.wiebe@nokia.com>");
> +MODULE_DESCRIPTION("ARM Cortex A15 L2 internal asynchronous error detection");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.16.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
