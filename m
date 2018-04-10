Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeDJKDw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:03:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43354 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeDJKDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:03:50 -0400
Date: Tue, 10 Apr 2018 12:03:38 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 5/9] mtd: nand: qcom: parse read errors for read oob
 also
Message-ID: <20180410120338.663d5925@xps13>
In-Reply-To: <1522845745-6624-6-git-send-email-absahu@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
        <1522845745-6624-6-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Wed,  4 Apr 2018 18:12:21 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> read_page and read_oob both calls the read_page_ecc function.
> The QCOM NAND controller protect the OOB available bytes with
> ECC so read errors should be checked for read_oob also. Now
> this patch moves the error checking code inside read_page_ecc
> so caller does not have to check explicitly for read errors.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Nitpick: the prefix should be "mtd: rawnand: qcom: " now as this driver
has been moved to drivers/mtd/nand/raw/.

Otherwise:
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  drivers/mtd/nand/qcom_nandc.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
> index 0ebcc55..ba43752 100644
> --- a/drivers/mtd/nand/qcom_nandc.c
> +++ b/drivers/mtd/nand/qcom_nandc.c
> @@ -1676,6 +1676,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  	struct nand_chip *chip = &host->chip;
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
>  	int i, ret;
>  
>  	config_nand_page_read(nandc);
> @@ -1741,6 +1742,9 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  
>  	free_descs(nandc);
>  
> +	if (!ret)
> +		ret = parse_read_errors(host, data_buf_start, oob_buf_start);
> +
>  	return ret;
>  }
>  
> @@ -1786,20 +1790,14 @@ static int qcom_nandc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
>  	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  	u8 *data_buf, *oob_buf = NULL;
> -	int ret;
>  
>  	nand_read_page_op(chip, page, 0, NULL, 0);
>  	data_buf = buf;
>  	oob_buf = oob_required ? chip->oob_poi : NULL;
>  
>  	clear_bam_transaction(nandc);
> -	ret = read_page_ecc(host, data_buf, oob_buf);
> -	if (ret) {
> -		dev_err(nandc->dev, "failure to read page\n");
> -		return ret;
> -	}
>  
> -	return parse_read_errors(host, data_buf, oob_buf);
> +	return read_page_ecc(host, data_buf, oob_buf);
>  }
>  
>  /* implements ecc->read_page_raw() */
> @@ -1889,7 +1887,6 @@ static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
>  	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
> -	int ret;
>  
>  	clear_read_regs(nandc);
>  	clear_bam_transaction(nandc);
> @@ -1898,11 +1895,7 @@ static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
>  	set_address(host, 0, page);
>  	update_rw_regs(host, ecc->steps, true);
>  
> -	ret = read_page_ecc(host, NULL, chip->oob_poi);
> -	if (ret)
> -		dev_err(nandc->dev, "failure to read oob\n");
> -
> -	return ret;
> +	return read_page_ecc(host, NULL, chip->oob_poi);
>  }
>  
>  /* implements ecc->write_page() */



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
