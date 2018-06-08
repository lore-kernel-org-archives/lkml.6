Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WDMCDzZ4GlugbQAAmS7hNA
	; Fri, 08 Jun 2018 12:36:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C48C4608BA; Fri,  8 Jun 2018 12:36:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9FE85608C1;
	Fri,  8 Jun 2018 12:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FE85608C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeFHMgC convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 08:36:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40166 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbeFHMgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:36:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 94AA4207C0; Fri,  8 Jun 2018 14:35:59 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 228DD2069C;
        Fri,  8 Jun 2018 14:35:49 +0200 (CEST)
Date: Fri, 8 Jun 2018 14:35:49 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "wmw2@infradead.org" <wmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v9 4/4] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Message-ID: <20180608143549.04400f92@xps13>
In-Reply-To: <MWHPR02MB26238A3344D0F611D8D6B0DAAF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1528271382-21690-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180607215949.58e2d15d@xps13>
        <MWHPR02MB26238A3344D0F611D8D6B0DAAF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

> > > +		ecc->read_page = pl353_nand_read_page_hwecc;
> > > +		ecc->size = PL353_NAND_ECC_SIZE;
> > > +		ecc->write_page = pl353_nand_write_page_hwecc;
> > > +		pl353_smc_set_ecc_pg_size(mtd->writesize);
> > > +		switch (mtd->writesize) {
> > > +		case SZ_512:
> > > +		case SZ_1K:
> > > +		case SZ_2K:
> > > +			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
> > > +			break;
> > > +		default:
> > > +			/*
> > > +			 * The software ECC routines won't work with the
> > > +			 * SMC controller
> > > +			 */
> > > +			ecc->calculate = nand_calculate_ecc;
> > > +			ecc->correct = nand_correct_data;
> > > +			ecc->size = 256;
> > > +			break;
> > > +		}
> > > +		if (mtd->writesize <= SZ_512)
> > > +			xnand->addr_cycles = 1;
> > > +		else
> > > +			xnand->addr_cycles = 2;
> > > +
> > > +		if (chip->options & NAND_ROW_ADDR_3)
> > > +			xnand->addr_cycles += 3;
> > > +		else
> > > +			xnand->addr_cycles += 2;
> > > +
> > > +		if (mtd->oobsize == 16)
> > > +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
> > > +		else if (mtd->oobsize == 64)
> > > +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);  
> > 
> > else?  
> You mean to say, add an error condition?

I do.

> >   
> > > +	}
> > > +}
> > > +
> > > +/**
> > > + * pl353_nand_probe - Probe method for the NAND driver
> > > + * @pdev:	Pointer to the platform_device structure
> > > + *
> > > + * This function initializes the driver data structures and the hardware.
> > > + *
> > > + * Return:	0 on success or error value on failure
> > > + */
> > > +static int pl353_nand_probe(struct platform_device *pdev) {
> > > +	struct pl353_nand_info *xnand;  
> > 
> > xnand is a strange name, more and more because its a bout NAND controller data, not NAND
> > chip.  
> We added this name to represent Xilinx Nand(xnand), 
> >   

I see where the x comes from.

Maybe just nfc (for NAND flash controller) or xnfc if you prefer. What
I want is to clearly make the distinction between what is a NAND chip,
what is a NAND controller.

> > > +	struct mtd_info *mtd;
> > > +	struct nand_chip *nand_chip;  
> > 
> > This one you can call it just "nand" or "chip".  
> Ok, I will update.
> 
> >   
> > > +	struct resource *res;
> > > +
> > > +	xnand = devm_kzalloc(&pdev->dev, sizeof(*xnand), GFP_KERNEL);
> > > +	if (!xnand)
> > > +		return -ENOMEM;
> > > +
> > > +	/* Map physical address of NAND flash */
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	xnand->nand_base = devm_ioremap_resource(&pdev->dev, res);
> > > +	if (IS_ERR(xnand->nand_base))
> > > +		return PTR_ERR(xnand->nand_base);
> > > +
> > > +	nand_chip = &xnand->chip;
> > > +	mtd = nand_to_mtd(nand_chip);
> > > +	nand_chip->exec_op = pl353_nfc_exec_op;
> > > +	nand_set_controller_data(nand_chip, xnand);
> > > +	mtd->priv = nand_chip;
> > > +	mtd->owner = THIS_MODULE;
> > > +	mtd->name = PL353_NAND_DRIVER_NAME;  
> > 
> > A label property in the DT might overwrite this value.  
> Could you please explain a bit more ?
> 

I meant something like this:

https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/marvell_nand.c#L2515

Thanks,
Miquèl
