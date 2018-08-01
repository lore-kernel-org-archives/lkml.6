Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B311C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13100208B2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13100208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbeHAXil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:38:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60739 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbeHAXil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:38:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 931D820789; Wed,  1 Aug 2018 23:50:46 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1599120799;
        Wed,  1 Aug 2018 23:50:46 +0200 (CEST)
Date:   Wed, 1 Aug 2018 23:50:45 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20180801235045.5b4d8211@bbrezillon>
In-Reply-To: <20180719094612.5833-3-yixun.lan@amlogic.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
        <20180719094612.5833-3-yixun.lan@amlogic.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun,

On Thu, 19 Jul 2018 17:46:12 +0800
Yixun Lan <yixun.lan@amlogic.com> wrote:

I haven't finished reviewing the driver yet (I'll try to do that later
this week), but I already pointed a few things to fix/improve.

> +
> +static int meson_nfc_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op, bool check_only)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct meson_nfc *nfc = nand_get_controller_data(chip);
> +	const struct nand_op_instr *instr = NULL;
> +	int ret = 0, cmd;
> +	unsigned int op_id;
> +	int i;
> +
> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
> +		instr = &op->instrs[op_id];
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			cmd = nfc->param.chip_select | NFC_CMD_CLE;
> +			cmd |= instr->ctx.cmd.opcode & 0xff;
> +			writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +			meson_nfc_cmd_idle(nfc, NAND_TWB_TIME_CYCLE);

This is not necessarily TWB you have to wait after a CMD cycle. It can
be tWHR. And you should definitely not hardcode the value, since,
AFAIR, it depends on the selected SDR timings. Probably something you
should calculate in ->setup_data_interface().

> +			meson_nfc_drain_cmd(nfc);

I don't know exactly how the NAND controller works, but it's usually
not a good idea to execute the operation right away, especially if you
have address/cmd/data cycles following this cmd and those can be
packed in the same controller operation. 

> +			break;
> +
> +		case NAND_OP_ADDR_INSTR:
> +			for (i = 0; i < instr->ctx.addr.naddrs; i++) {
> +				cmd = nfc->param.chip_select | NFC_CMD_ALE;
> +				cmd |= instr->ctx.addr.addrs[i] & 0xff;
> +				writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +			}
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			meson_nfc_read_buf(mtd, instr->ctx.data.buf.in,
> +					   instr->ctx.data.len);
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			meson_nfc_write_buf(mtd, instr->ctx.data.buf.out,
> +					    instr->ctx.data.len);

Well, I'm not entirely sure what happens when you call
read/write_buf(), but it seems you're doing that one byte at a time,
and that sounds not so efficient given the operation you do for each
byte read/written. Don't you have a way to tell the engine that you
want to read/write X bytes?

> +			break;
> +
> +		case NAND_OP_WAITRDY_INSTR:
> +			mdelay(instr->ctx.waitrdy.timeout_ms);
> +			ret = nand_soft_waitrdy(chip,
> +						instr->ctx.waitrdy.timeout_ms);

Hm, i'd be surprised if the controller does not have a way to optimize
waits on R/B transitions.

> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int meson_ooblayout_ecc(struct mtd_info *mtd, int section,
> +			       struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	int free_oob;
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	free_oob = (section + 1) * 2;
> +	oobregion->offset = section * chip->ecc.bytes + free_oob;

Hm, this offset calculation looks weird. Are you sure it's correct?
I'd bet on something like:

	oobregion->offset = 2 + (section * (chip->ecc.bytes + 4));

> +	oobregion->length = chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int meson_ooblayout_free(struct mtd_info *mtd, int section,
> +				struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = section * (2 + chip->ecc.bytes);
> +	oobregion->length = 2;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops meson_ooblayout_ops = {
> +	.ecc = meson_ooblayout_ecc,
> +	.free = meson_ooblayout_free,
> +};
> +
> +static int meson_nfc_ecc_init(struct device *dev, struct mtd_info *mtd)
> +{
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	const struct meson_nand_ecc *meson_ecc = nfc->data->ecc;
> +	int num = nfc->data->ecc_num;
> +	int nsectors, i, bytes;
> +
> +	/* support only ecc hw mode */
> +	if (nand->ecc.mode != NAND_ECC_HW) {
> +		dev_err(dev, "ecc.mode not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!nand->ecc.size || !nand->ecc.strength) {
> +		/* use datasheet requirements */
> +		nand->ecc.strength = nand->ecc_strength_ds;
> +		nand->ecc.size = nand->ecc_step_ds;
> +	}
> +
> +	if (nand->ecc.options & NAND_ECC_MAXIMIZE) {
> +		nand->ecc.size = 1024;
> +		nsectors = mtd->writesize / nand->ecc.size;
> +		bytes = mtd->oobsize - 2 * nsectors;
> +		bytes /= nsectors;
> +
> +		/* and bytes has to be even. */
> +		if (bytes % 2)
> +			bytes--;
> +
> +		nand->ecc.strength = bytes * 8 / fls(8 * nand->ecc.size);
> +	} else {
> +		if (nand->ecc.strength > meson_ecc[num - 1].strength) {
> +			dev_err(dev, "not support ecc strength\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		if (meson_ecc[i].strength == 0xff ||
> +		    nand->ecc.strength < meson_ecc[i].strength)
> +			break;
> +	}

I'd suggest that you look at nand_match_ecc_req(). It's likely that the
selection logic you have here can be replaced by the generic function.

> +
> +	nand->ecc.strength = meson_ecc[i - 1].strength;
> +	nand->ecc.bytes = meson_ecc[i - 1].parity;
> +
> +	meson_chip->bch_mode = meson_ecc[i - 1].bch;
> +
> +	if (nand->ecc.size != 512 && nand->ecc.size != 1024)
> +		return -EINVAL;
> +
> +	nsectors = mtd->writesize / nand->ecc.size;
> +	bytes = nsectors * 2;
> +
> +	if (mtd->oobsize < (nand->ecc.bytes * nsectors + bytes))
> +		return -EINVAL;
> +
> +	mtd_set_ooblayout(mtd, &meson_ooblayout_ops);
> +
> +	return 0;
> +}
> +
> +static int meson_nfc_clk_init(struct meson_nfc *nfc)
> +{
> +	int ret;
> +
> +	/* request core clock */
> +	nfc->core_clk = devm_clk_get(nfc->dev, "core");
> +	if (IS_ERR(nfc->core_clk)) {
> +		dev_err(nfc->dev, "failed to get core clk\n");
> +		return PTR_ERR(nfc->core_clk);
> +	}
> +
> +	nfc->device_clk = devm_clk_get(nfc->dev, "device");
> +	if (IS_ERR(nfc->device_clk)) {
> +		dev_err(nfc->dev, "failed to get device clk\n");
> +		return PTR_ERR(nfc->device_clk);
> +	}
> +
> +	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> +	regmap_update_bits(nfc->reg_clk, 0,
> +			   CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK,
> +			   CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK);
> +
> +	ret = clk_prepare_enable(nfc->core_clk);
> +	if (ret) {
> +		dev_err(nfc->dev, "failed to enable core clk\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(nfc->device_clk);
> +	if (ret) {
> +		dev_err(nfc->dev, "failed to enable device clk\n");
> +		clk_disable_unprepare(nfc->core_clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void meson_nfc_disable_clk(struct meson_nfc *nfc)
> +{
> +	clk_disable_unprepare(nfc->device_clk);
> +	clk_disable_unprepare(nfc->core_clk);
> +}
> +
> +static int meson_nfc_buffer_init(struct mtd_info *mtd)
> +{
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	int info_bytes, page_bytes;
> +	int nsectors;
> +
> +	nsectors = mtd->writesize / nand->ecc.size;
> +	info_bytes = nsectors * PER_INFO_BYTE;
> +	page_bytes = mtd->writesize + mtd->oobsize;
> +
> +	if (nfc->data_buf && nfc->info_buf)
> +		return 0;
> +
> +	nfc->data_buf = kmalloc(page_bytes, GFP_KERNEL);

I'm pretty sure that does not work if you have several chips. Either
you have one buffer tied to the NFC, and it has to be large enough to
handle the NAND with the largest page, or you have one buffer per chip.

> +	if (!nfc->data_buf)
> +		return -ENOMEM;
> +
> +	nfc->info_buf = kmalloc(info_bytes, GFP_KERNEL);
> +	if (!nfc->info_buf) {
> +		kfree(nfc->data_buf);
> +		return -ENOMEM;
> +	}
> +

Those buffers are not removed in the cleanup/error path.

> +	return 0;
> +}
> +
> +static int meson_nfc_calc_set_timing(struct meson_nfc *nfc,
> +				     int rc_min, int rea_max, int rhoh_min)
> +{
> +	int div, bt_min, bt_max, bus_timing;
> +	int ret;
> +
> +	div = DIV_ROUND_UP((rc_min / 1000), NFC_CLK_CYCLE);
> +	ret = clk_set_rate(nfc->device_clk, 1000000000 / div);
> +	if (ret) {
> +		dev_err(nfc->dev, "failed to set nand clock rate\n");
> +		return ret;
> +	}
> +
> +	bt_min = (rea_max + NFC_DEFAULT_DELAY) / div;
> +	bt_max = (NFC_DEFAULT_DELAY + rhoh_min + rc_min / 2) / div;
> +
> +	bt_min = DIV_ROUND_UP(bt_min, 1000);
> +	bt_max = DIV_ROUND_UP(bt_max, 1000);
> +
> +	if (bt_max < bt_min)
> +		return -EINVAL;
> +
> +	bus_timing = (bt_min + bt_max) / 2 + 1;
> +
> +	writel((1 << 21), nfc->reg_base + NFC_REG_CFG);
> +	writel((NFC_CLK_CYCLE - 1) | (bus_timing << 5),
> +	       nfc->reg_base + NFC_REG_CFG);
> +
> +	writel((1 << 31), nfc->reg_base + NFC_REG_CMD);

Nothing special to setup when operating in EDO mode (tRC < 20ns)?

> +
> +	return 0;
> +}
> +
> +static int
> +meson_nfc_setup_data_interface(struct mtd_info *mtd, int csline,
> +			       const struct nand_data_interface *conf)
> +{
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	const struct nand_sdr_timings *timings;
> +
> +	timings = nand_get_sdr_timings(conf);
> +	if (IS_ERR(timings))
> +		return -ENOTSUPP;
> +
> +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> +		return 0;

Are you sure you support all SDR timing modes, even EDO ones (tRC <
20ns)?

> +
> +	meson_nfc_calc_set_timing(nfc, timings->tRC_min,
> +				  timings->tREA_max, timings->tRHOH_min);
> +	return 0;
> +}
> +
> +static int
> +meson_nfc_nand_chip_init(struct device *dev,
> +			 struct meson_nfc *nfc, struct device_node *np)
> +{
> +	struct meson_nfc_nand_chip *chip;
> +	struct nand_chip *nand;
> +	struct mtd_info *mtd;
> +	int ret, nsels, i, len = 0;
> +	char cs_id[16];
> +	u32 tmp;
> +
> +	if (!of_get_property(np, "reg", &nsels))
> +		return -EINVAL;
> +
> +	nsels /= sizeof(u32);
> +	if (!nsels || nsels > MAX_CE_NUM) {
> +		dev_err(dev, "invalid reg property size\n");
> +		return -EINVAL;
> +	}
> +
> +	chip = devm_kzalloc(dev, sizeof(*chip) + (nsels * sizeof(u8)),
> +			    GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->nsels = nsels;
> +
> +	for (i = 0; i < nsels; i++) {
> +		ret = of_property_read_u32_index(np, "reg", i, &tmp);
> +		if (ret) {
> +			dev_err(dev, "could not retrieve reg property: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		chip->sels[i] = tmp;

You should probably keep track of all the already assigned CS lines, to
prevent situations where the same controller-CS is used twice
(copy&paste error when writing the DT).

> +		len += snprintf(cs_id + len, 16, "%s%d", i ? "-" : ".", tmp);

Hm, do we really need to be that accurate? I'd suggest using the first
CS only.

> +	}
> +
> +	chip->is_scramble =
> +		of_property_read_bool(np, "amlogic,nand-enable-scrambler");

I think I already complained about that :P. If you think this is still
needed (meaning that the autodetection + NAND_NEED_SCRAMBLING flag are
not enough), I'll need a detailed explanation ;-).

> +
> +	nand = &chip->nand;
> +	nand_set_flash_node(nand, np);
> +	nand_set_controller_data(nand, nfc);
> +
> +	nand->options |= NAND_USE_BOUNCE_BUFFER;
> +	nand->select_chip = meson_nfc_select_chip;
> +	nand->exec_op = meson_nfc_exec_op;
> +	nand->setup_data_interface = meson_nfc_setup_data_interface;
> +
> +	nand->ecc.mode = NAND_ECC_HW;
> +
> +	nand->ecc.write_page_raw = meson_nfc_write_page_raw;
> +	nand->ecc.write_page = meson_nfc_write_page_hwecc;
> +	nand->ecc.write_oob_raw = nand_write_oob_std;
> +	nand->ecc.write_oob = nand_write_oob_std;
> +
> +	nand->ecc.read_page_raw = meson_nfc_read_page_raw;
> +	nand->ecc.read_page = meson_nfc_read_page_hwecc;
> +	nand->ecc.read_oob_raw = meson_nfc_read_oob_raw;
> +	nand->ecc.read_oob = meson_nfc_read_oob;

We usually setup the ECC fields after the identification phase. This
way, if you ever want/need to support SW ECC, the code is already
properly placed.

> +
> +	mtd = nand_to_mtd(nand);
> +	mtd->owner = THIS_MODULE;
> +	mtd->dev.parent = dev;
> +
> +	ret = nand_scan_ident(mtd, 1, NULL);
> +	if (ret) {
> +		dev_err(dev, "failed to can ident\n");
> +		return -ENODEV;
> +	}
> +
> +	mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL, "%s:nand%s",
> +				   dev_name(dev), cs_id);

So, if you follow my suggestion, it should be:


You should make that conditional, because the core might have retrieved
a user-friendly from the DT (label prop defined to the NAND chip node).

So, if you follow my suggestion to just use the first CS for the nand
id, that gives:

	if (!mtd->name) {
		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
					   "%s:nand%d",
					   dev_name(dev),
					   chip->sels[i]);
		if (!mtd->name)
			return -ENOMEM;
	}
> +
> +	/* store bbt magic in page, cause OOB is not protected */
> +	if (nand->bbt_options & NAND_BBT_USE_FLASH)
> +		nand->bbt_options |= NAND_BBT_NO_OOB;
> +
> +	nand->options |= NAND_NO_SUBPAGE_WRITE;
> +
> +	ret = meson_nfc_ecc_init(dev, mtd);
> +	if (ret) {
> +		dev_err(dev, "failed to ecc init\n");
> +		return -EINVAL;
> +	}
> +
> +	if (nand->options & NAND_BUSWIDTH_16) {
> +		dev_err(dev, "16bits buswidth not supported");
> +		return -EINVAL;
> +	}
> +
> +	ret = meson_nfc_buffer_init(mtd);
> +	if (ret)
> +		return -ENOMEM;
> +
> +	ret = nand_scan_tail(mtd);

Miquel has reworked the nand_scan() infrastructure recently. Now you
have to use nand_scan() and define ->attach_chip() hook to do all the
init that happens between nand_scan_ident() and nand_scan_tail() in
your code. And of course, all resources allocated in the
->attach_chip() hook should be freed in ->detach_chip().

> +	if (ret)
> +		return -ENODEV;
> +
> +	ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(dev, "failed to register mtd device: %d\n", ret);
> +		nand_cleanup(nand);
> +		return ret;
> +	}
> +
> +	list_add_tail(&chip->node, &nfc->chips);
> +
> +	return 0;
> +}
> +
> +static int meson_nfc_nand_chip_cleanup(struct meson_nfc *nfc)

			     ^ chips

> +{
> +	struct meson_nfc_nand_chip *chip;
> +	struct mtd_info *mtd;
> +	int ret;
> +
> +	while (!list_empty(&nfc->chips)) {
> +		chip = list_first_entry(&nfc->chips, struct meson_nfc_nand_chip,
> +					node);
> +		mtd = nand_to_mtd(&chip->nand);
> +		ret = mtd_device_unregister(mtd);
> +		if (ret)
> +			return ret;
> +
> +		nand_cleanup(&chip->nand);
> +		list_del(&chip->node);
> +	}
> +
> +	return 0;
> +}
> +
> +static int meson_nfc_nand_chips_init(struct device *dev, struct meson_nfc *nfc)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct device_node *nand_np;
> +	int ret;
> +
> +	for_each_child_of_node(np, nand_np) {
> +		ret = meson_nfc_nand_chip_init(dev, nfc, nand_np);
> +		if (ret) {
> +			meson_nfc_nand_chip_cleanup(nfc);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t meson_nfc_irq(int irq, void *id)
> +{
> +	struct meson_nfc *nfc = id;
> +	u32 cfg;
> +
> +	cfg = readl(nfc->reg_base + NFC_REG_CFG);
> +	cfg |= (1 << 21);
> +	writel(cfg, nfc->reg_base + NFC_REG_CFG);
> +
> +	complete(&nfc->completion);
> +	return IRQ_HANDLED;

Can you check if at least one event has been generated, and if not
return IRQ_NONE?

> +}
> +
> +static const struct meson_nfc_data meson_gxl_data = {
> +	.short_bch	= NFC_ECC_BCH60_1K,
> +	.ecc		= meson_gxl_ecc,
> +	.ecc_num	= ARRAY_SIZE(meson_gxl_ecc),
> +};
> +
> +static const struct meson_nfc_data meson_axg_data = {
> +	.short_bch	= NFC_ECC_BCH8_1K,
> +	.ecc		= meson_axg_ecc,
> +	.ecc_num	= ARRAY_SIZE(meson_axg_ecc),
> +};
> +
> +static const struct of_device_id meson_nfc_id_table[] = {
> +	{
> +		.compatible = "amlogic,meson-gxl-nfc",
> +		.data = &meson_gxl_data,
> +	}, {
> +		.compatible = "amlogic,meson-axg-nfc",
> +		.data = &meson_axg_data,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, meson_nfc_id_table);
> +
> +static int meson_nfc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct meson_nfc *nfc;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
> +	if (!nfc)
> +		return -ENOMEM;
> +
> +	nfc->data =
> +		(struct meson_nfc_data *)of_device_get_match_data(&pdev->dev);

You don't need the cast if you declare nfc->data as const in the struct
def.

> +	if (!nfc->data)
> +		return -ENODEV;
> +
> +	spin_lock_init(&nfc->controller.lock);
> +	init_waitqueue_head(&nfc->controller.wq);

There's a helper for that (nand_controller_init()).

> +	INIT_LIST_HEAD(&nfc->chips);
> +
> +	nfc->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "Failed to nfc reg resource\n");
> +		return -EINVAL;
> +	}

No need to do this check, just pass res to devm_ioremap_resource() and
it will do the check for you.

> +
> +	nfc->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(nfc->reg_base)) {
> +		dev_err(dev, "Failed to lookup nfi reg base\n");

This error message is not needed, devm_ioremap_resource() complains
already.

Just do:

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	nfc->reg_base = devm_ioremap_resource(dev, res);
	if (IS_ERR(nfc->reg_base))
		return PTR_ERR(nfc->reg_base);

> +		return PTR_ERR(nfc->reg_base);
> +	}
> +
> +	nfc->reg_clk =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,
> +						"amlogic,mmc-syscon");
> +	if (IS_ERR(nfc->reg_clk)) {
> +		dev_err(dev, "Failed to lookup clock base\n");
> +		return PTR_ERR(nfc->reg_clk);
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "no nfi irq resource\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = meson_nfc_clk_init(nfc);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize nand clk\n");
> +		goto err_clk;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc);

You should make sure all irqs are masked/cleared before setting up your
irq handler.

> +	if (ret) {
> +		dev_err(dev, "failed to request nfi irq\n");
> +		ret = -EINVAL;
> +		goto err_clk;
> +	}
> +
> +	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(dev, "failed to set dma mask\n");
> +		goto err_clk;
> +	}
> +
> +	platform_set_drvdata(pdev, nfc);
> +
> +	ret = meson_nfc_nand_chips_init(dev, nfc);
> +	if (ret) {
> +		dev_err(dev, "failed to init nand chips\n");
> +		goto err_clk;
> +	}
> +
> +	return 0;
> +
> +err_clk:
> +	meson_nfc_disable_clk(nfc);
> +	return ret;
> +}

Regards,

Boris

