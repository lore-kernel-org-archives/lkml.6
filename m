Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F24C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4D226D11
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4D226D11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeFZSCf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:02:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45552 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbeFZSCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:02:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4C4DA2079D; Tue, 26 Jun 2018 20:02:31 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9B5F3206D8;
        Tue, 26 Jun 2018 20:02:30 +0200 (CEST)
Date:   Tue, 26 Jun 2018 20:02:29 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Abhishek Sahu <absahu@codeaurora.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v4 14/15] mtd: rawnand: qcom: erased page bitflips
 detection
Message-ID: <20180626200229.7f638f7e@xps13>
In-Reply-To: <1529479662-4026-15-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
        <1529479662-4026-15-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Wed, 20 Jun 2018 12:57:41 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> NAND parts can have bitflips in an erased page due to the
> process technology used. In this case, QCOM NAND controller
> is not able to identify that page as an erased page.
> Currently the driver calls nand_check_erased_ecc_chunk() for
> identifying the erased pages but this won’t work always since the
> checking is being with ECC engine returned data. In case of
> bitflips, the ECC engine tries to correct the data and then it
> generates the uncorrectable error. Now, this data is not equal to
> original raw data. For erased CW identification, the raw data
> should be read again from NAND device and this
> nand_check_erased_ecc_chunk function() should be called for raw
> data only.
> 
> Now following logic is being added to identify the erased
> codeword bitflips.
> 
> 1. In most of the cases, not all the codewords will have bitflips
>    and only single CW will have bitflips. So, there is no need to
>    read the complete raw page data. The NAND raw read can be
>    scheduled for any CW in page. The NAND controller works on CW
>    basis and it will update the status register after each CW read.
>    Maintain the bitmask for the CW which generated the uncorrectable
>    error.
> 2. Do raw read for all the CW's which generated the uncorrectable
>    error.
> 3. Both DATA and OOB need to be checked for number of 0. The
>    top-level API can be called with only data buf or OOB buf so use
>    chip->databuf if data buf is null and chip->oob_poi if
>    OOB buf is null for copying the raw bytes temporarily.
> 4. For each CW, check the number of 0 in cw_data and usable
>    oob bytes, The bbm and spare (unused) bytes bit flip won’t
>    affect the ECC so don’t check the number of bitflips in this area.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v3:
> 
>  1. Major changes in erased codeword detection for
>     raw read function

I really prefer this version, much more readable from my point of view!

> 
> * Changes from v2:
>   NONE
> 
> * Changes from v1:
>  1. Minor change in commit message
>  2. invalidate pagebuf if databuf or oob_poi is used
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 127 +++++++++++++++++++++++++++-----------
>  1 file changed, 90 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 160acdf..e34edf1 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -1656,20 +1656,95 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
>  }
>  
>  /*
> + * Bitflips can happen in erased codewords also so this function counts the
> + * number of 0 in each CW for which ECC engine returns the uncorrectable
> + * error. The page will be assumed as erased if this count is less than or
> + * equal to the ecc->strength for each CW.
> + *
> + * 1. Both DATA and OOB need to be checked for number of 0. The
> + *    top-level API can be called with only data buf or OOB buf so use
> + *    chip->data_buf if data buf is null and chip->oob_poi if oob buf
> + *    is null for copying the raw bytes.
> + * 2. Perform raw read for all the CW which has uncorrectable errors.
> + * 3. For each CW, check the number of 0 in cw_data and usable OOB bytes.
> + *    The BBM and spare bytes bit flip won’t affect the ECC so don’t check
> + *    the number of bitflips in this area.
> + */
> +static int
> +check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
> +		      u8 *oob_buf, unsigned long uncorrectable_cws,
> +		      int page, unsigned int max_bitflips)
> +{
> +	struct nand_chip *chip = &host->chip;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +	int cw, data_size, oob_size, ret = 0;
> +
> +	if (!data_buf) {
> +		data_buf = chip->data_buf;
> +		chip->pagebuf = -1;
> +	}
> +
> +	if (!oob_buf) {
> +		oob_buf = chip->oob_poi;
> +		chip->pagebuf = -1;
> +	}
> +
> +	for (cw = 0; cw < ecc->steps && uncorrectable_cws; cw++) {

Last nitpick:

Could you have a look to bitmap.c and bitops.h and use a
for_each_set_bit() loop?

No need to resend all the patches, you can send a v5 just for this
patch, the others are fine for me.

Thanks,
Miquèl
