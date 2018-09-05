Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3036DC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65852075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65852075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeIEO7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:59:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38513 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeIEO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:59:41 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fxV4N-0004OQ-JW; Wed, 05 Sep 2018 12:29:55 +0200
Message-ID: <1536143395.4084.5.camel@pengutronix.de>
Subject: Re: [RFC PATCH v3 3/3] reset: reset-zynqmp: Adding support for
 Xilinx zynqmp reset controller.
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        jollys@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 12:29:55 +0200
In-Reply-To: <1536131342-28041-4-git-send-email-nava.manne@xilinx.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
         <1536131342-28041-4-git-send-email-nava.manne@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thank you for the patch. I have a few comments below:

On Wed, 2018-09-05 at 12:39 +0530, Nava kishore Manne wrote:
> Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
> The zynqmp reset-controller has the ability to reset lines
> connected to different blocks and peripheral in the Soc.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-None.
> Changes for v2:
> 		-Moved eemi_ops into a priv struct as suggested
> 		 by philipp.
> 
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-zynqmp.c | 115 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 drivers/reset/reset-zynqmp.c
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index c1261dc..27e4a33 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -21,4 +21,5 @@ obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> +obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
>  
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> new file mode 100644
> index 0000000..f908492
> --- /dev/null
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Xilinx, Inc.
> + *
> + */
> +
> +#include <linux/io.h>

I think including io.h is not necessary.

[...]
> +static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> +	int val, err;
> +
> +	err = priv->eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
> +	if (!err)
> +		return -EINVAL;

This looks like it should be

	if (err)
		return err;

instead.

[...]
> +static struct reset_control_ops zynqmp_reset_ops = {

static const struct reset_control_ops zynqmp_reset_ops = {

> +	.reset = zynqmp_reset_reset,
> +	.assert = zynqmp_reset_assert,
> +	.deassert = zynqmp_reset_deassert,
> +	.status = zynqmp_reset_status,
> +};
> +
> +static int zynqmp_reset_probe(struct platform_device *pdev)
> +{
> +	struct zynqmp_reset_data *priv;
> +
> +	priv = devm_kzalloc(&pdev->dev,
> +			    sizeof(*priv), GFP_KERNEL);

This should fit on one line.

regards
Philipp
