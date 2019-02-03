Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD1C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47032084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="DvZZ8gec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfBCN6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:58:34 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:56430 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbfBCN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549202307; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7B7LEY980IIsei+l9lmIK+ExFqBl1PxHGIm6tvKNi1M=;
        b=DvZZ8gecrOfvbI+1sah1H+rsQs6fRynf9AONU5B07/a9kx+KKjEafNirRrP9D4OsoGj+Bi
        iyIpYo57T3nY14eP12O2cZfiIjoK+6TFdkpInOA4Z44XvvO7WdRcW8G+mIuTy4eMWEWVft
        cU+KbLAPXSozWhv541aDuxO044JPLo4=
Date:   Sun, 03 Feb 2019 10:58:13 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 9/9] mtd: rawnand: jz4780-bch: Add support for the
 JZ4740
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1549202293.1950.2@crapouillou.net>
In-Reply-To: <20190203083505.4dc52278@bbrezillon>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190202231926.2444-10-paul@crapouillou.net>
        <20190203083505.4dc52278@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 3 f=E9vr. 2019 =E0 4:35, Boris Brezillon <bbrezillon@kernel.org>=20
a =E9crit :
> On Sat,  2 Feb 2019 20:19:26 -0300
> Paul Cercueil <paul@crapouillou.net> wrote:
>=20
>>  Add the backend code for the jz4780-bch driver to support the JZ4740
>>  SoC from Ingenic.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Changes:
>>=20
>>  v2: New patch
>>=20
>>   drivers/mtd/nand/raw/ingenic/Makefile         |   2 +-
>>   drivers/mtd/nand/raw/ingenic/jz4740_bch.c     | 173=20
>> ++++++++++++++++++
>>   .../mtd/nand/raw/ingenic/jz4780_bch_common.c  |   1 +
>>   .../nand/raw/ingenic/jz4780_bch_internal.h    |   1 +
>>   4 files changed, 176 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_bch.c
>>=20
>>  diff --git a/drivers/mtd/nand/raw/ingenic/Makefile=20
>> b/drivers/mtd/nand/raw/ingenic/Makefile
>>  index f38b467490cf..d16c96113a93 100644
>>  --- a/drivers/mtd/nand/raw/ingenic/Makefile
>>  +++ b/drivers/mtd/nand/raw/ingenic/Makefile
>>  @@ -1,3 +1,3 @@
>>   obj-$(CONFIG_MTD_NAND_JZ4740) +=3D jz4740_nand.o
>>   obj-$(CONFIG_MTD_NAND_JZ4780) +=3D jz4780_nand.o jz4780_bch_common.o=20
>> \
>>  -				 jz4780_bch.o jz4725b_bch.o
>>  +				 jz4780_bch.o jz4725b_bch.o jz4740_bch.o
>=20
> I still don't see the point of the jz4780_bch_common/jz47xxx_bch
> separation. You seem to always embed all objects anyway, so you can
> just put the code for both engines in the same source file and decide
> which one to use based on the compat (which you already do anyway).

Each SoC has a different set of registers for the BCH hardware. I can=20
try to
cram everything into one file, but it won't be that much cleaner.

>>  diff --git a/drivers/mtd/nand/raw/ingenic/jz4740_bch.c=20
>> b/drivers/mtd/nand/raw/ingenic/jz4740_bch.c
>>  new file mode 100644
>>  index 000000000000..61ea109cee9d
>>  --- /dev/null
>>  +++ b/drivers/mtd/nand/raw/ingenic/jz4740_bch.c
>>  @@ -0,0 +1,173 @@
>>  +// SPDX-License-Identifier: GPL-2.0
>>  +/*
>>  + * JZ4740 backend code for the jz4780-bch driver
>>  + * based on jz4740-nand.c
>>  + *
>>  + * Copyright (c) 2019 Paul Cercueil <paul@crapouillou.net>
>>  + */
>>  +
>>  +#include <linux/bitops.h>
>>  +#include <linux/device.h>
>>  +
>>  +#include "jz4780_bch.h"
>>  +#include "jz4780_bch_internal.h"
>>  +
>>  +#define JZ_REG_NAND_ECC_CTRL	0x00
>>  +#define JZ_REG_NAND_DATA	0x04
>>  +#define JZ_REG_NAND_PAR0	0x08
>>  +#define JZ_REG_NAND_PAR1	0x0C
>>  +#define JZ_REG_NAND_PAR2	0x10
>>  +#define JZ_REG_NAND_IRQ_STAT	0x14
>>  +#define JZ_REG_NAND_IRQ_CTRL	0x18
>>  +#define JZ_REG_NAND_ERR(x)	(0x1C + ((x) << 2))
>>  +
>>  +#define JZ_NAND_ECC_CTRL_PAR_READY	BIT(4)
>>  +#define JZ_NAND_ECC_CTRL_ENCODING	BIT(3)
>>  +#define JZ_NAND_ECC_CTRL_RS		BIT(2)
>>  +#define JZ_NAND_ECC_CTRL_RESET		BIT(1)
>>  +#define JZ_NAND_ECC_CTRL_ENABLE		BIT(0)
>>  +
>>  +#define JZ_NAND_STATUS_ERR_COUNT	(BIT(31) | BIT(30) | BIT(29))
>>  +#define JZ_NAND_STATUS_PAD_FINISH	BIT(4)
>>  +#define JZ_NAND_STATUS_DEC_FINISH	BIT(3)
>>  +#define JZ_NAND_STATUS_ENC_FINISH	BIT(2)
>>  +#define JZ_NAND_STATUS_UNCOR_ERROR	BIT(1)
>>  +#define JZ_NAND_STATUS_ERROR		BIT(0)
>>  +
>>  +static const uint8_t empty_block_ecc[] =3D {
>>  +	0xcd, 0x9d, 0x90, 0x58, 0xf4, 0x8b, 0xff, 0xb7, 0x6f
>>  +};
>>  +
>>  +static void jz4740_bch_init(struct jz4780_bch *bch, bool encode)
>>  +{
>>  +	uint32_t reg;
>>  +
>>  +	/* Clear interrupt status */
>>  +	writel(0, bch->base + JZ_REG_NAND_IRQ_STAT);
>>  +
>>  +	/* Initialize and enable BCH */
>>  +	reg =3D readl(bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +	reg |=3D JZ_NAND_ECC_CTRL_RESET;
>>  +	reg |=3D JZ_NAND_ECC_CTRL_ENABLE;
>>  +	reg |=3D JZ_NAND_ECC_CTRL_RS;
>>  +	if (encode)
>>  +		reg |=3D JZ_NAND_ECC_CTRL_ENCODING;
>>  +	else
>>  +		reg &=3D ~JZ_NAND_ECC_CTRL_ENCODING;
>>  +
>>  +	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +}
>>  +
>>  +static int jz4740_bch_calculate(struct jz4780_bch *bch,
>>  +				struct jz4780_bch_params *params,
>>  +				const u8 *buf, u8 *ecc_code)
>>  +{
>>  +	uint32_t reg, status;
>>  +	unsigned int timeout =3D 1000;
>>  +	int i;
>>  +
>>  +	jz4740_bch_init(bch, true);
>>  +
>>  +	do {
>>  +		status =3D readl(bch->base + JZ_REG_NAND_IRQ_STAT);
>>  +	} while (!(status & JZ_NAND_STATUS_ENC_FINISH) && --timeout);
>>  +
>>  +	if (timeout =3D=3D 0)
>>  +		return -ETIMEDOUT;
>>  +
>>  +	reg =3D readl(bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +	reg &=3D ~JZ_NAND_ECC_CTRL_ENABLE;
>>  +	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +
>>  +	for (i =3D 0; i < params->bytes; ++i)
>>  +		ecc_code[i] =3D readb(bch->base + JZ_REG_NAND_PAR0 + i);
>>  +
>>  +	/* If the written data is completely 0xff, we also want to write=20
>> 0xff as
>>  +	 * ecc, otherwise we will get in trouble when doing subpage=20
>> writes.
>>  +	 */
>>  +	if (memcmp(ecc_code, empty_block_ecc,=20
>> ARRAY_SIZE(empty_block_ecc)) =3D=3D 0)
>>  +		memset(ecc_code, 0xff, ARRAY_SIZE(empty_block_ecc));
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static void jz_nand_correct_data(uint8_t *buf, int index, int mask)
>>  +{
>>  +	int offset =3D index & 0x7;
>>  +	uint16_t data;
>>  +
>>  +	index +=3D (index >> 3);
>>  +
>>  +	data =3D buf[index];
>>  +	data |=3D buf[index + 1] << 8;
>>  +
>>  +	mask ^=3D (data >> offset) & 0x1ff;
>>  +	data &=3D ~(0x1ff << offset);
>>  +	data |=3D (mask << offset);
>>  +
>>  +	buf[index] =3D data & 0xff;
>>  +	buf[index + 1] =3D (data >> 8) & 0xff;
>>  +}
>>  +
>>  +static int jz4740_bch_correct(struct jz4780_bch *bch,
>>  +			      struct jz4780_bch_params *params,
>>  +			      u8 *buf, u8 *ecc_code)
>>  +{
>>  +	int i, error_count, index;
>>  +	uint32_t reg, status, error;
>>  +	unsigned int timeout =3D 1000;
>>  +
>>  +	jz4740_bch_init(bch, false);
>>  +
>>  +	for (i =3D 0; i < params->bytes; ++i)
>>  +		writeb(ecc_code[i], bch->base + JZ_REG_NAND_PAR0 + i);
>>  +
>>  +	reg =3D readl(bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +	reg |=3D JZ_NAND_ECC_CTRL_PAR_READY;
>>  +	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +
>>  +	do {
>>  +		status =3D readl(bch->base + JZ_REG_NAND_IRQ_STAT);
>>  +	} while (!(status & JZ_NAND_STATUS_DEC_FINISH) && --timeout);
>>  +
>>  +	if (timeout =3D=3D 0)
>>  +		return -ETIMEDOUT;
>>  +
>>  +	reg =3D readl(bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +	reg &=3D ~JZ_NAND_ECC_CTRL_ENABLE;
>>  +	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +
>>  +	if (status & JZ_NAND_STATUS_ERROR) {
>>  +		if (status & JZ_NAND_STATUS_UNCOR_ERROR)
>>  +			return -EBADMSG;
>>  +
>>  +		error_count =3D (status & JZ_NAND_STATUS_ERR_COUNT) >> 29;
>>  +
>>  +		for (i =3D 0; i < error_count; ++i) {
>>  +			error =3D readl(bch->base + JZ_REG_NAND_ERR(i));
>>  +			index =3D ((error >> 16) & 0x1ff) - 1;
>>  +			if (index >=3D 0 && index < params->size)
>>  +				jz_nand_correct_data(buf, index, error & 0x1ff);
>>  +		}
>>  +
>>  +		return error_count;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static void jz4740_bch_disable(struct jz4780_bch *bch)
>>  +{
>>  +	u32 reg;
>>  +
>>  +	writel(0, bch->base + JZ_REG_NAND_IRQ_STAT);
>>  +	reg =3D readl(bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +	reg &=3D ~JZ_NAND_ECC_CTRL_ENABLE;
>>  +	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
>>  +}
>>  +
>>  +const struct jz4780_bch_ops jz4780_bch_jz4740_ops =3D {
>>  +	.disable =3D jz4740_bch_disable,
>>  +	.calculate =3D jz4740_bch_calculate,
>>  +	.correct =3D jz4740_bch_correct,
>>  +};
>>  diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch_common.c=20
>> b/drivers/mtd/nand/raw/ingenic/jz4780_bch_common.c
>>  index f505816193a8..c2326286abb2 100644
>>  --- a/drivers/mtd/nand/raw/ingenic/jz4780_bch_common.c
>>  +++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch_common.c
>>  @@ -157,6 +157,7 @@ static int jz4780_bch_probe(struct=20
>> platform_device *pdev)
>>   }
>>=20
>>   static const struct of_device_id jz4780_bch_dt_match[] =3D {
>>  +	{ .compatible =3D "ingenic,jz4740-bch", .data =3D=20
>> &jz4780_bch_jz4740_ops},
>>   	{ .compatible =3D "ingenic,jz4725b-bch", .data =3D=20
>> &jz4780_bch_jz4725b_ops},
>>   	{ .compatible =3D "ingenic,jz4780-bch", .data =3D=20
>> &jz4780_bch_jz4780_ops },
>>   	{},
>>  diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch_internal.h=20
>> b/drivers/mtd/nand/raw/ingenic/jz4780_bch_internal.h
>>  index 462aded811b1..7909a49c57db 100644
>>  --- a/drivers/mtd/nand/raw/ingenic/jz4780_bch_internal.h
>>  +++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch_internal.h
>>  @@ -30,6 +30,7 @@ struct jz4780_bch {
>>   	struct mutex lock;
>>   };
>>=20
>>  +extern const struct jz4780_bch_ops jz4780_bch_jz4740_ops;
>>   extern const struct jz4780_bch_ops jz4780_bch_jz4725b_ops;
>>   extern const struct jz4780_bch_ops jz4780_bch_jz4780_ops;
>>=20
>=20
=

