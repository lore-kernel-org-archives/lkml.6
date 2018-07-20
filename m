Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B7CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BF72064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BF72064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeGTIWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:22:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37135 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbeGTIWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:22:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 49C3D207A8; Fri, 20 Jul 2018 09:35:41 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id A72DB2069C;
        Fri, 20 Jul 2018 09:35:40 +0200 (CEST)
Date:   Fri, 20 Jul 2018 09:35:40 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 28/33] mtd: rawnand: docg4: convert driver to
 nand_scan()
Message-ID: <20180720093540.1fd211dd@bbrezillon>
In-Reply-To: <20180720091745.7b1de031@xps13>
References: <20180719230026.8741-1-miquel.raynal@bootlin.com>
        <20180719230026.8741-29-miquel.raynal@bootlin.com>
        <20180720012732.3753e0ef@bbrezillon>
        <20180720091745.7b1de031@xps13>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 09:17:45 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> Boris Brezillon <boris.brezillon@bootlin.com> wrote on Fri, 20 Jul 2018
> 01:27:32 +0200:
> 
> > On Fri, 20 Jul 2018 01:00:21 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > Two helpers have been added to the core to make ECC-related
> > > configuration between the detection phase and the final NAND scan. Use
> > > these hooks and convert the driver to just use nand_scan() instead of
> > > both nand_scan_ident() and nand_scan_tail().
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/mtd/nand/raw/docg4.c | 55 ++++++++++++++++++++++++++------------------
> > >  1 file changed, 32 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
> > > index 4dccdfba6140..2f6fcd4efab2 100644
> > > --- a/drivers/mtd/nand/raw/docg4.c
> > > +++ b/drivers/mtd/nand/raw/docg4.c
> > > @@ -1227,10 +1227,9 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
> > >  	 * required within a nand driver because they are performed by the nand
> > >  	 * infrastructure code as part of nand_scan().  In this case they need
> > >  	 * to be initialized here because we skip call to nand_scan_ident() (the
> > > -	 * first half of nand_scan()).  The call to nand_scan_ident() is skipped
> > > -	 * because for this device the chip id is not read in the manner of a
> > > -	 * standard nand device.  Unfortunately, nand_scan_ident() does other
> > > -	 * things as well, such as call nand_set_defaults().
> > > +	 * first half of nand_scan()).  The call to nand_scan_ident() could be
> > > +	 * skipped because for this device the chip id is not read in the manner
> > > +	 * of a standard nand device.
> > >  	 */
> > >  
> > >  	struct nand_chip *nand = mtd_to_nand(mtd);
> > > @@ -1315,6 +1314,27 @@ static int __init read_id_reg(struct mtd_info *mtd)
> > >  
> > >  static char const *part_probes[] = { "cmdlinepart", "saftlpart", NULL };
> > >  
> > > +static int docg4_attach_chip(struct nand_chip *chip)
> > > +{
> > > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > > +	struct docg4_priv *doc = (struct docg4_priv *)(chip + 1);
> > > +
> > > +	init_mtd_structs(mtd);
> > > +
> > > +	/* Initialize kernel BCH algorithm */
> > > +	doc->bch = init_bch(DOCG4_M, DOCG4_T, DOCG4_PRIMITIVE_POLY);
> > > +	if (!doc->bch)
> > > +		return -EINVAL;
> > > +
> > > +	reset(mtd);
> > > +
> > > +	return read_id_reg(mtd);
> > > +}
> > > +
> > > +static struct nand_controller_ops docg4_controller_ops = {
> > > +	.attach_chip = docg4_attach_chip,
> > > +};
> > > +
> > >  static int __init probe_docg4(struct platform_device *pdev)
> > >  {
> > >  	struct mtd_info *mtd;
> > > @@ -1350,26 +1370,16 @@ static int __init probe_docg4(struct platform_device *pdev)
> > >  	mtd->dev.parent = &pdev->dev;
> > >  	doc->virtadr = virtadr;
> > >  	doc->dev = dev;
> > > -
> > > -	init_mtd_structs(mtd);
> > > -
> > > -	/* initialize kernel bch algorithm */
> > > -	doc->bch = init_bch(DOCG4_M, DOCG4_T, DOCG4_PRIMITIVE_POLY);
> > > -	if (doc->bch == NULL) {
> > > -		retval = -EINVAL;
> > > -		goto free_nand;
> > > -	}
> > > -
> > >  	platform_set_drvdata(pdev, doc);
> > >  
> > > -	reset(mtd);
> > > -	retval = read_id_reg(mtd);
> > > -	if (retval == -ENODEV) {
> > > -		dev_warn(dev, "No diskonchip G4 device found.\n");
> > > -		goto free_bch;
> > > -	}
> > > -
> > > -	retval = nand_scan_tail(mtd);
> > > +	/*
> > > +	 * Asking for 0 chips is useless here but it warns the user that the use
> > > +	 * of the nand_scan() function is a bit abused here because the
> > > +	 * initialization is actually a bit specific and re-handled again in the
> > > +	 * ->attach_chip() hook. It will probably leak some memory though.
> > > +	 */
> > > +	nand->dummy_controller.ops = &docg4_controller_ops;
> > > +	retval = nand_scan(mtd, 0);
> > >  	if (retval)
> > >  		goto free_bch;    
> > 
> > Hm, not sure this works. The driver only calls nand_scan_tail(), but
> > you replace that by a call to nand_scan(), which will call both
> > nand_scan_ident() and nand_scan_tail(), and I'm pretty sure
> > nand_scan_ident() will fail here.  
> 
> I know docg4 is a bit specific and could maybe be moved out of the raw/
> subdirectory. But in the meantime I don't want to block the series for
> this. The better I can propose right now (open to other ideas as
> well) would be to return 0 in nand_scan_ident() if the maxchip parameter
> is 0 which is the case only in this driver AFAIS.

Sounds good. Just document this particular case in nand_scan_ident()
kernel-doc header.
