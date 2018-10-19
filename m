Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606F9ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF6721476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF6721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJSRIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:08:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58179 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJSRIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:08:35 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gDQgc-0004Tc-6i; Fri, 19 Oct 2018 11:03:14 +0200
Message-ID: <1539939793.3395.2.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] reset: reset-zynqmp: Adding support for Xilinx
 zynqmp reset controller.
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        jollys@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
Date:   Fri, 19 Oct 2018 11:03:13 +0200
In-Reply-To: <20181020084107.28251-4-nava.manne@xilinx.com>
References: <20181020084107.28251-1-nava.manne@xilinx.com>
         <20181020084107.28251-4-nava.manne@xilinx.com>
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

Hi Nava,

On Sat, 2018-10-20 at 14:11 +0530, Nava kishore Manne wrote:
> Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
> The zynqmp reset-controller has the ability to reset lines
> connected to different blocks and peripheral in the Soc.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v1:
> 		-None.

I had comments on RFC v3 that are not addressed yet, see below.

> --- /dev/null
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Xilinx, Inc.
> + *
> + */
> +
> +#include <linux/io.h>

Unnecessary.

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

Should return error code, and only if there is an error:

	if (err)
		return err;

> +	return val;
> +}
> +
> +static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> +
> +	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
> +					    PM_RESET_ACTION_PULSE);
> +}
> +
> +static struct reset_control_ops zynqmp_reset_ops = {

Should be const:

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

Fits on one line:

	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);

regards
Philipp
