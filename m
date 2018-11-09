Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1C8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202C120855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202C120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeKIRrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:47:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35593 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbeKIRrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:47:03 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D003B207B0; Fri,  9 Nov 2018 09:07:35 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 798112039F;
        Fri,  9 Nov 2018 09:07:35 +0100 (CET)
Date:   Fri, 9 Nov 2018 09:07:33 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <michals@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh12@gmail.com>, <robh@kernel.org>
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20181109090733.41ef6edf@bbrezillon>
In-Reply-To: <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Just a preliminary review. I still think we have problems with how you
execute NAND operations. You seem to assume that read/write operation
are always page write/read operation with a size aligned on a page
size. This is wrong, either the controller is able to execute the exact
operation that has been requested or it returns -ENOTSUPP.

On Fri, 9 Nov 2018 10:30:41 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> +
> +/**
> + * struct anfc_nand_chip - Defines the nand chip related information
> + * @node:		Used to store NAND chips into a list.
> + * @chip:		NAND chip information structure.
> + * @strength:		Bch or Hamming mode enable/disable.

The name is still confusing. BTW, can't you deduce Hamming vs BCH from
the strength? Hamming strength is 1, while BCH strengths seem to start
at 4.

> + * @ecc_strength:	Ecc strength 4.8/12/16.

				      ^/

> + * @eccval:		Ecc config value.
> + * @spare_caddr_cycles:	Column address cycle information for spare area.
> + * @pktsize:		Packet size for read / write operation.
> + * @csnum:		chipselect number to be used.
> + * @spktsize:		Packet size in ddr mode for status operation.
> + * @inftimeval:		Data interface and timing mode information
> + */
> +struct anfc_nand_chip {
> +	struct list_head node;
> +	struct nand_chip chip;
> +	bool strength;
> +	u32 ecc_strength;
> +	u32 eccval;
> +	u16 spare_caddr_cycles;
> +	u32 pktsize;
> +	int csnum;
> +	u32 spktsize;
> +	u32 inftimeval;
> +};
> +
> +/**
> + * struct anfc_nand_controller - Defines the Arasan NAND flash controller
> + *				 driver instance
> + * @controller:		base controller structure.
> + * @chips:		list of all nand chips attached to the ctrler.
> + * @dev:		Pointer to the device structure.
> + * @base:		Virtual address of the NAND flash device.
> + * @clk_sys:		Pointer to the system clock.
> + * @clk_flash:		Pointer to the flash clock.
> + * @dma:		Dma enable/disable.
> + * @buf:		Buffer used for read/write byte operations.
> + * @irq:		irq number

You should need this field. Just get the irq num in you probe path an
register an irq handler with devm_request_irq().

> + * @bufshift:		Variable used for indexing buffer operation
> + * @csnum:		Chip select number currently inuse.

						     ^ in use

> + * @event:		Completion event for nand status events.
> + * @status:		Status of the flash device.
> + * @prog:		Used to initiate controller operations.
> + */
> +struct anfc_nand_controller {
> +	struct nand_controller controller;
> +	struct list_head chips;
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk *clk_sys;
> +	struct clk *clk_flash;
> +	int irq;
> +	int csnum;
> +	struct completion event;
> +	int status;
> +	u8 buf[TEMP_BUF_SIZE];

Allocate this buf dynamically.

> +	u32 eccval;
> +};

> +static int anfc_page_write_type_exec(struct nand_chip *chip,
> +				     const struct nand_subop *subop)
> +{
> +	const struct nand_op_instr *instr;
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +	unsigned int op_id, len;
> +	struct anfc_op nfc_op = {};
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +
> +	anfc_parse_instructions(chip, subop, &nfc_op);
> +	instr = nfc_op.data_instr;
> +	op_id = nfc_op.data_instr_idx;
> +	anfc_prepare_cmd(chip, nfc_op.cmds[0], nfc_op.cmds[1], 1,
> +			 mtd->writesize, nfc_op.naddrcycles);
> +	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +	if (!nfc_op.data_instr)
> +		return 0;
> +
> +	len = nand_subop_get_data_len(subop, op_id);
> +	anfc_write_data_op(chip,  (char *)instr->ctx.data.buf.out,

				^ extra white space here
and please drop the cast.

Can you please run checkpatch --strict prior to submitting patches?

> +			   mtd->writesize,
> +			   DIV_ROUND_UP(mtd->writesize, achip->pktsize),

No, that's wrong. You should use instr->ctx.data.len here, and the
DIV_ROUND_UP() thing is a bit scary. That means you might be writing
more data than requested.

> +			   achip->pktsize);
> +
> +	return 0;
> +}
> +

> +
> +static int anfc_probe(struct platform_device *pdev)
> +{
> +	struct anfc_nand_controller *nfc;
> +	struct anfc_nand_chip *anand_chip;
> +	struct device_node *np = pdev->dev.of_node, *child;
> +	struct resource *res;
> +	int err;
> +
> +	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
> +	if (!nfc)
> +		return -ENOMEM;
> +
> +	nand_controller_init(&nfc->controller);
> +	INIT_LIST_HEAD(&nfc->chips);
> +	init_completion(&nfc->event);
> +	nfc->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, nfc);
> +	nfc->csnum = -1;
> +	nfc->controller.ops = &anfc_nand_controller_ops;

Add a blank line here please

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	nfc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(nfc->base))
> +		return PTR_ERR(nfc->base);

and here

> +	nfc->irq = platform_get_irq(pdev, 0);
> +	if (nfc->irq < 0) {
> +		dev_err(&pdev->dev, "platform_get_irq failed\n");
> +		return -ENXIO;
> +	}

and here

> +	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));

Is this really needed?

> +	err = devm_request_irq(&pdev->dev, nfc->irq, anfc_irq_handler,
> +			       0, "arasannfc", nfc);
> +	if (err)
> +		return err;

Add a blank line here too.

> +	nfc->clk_sys = devm_clk_get(&pdev->dev, "clk_sys");
> +	if (IS_ERR(nfc->clk_sys)) {
> +		dev_err(&pdev->dev, "sys clock not found.\n");
> +		return PTR_ERR(nfc->clk_sys);
> +	}
> +
> +	nfc->clk_flash = devm_clk_get(&pdev->dev, "clk_flash");
> +	if (IS_ERR(nfc->clk_flash)) {
> +		dev_err(&pdev->dev, "flash clock not found.\n");
> +		return PTR_ERR(nfc->clk_flash);
> +	}
> +
> +	err = clk_prepare_enable(nfc->clk_sys);
> +	if (err) {
> +		dev_err(&pdev->dev, "Unable to enable sys clock.\n");
> +		return err;
> +	}
> +
> +	err = clk_prepare_enable(nfc->clk_flash);
> +	if (err) {
> +		dev_err(&pdev->dev, "Unable to enable flash clock.\n");
> +		goto clk_dis_sys;
> +	}
> +
> +	for_each_available_child_of_node(np, child) {
> +		anand_chip = devm_kzalloc(&pdev->dev, sizeof(*anand_chip),
> +					  GFP_KERNEL);
> +		if (!anand_chip) {
> +			of_node_put(child);
> +			err = -ENOMEM;
> +			goto nandchip_clean_up;
> +		}

and here.

> +		err = anfc_nand_chip_init(nfc, anand_chip, child);
> +		if (err) {
> +			devm_kfree(&pdev->dev, anand_chip);

We usually try to avoid calling devm_kfree(). I guess you do it to
avoid keeping the chip obj around when init failed, but this should
be rare enough so we can actually ignore it and let the mem allocated
for the NFC lifetime.

> +			continue;
> +		}
> +
> +		list_add_tail(&anand_chip->node, &nfc->chips);
> +	}
> +	return 0;
> +
> +nandchip_clean_up:
> +	list_for_each_entry(anand_chip, &nfc->chips, node)
> +		nand_release(&anand_chip->chip);

Blank line here.

> +	clk_disable_unprepare(nfc->clk_flash);

Blank line here.

> +clk_dis_sys:
> +	clk_disable_unprepare(nfc->clk_sys);
> +
> +	return err;
> +}

Regards,

Boris
