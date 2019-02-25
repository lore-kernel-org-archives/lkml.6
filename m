Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB747C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919CE2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="T+k6KT2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfBYLdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:33:10 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:38902 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfBYLdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 06:33:10 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9C3795C04E3;
        Mon, 25 Feb 2019 12:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551094387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dXtA3SnEGQXp0dpt3sFZkAbUWsKZGhoPC1B5/rLMrA=;
        b=T+k6KT2lyKUrfsROqjOOunncdvxGQUeMn/H98+PJTBVoFQEd8TrrINLcadrJK/BzrMXJgF
        Cv2JlJI62Y6V1hjUNkjvp77EsJZREC3x32uyUAdQBy2RJu/ZyXqpTlIFmxH0maDfclkbfG
        CzzUQ9BKlXtXyzMy5AOzbtz+ecpF6+Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Feb 2019 12:33:07 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: imx: Add generic i.MX8 SoC driver
In-Reply-To: <1549194583-7684-1-git-send-email-abel.vesa@nxp.com>
References: <1549194583-7684-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <b070b5e1664623ab6c7d003b2f935d8d@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.2019 12:49, Abel Vesa wrote:
> Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/soc/imx/Makefile   |   1 +
>  drivers/soc/imx/soc-imx8.c | 108 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 drivers/soc/imx/soc-imx8.c
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 506a6f3..d6b529e0 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> +obj-$(CONFIG_ARCH_MXC) += soc-imx8.o
> diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
> new file mode 100644
> index 0000000..69fe04e
> --- /dev/null
> +++ b/drivers/soc/imx/soc-imx8.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +
> +#define ANADIG_DIGPROG		0x6c
> +
> +struct imx8_soc_data {
> +	char *name;
> +	u32 (*soc_revision)(void);
> +};
> +
> +static u32 __init imx_init_revision_from_anatop(void)
> +{
> +	struct device_node *np;
> +	void __iomem *anatop_base;
> +	u32 digprog;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
> +	anatop_base = of_iomap(np, 0);
> +	WARN_ON(!anatop_base);
> +	digprog = readl_relaxed(anatop_base + ANADIG_DIGPROG);
> +	iounmap(anatop_base);
> +
> +	/*
> +	 * Bit[7:4] is the base layer revision,
> +	 * Bit[3:0] is the metal layer revision
> +	 * e.g. 0x10 stands for Tapeout 1.0
> +	 */
> +	return digprog & 0xff;
> +}
> +
> +u32 imx8mq_soc_revision(void)

Since imx_init_revision_from_anatop is __init, you should make this
__init too.

> +{
> +	return imx_init_revision_from_anatop();
> +}
> +
> +struct imx8_soc_data imx8mq_soc_data = {
> +	.name = "i.MX8MQ",
> +	.soc_revision = imx8mq_soc_revision,
> +};

Can we make this const?

> +
> +static const struct of_device_id imx8_soc_match[] = {
> +	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
> +	{ }
> +};
> +
> +static int __init imx8_soc_init(void)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	struct device_node *root;
> +	const struct of_device_id *id;
> +	u32 soc_rev = 0;
> +	const struct imx8_soc_data *data;
> +	int ret;
> +
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENODEV;
> +
> +	soc_dev_attr->family = "Freescale i.MX";
> +
> +	root = of_find_node_by_path("/");
> +	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
> +	if (ret)
> +		goto free_soc;
> +
> +	id = of_match_node(imx8_soc_match, root);
> +	if (!id)
> +		goto free_soc;

In this and the error case above you also need to make sure to call
of_node_put.

--
Stefan

> +
> +	of_node_put(root);
> +
> +	data = id->data;
> +	if (data) {
> +		soc_dev_attr->soc_id = data->name;
> +		if (data->soc_revision)
> +			soc_rev = data->soc_revision();
> +	}
> +
> +	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
> +					   (soc_rev >> 4) & 0xf,
> +					    soc_rev & 0xf);
> +	if (!soc_dev_attr->revision)
> +		goto free_soc;
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev))
> +		goto free_rev;
> +
> +	return 0;
> +
> +free_rev:
> +	kfree(soc_dev_attr->revision);
> +free_soc:
> +	kfree(soc_dev_attr);
> +	return -ENODEV;
> +}
> +device_initcall(imx8_soc_init);
