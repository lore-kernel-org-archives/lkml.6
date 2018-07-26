Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2645FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB16020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB16020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeGZIFL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:05:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43410 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbeGZIFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:05:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7AD9F208FF; Thu, 26 Jul 2018 08:49:47 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id DFA0920730;
        Thu, 26 Jul 2018 08:49:36 +0200 (CEST)
Date:   Thu, 26 Jul 2018 08:49:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     xiaolei li <xiaolei.li@mediatek.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        "Tudor Ambarus" <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        "Mans Rullgard" <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v4 14/35] mtd: rawnand: mtk: convert driver to
 nand_scan()
Message-ID: <20180726084935.047f33c7@xps13>
In-Reply-To: <1532587589.10234.14.camel@mhfsdcap03>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-15-miquel.raynal@bootlin.com>
        <20180721191004.26fc9290@bbrezillon>
        <1532585201.10234.9.camel@mhfsdcap03>
        <20180726081402.1fa86ec5@bbrezillon>
        <1532587589.10234.14.camel@mhfsdcap03>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi xiaolei,

xiaolei li <xiaolei.li@mediatek.com> wrote on Thu, 26 Jul 2018 14:46:29
+0800:

> On Thu, 2018-07-26 at 08:14 +0200, Boris Brezillon wrote:
> > On Thu, 26 Jul 2018 14:06:41 +0800
> > xiaolei li <xiaolei.li@mediatek.com> wrote:
> >   
> > > On Sat, 2018-07-21 at 19:10 +0200, Boris Brezillon wrote:  
> > > > On Fri, 20 Jul 2018 17:15:06 +0200
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >     
> > > > > Two helpers have been added to the core to make ECC-related
> > > > > configuration between the detection phase and the final NAND scan. Use
> > > > > these hooks and convert the driver to just use nand_scan() instead of
> > > > > both nand_scan_ident() and nand_scan_tail().
> > > > > 
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > > > >  drivers/mtd/nand/raw/mtk_nand.c | 75 ++++++++++++++++++++++++-----------------
> > > > >  1 file changed, 44 insertions(+), 31 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
> > > > > index 7bc6be3f6ec0..967418f945ea 100644
> > > > > --- a/drivers/mtd/nand/raw/mtk_nand.c
> > > > > +++ b/drivers/mtd/nand/raw/mtk_nand.c
> > > > > @@ -1250,13 +1250,54 @@ static int mtk_nfc_ecc_init(struct device *dev, struct mtd_info *mtd)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static int mtk_nfc_attach_chip(struct nand_chip *chip)
> > > > > +{
> > > > > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > > > > +	struct device *dev = mtd->dev.parent;
> > > > > +	struct mtk_nfc *nfc = nand_get_controller_data(chip);
> > > > > +	struct mtk_nfc_nand_chip *mtk_nand = to_mtk_nand(chip);
> > > > > +	int len;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (chip->options & NAND_BUSWIDTH_16) {
> > > > > +		dev_err(dev, "16bits buswidth not supported");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	/* store bbt magic in page, cause OOB is not protected */
> > > > > +	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> > > > > +		chip->bbt_options |= NAND_BBT_NO_OOB;
> > > > > +
> > > > > +	ret = mtk_nfc_ecc_init(dev, mtd);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret = mtk_nfc_set_spare_per_sector(&mtk_nand->spare_per_sector, mtd);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	mtk_nfc_set_fdm(&mtk_nand->fdm, mtd);
> > > > > +	mtk_nfc_set_bad_mark_ctl(&mtk_nand->bad_mark, mtd);
> > > > > +
> > > > > +	len = mtd->writesize + mtd->oobsize;
> > > > > +	nfc->buffer = devm_kzalloc(dev, len, GFP_KERNEL);
> > > > > +	if (!nfc->buffer)
> > > > > +		return  -ENOMEM;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct nand_controller_ops mtk_nfc_controller_ops = {
> > > > > +	.attach_chip = mtk_nfc_attach_chip,
> > > > > +};
> > > > > +
> > > > >  static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
> > > > >  				  struct device_node *np)
> > > > >  {
> > > > >  	struct mtk_nfc_nand_chip *chip;
> > > > >  	struct nand_chip *nand;
> > > > >  	struct mtd_info *mtd;
> > > > > -	int nsels, len;
> > > > > +	int nsels;
> > > > >  	u32 tmp;
> > > > >  	int ret;
> > > > >  	int i;
> > > > > @@ -1287,6 +1328,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
> > > > >  
> > > > >  	nand = &chip->nand;
> > > > >  	nand->controller = &nfc->controller;
> > > > > +	nand->controller->ops = &mtk_nfc_controller_ops;    
> > > > 
> > > > Just like for the marvell driver, this assignment should be moved here
> > > > [1].     
> > > Agree to this.
> > >  
> >    
> > > > Also, it looks like this driver is open-coding
> > > > nand_controller_init(), probably something we should fix (in a separate
> > > > patch).    
> > > May I ask if you mean driver should use nand_hw_control_init helper to
> > > do controller_init?  
> > 
> > Well, now it's named nand_controller_init(), but yes, that's what I
> > meant.  
> 
> OK. I will fix it base on this patch series later.

Nice!

Then you can just wait for the next -rc1, this series should be
available.

Thanks,
Miquèl
