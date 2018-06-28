Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78D1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF992701A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF992701A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbeF1HOy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:14:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36321 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752739AbeF1HOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:14:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F0B2C20714; Thu, 28 Jun 2018 09:14:50 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 901A2206FF;
        Thu, 28 Jun 2018 09:14:50 +0200 (CEST)
Date:   Thu, 28 Jun 2018 09:14:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
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
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: Re: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver
 for arm pl353 smc nand interface
Message-ID: <20180628091450.25bd54e5@xps13>
In-Reply-To: <MWHPR02MB26236BEABAAF0213B49EC21EAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180627172249.72f878a2@xps13>
        <MWHPR02MB26236BEABAAF0213B49EC21EAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
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

> > > +/**
> > > + * pl353_nand_read_page_hwecc - Hardware ECC based page read function
> > > + * @mtd:		Pointer to the mtd info structure
> > > + * @chip:		Pointer to the NAND chip info structure
> > > + * @buf:		Pointer to the buffer to store read data
> > > + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> > > + * @page:		Page number to read
> > > + *
> > > + * This functions reads data and checks the data integrity by
> > > +comparing hardware
> > > + * generated ECC values and read ECC values from spare area.
> > > + *
> > > + * Return:	0 always and updates ECC operation status in to MTD structure
> > > + */
> > > +static int pl353_nand_read_page_hwecc(struct mtd_info *mtd,
> > > +				      struct nand_chip *chip,
> > > +				      u8 *buf, int oob_required, int page) {
> > > +	int i, stat, eccsize = chip->ecc.size;
> > > +	int eccbytes = chip->ecc.bytes;
> > > +	int eccsteps = chip->ecc.steps;
> > > +	u8 *p = buf;
> > > +	u8 *ecc_calc = chip->ecc.calc_buf;
> > > +	u8 *ecc = chip->ecc.code_buf;
> > > +	unsigned int max_bitflips = 0;
> > > +	u8 *oob_ptr;
> > > +	u32 ret;
> > > +	unsigned long data_phase_addr;
> > > +	struct pl353_nand_info *xnfc =
> > > +		container_of(chip, struct pl353_nand_info, chip);
> > > +	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
> > > +
> > > +	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_READ0,
> > > +			  NAND_CMD_READSTART, 1);
> > > +	ndelay(100);  
> > 
> > What is this delay for?  
> We have seen failures with out this delay, with older code.
> But i will check this by removing this delay, in this new driver.

Please check all of them. We should get rid of random delays like that.
Either there is something to poll, or there is a specific value to use
(you can get them from the SDR interface structure).

[...]

> > > +
> > > +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> > > +		return -EINVAL;  
> > 
> > Why?  
> It is similar to 
> if (chipnr < 0)
> 	return 0;

Mmmmmh, no?

(return 0) != (return -EINVAL)

The core is asking you to check if the controller driver support
particular timings (usually ONFI modes 1-5). Returning an error means
"I only support the slowest timings" which, I suppose, is wrong. Please
fix this and compare the speeds.

> hence written like that.
> Also if I didn't do that, then probe is failing.
> Am I missing some thing?
> >   

[...]

> > > +/**
> > > + * pl353_nand_probe - Probe method for the NAND driver
> > > + * @pdev:	Pointer to the platform_device structure
> > > + *
> > > + * This function initializes the driver data structures and the hardware.
> > > + *
> > > + * Return:	0 on success or error value on failure
> > > + */
> > > +static int pl353_nand_probe(struct platform_device *pdev) {
> > > +	struct pl353_nand_info *xnfc;
> > > +	struct mtd_info *mtd;
> > > +	struct nand_chip *chip;
> > > +	struct resource *res;
> > > +	struct device_node *np;
> > > +	u32 ret;
> > > +
> > > +	xnfc = devm_kzalloc(&pdev->dev, sizeof(*xnfc), GFP_KERNEL);
> > > +	if (!xnfc)
> > > +		return -ENOMEM;
> > > +	xnfc->dev = &pdev->dev;
> > > +	/* Map physical address of NAND flash */
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	xnfc->nand_base = devm_ioremap_resource(xnfc->dev, res);
> > > +	if (IS_ERR(xnfc->nand_base))
> > > +		return PTR_ERR(xnfc->nand_base);
> > > +
> > > +	chip = &xnfc->chip;
> > > +	mtd = nand_to_mtd(chip);
> > > +	chip->exec_op = pl353_nfc_exec_op;
> > > +	nand_set_controller_data(chip, xnfc);
> > > +	mtd->priv = chip;
> > > +	mtd->owner = THIS_MODULE;
> > > +	if (!mtd->name) {
> > > +		/*
> > > +		 * If the new bindings are used and the bootloader has not been
> > > +		 * updated to pass a new mtdparts parameter on the cmdline, you
> > > +		 * should define the following property in your NAND node, ie:
> > > +		 *
> > > +		 *	label = "pl353-nand";
> > > +		 *
> > > +		 * This way, mtd->name will be set by the core when
> > > +		 * nand_set_flash_node() is called.
> > > +		 */
> > > +		mtd->name = devm_kasprintf(xnfc->dev, GFP_KERNEL,
> > > +					   "%s", PL353_NAND_DRIVER_NAME);
> > > +		if (!mtd->name) {
> > > +			dev_err(xnfc->dev, "Failed to allocate mtd->name\n");
> > > +			return -ENOMEM;
> > > +		}
> > > +	}
> > > +	nand_set_flash_node(chip, xnfc->dev->of_node);
> > > +
> > > +	/* Set address of NAND IO lines */
> > > +	chip->IO_ADDR_R = xnfc->nand_base;
> > > +	chip->IO_ADDR_W = xnfc->nand_base;
> > > +	/* Set the driver entry points for MTD */
> > > +	chip->dev_ready = pl353_nand_device_ready;
> > > +	chip->select_chip = pl353_nand_select_chip;
> > > +	/* If we don't set this delay driver sets 20us by default */
> > > +	np = of_get_next_parent(xnfc->dev->of_node);
> > > +	xnfc->mclk = of_clk_get(np, 0);
> > > +	if (IS_ERR(xnfc->mclk)) {
> > > +		dev_err(xnfc->dev, "Failed to retrieve MCK clk\n");
> > > +		return PTR_ERR(xnfc->mclk);
> > > +	}
> > > +	chip->chip_delay = 30;
> > > +	/* Set the device option and flash width */
> > > +	chip->options = NAND_BUSWIDTH_AUTO;
> > > +	chip->bbt_options = NAND_BBT_USE_FLASH;
> > > +	platform_set_drvdata(pdev, xnfc);
> > > +	chip->setup_data_interface = pl353_setup_data_interface;
> > > +	/* first scan to find the device and get the page size */
> > > +	if (nand_scan_ident(mtd, 1, NULL)) {
> > > +		dev_err(xnfc->dev, "nand_scan_ident for NAND failed\n");
> > > +		return -ENXIO;
> > > +	}

Space here

> > > +	ret = pl353_nand_ecc_init(mtd, &chip->ecc, chip->ecc.mode);

ret should be checked

> > > +	if (chip->options & NAND_BUSWIDTH_16)
> > > +		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);

Space

> > > +	/* second phase scan */
> > > +	if (nand_scan_tail(mtd)) {
> > > +		dev_err(xnfc->dev, "nand_scan_tail for NAND failed\n");
> > > +		return -ENXIO;
> > > +	}
> > > +
> > > +	mtd_device_register(mtd, NULL, 0);  
> > 
> > Check the returned code  
> Ok.

And if it returns an error, please call nand_cleanup().

> >   
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * pl353_nand_remove - Remove method for the NAND driver
> > > + * @pdev:	Pointer to the platform_device structure
> > > + *
> > > + * This function is called if the driver module is being unloaded. It
> > > +frees all
> > > + * resources allocated to the device.
> > > + *
> > > + * Return:	0 on success or error value on failure
> > > + */
> > > +static int pl353_nand_remove(struct platform_device *pdev) {
> > > +	struct pl353_nand_info *xnfc = platform_get_drvdata(pdev);
> > > +	struct mtd_info *mtd = nand_to_mtd(&xnfc->chip);
> > > +
> > > +	/* Release resources, unregister device */
> > > +	nand_release(mtd);  
> > 
> > What about MTD core deregistration?  
> nand_release(), it self will do that.

My bad.

> >   
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/* Match table for device tree binding */ static const struct
> > > +of_device_id pl353_nand_of_match[] = {
> > > +	{ .compatible = "arm,pl353-nand-r2p1" },
> > > +	{},
> > > +};

Thanks,
Miquèl
