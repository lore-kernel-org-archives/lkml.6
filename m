Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D671BC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BBA206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BBA206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeKUCzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:55:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38749 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeKUCzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:55:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A01B820DB0; Tue, 20 Nov 2018 17:25:18 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 19F802074F;
        Tue, 20 Nov 2018 17:24:44 +0100 (CET)
Date:   Tue, 20 Nov 2018 17:24:43 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <michals@xilinx.com>,
        nagasuresh12@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20181120172443.5fb0bc14@bbrezillon>
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

On Fri, 9 Nov 2018 10:30:41 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> +static int anfc_setup_data_interface(struct nand_chip *chip, int csline,
> +				     const struct nand_data_interface *conf)
> +{
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	int err;
> +	const struct nand_sdr_timings *sdr;
> +	u32 inftimeval;
> +	bool change_sdr_clk = false;
> +
> +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> +		return 0;
> +
> +	/*
> +	 * If the controller is already in the same mode as flash device
> +	 * then no need to change the timing mode again.
> +	 */
> +	sdr = nand_get_sdr_timings(conf);
> +	if (IS_ERR(sdr))
> +		return PTR_ERR(sdr);
> +
> +	if (sdr->mode < 0)
> +		return -ENOTSUPP;
> +
> +	inftimeval = sdr->mode & 7;
> +	if (sdr->mode >= 2 && sdr->mode <= 5)
> +		change_sdr_clk = true;
> +	/*
> +	 * SDR timing modes 2-5 will not work for the arasan nand when
> +	 * freq > 90 MHz, so reduce the freq in SDR modes 2-5 to < 90Mhz

What's the freq for mode 0 and 1?

> +	 */
> +	if (change_sdr_clk) {
> +		clk_disable_unprepare(nfc->clk_sys);
> +		err = clk_set_rate(nfc->clk_sys, SDR_MODE_DEFLT_FREQ);

You should not change the clk rate here. It should be done when the
chip is selected, so that, if you ever have 2 different chips connected
to the same controller, you can adapt the rate when they are accessed.

> +		if (err) {
> +			dev_err(nfc->dev, "Can't set the clock rate\n");
> +			return err;
> +		}
> +		err = clk_prepare_enable(nfc->clk_sys);
> +		if (err) {
> +			dev_err(nfc->dev, "Unable to enable sys clock.\n");
> +			clk_disable_unprepare(nfc->clk_sys);
> +			return err;
> +		}
> +	}
> +	achip->inftimeval = inftimeval;
> +
> +	return 0;
> +}
> +
> +static int anfc_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	u32 ret;
> +
> +	if (mtd->writesize <= SZ_512)
> +		achip->spare_caddr_cycles = 1;
> +	else
> +		achip->spare_caddr_cycles = 2;
> +
> +	chip->ecc.calc_buf = kmalloc(mtd->oobsize, GFP_KERNEL);
> +	chip->ecc.code_buf = kmalloc(mtd->oobsize, GFP_KERNEL);

Those bufs are allocated but never freed (memleak). Also, are you sure
you really need them.
