Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031468AbeEZIn1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:43:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35904 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031300AbeEZInW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:43:22 -0400
Date: Sat, 26 May 2018 10:43:05 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v3 06/16] mtd: rawnand: qcom: use the ecc strength from
 device parameter
Message-ID: <20180526104305.6f957db9@xps13>
In-Reply-To: <1527250904-21988-7-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-7-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Fri, 25 May 2018 17:51:34 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> Currently the driver uses the ECC strength specified in DT.
> The QPIC/EBI2 NAND supports 4 or 8-bit ECC correction. The same
> kind of board can have different NAND parts so use the ECC
> strength from device parameters if it is not specified in DT.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v2:
>   NONE

Yes you did change things:

- s/<< 2/* 4/
- updated the cwperpage location
- the block handling the ecc-step-size property has been removed in a
  previous patch

Please be careful with that, it is time consuming to review the patches
all over again.

> 
> * Changes from v1:
> 
>   1. Removed the custom logic and used the helper fuction.
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index b538390..7377923 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2315,19 +2315,39 @@ static int qcom_nand_ooblayout_free(struct mtd_info *mtd, int section,
>  	.free = qcom_nand_ooblayout_free,
>  };
>  
> +static int
> +qcom_nandc_calc_ecc_bytes(int step_size, int strength)
> +{
> +	return strength == 4 ? 12 : 16;
> +}
> +NAND_ECC_CAPS_SINGLE(qcom_nandc_ecc_caps, qcom_nandc_calc_ecc_bytes,
> +		     NANDC_STEP_SIZE, 4, 8);
> +
>  static int qcom_nand_host_setup(struct qcom_nand_host *host)
>  {
>  	struct nand_chip *chip = &host->chip;
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> -	int cwperpage, bad_block_byte;
> +	int cwperpage, bad_block_byte, ret;
>  	bool wide_bus;
>  	int ecc_mode = 1;
>  
>  	/* controller only supports 512 bytes of data in each step */
>  	ecc->size = NANDC_STEP_SIZE;
>  	wide_bus = chip->options & NAND_BUSWIDTH_16 ? true : false;
> +	cwperpage = mtd->writesize / NANDC_STEP_SIZE;
> +
> +	/*
> +	 * Each CW has 4 available OOB bytes which will be protected with ECC
> +	 * so remaining bytes can be used for ECC.
> +	 */
> +	ret = nand_ecc_choose_conf(chip, &qcom_nandc_ecc_caps,
> +				   mtd->oobsize - cwperpage * 4);

Nitpick: could you add parenthesis around (cwperpage * 4) just for
clarity.

> +	if (ret) {
> +		dev_err(nandc->dev, "No valid ECC settings possible\n");
> +		return ret;
> +	}
>  
>  	if (ecc->strength >= 8) {
>  		/* 8 bit ECC defaults to BCH ECC on all platforms */
> @@ -2396,7 +2416,6 @@ static int qcom_nand_host_setup(struct qcom_nand_host *host)
>  
>  	mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
>  
> -	cwperpage = mtd->writesize / ecc->size;
>  	nandc->max_cwperpage = max_t(unsigned int, nandc->max_cwperpage,
>  				     cwperpage);
>  
> @@ -2412,12 +2431,6 @@ static int qcom_nand_host_setup(struct qcom_nand_host *host)
>  	 * for 8 bit ECC
>  	 */
>  	host->cw_size = host->cw_data + ecc->bytes;
> -
> -	if (ecc->bytes * (mtd->writesize / ecc->size) > mtd->oobsize) {
> -		dev_err(nandc->dev, "ecc data doesn't fit in OOB area\n");
> -		return -EINVAL;
> -	}
> -
>  	bad_block_byte = mtd->writesize - host->cw_size * (cwperpage - 1) + 1;
>  
>  	host->cfg0 = (cwperpage - 1) << CW_PER_PAGE

Once corrected:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
