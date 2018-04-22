Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbeDVQTr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 12:19:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45733 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeDVQTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 12:19:43 -0400
Date: Sun, 22 Apr 2018 18:19:29 +0200
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
Subject: Re: [PATCH 8/9] mtd: nand: qcom: helper function for raw read
Message-ID: <20180422181929.65d42ca8@xps13>
In-Reply-To: <c3e32eb24408a973d0c89984a466d9da@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
        <1522845745-6624-9-git-send-email-absahu@codeaurora.org>
        <20180410114428.68d59c8d@xps13>
        <c3e32eb24408a973d0c89984a466d9da@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Thu, 12 Apr 2018 12:36:42 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> On 2018-04-10 15:14, Miquel Raynal wrote:
> > Hi Abhishek,  
> > > On Wed,  4 Apr 2018 18:12:24 +0530, Abhishek Sahu  
> > <absahu@codeaurora.org> wrote:  
> > >> This patch does minor code reorganization for raw reads.  
> >> Currently the raw read is required for complete page but for
> >> subsequent patches related with erased codeword bit flips
> >> detection, only few CW should be read. So, this patch adds
> >> helper function and introduces the read CW bitmask which
> >> specifies which CW reads are required in complete page.
> > > I am not sure this is the right approach for subpage reads. If the  
> > controller supports it, you should just enable it in chip->options.
> >   
>   Thanks Miquel.
> 
>   It is internal to this file only. This patch makes one static helper
>   function which provides the support to read subpages.

Drivers should expose raw helpers, why keeping this helper static then?

> 
> >> >> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>  
> >> ---
> >>  drivers/mtd/nand/qcom_nandc.c | 186 >> +++++++++++++++++++++++++-----------------
> >>  1 file changed, 110 insertions(+), 76 deletions(-)  
> >> >> diff --git a/drivers/mtd/nand/qcom_nandc.c >> b/drivers/mtd/nand/qcom_nandc.c  
> >> index 40c790e..f5d1fa4 100644
> >> --- a/drivers/mtd/nand/qcom_nandc.c
> >> +++ b/drivers/mtd/nand/qcom_nandc.c
> >> @@ -1590,6 +1590,114 @@ static int check_flash_errors(struct >> qcom_nand_host *host, int cw_cnt)
> >>  }  
> >> >>  /*  
> >> + * Helper to perform the page raw read operation. The read_cw_mask >> will be
> >> + * used to specify the codewords for which the data should be read. >> The
> >> + * single page contains multiple CW. Sometime, only few CW data is >> required
> >> + * in complete page. Also, start address will be determined with
> >> + * this CW mask to skip unnecessary data copy from NAND flash device. >> Then,
> >> + * actual data copy from NAND controller to data buffer will be done >> only
> >> + * for the CWs which have the mask set.
> >> + */
> >> +static int
> >> +nandc_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
> >> +		    u8 *data_buf, u8 *oob_buf,
> >> +		    int page, unsigned long read_cw_mask)
> >> +{
> >> +	struct qcom_nand_host *host = to_qcom_nand_host(chip);
> >> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> >> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> +	int i, ret;
> >> +	int read_loc, start_step, last_step;
> >> +
> >> +	nand_read_page_op(chip, page, 0, NULL, 0);
> >> +
> >> +	host->use_ecc = false;
> >> +	start_step = ffs(read_cw_mask) - 1;
> >> +	last_step = fls(read_cw_mask);
> >> +
> >> +	clear_bam_transaction(nandc);
> >> +	set_address(host, host->cw_size * start_step, page);
> >> +	update_rw_regs(host, last_step - start_step, true);
> >> +	config_nand_page_read(nandc);
> >> +
> >> +	for (i = start_step; i < last_step; i++) {
> >> +		int data_size1, data_size2, oob_size1, oob_size2;
> >> +		int reg_off = FLASH_BUF_ACC;
> >> +
> >> +		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
> >> +		oob_size1 = host->bbm_size;
> >> +
> >> +		if (i == (ecc->steps - 1)) {
> >> +			data_size2 = ecc->size - data_size1 -
> >> +				     ((ecc->steps - 1) << 2);
> >> +			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
> >> +				    host->spare_bytes;
> >> +		} else {
> >> +			data_size2 = host->cw_data - data_size1;
> >> +			oob_size2 = host->ecc_bytes_hw + host->spare_bytes;
> >> +		}
> >> +
> >> +		/*
> >> +		 * Don't perform actual data copy from NAND controller to data
> >> +		 * buffer through DMA for this codeword
> >> +		 */
> >> +		if (!(read_cw_mask & BIT(i))) {
> >> +			if (nandc->props->is_bam)
> >> +				nandc_set_read_loc(nandc, 0, 0, 0, 1);
> >> +
> >> +			config_nand_cw_read(nandc, false);
> >> +
> >> +			data_buf += data_size1 + data_size2;
> >> +			oob_buf += oob_size1 + oob_size2;
> >> +
> >> +			continue;
> >> +		}
> >> +
> >> +		if (nandc->props->is_bam) {
> >> +			read_loc = 0;
> >> +			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> >> +			read_loc += data_size1;
> >> +
> >> +			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> >> +			read_loc += oob_size1;
> >> +
> >> +			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> >> +			read_loc += data_size2;
> >> +
> >> +			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> >> +		}
> >> +
> >> +		config_nand_cw_read(nandc, false);
> >> +
> >> +		read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
> >> +		reg_off += data_size1;
> >> +		data_buf += data_size1;
> >> +
> >> +		read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
> >> +		reg_off += oob_size1;
> >> +		oob_buf += oob_size1;
> >> +
> >> +		read_data_dma(nandc, reg_off, data_buf, data_size2, 0);
> >> +		reg_off += data_size2;
> >> +		data_buf += data_size2;
> >> +
> >> +		read_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
> >> +		oob_buf += oob_size2;
> >> +	}
> >> +
> >> +	ret = submit_descs(nandc);
> >> +	if (ret)
> >> +		dev_err(nandc->dev, "failure to read raw page\n");
> >> +
> >> +	free_descs(nandc);
> >> +
> >> +	if (!ret)
> >> +		ret = check_flash_errors(host, last_step - start_step);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +/*
> >>   * reads back status registers set by the controller to notify page >> read
> >>   * errors. this is equivalent to what 'ecc->correct()' would do.
> >>   */
> >> @@ -1839,82 +1947,8 @@ static int qcom_nandc_read_page_raw(struct >> mtd_info *mtd,
> >>  				    struct nand_chip *chip, uint8_t *buf,
> >>  				    int oob_required, int page)
> >>  {
> >> -	struct qcom_nand_host *host = to_qcom_nand_host(chip);
> >> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> >> -	u8 *data_buf, *oob_buf;
> >> -	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> -	int i, ret;
> >> -	int read_loc;
> >> -
> >> -	nand_read_page_op(chip, page, 0, NULL, 0);
> >> -	data_buf = buf;
> >> -	oob_buf = chip->oob_poi;
> >> -
> >> -	host->use_ecc = false;
> >> -
> >> -	clear_bam_transaction(nandc);
> >> -	update_rw_regs(host, ecc->steps, true);
> >> -	config_nand_page_read(nandc);
> >> -
> >> -	for (i = 0; i < ecc->steps; i++) {
> >> -		int data_size1, data_size2, oob_size1, oob_size2;
> >> -		int reg_off = FLASH_BUF_ACC;
> >> -
> >> -		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
> >> -		oob_size1 = host->bbm_size;
> >> -
> >> -		if (i == (ecc->steps - 1)) {
> >> -			data_size2 = ecc->size - data_size1 -
> >> -				     ((ecc->steps - 1) << 2);
> >> -			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
> >> -				    host->spare_bytes;
> >> -		} else {
> >> -			data_size2 = host->cw_data - data_size1;
> >> -			oob_size2 = host->ecc_bytes_hw + host->spare_bytes;
> >> -		}
> >> -
> >> -		if (nandc->props->is_bam) {
> >> -			read_loc = 0;
> >> -			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> >> -			read_loc += data_size1;
> >> -
> >> -			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> >> -			read_loc += oob_size1;
> >> -
> >> -			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> >> -			read_loc += data_size2;
> >> -
> >> -			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> >> -		}
> >> -
> >> -		config_nand_cw_read(nandc, false);
> >> -
> >> -		read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
> >> -		reg_off += data_size1;
> >> -		data_buf += data_size1;
> >> -
> >> -		read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
> >> -		reg_off += oob_size1;
> >> -		oob_buf += oob_size1;
> >> -
> >> -		read_data_dma(nandc, reg_off, data_buf, data_size2, 0);
> >> -		reg_off += data_size2;
> >> -		data_buf += data_size2;
> >> -
> >> -		read_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
> >> -		oob_buf += oob_size2;
> >> -	}
> >> -
> >> -	ret = submit_descs(nandc);
> >> -	if (ret)
> >> -		dev_err(nandc->dev, "failure to read raw page\n");
> >> -
> >> -	free_descs(nandc);
> >> -
> >> -	if (!ret)
> >> -		ret = check_flash_errors(host, ecc->steps);
> >> -
> >> -	return 0;
> >> +	return nandc_read_page_raw(mtd, chip, buf, chip->oob_poi, page,
> >> +				   BIT(chip->ecc.steps) - 1);
> > > I don't understand this. chip->ecc.steps is constant, right? So you  
> > always ask for the same subpage?  
> 
>   We need to do raw read for subpages in which we got uncorrectable
>   error in next patch for erased page bitflip detection. This patch does
>   reorganization of raw read and moves common code in helper function
>   nandc_read_page_raw.
> 
>   For nomral raw read, all the subpages will be read so
>   BIT(chip->ecc.steps) - 1 is used for qcom_nandc_read_page_raw.
> 
>   While for erased page raw read, only those sub pages will be
>   read for which the controller gives the uncorrectable error.

Still not okay: the driver should expose a way to do raw reads no
matter the length and the start and you should use that in a generic
way.

> 
>   Thanks,
>   Abhishek
> 
> > >>  }  
> >> >>  /* implements ecc->read_oob() */  



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
