Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeA3IFB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:05:01 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:60599 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbeA3IE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:04:59 -0500
Date: Tue, 30 Jan 2018 09:04:46 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Cc: richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3 1/2] mtd: nand: toshiba: Retrieve ECC
 requirements from extended ID
Message-ID: <20180130090446.1ace92b3@bbrezillon>
In-Reply-To: <0cf2e0f7-e61b-2cae-f216-e616aecf3e76@toshiba.co.jp>
References: <1512569098-30038-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
        <1512569098-30038-2-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
        <20171206160805.2435094b@bbrezillon>
        <3e11d966-0801-96f2-8417-194b36a0b775@toshiba.co.jp>
        <20171219125624.58e3e8f8@bbrezillon>
        <b9e62f60-770b-89c3-a2e2-c05767cfd16a@toshiba.co.jp>
        <0cf2e0f7-e61b-2cae-f216-e616aecf3e76@toshiba.co.jp>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018 08:44:30 +0900
KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp> wrote:

> On 2017/12/27 15:06, KOBAYASHI Yoshitake wrote:
> > On 2017/12/19 20:56, Boris Brezillon wrote:  
> >> On Tue, 19 Dec 2017 20:42:36 +0900
> >> KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp> wrote:
> >>  
> >>> On 2017/12/07 0:08, Boris Brezillon wrote:  
> >>>> On Wed,  6 Dec 2017 23:04:57 +0900
> >>>> KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp> wrote:
> >>>>     
> >>>>> This patch enables support to read the ECC strength and size from the
> >>>>> NAND flash using Toshiba Memory SLC NAND extended-ID. This patch is
> >>>>> based on the information of the 6th ID byte of the Toshiba Memory SLC
> >>>>> NAND.
> >>>>>
> >>>>> Signed-off-by: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
> >>>>> ---
> >>>>>  drivers/mtd/nand/nand_toshiba.c | 28 ++++++++++++++++++++++++++++
> >>>>>  1 file changed, 28 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/mtd/nand/nand_toshiba.c b/drivers/mtd/nand/nand_toshiba.c
> >>>>> index 57df857..c2c141b 100644
> >>>>> --- a/drivers/mtd/nand/nand_toshiba.c
> >>>>> +++ b/drivers/mtd/nand/nand_toshiba.c
> >>>>> @@ -35,6 +35,34 @@ static void toshiba_nand_decode_id(struct nand_chip *chip)
> >>>>>  	    (chip->id.data[5] & 0x7) == 0x6 /* 24nm */ &&
> >>>>>  	    !(chip->id.data[4] & 0x80) /* !BENAND */)
> >>>>>  		mtd->oobsize = 32 * mtd->writesize >> 9;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * Extract ECC requirements from 6th id byte.
> >>>>> +	 * For Toshiba SLC, ecc requrements are as follows:
> >>>>> +	 *  - 43nm: 1 bit ECC for each 512Byte is required.
> >>>>> +	 *  - 32nm: 4 bit ECC for each 512Byte is required.
> >>>>> +	 *  - 24nm: 8 bit ECC for each 512Byte is required.
> >>>>> +	 */
> >>>>> +	if (chip->id.len >= 6 && nand_is_slc(chip)) {
> >>>>> +		chip->ecc_step_ds = 512;
> >>>>> +		switch (chip->id.data[5] & 0x7) {
> >>>>> +		case 0x4:
> >>>>> +			chip->ecc_strength_ds = 1;
> >>>>> +			break;
> >>>>> +		case 0x5:
> >>>>> +			chip->ecc_strength_ds = 4;
> >>>>> +			break;
> >>>>> +		case 0x6:
> >>>>> +			chip->ecc_strength_ds = 8;
> >>>>> +			break;
> >>>>> +		default:
> >>>>> +			WARN(1, "Could not get ECC info");
> >>>>> +			chip->ecc_step_ds = 0;
> >>>>> +			break;
> >>>>> +		}
> >>>>> +	} else if (chip->id.len < 6 && nand_is_slc(chip)) {
> >>>>> +		WARN(1, "Could not get ECC info, 6th nand id byte does not exist.");    
> >>>>
> >>>> I'm pretty sure you have old NAND chips that do not have 6bytes ids
> >>>> (see the table here [1]), and printing a huge backtrace in this case is
> >>>> probably not what you want.
> >>>>
> >>>> If you're okay with dropping this else block, I'll do the change when
> >>>> applying, no need to send a new version.    
> >>>
> >>> Some controllers may have limitation in reading ids beyond 5 bytes, 
> >>> considering such scenario we think it is better to keep this warning.
> >>> However if you feel huge backtrace is an issue, how about we using pr_warn() instead?
> >>>  
> >>
> >> Toshiba NANDs with an id smaller than 6 bytes exist, so no, we should
> >> not complain at all. If the controller is broken and can't read the 8 id
> >> bytes the core is asking for, then it should be detected at the core
> >> level not in the NAND manufacturer driver.  
> > 
> > I understood your opinion. Please apply this patch with dropping the else block.  
> 
> Should I repost patch with else block dropped? Please let me know if that is necessary.

I forgot to apply it :-/. Please, send a new version so I can track
it in patchwork.

Thanks,

Boris
