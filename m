Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD6C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfAQRQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:16:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52607 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfAQRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:16:29 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gkBHB-00013U-AQ; Thu, 17 Jan 2019 18:16:21 +0100
Message-ID: <1547745380.4009.18.camel@pengutronix.de>
Subject: Re: [PATCH v4 1/3] reset: imx7: Add plubming to support multiple IP
 variants
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 18:16:20 +0100
In-Reply-To: <20181220010700.8598-2-andrew.smirnov@gmail.com>
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
         <20181220010700.8598-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 17:06 -0800, Andrey Smirnov wrote:
> In order to enable supporting i.MX8MQ with this driver, convert it to
> expect variant specific bits to be passed via driver data.
> 
> Cc: p.zabel@pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/reset/reset-imx7.c | 62 +++++++++++++++++++++++++++-----------
>  1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 77911fa8f31d..3a36d5863891 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -17,14 +17,29 @@
>  
>  #include <linux/mfd/syscon.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
>  #include <linux/regmap.h>
>  #include <dt-bindings/reset/imx7-reset.h>
>  
> +struct imx7_src_signal {
> +	unsigned int offset, bit;
> +};
> +
> +struct imx7_src;
> +
> +struct imx7_src_variant {
> +	const struct imx7_src_signal *signals;
> +	unsigned int signals_num;
> +	unsigned int (*prepare)(struct imx7_src *imx7src, unsigned long id,
> +				bool assert);

Instead of adding a function pointer indirection, I'd prefer separate
imx7_reset_ops and imx8m_reset_ops set by the variant, see below.

> +};
> +
>  struct imx7_src {
>  	struct reset_controller_dev rcdev;
>  	struct regmap *regmap;
> +	const struct imx7_src_variant *variant;

This could then replaced with a direct pointer to the respective signals
array.

>  };
>  
>  enum imx7_src_registers {
> @@ -39,10 +54,6 @@ enum imx7_src_registers {
>  	SRC_DDRC_RCR		= 0x1000,
>  };
>  
> -struct imx7_src_signal {
> -	unsigned int offset, bit;
> -};
> -
>  static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
>  	[IMX7_RESET_A7_CORE_POR_RESET0] = { SRC_A7RCR0, BIT(0) },
>  	[IMX7_RESET_A7_CORE_POR_RESET1] = { SRC_A7RCR0, BIT(1) },
> @@ -72,17 +83,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
>  	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
>  };
>  
> -static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
> +static unsigned int
> +imx7_src_prepare(struct imx7_src *imx7src, unsigned long id, bool assert)
>  {
> -	return container_of(rcdev, struct imx7_src, rcdev);
> -}
> -
> -static int imx7_reset_set(struct reset_controller_dev *rcdev,
> -			  unsigned long id, bool assert)
> -{
> -	struct imx7_src *imx7src = to_imx7_src(rcdev);
> -	const struct imx7_src_signal *signal = &imx7_src_signals[id];
> -	unsigned int value = assert ? signal->bit : 0;
> +	const unsigned int bit = imx7src->variant->signals[id].bit;
> +	unsigned int value = assert ? bit : 0;
>  
>  	switch (id) {
>  	case IMX7_RESET_PCIEPHY:
> @@ -95,10 +100,32 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
>  		break;
>  
>  	case IMX7_RESET_PCIE_CTRL_APPS_EN:
> -		value = (assert) ? 0 : signal->bit;
> +		value = assert ? 0 : bit;
>  		break;
>  	}
>  
> +	return value;
> +}

Instead of having a common imx7_reset_set and then calling the custom
.prepare() through a function pointer, I'd suggest to have custom
imx7_reset_set and imx8m_reset_set functions that contain the code from
.prepare() and then call a common function to do the actual register
access.

> +
> +static const struct imx7_src_variant variant_imx7 = {
> +	.signals = imx7_src_signals,
> +	.signals_num = ARRAY_SIZE(imx7_src_signals),
> +	.prepare = imx7_src_prepare,
> +};
> +
> +static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct imx7_src, rcdev);
> +}
> +
> +static int imx7_reset_set(struct reset_controller_dev *rcdev,
> +			  unsigned long id, bool assert)
> +{
> +	struct imx7_src *imx7src = to_imx7_src(rcdev);
> +	const struct imx7_src_variant *variant = imx7src->variant;
> +	const struct imx7_src_signal *signal = &variant->signals[id];
> +	const unsigned int value = variant->prepare(imx7src, id, assert);
> +
>  	return regmap_update_bits(imx7src->regmap,
>  				  signal->offset, signal->bit, value);
>  }
> @@ -130,6 +157,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
>  	if (!imx7src)
>  		return -ENOMEM;
>  
> +	imx7src->variant = of_device_get_match_data(dev);
>  	imx7src->regmap = syscon_node_to_regmap(dev->of_node);
>  	if (IS_ERR(imx7src->regmap)) {
>  		dev_err(dev, "Unable to get imx7-src regmap");
> @@ -138,7 +166,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
>  	regmap_attach_dev(dev, imx7src->regmap, &config);
>  
>  	imx7src->rcdev.owner     = THIS_MODULE;
> -	imx7src->rcdev.nr_resets = IMX7_RESET_NUM;
> +	imx7src->rcdev.nr_resets = imx7src->variant->signals_num;
>  	imx7src->rcdev.ops       = &imx7_reset_ops;
>  	imx7src->rcdev.of_node   = dev->of_node;
>  
> @@ -146,7 +174,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id imx7_reset_dt_ids[] = {
> -	{ .compatible = "fsl,imx7d-src", },
> +	{ .compatible = "fsl,imx7d-src", .data = &variant_imx7 },
>  	{ /* sentinel */ },
>  };

regards
Phililipp
