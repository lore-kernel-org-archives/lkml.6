Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BR/5B40oGVudfQAAmS7hNA
	; Thu, 07 Jun 2018 12:43:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4519A608C9; Thu,  7 Jun 2018 12:43:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 88CB8608BA;
	Thu,  7 Jun 2018 12:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88CB8608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbeFGMnz convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 08:43:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42527 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932318AbeFGMnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:43:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 16CB720717; Thu,  7 Jun 2018 14:43:51 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id ADD6F203EC;
        Thu,  7 Jun 2018 14:43:50 +0200 (CEST)
Date: Thu, 7 Jun 2018 14:43:50 +0200
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
Subject: Re: [PATCH v3 15/16] mtd: rawnand: qcom: helper function for raw
 read
Message-ID: <20180607144350.1a4427a0@xps13>
In-Reply-To: <19569fdc057754978298a7e7afc9016a@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-16-git-send-email-absahu@codeaurora.org>
        <20180527155311.4c05d7ab@xps13>
        <19569fdc057754978298a7e7afc9016a@codeaurora.org>
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

On Mon, 28 May 2018 13:04:45 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> On 2018-05-27 19:23, Miquel Raynal wrote:
> > Hi Abhishek,  
> > > On Fri, 25 May 2018 17:51:43 +0530, Abhishek Sahu  
> > <absahu@codeaurora.org> wrote:  
> > >> This patch does minor code reorganization for raw reads.  
> >> Currently the raw read is required for complete page but for
> >> subsequent patches related with erased codeword bit flips
> >> detection, only few CW should be read. So, this patch adds
> >> helper function and introduces the read CW bitmask which
> >> specifies which CW reads are required in complete page.  
> >> >> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>  
> >> ---
> >> * Changes from v2:
> >>   NONE  
> >> >> * Changes from v1:  
> >>  1. Included more detail in function comment  
> >> >>  drivers/mtd/nand/raw/qcom_nandc.c | 197 >> ++++++++++++++++++++++++--------------  
> >>  1 file changed, 123 insertions(+), 74 deletions(-)  
> >> >> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c >> b/drivers/mtd/nand/raw/qcom_nandc.c  
> >> index 87f900e..34143a4 100644
> >> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> >> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> >> @@ -1588,6 +1588,127 @@ static int check_flash_errors(struct >> qcom_nand_host *host, int cw_cnt)
> >>  }  
> >> >>  /*  
> >> + * Helper to perform the page raw read operation. The read_cw_mask >> will be
> >> + * used to specify the codewords (CW) for which the data should be >> read. The
> >> + * single page contains multiple CW.
> >> + *
> >> + * Normally other NAND controllers store the data in main area and
> >> + * ecc bytes in OOB area. So, if page size is 2048+64 then 2048
> >> + * data bytes will go in main area followed by ECC bytes. The QCOM >> NAND
> >> + * controller follows different layout in which the data+OOB is >> internally
> >> + * divided in 528/532 bytes CW and each CW contains 516 bytes >> followed by
> >> + * ECC parity bytes for that CW. By this, 4 available OOB bytes per >> CW
> >> + * will also be protected with ECC.
> >> + *
> >> + * For each CW read, following are the 2 steps:
> >> + * 1. Read the codeword bytes from NAND chip to NAND controller >> internal HW
> >> + *    buffer.
> >> + * 2. Copy all these bytes from this HW buffer to actual buffer.
> >> + *
> >> + * Sometime, only few CW data is required in complete page. The >> read_cw_mask
> >> + * specifies which CW in a page needs to be read. Start address will >> be
> >> + * determined with this CW mask to skip unnecessary data copy from >> NAND
> >> + * flash device. Then, actual data copy from NAND controller HW >> internal buffer
> >> + * to data buffer will be done only for the CWs, which have the mask >> set.
> >> + */
> >> +static int
> >> +nandc_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
> >> +		    u8 *data_buf, u8 *oob_buf,
> >> +		    int page, unsigned long read_cw_mask)
> > > Please prefix the helper with "qcom_nandc"  
> >   
>   Sure Miquel.
>   I will update that.
> 
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
> > > This comment applies for both patches 15 and 16:
> > > I would really prefer having a qcom_nandc_read_cw_raw() that reads only  
> > one CW. From qcom_nandc_read_page_raw() you would loop over all the CW
> > calling qcom_nandc_read_cw_raw() helper (it's raw reads, we don't care
> > about performances)  
> 
>   Doing that way will degrade performances hugely.
> 
>   Currently once we formed the descriptor, the DMA will take care
>   of complete page data transfer from NAND device to buffer and will
>   generate single interrupt.
> 
>   Now it will form one CW descriptor and wait for it to be finished.
>   In background, the data transfer from NAND device will be also
>   split and for every CW, it will give the PAGE_READ command again,
>   which is again time consuming.
> 
>   Data transfer degradation is ok but it will increase CPU time
>   and number of interrupts which will impact other peripherals
>   performance that time.
> 
>   Most of the NAND parts has 4K page size i.e 8 CWs.
> 
> > and from ->read_page_raw() you would check
> > CW with uncorrectable errors for being blank with that helper. You
> > would avoid the not-so-nice logic where you read all the CW between the
> > first bad one and the last bad one.
> >   
>   The reading b/w first CW and last CW is only from NAND device to NAND
>   HW buffers. The NAND controller has 2 HW buffers which is used to
>   optimize the traffic throughput between the NAND device and
>   system memory,in both directions. Each buffer is 544B in size: 512B
>   for data + 32B spare bytes. Throughput optimization is achieved by
>   executing internal data transfers (i.e. between NANDc buffers and
>   system memory) simultaneously with NAND device operations.
> 
>   Making separate function won't help in improving performance for
>   this case either since once every thing is set for reading page
>   (descriptor formation, issue the PAGE_READ, Data transfer from
>   Flash array to data register in NAND device), the read time from
>   device to NAND HW buffer is very less. Again, we did optimization
>   in which the copying from NAND HW buffer to actual buffer is being
>   done only for those CW's only.
> 
>   Again, in this case CPU time will be more.
> 


I understand the point and thanks for detailing it. But raw access
happen either during debug (we don't care about CPU time) or when there
is an uncorrectable error, which is very unlikely to happen very often
when using eg. UBI/UBIFS. So I'm still convinced it is better to have a
_simple_ and straightforward code for this path than something way
harder to understand and much faster.

You can add a comment to explain what would be the fastest way and
why though.


Thanks,
Miquèl
