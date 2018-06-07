Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rc7aEhwqGVvwEwAAmS7hNA
	; Thu, 07 Jun 2018 12:53:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2E214608BA; Thu,  7 Jun 2018 12:53:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9128560115;
	Thu,  7 Jun 2018 12:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9128560115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeFGMxd convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 08:53:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42746 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932100AbeFGMx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:53:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3D28F20717; Thu,  7 Jun 2018 14:53:27 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id D803F20012;
        Thu,  7 Jun 2018 14:53:26 +0200 (CEST)
Date: Thu, 7 Jun 2018 14:53:26 +0200
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
Message-ID: <20180607145326.339170fd@xps13>
In-Reply-To: <53caff8799d30b6a81ac10f63a7c56c4@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-14-git-send-email-absahu@codeaurora.org>
        <20180526104629.74315561@xps13>
        <90ae248edf8a06a1d35e2da458f75af5@codeaurora.org>
        <20180528090352.254022ed@xps13>
        <53caff8799d30b6a81ac10f63a7c56c4@codeaurora.org>
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

On Mon, 28 May 2018 15:40:52 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> On 2018-05-28 12:33, Miquel Raynal wrote:
> > Hi Abhishek,  
> > >> >>  /* implements ecc->read_page() */  
> >> >>  static int qcom_nandc_read_page(struct mtd_info *mtd, struct >> nand_chip *chip,
> >> >>  				uint8_t *buf, int oob_required, int page)
> >> >> @@ -2118,6 +2083,7 @@ static int qcom_nandc_block_bad(struct mtd_info >> *mtd, loff_t ofs)
> >> >>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> >>  	int page, ret, bbpos, bad = 0;
> >> >>  	u32 flash_status;
> >> >> +	u8 *bbm_bytes_buf = chip->data_buf;  
> >> >> >>  	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
> >> >> >> @@ -2128,11 +2094,31 @@ static int qcom_nandc_block_bad(struct >> mtd_info *mtd, loff_t ofs)  
> >> >>  	 * that contains the BBM
> >> >>  	 */
> >> >>  	host->use_ecc = false;
> >> >> +	bbpos = mtd->writesize - host->cw_size * (ecc->steps - 1);
> >> > > Are we sure there is no layout with only 1 step?
> >> >>   All the layouts are such that, the BBM will come in  
> >>   first byte of spare area.  
> >> >>   For 4 bit ECC, the cw_size is 528 so for 2K page
> >> >>    2048 - 528 * 3 = 464  
> > > My question was more about small page NANDs. But I suppose it works  
> > too if ecc->steps == 1.
> >   
>   Correct Miquel.
> 
> >> >>   So for last CW, the 464 is BBM (i.e 2048th byte) in  
> >>   full page.  
> >> >> > >> >>  	clear_bam_transaction(nandc);  
> >> >> -	ret = copy_last_cw(host, page);
> >> >> -	if (ret)
> >> >> +	clear_read_regs(nandc);
> >> >> +
> >> >> +	set_address(host, host->cw_size * (ecc->steps - 1), page);
> >> >> +	update_rw_regs(host, 1, true);
> >> >> +
> >> >> +	/*
> >> >> +	 * The last codeword data will be copied from NAND device to NAND
> >> >> +	 * controller internal HW buffer. Copy only required BBM size bytes
> >> >> +	 * from this HW buffer to bbm_bytes_buf which is present at
> >> >> +	 * bbpos offset.
> >> >> +	 */
> >> >> +	nandc_set_read_loc(nandc, 0, bbpos, host->bbm_size, 1);
> >> >> +	config_nand_single_cw_page_read(nandc);
> >> >> +	read_data_dma(nandc, FLASH_BUF_ACC + bbpos, bbm_bytes_buf,
> >> >> +		      host->bbm_size, 0);
> >> >> +
> >> >> +	ret = submit_descs(nandc);
> >> >> +	free_descs(nandc);
> >> >> +	if (ret) {
> >> >> +		dev_err(nandc->dev, "failed to copy bad block bytes\n");
> >> >>  		goto err;
> >> >> +	}  
> >> >> >>  	flash_status = le32_to_cpu(nandc->reg_read_buf[0]);
> >> >> >> @@ -2141,12 +2127,10 @@ static int qcom_nandc_block_bad(struct >> mtd_info *mtd, loff_t ofs)  
> >> >>  		goto err;
> >> >>  	}  
> >> >> >> -	bbpos = mtd->writesize - host->cw_size * (ecc->steps - 1);  
> >> >> -
> >> >> -	bad = nandc->data_buffer[bbpos] != 0xff;
> >> >> +	bad = bbm_bytes_buf[0] != 0xff;
> >> > > This is suspect as it still points to the beginning of the data buffer.  
> >> > Can you please check you did not meant bbm_bytes_buf[bbpos]?
> >> >  
> >>   The main thing here is
> >>   nandc_set_read_loc(nandc, 0, bbpos, host->bbm_size, 1);  
> >> >>   After reading one complete CW from NAND, the data will be still  
> >>   in NAND HW buffer.  
> >> >>   The above register tells that we need to read data from  
> >>   bbpos of size host->bbm_size (which is 1 byte for 8 bus witdh
> >>   and 2 byte for 16 bus width) in bbm_bytes_buf.
> > > I see: idx 0 in bbm_bytes_buf is the data at offset bbpos. Then  
> > it's ok.  
> > >> >>   So bbm_bytes_buf[0] will contain the BBM first byte.  
> >>   and bbm_bytes_buf[1] will contain the BBM second byte.  
> >> >>   Regards,  
> >>   Abhishek  
> >> >> >> >>  	if (chip->options & NAND_BUSWIDTH_16)  
> >> >> -		bad = bad || (nandc->data_buffer[bbpos + 1] != 0xff);
> >> >> +		bad = bad || (bbm_bytes_buf[1] != 0xff);  
> > > Sorry, my mistake, I did not see the above line.
> > > However, technically, the BBM could be located in the first, second or  
> > last page of the block. You should check the three of them are 0xFF
> > before declaring the block is not bad.  
> > > The more I look at the function, the more I wonder if you actually need  
> > it. Why does the generic nand_block_bad() implementation in the core
> > do not fit?  
> 
>   The BBM bytes can be accessed in raw mode only for QCOM NAND
>   Contoller. We started with following patch for initial patches
> 
>   http://patchwork.ozlabs.org/patch/508565/
> 
>   I am also not very much sure, how can we go ahead now.
>   Ideally we need to use generic function only which
>   requires raw_read.
> 

I see, thanks for pointing this thread.

Well for now then let's keep our driver-specific implementation.

I will just ask you to do a consistent check as requested above (you
can copy code from the core) and add a comment above this function
explaining why it is needed (what you just told me).

Thanks,
Miquèl
