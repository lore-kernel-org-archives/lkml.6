Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeE1HEB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:04:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34743 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753779AbeE1HDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:03:55 -0400
Date: Mon, 28 May 2018 09:03:52 +0200
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
Subject: Re: [PATCH v3 13/16] mtd: rawnand: qcom: minor code reorganization
 for bad block check
Message-ID: <20180528090352.254022ed@xps13>
In-Reply-To: <90ae248edf8a06a1d35e2da458f75af5@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-14-git-send-email-absahu@codeaurora.org>
        <20180526104629.74315561@xps13>
        <90ae248edf8a06a1d35e2da458f75af5@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> >>  /* implements ecc->read_page() */
> >>  static int qcom_nandc_read_page(struct mtd_info *mtd, struct >> nand_chip *chip,
> >>  				uint8_t *buf, int oob_required, int page)
> >> @@ -2118,6 +2083,7 @@ static int qcom_nandc_block_bad(struct mtd_info >> *mtd, loff_t ofs)
> >>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >>  	int page, ret, bbpos, bad = 0;
> >>  	u32 flash_status;
> >> +	u8 *bbm_bytes_buf = chip->data_buf;  
> >> >>  	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
> >> >> @@ -2128,11 +2094,31 @@ static int qcom_nandc_block_bad(struct >> mtd_info *mtd, loff_t ofs)  
> >>  	 * that contains the BBM
> >>  	 */
> >>  	host->use_ecc = false;
> >> +	bbpos = mtd->writesize - host->cw_size * (ecc->steps - 1);
> > > Are we sure there is no layout with only 1 step?  
> 
>   All the layouts are such that, the BBM will come in
>   first byte of spare area.
> 
>   For 4 bit ECC, the cw_size is 528 so for 2K page
> 
>    2048 - 528 * 3 = 464

My question was more about small page NANDs. But I suppose it works
too if ecc->steps == 1.

> 
>   So for last CW, the 464 is BBM (i.e 2048th byte) in
>   full page.
> 
> > >> >>  	clear_bam_transaction(nandc);  
> >> -	ret = copy_last_cw(host, page);
> >> -	if (ret)
> >> +	clear_read_regs(nandc);
> >> +
> >> +	set_address(host, host->cw_size * (ecc->steps - 1), page);
> >> +	update_rw_regs(host, 1, true);
> >> +
> >> +	/*
> >> +	 * The last codeword data will be copied from NAND device to NAND
> >> +	 * controller internal HW buffer. Copy only required BBM size bytes
> >> +	 * from this HW buffer to bbm_bytes_buf which is present at
> >> +	 * bbpos offset.
> >> +	 */
> >> +	nandc_set_read_loc(nandc, 0, bbpos, host->bbm_size, 1);
> >> +	config_nand_single_cw_page_read(nandc);
> >> +	read_data_dma(nandc, FLASH_BUF_ACC + bbpos, bbm_bytes_buf,
> >> +		      host->bbm_size, 0);
> >> +
> >> +	ret = submit_descs(nandc);
> >> +	free_descs(nandc);
> >> +	if (ret) {
> >> +		dev_err(nandc->dev, "failed to copy bad block bytes\n");
> >>  		goto err;
> >> +	}  
> >> >>  	flash_status = le32_to_cpu(nandc->reg_read_buf[0]);
> >> >> @@ -2141,12 +2127,10 @@ static int qcom_nandc_block_bad(struct >> mtd_info *mtd, loff_t ofs)  
> >>  		goto err;
> >>  	}  
> >> >> -	bbpos = mtd->writesize - host->cw_size * (ecc->steps - 1);  
> >> -
> >> -	bad = nandc->data_buffer[bbpos] != 0xff;
> >> +	bad = bbm_bytes_buf[0] != 0xff;
> > > This is suspect as it still points to the beginning of the data buffer.  
> > Can you please check you did not meant bbm_bytes_buf[bbpos]?
> >   
>   The main thing here is
>   nandc_set_read_loc(nandc, 0, bbpos, host->bbm_size, 1);
> 
>   After reading one complete CW from NAND, the data will be still
>   in NAND HW buffer.
> 
>   The above register tells that we need to read data from
>   bbpos of size host->bbm_size (which is 1 byte for 8 bus witdh
>   and 2 byte for 16 bus width) in bbm_bytes_buf.

I see: idx 0 in bbm_bytes_buf is the data at offset bbpos. Then
it's ok.

> 
>   So bbm_bytes_buf[0] will contain the BBM first byte.
>   and bbm_bytes_buf[1] will contain the BBM second byte.
> 
>   Regards,
>   Abhishek
> 
> >> >>  	if (chip->options & NAND_BUSWIDTH_16)  
> >> -		bad = bad || (nandc->data_buffer[bbpos + 1] != 0xff);
> >> +		bad = bad || (bbm_bytes_buf[1] != 0xff);

Sorry, my mistake, I did not see the above line.

However, technically, the BBM could be located in the first, second or
last page of the block. You should check the three of them are 0xFF
before declaring the block is not bad.

The more I look at the function, the more I wonder if you actually need
it. Why does the generic nand_block_bad() implementation in the core
do not fit?

> >>  err:
> >>  	return bad;
> >>  }  
> > > > Thanks,  
> > Miquèl  
