Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C258BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90393218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="gz0f46/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfBCN5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:57:20 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:55924 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbfBCN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549202228; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JhIxqtYBUymNwnoVtMBVkJEhdQaXjb8TBlyTpJXq6QE=;
        b=gz0f46/P4qWJkl2gZa8c+ftr7SWafPUt5fIglBjz9jNaLGD1+hEciqs3+QTsuMfDLIgLmI
        Mh3j4xQvIm8QzRganOe/w+AEbVyjAufI5g5qqJJgLrpLHggWSj/F16ZeCZlubMZ6k1NUHx
        onJm2Bwn9rc/bw2JDtvh2clCVlwOVUg=
Date:   Sun, 03 Feb 2019 10:56:53 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 4/9] mtd: rawnand: jz4780: Add support for the JZ4740
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
Message-Id: <1549202213.1950.1@crapouillou.net>
In-Reply-To: <20190203083151.4fc29c5b@bbrezillon>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190202231926.2444-5-paul@crapouillou.net>
        <20190203083151.4fc29c5b@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 3 f=E9vr. 2019 =E0 4:31, Boris Brezillon <bbrezillon@kernel.org>=20
a =E9crit :
> On Sat,  2 Feb 2019 20:19:21 -0300
> Paul Cercueil <paul@crapouillou.net> wrote:
>=20
>>  Add support for probing the jz4780-nand driver on the JZ4740 SoC=20
>> from
>>  Ingenic.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Changes:
>>=20
>>  v2: - Add support for the JZ4740 and not the JZ4725B: they behave=20
>> the
>>        same, and JZ4740 is fully upstream while JZ4725B is not. The
>>        JZ4725B devicetree will then simply use the=20
>> "ingenic,jz4740-nand"
>>        compatible string.
>>      - Fix the number of bytes for the ECC when the ECC strength is=20
>> 4.
>>        This is needed for the JZ4740, which uses Reed-Solomon=20
>> instead of
>>        BCH.
>>=20
>>   drivers/mtd/nand/raw/ingenic/jz4780_nand.c | 48=20
>> +++++++++++++++++-----
>=20
> If we're going to make the driver compatible with jz4740 and jz4725b
> maybe we should rename the source files jz47xx_{nand,bch}.{c,h}.

I don't know about that. Adding support for new hardware isn't a good=20
reason to
rename the driver, or so I've been told around here, as you then make=20
it harder
to review the git history of the driver.

>>   1 file changed, 37 insertions(+), 11 deletions(-)
>>=20
>>  diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c=20
>> b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
>>  index 7f55358b860f..c0855fef7735 100644
>>  --- a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
>>  +++ b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
>>  @@ -13,6 +13,7 @@
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>>  +#include <linux/of_device.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>  @@ -26,13 +27,15 @@
>>=20
>>   #define DRV_NAME	"jz4780-nand"
>>=20
>>  -#define OFFSET_DATA	0x00000000
>>  -#define OFFSET_CMD	0x00400000
>>  -#define OFFSET_ADDR	0x00800000
>>  -
>>   /* Command delay when there is no R/B pin. */
>>   #define RB_DELAY_US	100
>>=20
>>  +struct jz_soc_info {
>>  +	unsigned long data_offset;
>>  +	unsigned long addr_offset;
>>  +	unsigned long cmd_offset;
>>  +};
>>  +
>>   struct jz4780_nand_cs {
>>   	unsigned int bank;
>>   	void __iomem *base;
>>  @@ -40,6 +43,7 @@ struct jz4780_nand_cs {
>>=20
>>   struct jz4780_nand_controller {
>>   	struct device *dev;
>>  +	const struct jz_soc_info *soc_info;
>>   	struct jz4780_bch *bch;
>>   	struct nand_controller controller;
>>   	unsigned int num_banks;
>>  @@ -101,9 +105,9 @@ static void jz4780_nand_cmd_ctrl(struct=20
>> nand_chip *chip, int cmd,
>>   		return;
>>=20
>>   	if (ctrl & NAND_ALE)
>>  -		writeb(cmd, cs->base + OFFSET_ADDR);
>>  +		writeb(cmd, cs->base + nfc->soc_info->addr_offset);
>>   	else if (ctrl & NAND_CLE)
>>  -		writeb(cmd, cs->base + OFFSET_CMD);
>>  +		writeb(cmd, cs->base + nfc->soc_info->cmd_offset);
>>   }
>>=20
>>   static int jz4780_nand_dev_ready(struct nand_chip *chip)
>>  @@ -161,8 +165,13 @@ static int jz4780_nand_attach_chip(struct=20
>> nand_chip *chip)
>>   	struct jz4780_nand_controller *nfc =3D=20
>> to_jz4780_nand_controller(chip->controller);
>>   	int eccbytes;
>>=20
>>  -	chip->ecc.bytes =3D fls((1 + 8) * chip->ecc.size)	*
>>  -				(chip->ecc.strength / 8);
>>  +	if (chip->ecc.strength =3D=3D 4) {
>>  +		/* JZ4740 uses 9 bytes of ECC to correct maximum 4 errors */
>>  +		chip->ecc.bytes =3D 9;
>>  +	} else {
>>  +		chip->ecc.bytes =3D fls((1 + 8) * chip->ecc.size)	*
>>  +				  (chip->ecc.strength / 8);
>>  +	}
>>=20
>>   	switch (chip->ecc.mode) {
>>   	case NAND_ECC_HW:
>>  @@ -272,8 +281,8 @@ static int jz4780_nand_init_chip(struct=20
>> platform_device *pdev,
>>   		return -ENOMEM;
>>   	mtd->dev.parent =3D dev;
>>=20
>>  -	chip->legacy.IO_ADDR_R =3D cs->base + OFFSET_DATA;
>>  -	chip->legacy.IO_ADDR_W =3D cs->base + OFFSET_DATA;
>>  +	chip->legacy.IO_ADDR_R =3D cs->base + nfc->soc_info->data_offset;
>>  +	chip->legacy.IO_ADDR_W =3D cs->base + nfc->soc_info->data_offset;
>>   	chip->legacy.chip_delay =3D RB_DELAY_US;
>>   	chip->options =3D NAND_NO_SUBPAGE_WRITE;
>>   	chip->legacy.select_chip =3D jz4780_nand_select_chip;
>>  @@ -353,6 +362,10 @@ static int jz4780_nand_probe(struct=20
>> platform_device *pdev)
>>   	if (!nfc)
>>   		return -ENOMEM;
>>=20
>>  +	nfc->soc_info =3D device_get_match_data(dev);
>>  +	if (!nfc->soc_info)
>>  +		return -EINVAL;
>>  +
>>   	/*
>>   	 * Check for BCH HW before we call nand_scan_ident, to prevent us=20
>> from
>>   	 * having to call it again if the BCH driver returns=20
>> -EPROBE_DEFER.
>>  @@ -390,8 +403,21 @@ static int jz4780_nand_remove(struct=20
>> platform_device *pdev)
>>   	return 0;
>>   }
>>=20
>>  +static const struct jz_soc_info jz4740_soc_info =3D {
>>  +	.data_offset =3D 0x00000000,
>>  +	.cmd_offset  =3D 0x00008000,
>>  +	.addr_offset =3D 0x00010000,
>>  +};
>>  +
>>  +static const struct jz_soc_info jz4780_soc_info =3D {
>>  +	.data_offset =3D 0x00000000,
>>  +	.cmd_offset  =3D 0x00400000,
>>  +	.addr_offset =3D 0x00800000,
>>  +};
>>  +
>>   static const struct of_device_id jz4780_nand_dt_match[] =3D {
>>  -	{ .compatible =3D "ingenic,jz4780-nand" },
>>  +	{ .compatible =3D "ingenic,jz4740-nand", .data =3D &jz4740_soc_info }=
,
>>  +	{ .compatible =3D "ingenic,jz4780-nand",  .data =3D &jz4780_soc_info =
=20
>> },
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(of, jz4780_nand_dt_match);
>=20
=

