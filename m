Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1C2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3FC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3FC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeGRWDs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:03:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41030 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeGRWDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:03:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 83E9920731; Wed, 18 Jul 2018 23:24:01 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id DF9CC206ED;
        Wed, 18 Jul 2018 23:23:50 +0200 (CEST)
Date:   Wed, 18 Jul 2018 23:23:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Abhishek Sahu <absahu@codeaurora.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 2/5] mtd: rawnand: qcom: remove driver specific
 block_markbad function
Message-ID: <20180718232350.3eaade9a@xps13>
In-Reply-To: <1530863519-5564-3-git-send-email-absahu@codeaurora.org>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
        <1530863519-5564-3-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,

Can you please check the change in qcom_nandc_write_oob() is
valid? I think it is but as this is a bit of a hack I prefer double checking.

Thanks,
Miquèl


Abhishek Sahu <absahu@codeaurora.org> wrote on Fri,  6 Jul 2018
13:21:56 +0530:

> The NAND base layer calls write_oob() by setting bytes at
> chip->badblockpos with value non 0xFF for updating bad block status.
> The QCOM NAND controller skips the bad block bytes while doing normal
> write with ECC enabled. When initial support for this driver was
> added, the driver specific function was added temporarily for
> block_markbad() with assumption to change for raw read in NAND base
> layer. Moving to raw read for block_markbad() seems to take more time
> so this patch removes driver specific block_markbad() function by
> using following HACK in write_oob() function.
> 
> Check for BBM bytes in OOB and accordingly do raw write for updating
> BBM bytes in NAND flash or normal write for updating available OOB
> bytes.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 103 +++++++++++++++-----------------------
>  1 file changed, 40 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index ea253ac..df12cf3 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2138,28 +2138,57 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
>  	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
> -	u8 *oob = chip->oob_poi;
> -	int data_size, oob_size;
> +	u8 *oob = chip->oob_poi, bbm_byte;
> +	int data_size, oob_size, bbm_offset, write_size;
>  	int ret;
>  
> -	host->use_ecc = true;
>  	clear_bam_transaction(nandc);
>  
> -	/* calculate the data and oob size for the last codeword/step */
> -	data_size = ecc->size - ((ecc->steps - 1) << 2);
> -	oob_size = mtd->oobavail;
> +	/*
> +	 * The NAND base layer calls ecc->write_oob() by setting bytes at
> +	 * chip->badblockpos (chip->badblockpos will be 0 for QCOM NAND
> +	 * controller layout) in OOB buffer with value other that 0xFF
> +	 * for updating bad block status. QCOM NAND controller skips
> +	 * BBM bytes while writing with ECC, so following HACK has been
> +	 * added in this function for using generic block_markbad() function.
> +	 *
> +	 * Check for BBM bytes in OOB and accordingly do raw write for
> +	 * updating BBM bytes in NAND flash or normal write with ECC for
> +	 * updating available OOB bytes.
> +	 */
> +	bbm_byte = oob[0];
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		bbm_byte &= oob[1];
>  
> -	memset(nandc->data_buffer, 0xff, host->cw_data);
> -	/* override new oob content to last codeword */
> -	mtd_ooblayout_get_databytes(mtd, nandc->data_buffer + data_size, oob,
> -				    0, mtd->oobavail);
> +	/* Write BBM bytes by doing raw write. */
> +	if (bbm_byte != 0xff) {
> +		host->use_ecc = false;
> +		memset(nandc->data_buffer, 0xff, host->cw_size);
> +		/* Determine the BBM bytes position and update the same */
> +		bbm_offset = mtd->writesize - host->cw_size * (ecc->steps - 1);
> +		memcpy(nandc->data_buffer + bbm_offset, oob, host->bbm_size);
> +		write_size = host->cw_size;
> +	/* Write OOB bytes by doing normal write with ECC */
> +	} else {
> +		host->use_ecc = true;
> +		/* calculate the data and oob size for the last codeword/step */
> +		data_size = ecc->size - ((ecc->steps - 1) << 2);
> +		oob_size = mtd->oobavail;
> +
> +		memset(nandc->data_buffer, 0xff, host->cw_data);
> +		/* override new oob content to last codeword */
> +		mtd_ooblayout_get_databytes(mtd, nandc->data_buffer + data_size,
> +					    oob, 0, mtd->oobavail);
> +
> +		write_size = data_size + oob_size;
> +	}
>  
>  	set_address(host, host->cw_size * (ecc->steps - 1), page);
>  	update_rw_regs(host, 1, false);
>  
>  	config_nand_page_write(nandc);
>  	write_data_dma(nandc, FLASH_BUF_ACC,
> -		       nandc->data_buffer, data_size + oob_size, 0);
> +		       nandc->data_buffer, write_size, 0);
>  	config_nand_cw_write(nandc);
>  
>  	ret = submit_descs(nandc);
> @@ -2174,48 +2203,6 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
>  	return nand_prog_page_end_op(chip);
>  }
>  
> -static int qcom_nandc_block_markbad(struct mtd_info *mtd, loff_t ofs)
> -{
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> -	struct qcom_nand_host *host = to_qcom_nand_host(chip);
> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> -	struct nand_ecc_ctrl *ecc = &chip->ecc;
> -	int page, ret;
> -
> -	clear_read_regs(nandc);
> -	clear_bam_transaction(nandc);
> -
> -	/*
> -	 * to mark the BBM as bad, we flash the entire last codeword with 0s.
> -	 * we don't care about the rest of the content in the codeword since
> -	 * we aren't going to use this block again
> -	 */
> -	memset(nandc->data_buffer, 0x00, host->cw_size);
> -
> -	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
> -
> -	/* prepare write */
> -	host->use_ecc = false;
> -	set_address(host, host->cw_size * (ecc->steps - 1), page);
> -	update_rw_regs(host, 1, false);
> -
> -	config_nand_page_write(nandc);
> -	write_data_dma(nandc, FLASH_BUF_ACC,
> -		       nandc->data_buffer, host->cw_size, 0);
> -	config_nand_cw_write(nandc);
> -
> -	ret = submit_descs(nandc);
> -
> -	free_descs(nandc);
> -
> -	if (ret) {
> -		dev_err(nandc->dev, "failure to update BBM\n");
> -		return -EIO;
> -	}
> -
> -	return nand_prog_page_end_op(chip);
> -}
> -
>  /*
>   * the three functions below implement chip->read_byte(), chip->read_buf()
>   * and chip->write_buf() respectively. these aren't used for
> @@ -2757,16 +2744,6 @@ static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
>  	chip->set_features	= nand_get_set_features_notsupp;
>  	chip->get_features	= nand_get_set_features_notsupp;
>  
> -	/*
> -	 * the bad block marker is writable only when we write the last codeword
> -	 * of a page with ECC disabled. currently, the nand_base and nand_bbt
> -	 * helpers don't allow us to write BB from a nand chip with ECC
> -	 * disabled (MTD_OPS_PLACE_OOB is set by default). use the block_markbad
> -	 * helpers until we permanently switch to using
> -	 * MTD_OPS_RAW for all drivers (with the help of badblockbits)
> -	 */
> -	chip->block_markbad	= qcom_nandc_block_markbad;
> -
>  	chip->controller = &nandc->controller;
>  	chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER |
>  			 NAND_SKIP_BBTSCAN;



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
