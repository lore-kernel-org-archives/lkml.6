Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5919C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D4C20643
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="h6h9uKcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeLSPbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:31:39 -0500
Received: from mail.nic.cz ([217.31.204.67]:40936 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbeLSPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:31:39 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPS id 9729162A74;
        Wed, 19 Dec 2018 16:31:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1545233496; bh=djuxDkz/MhwahEInJjWhb8aOyvrhqfFB5tLeCVBgcgA=;
        h=Date:From:To;
        b=h6h9uKcuMr/nhCXOvA5WIW/LWOOGfJNvhQmydItlFthzt1Th5aqQpQkobKn0cHGaY
         noIX6T6cIEIiMQ/4iyXvADrFxnFd3FY8yQ7g2RIngJW9ER8zRy24rcaRMY1VX9T+XN
         WDzo5P3lBzZ91sJhs7K8MWwwMoQzj2xpLouby39o=
Date:   Wed, 19 Dec 2018 16:31:28 +0100
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] mailbox: Add support for Armada 37xx rWTM
 mailbox
Message-ID: <20181219163128.7dceb645@dellmb.labs.office.nic.cz>
In-Reply-To: <20181217153706.25873-1-marek.behun@nic.cz>
References: <20181217153706.25873-1-marek.behun@nic.cz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to git add the header file containing definitions of
structures for messages :(. Will send in the next version.

On Mon, 17 Dec 2018 16:37:04 +0100
Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:

> This adds support for the mailbox via which the kernel can communicate
> with the firmware running on the secure processor of the Armada 37xx
> SOC.
>=20
> The rWTM secure processor has access to internal eFuses and
> cryptographic circuits, such as the Entropy Bit Generator to generate
> true random numbers.
>=20
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> ---
>  drivers/mailbox/Kconfig                    |  10 +
>  drivers/mailbox/Makefile                   |   2 +
>  drivers/mailbox/armada-37xx-rwtm-mailbox.c | 227
> +++++++++++++++++++++ 3 files changed, 239 insertions(+)
>  create mode 100644 drivers/mailbox/armada-37xx-rwtm-mailbox.c
>=20
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 3eeb12e93e98..939927290ac6 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -41,6 +41,16 @@ config PL320_MBOX
>  	  Management Engine, primarily for cpufreq. Say Y here if
> you want to use the PL320 IPCM support.
> =20
> +config ARMADA_37XX_RWTM_MBOX
> +	tristate "Armada 37xx rWTM BIU Mailbox"
> +	depends on ARCH_MVEBU || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Mailbox implementation for communication with the the
> firmware
> +	  running on the Cortex-M3 rWTM secure processor of the
> Armada 37xx
> +	  SOC. Say Y here if you are building for such a device (for
> example
> +	  the Turris Mox router).
> +
>  config OMAP2PLUS_MBOX
>  	tristate "OMAP2+ Mailbox framework support"
>  	depends on ARCH_OMAP2PLUS
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index c818b5d011ae..792894db6b43 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -9,6 +9,8 @@ obj-$(CONFIG_ARM_MHU)	+=3D arm_mhu.o
> =20
>  obj-$(CONFIG_IMX_MBOX)	+=3D imx-mailbox.o
> =20
> +obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)	+=3D
> armada-37xx-rwtm-mailbox.o +
>  obj-$(CONFIG_PLATFORM_MHU)	+=3D platform_mhu.o
> =20
>  obj-$(CONFIG_PL320_MBOX)	+=3D pl320-ipc.o
> diff --git a/drivers/mailbox/armada-37xx-rwtm-mailbox.c
> b/drivers/mailbox/armada-37xx-rwtm-mailbox.c new file mode 100644
> index 000000000000..b8b3e8cd49f0
> --- /dev/null
> +++ b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * rWTM BIU Mailbox driver for Armada 37xx
> + *
> + * Author: Marek Behun <marek.behun@nic.cz>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/armada-37xx-rwtm-mailbox.h>
> +
> +#define DRIVER_NAME	"armada-37xx-rwtm-mailbox"
> +
> +/* relative to rWTM BIU Mailbox Registers */
> +#define RWTM_MBOX_PARAM(i)		(0x0 + ((i) << 2))
> +#define RWTM_MBOX_COMMAND		0x40
> +#define RWTM_MBOX_RETURN_STATUS		0x80
> +#define RWTM_MBOX_STATUS(i)		(0x84 + ((i) << 2))
> +#define RWTM_MBOX_FIFO_STATUS		0xc4
> +#define FIFO_STS_RDY			0x100
> +#define FIFO_STS_CNTR_MASK		0x7
> +#define FIFO_STS_CNTR_MAX		4
> +
> +#define RWTM_HOST_INT_RESET		0xc8
> +#define RWTM_HOST_INT_MASK		0xcc
> +#define SP_CMD_COMPLETE			BIT(0)
> +#define SP_CMD_QUEUE_FULL_ACCESS	BIT(17)
> +#define SP_CMD_QUEUE_FULL		BIT(18)
> +
> +struct a37xx_mbox {
> +	struct device *dev;
> +	struct mbox_controller controller;
> +	void __iomem *base;
> +	int irq;
> +};
> +
> +static void a37xx_mbox_receive(struct mbox_chan *chan)
> +{
> +	struct a37xx_mbox *mbox =3D chan->con_priv;
> +	struct armada_37xx_rwtm_rx_msg rx_msg;
> +	int i;
> +
> +	rx_msg.retval =3D readl(mbox->base + RWTM_MBOX_RETURN_STATUS);
> +	for (i =3D 0; i < 16; ++i)
> +		rx_msg.status[i] =3D readl(mbox->base +
> RWTM_MBOX_STATUS(i)); +
> +	mbox_chan_received_data(chan, &rx_msg);
> +}
> +
> +static irqreturn_t a37xx_mbox_irq_handler(int irq, void *data)
> +{
> +	struct mbox_chan *chan =3D data;
> +	struct a37xx_mbox *mbox =3D chan->con_priv;
> +	u32 reg;
> +
> +	reg =3D readl(mbox->base + RWTM_HOST_INT_RESET);
> +
> +	if (reg & SP_CMD_COMPLETE)
> +		a37xx_mbox_receive(chan);
> +
> +	if (reg & (SP_CMD_QUEUE_FULL_ACCESS | SP_CMD_QUEUE_FULL))
> +		dev_err(mbox->dev, "Secure processor command queue
> full\n"); +
> +	writel(reg, mbox->base + RWTM_HOST_INT_RESET);
> +	if (reg)
> +		mbox_chan_txdone(chan, 0);
> +
> +	return reg ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int a37xx_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct a37xx_mbox *mbox =3D chan->con_priv;
> +	struct armada_37xx_rwtm_tx_msg *msg =3D data;
> +	int i;
> +	u32 reg;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	reg =3D readl(mbox->base + RWTM_MBOX_FIFO_STATUS);
> +	if (!(reg & FIFO_STS_RDY)) {
> +		dev_err(mbox->dev, "Secure processor not ready\n");
> +		return -EAGAIN;
> +	}
> +
> +	if ((reg & FIFO_STS_CNTR_MASK) >=3D FIFO_STS_CNTR_MAX) {
> +		dev_err(mbox->dev, "Secure processor command queue
> full\n");
> +		return -EBUSY;
> +	}
> +
> +	for (i =3D 0; i < 16; ++i)
> +		writel(msg->args[i], mbox->base +
> RWTM_MBOX_PARAM(i));
> +	writel(msg->command, mbox->base + RWTM_MBOX_COMMAND);
> +
> +	return 0;
> +}
> +
> +static int a37xx_mbox_startup(struct mbox_chan *chan)
> +{
> +	struct a37xx_mbox *mbox =3D chan->con_priv;
> +	u32 reg;
> +	int ret;
> +
> +	ret =3D devm_request_irq(mbox->dev, mbox->irq,
> a37xx_mbox_irq_handler, 0,
> +			       DRIVER_NAME, chan);
> +	if (ret < 0) {
> +		dev_err(mbox->dev, "Cannot request irq\n");
> +		return ret;
> +	}
> +
> +	/* enable IRQ generation */
> +	reg =3D readl(mbox->base + RWTM_HOST_INT_MASK);
> +	reg &=3D ~(SP_CMD_COMPLETE | SP_CMD_QUEUE_FULL_ACCESS |
> SP_CMD_QUEUE_FULL);
> +	writel(reg, mbox->base + RWTM_HOST_INT_MASK);
> +
> +	return 0;
> +}
> +
> +static void a37xx_mbox_shutdown(struct mbox_chan *chan)
> +{
> +	u32 reg;
> +	struct a37xx_mbox *mbox =3D chan->con_priv;
> +
> +	/* disable interrupt generation */
> +	reg =3D readl(mbox->base + RWTM_HOST_INT_MASK);
> +	reg |=3D SP_CMD_COMPLETE | SP_CMD_QUEUE_FULL_ACCESS |
> SP_CMD_QUEUE_FULL;
> +	writel(reg, mbox->base + RWTM_HOST_INT_MASK);
> +
> +	devm_free_irq(mbox->dev, mbox->irq, chan);
> +}
> +
> +static const struct mbox_chan_ops a37xx_mbox_ops =3D {
> +	.send_data	=3D a37xx_mbox_send_data,
> +	.startup	=3D a37xx_mbox_startup,
> +	.shutdown	=3D a37xx_mbox_shutdown,
> +};
> +
> +static int armada_37xx_mbox_probe(struct platform_device *pdev)
> +{
> +	struct a37xx_mbox *mbox;
> +	struct resource *regs;
> +	struct mbox_chan *chans;
> +	int ret;
> +
> +	mbox =3D devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +
> +	/* Allocated one channel */
> +	chans =3D devm_kzalloc(&pdev->dev, sizeof(*chans), GFP_KERNEL);
> +	if (!chans)
> +		return -ENOMEM;
> +
> +	regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	mbox->base =3D devm_ioremap_resource(&pdev->dev, regs);
> +	if (IS_ERR(mbox->base)) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		return PTR_ERR(mbox->base);
> +	}
> +
> +	mbox->irq =3D platform_get_irq(pdev, 0);
> +	if (mbox->irq < 0) {
> +		dev_err(&pdev->dev, "Cannot get irq\n");
> +		return mbox->irq;
> +	}
> +
> +	mbox->dev =3D &pdev->dev;
> +
> +	/* Hardware supports only one channel. */
> +	chans[0].con_priv =3D mbox;
> +	mbox->controller.dev =3D mbox->dev;
> +	mbox->controller.num_chans =3D 1;
> +	mbox->controller.chans =3D chans;
> +	mbox->controller.ops =3D &a37xx_mbox_ops;
> +	mbox->controller.txdone_irq =3D true;
> +
> +	ret =3D mbox_controller_register(&mbox->controller);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not register mailbox
> controller\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, mbox);
> +	return ret;
> +}
> +
> +static int armada_37xx_mbox_remove(struct platform_device *pdev)
> +{
> +	struct a37xx_mbox *mbox =3D platform_get_drvdata(pdev);
> +
> +	if (!mbox)
> +		return -EINVAL;
> +
> +	mbox_controller_unregister(&mbox->controller);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id armada_37xx_mbox_match[] =3D {
> +	{ .compatible =3D "marvell,armada-37xx-rwtm-mailbox" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, armada_37xx_mbox_match);
> +
> +static struct platform_driver armada_37xx_mbox_driver =3D {
> +	.probe	=3D armada_37xx_mbox_probe,
> +	.remove	=3D armada_37xx_mbox_remove,
> +	.driver	=3D {
> +		.name		=3D DRIVER_NAME,
> +		.of_match_table	=3D armada_37xx_mbox_match,
> +	},
> +};
> +
> +module_platform_driver(armada_37xx_mbox_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("rWTM BIU Mailbox driver for Armada 37xx");
> +MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");

