Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F20BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CF620852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CF620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbeFRLgB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:36:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60915 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933381AbeFRLf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:35:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 49CB12071B; Mon, 18 Jun 2018 13:35:57 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id C2C6920650;
        Mon, 18 Jun 2018 13:35:56 +0200 (CEST)
Date:   Mon, 18 Jun 2018 13:35:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Abhishek Sahu <absahu@codeaurora.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
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
Message-ID: <20180618133556.06e9a16a@xps13>
In-Reply-To: <7179eb382dbd3d49e2066178914636fd@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-14-git-send-email-absahu@codeaurora.org>
        <20180526104629.74315561@xps13>
        <90ae248edf8a06a1d35e2da458f75af5@codeaurora.org>
        <20180528090352.254022ed@xps13>
        <53caff8799d30b6a81ac10f63a7c56c4@codeaurora.org>
        <20180607145326.339170fd@xps13>
        <7179eb382dbd3d49e2066178914636fd@codeaurora.org>
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

Boris, one question for you below :)

> >> >> >>   So for last CW, the 464 is BBM (i.e 2048th byte) in  
> >> >>   full page.  
> >> >> >> > >> >>  	clear_bam_transaction(nandc);  
> >> >> >> -	ret = copy_last_cw(host, page);
> >> >> >> -	if (ret)
> >> >> >> +	clear_read_regs(nandc);
> >> >> >> +
> >> >> >> +	set_address(host, host->cw_size * (ecc->steps - 1), page);
> >> >> >> +	update_rw_regs(host, 1, true);
> >> >> >> +
> >> >> >> +	/*
> >> >> >> +	 * The last codeword data will be copied from NAND device to NAND
> >> >> >> +	 * controller internal HW buffer. Copy only required BBM size bytes
> >> >> >> +	 * from this HW buffer to bbm_bytes_buf which is present at
> >> >> >> +	 * bbpos offset.
> >> >> >> +	 */
> >> >> >> +	nandc_set_read_loc(nandc, 0, bbpos, host->bbm_size, 1);
> >> >> >> +	config_nand_single_cw_page_read(nandc);
> >> >> >> +	read_data_dma(nandc, FLASH_BUF_ACC + bbpos, bbm_bytes_buf,
> >> >> >> +		      host->bbm_size, 0);
> >> >> >> +
> >> >> >> +	ret = submit_descs(nandc);
> >> >> >> +	free_descs(nandc);
> >> >> >> +	if (ret) {
> >> >> >> +		dev_err(nandc->dev, "failed to copy bad block bytes\n");
> >> >> >>  		goto err;
> >> >> >> +	}  
> >> >> >> >>  	flash_status = le32_to_cpu(nandc->reg_read_buf[0]);
> >> >> >> >> @@ -2141,12 +2127,10 @@ static int qcom_nandc_block_bad(struct >> mtd_info *mtd, loff_t ofs)  
> >> >> >>  		goto err;
> >> >> >>  	}  
> >> >> >> >> -	bbpos = mtd->writesize - host->cw_size * (ecc->steps - 1);  
> >> >> >> -
> >> >> >> -	bad = nandc->data_buffer[bbpos] != 0xff;
> >> >> >> +	bad = bbm_bytes_buf[0] != 0xff;
> >> >> > > This is suspect as it still points to the beginning of the data buffer.  
> >> >> > Can you please check you did not meant bbm_bytes_buf[bbpos]?
> >> >> >  
> >> >>   The main thing here is
> >> >>   nandc_set_read_loc(nandc, 0, bbpos, host->bbm_size, 1);  
> >> >> >>   After reading one complete CW from NAND, the data will be still  
> >> >>   in NAND HW buffer.  
> >> >> >>   The above register tells that we need to read data from  
> >> >>   bbpos of size host->bbm_size (which is 1 byte for 8 bus witdh
> >> >>   and 2 byte for 16 bus width) in bbm_bytes_buf.
> >> > > I see: idx 0 in bbm_bytes_buf is the data at offset bbpos. Then  
> >> > it's ok.  
> >> > >> >>   So bbm_bytes_buf[0] will contain the BBM first byte.  
> >> >>   and bbm_bytes_buf[1] will contain the BBM second byte.  
> >> >> >>   Regards,  
> >> >>   Abhishek  
> >> >> >> >> >>  	if (chip->options & NAND_BUSWIDTH_16)  
> >> >> >> -		bad = bad || (nandc->data_buffer[bbpos + 1] != 0xff);
> >> >> >> +		bad = bad || (bbm_bytes_buf[1] != 0xff);  
> >> > > Sorry, my mistake, I did not see the above line.
> >> > > However, technically, the BBM could be located in the first, second or  
> >> > last page of the block. You should check the three of them are 0xFF
> >> > before declaring the block is not bad.  
> >> > > The more I look at the function, the more I wonder if you actually need  
> >> > it. Why does the generic nand_block_bad() implementation in the core
> >> > do not fit?  
> >> >>   The BBM bytes can be accessed in raw mode only for QCOM NAND  
> >>   Contoller. We started with following patch for initial patches  
> >> >>   http://patchwork.ozlabs.org/patch/508565/
> >> >>   I am also not very much sure, how can we go ahead now.  
> >>   Ideally we need to use generic function only which
> >>   requires raw_read.  
> >> > > I see, thanks for pointing this thread.  
> > > Well for now then let's keep our driver-specific implementation.
> > > I will just ask you to do a consistent check as requested above (you  
> > can copy code from the core) and add a comment above this function
> > explaining why it is needed (what you just told me).
> >   
>   Hi Miquel,
> 
>   I explored more regarding making custom bad block functions in this
>   thread and it looks like, we can move to generic block_bad function
>   by small changes in QCOM NAND driver
>   only. The main problem was, in read page with ECC, the bad block
>   byte was skipped.
> 
>   But controller is copying the bad block bytes in another register
>   with following status bytes.
> 
>   BAD_BLOCK_STATUS : With every page read operation, when the controller
>   reads a page with a bad block, it writes the bad block status data into
>   this register.
> 
>   We can update the BBM bytes at start of OOB data in read_oob function
>   with these status bytes. It will help in getting rid of driver-specific
>   implementation for chip->block_bad.

If think this is acceptable.

> 
>   For chip->block_markbad, if we want to get rid of
>   driver-specific implementation then we can have
>   following logic
> 
>   in write_oob function check for bad block bytes in oob
>   and do the raw write for updating BBM bytes alone in
>   flash if BBM bytes are non 0xff.

Ok but this will have to be properly explained in a descriptive comment!

Maybe Boris can give its point of view on the subject. Is it worth
adding the above 'hacks' in the qcom driver and get rid of the
driver-specific ->is_bad()/->mark_bad() impementations?

Thanks,
Miquèl
