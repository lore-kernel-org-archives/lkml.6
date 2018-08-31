Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9962AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4180D20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4180D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeHaLpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:45:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51635 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeHaLpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:45:51 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fve1a-00074e-3k; Fri, 31 Aug 2018 09:39:22 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fve1W-0002GG-E3; Fri, 31 Aug 2018 09:39:18 +0200
Date:   Fri, 31 Aug 2018 09:39:18 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 6/6] crypto: vf-crc - Add new driver for Freescale Vybrid
 CRC
Message-ID: <20180831073918.bcmonixmeehvr42h@pengutronix.de>
References: <20180830171539.20008-1-krzk@kernel.org>
 <20180830171539.20008-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830171539.20008-7-krzk@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:00:22 up 79 days, 16:09, 54 users,  load average: 3.11, 1.21,
 0.55
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Some comments inline.

On Thu, Aug 30, 2018 at 07:15:39PM +0200, Krzysztof Kozlowski wrote:
> Add driver for using the Freescale/NXP Vybrid processor CRC block for
> CRC16 and CRC32 offloading.  The driver implements shash_alg and was
> tested using internal testmgr tests and libkcapi.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  MAINTAINERS               |   7 +
>  drivers/crypto/Kconfig    |  10 ++
>  drivers/crypto/Makefile   |   1 +
>  drivers/crypto/vf-crc.c   | 387 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/crc32poly.h |   7 +
>  5 files changed, 412 insertions(+)
>  create mode 100644 drivers/crypto/vf-crc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a340f680230..e84fa829a4e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15388,6 +15388,13 @@ S:	Maintained
>  F:	Documentation/fb/uvesafb.txt
>  F:	drivers/video/fbdev/uvesafb.*
>  
> +VF500/VF610 HW CRC DRIVER
> +M:	Krzysztof Kozlowski <krzk@kernel.org>
> +L:	linux-crypto@vger.kernel.org
> +S:	Maintained
> +F:	drivers/crypto/vf-crc.c
> +F:	Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt
> +
>  VF610 NAND DRIVER
>  M:	Stefan Agner <stefan@agner.ch>
>  L:	linux-mtd@lists.infradead.org
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 20314d7a7b58..0ade940ac79c 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -418,6 +418,16 @@ config CRYPTO_DEV_MXS_DCP
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mxs-dcp.
>  
> +config CRYPTO_DEV_VF_CRC
> +	tristate "Support for Freescale/NXP Vybrid CRC HW accelerator"
> +	select CRYPTO_HASH
> +	help
> +	  This option enables support for the CRC16/32 hardware accelerator
> +	  on Freescale/NXP Vybrid VF500/VF610 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called vf-crc.
> +
>  config CRYPTO_DEV_EXYNOS_RNG
>  	tristate "EXYNOS HW pseudo random number generator support"
>  	depends on ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index c23396f32c8a..418c08bdc19c 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_ARCH_STM32) += stm32/
>  obj-$(CONFIG_CRYPTO_DEV_SUN4I_SS) += sunxi-ss/
>  obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
>  obj-$(CONFIG_CRYPTO_DEV_UX500) += ux500/
> +obj-$(CONFIG_CRYPTO_DEV_VF_CRC) += vf-crc.o
>  obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio/
>  obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
>  obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
> +static int vf_crc_update_prepare(struct vf_crc_tfm_ctx *mctx,
> +				 struct vf_crc_desc_ctx *desc_ctx)
> +{
> +	struct vf_crc *crc = desc_ctx->crc;
> +	int ret;
> +
> +	ret = clk_prepare_enable(crc->clk);
> +	if (ret) {
> +		dev_err(crc->dev, "Failed to enable clock\n");
> +		return ret;
> +	}

Generally have you measured the performance of this driver? Is it faster
than the software implementation?

Under certain circumstances a clk_prepare_enable might become expensive,
so it could happen that all this clk enabling/disabling takes longer
than the action you do in between. Using pm_runtime might help here.

> +
> +	mutex_lock(&crc->lock);
> +
> +	/*
> +	 * Check if we are continuing to process request already configured
> +	 * in HW. HW has to be re-initialized only on first update() for given
> +	 * request or if new request was processed after last call to update().
> +	 */
> +	if (crc->processed_desc == desc_ctx)
> +		return 0;

You never set crc->processed_desc to anything, so this optimization
never triggers.

Unless properly implementing this skip-to-reinitialize-hardware really
brings a measurerable performance gain I would just drop this
optimization. In the end you only save a few register writes, but it
makes the driver more complicated.

> +
> +	vf_crc_initialize_regs(mctx, desc_ctx);
> +
> +	return 0;
> +}
> +

> +static int vf_crc_finup(struct shash_desc *desc, const u8 *data,
> +			unsigned int len, u8 *out)
> +{
> +	return vf_crc_update(desc, data, len) ?:
> +	       vf_crc_final(desc, out);
> +}
> +
> +static int vf_crc_digest(struct shash_desc *desc, const u8 *data,
> +			 unsigned int leng, u8 *out)
> +{
> +	return vf_crc_init(desc) ?: vf_crc_finup(desc, data, leng, out);
> +}

These seem unnecessary. The crypto core will set these with similar
wrappers if unspecified.

> +static int vf_crc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct vf_crc *crc;
> +	int ret;
> +
> +	if (vf_crc_data) {
> +		dev_err(dev, "Device already registered (only one instance allowed)\n");
> +		return -EINVAL;
> +	}
> +
> +	crc = devm_kzalloc(dev, sizeof(*crc), GFP_KERNEL);
> +	if (!crc)
> +		return -ENOMEM;
> +
> +	crc->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	crc->iobase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(crc->iobase))
> +		return PTR_ERR(crc->iobase);
> +
> +	crc->clk = devm_clk_get(dev, "crc");
> +	if (IS_ERR(crc->clk)) {
> +		dev_err(dev, "Could not get clock\n");
> +		return PTR_ERR(crc->clk);
> +	}
> +
> +	vf_crc_data = crc;
> +
> +	ret = crypto_register_shashes(algs, ARRAY_SIZE(algs));
> +	if (ret) {
> +		dev_err(dev, "Failed to register crypto algorithms\n");
> +		goto err;
> +	}
> +
> +	mutex_init(&crc->lock);

Should be done before the shashes are registered.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
