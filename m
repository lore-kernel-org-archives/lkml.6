Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F7EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C18C214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C18C214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeHBP4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:56:38 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:29199 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHBP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:56:38 -0400
Received: from [192.168.90.67] (61.170.236.39) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 2 Aug 2018
 22:05:18 +0800
Subject: Re: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
 <20180719094612.5833-3-yixun.lan@amlogic.com>
 <20180801235045.5b4d8211@bbrezillon>
CC:     <yixun.lan@amlogic.com>, <linux-mtd@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <5f28cbcc-1de7-81df-3d28-9092d2f859c2@amlogic.com>
Date:   Thu, 2 Aug 2018 22:04:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180801235045.5b4d8211@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.170.236.39]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris


On 08/02/2018 05:50 AM, Boris Brezillon wrote:
> Hi Yixun,
> 
> On Thu, 19 Jul 2018 17:46:12 +0800
> Yixun Lan <yixun.lan@amlogic.com> wrote:
> 
> I haven't finished reviewing the driver yet (I'll try to do that later
> this week), but I already pointed a few things to fix/improve.
> 

thanks for the fully review, we really appreciate your time ;-)

I will comment on a few general items first, then clarify others after
talking to the NAND/ASIC team

>> +
>> +static int meson_nfc_exec_op(struct nand_chip *chip,
>> +			     const struct nand_operation *op, bool check_only)
>> +{
>> +
>> +static int meson_nfc_buffer_init(struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>> +	int info_bytes, page_bytes;
>> +	int nsectors;
>> +
>> +	nsectors = mtd->writesize / nand->ecc.size;
>> +	info_bytes = nsectors * PER_INFO_BYTE;
>> +	page_bytes = mtd->writesize + mtd->oobsize;
>> +
>> +	if (nfc->data_buf && nfc->info_buf)
>> +		return 0;
>> +
>> +	nfc->data_buf = kmalloc(page_bytes, GFP_KERNEL);
> 
> I'm pretty sure that does not work if you have several chips. Either
> you have one buffer tied to the NFC, and it has to be large enough to
> handle the NAND with the largest page, or you have one buffer per chip.
> 
em, we will fix this in next version,

>> +	if (!nfc->data_buf)
>> +		return -ENOMEM;
>> +
>> +	nfc->info_buf = kmalloc(info_bytes, GFP_KERNEL);
>> +	if (!nfc->info_buf) {
>> +		kfree(nfc->data_buf);
>> +		return -ENOMEM;
>> +	}
>> +
> 
> Those buffers are not removed in the cleanup/error path.
> 
indeed, thanks for pointing out.
we actually realized this error after sent out this patch ..
>> +	return 0;
>> +}
>> +
>> +static int meson_nfc_calc_set_timing(struct meson_nfc *nfc,
>> +				     int rc_min, int rea_max, int rhoh_min)
..

>> +
>> +static int
>> +meson_nfc_nand_chip_init(struct device *dev,
>> +			 struct meson_nfc *nfc, struct device_node *np)
>> +{
>> +	struct meson_nfc_nand_chip *chip;
>> +	struct nand_chip *nand;
>> +	struct mtd_info *mtd;
>> +	int ret, nsels, i, len = 0;
>> +	char cs_id[16];
>> +	u32 tmp;
>> +
>> +	if (!of_get_property(np, "reg", &nsels))
>> +		return -EINVAL;
>> +
>> +	nsels /= sizeof(u32);
>> +	if (!nsels || nsels > MAX_CE_NUM) {
>> +		dev_err(dev, "invalid reg property size\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	chip = devm_kzalloc(dev, sizeof(*chip) + (nsels * sizeof(u8)),
>> +			    GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	chip->nsels = nsels;
>> +
>> +	for (i = 0; i < nsels; i++) {
>> +		ret = of_property_read_u32_index(np, "reg", i, &tmp);
>> +		if (ret) {
>> +			dev_err(dev, "could not retrieve reg property: %d\n",
>> +				ret);
>> +			return ret;
>> +		}
>> +		chip->sels[i] = tmp;
> 
> You should probably keep track of all the already assigned CS lines, to
> prevent situations where the same controller-CS is used twice
> (copy&paste error when writing the DT).
> 

will do in next version, we would consider to use a bitmap for tracking
this ..
>> +		len += snprintf(cs_id + len, 16, "%s%d", i ? "-" : ".", tmp);
> 
> Hm, do we really need to be that accurate? I'd suggest using the first
> CS only.
> 
ok, this would much simple..
thanks for the suggestion and the detail sample code in the following
section ;-)
>> +	}
>> +
>> +	chip->is_scramble =
>> +		of_property_read_bool(np, "amlogic,nand-enable-scrambler");
> 
> I think I already complained about that :P. If you think this is still
> needed (meaning that the autodetection + NAND_NEED_SCRAMBLING flag are
> not enough), I'll need a detailed explanation ;-).
> 

yes, we saw this kind comment in DT patch already, we will try to fix this..
>> +
>> +	nand = &chip->nand;
>> +	nand_set_flash_node(nand, np);
>> +	nand_set_controller_data(nand, nfc);
>> +
>> +	nand->options |= NAND_USE_BOUNCE_BUFFER;
>> +	nand->select_chip = meson_nfc_select_chip;
>> +	nand->exec_op = meson_nfc_exec_op;
>> +	nand->setup_data_interface = meson_nfc_setup_data_interface;
>> +
>> +	nand->ecc.mode = NAND_ECC_HW;
>> +
>> +	nand->ecc.write_page_raw = meson_nfc_write_page_raw;
>> +	nand->ecc.write_page = meson_nfc_write_page_hwecc;
>> +	nand->ecc.write_oob_raw = nand_write_oob_std;
>> +	nand->ecc.write_oob = nand_write_oob_std;
>> +
>> +	nand->ecc.read_page_raw = meson_nfc_read_page_raw;
>> +	nand->ecc.read_page = meson_nfc_read_page_hwecc;
>> +	nand->ecc.read_oob_raw = meson_nfc_read_oob_raw;
>> +	nand->ecc.read_oob = meson_nfc_read_oob;
> 
> We usually setup the ECC fields after the identification phase. This
> way, if you ever want/need to support SW ECC, the code is already
> properly placed.
> 
>> +
>> +	mtd = nand_to_mtd(nand);
>> +	mtd->owner = THIS_MODULE;
>> +	mtd->dev.parent = dev;
>> +
>> +	ret = nand_scan_ident(mtd, 1, NULL);
>> +	if (ret) {
>> +		dev_err(dev, "failed to can ident\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL, "%s:nand%s",
>> +				   dev_name(dev), cs_id);
> 
> So, if you follow my suggestion, it should be:
> 
> 
> You should make that conditional, because the core might have retrieved
> a user-friendly from the DT (label prop defined to the NAND chip node).
> 
> So, if you follow my suggestion to just use the first CS for the nand
> id, that gives:
> 
> 	if (!mtd->name) {
> 		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
> 					   "%s:nand%d",
> 					   dev_name(dev),
> 					   chip->sels[i]);
> 		if (!mtd->name)
> 			return -ENOMEM;
> 	}
sure
>> +
>> +	/* store bbt magic in page, cause OOB is not protected */
>> +	if (nand->bbt_options & NAND_BBT_USE_FLASH)
>> +		nand->bbt_options |= NAND_BBT_NO_OOB;
>> +
>> +	nand->options |= NAND_NO_SUBPAGE_WRITE;
>> +
>> +	ret = meson_nfc_ecc_init(dev, mtd);
>> +	if (ret) {
>> +		dev_err(dev, "failed to ecc init\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (nand->options & NAND_BUSWIDTH_16) {
>> +		dev_err(dev, "16bits buswidth not supported");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = meson_nfc_buffer_init(mtd);
>> +	if (ret)
>> +		return -ENOMEM;
>> +
>> +	ret = nand_scan_tail(mtd);
> 
> Miquel has reworked the nand_scan() infrastructure recently. Now you
> have to use nand_scan() and define ->attach_chip() hook to do all the
> init that happens between nand_scan_ident() and nand_scan_tail() in
> your code. And of course, all resources allocated in the
> ->attach_chip() hook should be freed in ->detach_chip().
> 
thanks, will look into this

>> +	if (ret)
>> +		return -ENODEV;
>> +
>> +	ret = mtd_device_register(mtd, NULL, 0);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register mtd device: %d\n", ret);
>> +		nand_cleanup(nand);
>> +		return ret;
>> +	}
>> +
>> +	list_add_tail(&chip->node, &nfc->chips);
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_nfc_nand_chip_cleanup(struct meson_nfc *nfc)
> 
> 			     ^ chips
> 
sure

>> +{
>> +	struct meson_nfc_nand_chip *chip;
>> +	struct mtd_info *mtd;
>> +	int ret;
>> +
>> +	while (!list_empty(&nfc->chips)) {
>> +		chip = list_first_entry(&nfc->chips, struct meson_nfc_nand_chip,
>> +					node);
>> +		mtd = nand_to_mtd(&chip->nand);
>> +		ret = mtd_device_unregister(mtd);
>> +		if (ret)
>> +			return ret;
>> +
>> +		nand_cleanup(&chip->nand);
>> +		list_del(&chip->node);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int meson_nfc_nand_chips_init(struct device *dev, struct meson_nfc *nfc)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	struct device_node *nand_np;
>> +	int ret;
>> +
>> +	for_each_child_of_node(np, nand_np) {
>> +		ret = meson_nfc_nand_chip_init(dev, nfc, nand_np);
>> +		if (ret) {
>> +			meson_nfc_nand_chip_cleanup(nfc);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t meson_nfc_irq(int irq, void *id)
>> +{
>> +	struct meson_nfc *nfc = id;
>> +	u32 cfg;
>> +
>> +	cfg = readl(nfc->reg_base + NFC_REG_CFG);
>> +	cfg |= (1 << 21);
>> +	writel(cfg, nfc->reg_base + NFC_REG_CFG);
>> +
>> +	complete(&nfc->completion);
>> +	return IRQ_HANDLED;
> 
> Can you check if at least one event has been generated, and if not
> return IRQ_NONE?
> 
sure, will address this in next version
>> +}
>> +
>> +static const struct meson_nfc_data meson_gxl_data = {
>> +	.short_bch	= NFC_ECC_BCH60_1K,
>> +	.ecc		= meson_gxl_ecc,
>> +	.ecc_num	= ARRAY_SIZE(meson_gxl_ecc),
>> +};
>> +
>> +static const struct meson_nfc_data meson_axg_data = {
>> +	.short_bch	= NFC_ECC_BCH8_1K,
>> +	.ecc		= meson_axg_ecc,
>> +	.ecc_num	= ARRAY_SIZE(meson_axg_ecc),
>> +};
>> +
>> +static const struct of_device_id meson_nfc_id_table[] = {
>> +	{
>> +		.compatible = "amlogic,meson-gxl-nfc",
>> +		.data = &meson_gxl_data,
>> +	}, {
>> +		.compatible = "amlogic,meson-axg-nfc",
>> +		.data = &meson_axg_data,
>> +	},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, meson_nfc_id_table);
>> +
>> +static int meson_nfc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct meson_nfc *nfc;
>> +	struct resource *res;
>> +	int ret, irq;
>> +
>> +	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
>> +	if (!nfc)
>> +		return -ENOMEM;
>> +
>> +	nfc->data =
>> +		(struct meson_nfc_data *)of_device_get_match_data(&pdev->dev);
> 
> You don't need the cast if you declare nfc->data as const in the struct
> def.
> 
ok

>> +	if (!nfc->data)
>> +		return -ENODEV;
>> +
>> +	spin_lock_init(&nfc->controller.lock);
>> +	init_waitqueue_head(&nfc->controller.wq);
> 
> There's a helper for that (nand_controller_init()).
> 
ok
>> +	INIT_LIST_HEAD(&nfc->chips);
>> +
>> +	nfc->dev = dev;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "Failed to nfc reg resource\n");
>> +		return -EINVAL;
>> +	}
> 
> No need to do this check, just pass res to devm_ioremap_resource() and
> it will do the check for you.
> 
>> +
>> +	nfc->reg_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(nfc->reg_base)) {
>> +		dev_err(dev, "Failed to lookup nfi reg base\n");
> 
> This error message is not needed, devm_ioremap_resource() complains
> already.
> 
> Just do:
> 
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	nfc->reg_base = devm_ioremap_resource(dev, res);
> 	if (IS_ERR(nfc->reg_base))
> 		return PTR_ERR(nfc->reg_base);
> 

em.. indeed, thanks


>> +		return PTR_ERR(nfc->reg_base);
>> +	}
>> +
>> +	nfc->reg_clk =
>> +		syscon_regmap_lookup_by_phandle(dev->of_node,
>> +						"amlogic,mmc-syscon");
>> +	if (IS_ERR(nfc->reg_clk)) {
>> +		dev_err(dev, "Failed to lookup clock base\n");
>> +		return PTR_ERR(nfc->reg_clk);
>> +	}
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(dev, "no nfi irq resource\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = meson_nfc_clk_init(nfc);
>> +	if (ret) {
>> +		dev_err(dev, "failed to initialize nand clk\n");
>> +		goto err_clk;
>> +	}
>> +
>> +	ret = devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc);
> 
> You should make sure all irqs are masked/cleared before setting up your
> irq handler.
> 
ok, will do
>> +	if (ret) {
>> +		dev_err(dev, "failed to request nfi irq\n");
>> +		ret = -EINVAL;
>> +		goto err_clk;
>> +	}
>> +
>> +	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
>> +	if (ret) {
>> +		dev_err(dev, "failed to set dma mask\n");
>> +		goto err_clk;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, nfc);
>> +
>> +	ret = meson_nfc_nand_chips_init(dev, nfc);
>> +	if (ret) {
>> +		dev_err(dev, "failed to init nand chips\n");
>> +		goto err_clk;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_clk:
>> +	meson_nfc_disable_clk(nfc);
>> +	return ret;
>> +}
> 
> Regards,
> 
> Boris
> 
> .
> 

Yixun
