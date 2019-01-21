Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC58C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEC220855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548058400;
	bh=djyfNTCllQpKBZzzvuMRvitbEHsIQegNt3mk5IAXHhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tOpnFSI3LIKnsui7p2+du31uA4t94s02C4QMVdz7u4achvZAHxIQISq8enwOY+yeg
	 qMFYjUesB3BmoXayxCo0+hnk2LNiXw9W5DjAGJA+d4KbhYxjurEwvB7SD8y3kpl7zB
	 OW+VAkBi0e6rMpXr/wNWRqIEK0jqjK/OAS+5+Ugo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfAUINT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:13:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfAUINQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:13:16 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 730DB20855;
        Mon, 21 Jan 2019 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548058395;
        bh=djyfNTCllQpKBZzzvuMRvitbEHsIQegNt3mk5IAXHhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2TR12+jlu6L2TkPPPeeu3MjyIyi10TixwG3/7fjlCbnQ8XCPUZ0NJScoctesW06S2
         ttid3jFlBfO4C/xM/6L/KY2Vm1ryJi418KOKiiqOk0jRBmtyG9bNQ9vSGrM9nu+mn2
         23I1e7BopQ4wdEQtwGXKNsp7AjvyDKtTLaIprruU=
Date:   Mon, 21 Jan 2019 09:13:04 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] mtd: rawnand: remove ->legacy.erase and
 single_erase()
Message-ID: <20190121091304.63673375@bbrezillon>
In-Reply-To: <1548052327-26483-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548052327-26483-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 15:32:07 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Now that the last user of this hook, denali.c, stopped using it,
> we can remove the erase hook from nand_legacy.
> 
> I squashed single_erase() because only the difference between
> single_erase() and nand_erase_op() is the number of bit shifts.
> 
> The status/ret conversion in nand_erase_nand() is unneeded since
> commit eb94555e9e97 ("mtd: nand: use usual return values for the
> ->erase() hook"). Cleaned it up now.

Yeah! One less field in nand_legacy :-). 

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> 
> This depends on the denali patch:
> http://patchwork.ozlabs.org/patch/1028264/
> 
> 
> Changes in v2:
>   - I noticed the masking by chip->pagemask is still needed
> 
>  drivers/mtd/nand/raw/nand_base.c | 31 ++++---------------------------
>  include/linux/mtd/rawnand.h      |  2 --
>  2 files changed, 4 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index cca4b24..7ea3f10 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4155,23 +4155,6 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
>  }
>  
>  /**
> - * single_erase - [GENERIC] NAND standard block erase command function
> - * @chip: NAND chip object
> - * @page: the page address of the block which will be erased
> - *
> - * Standard erase command for NAND chips. Returns NAND status.
> - */
> -static int single_erase(struct nand_chip *chip, int page)
> -{
> -	unsigned int eraseblock;
> -
> -	/* Send commands to erase a block */
> -	eraseblock = page >> (chip->phys_erase_shift - chip->page_shift);
> -
> -	return nand_erase_op(chip, eraseblock);
> -}
> -
> -/**
>   * nand_erase - [MTD Interface] erase block(s)
>   * @mtd: MTD device structure
>   * @instr: erase instruction
> @@ -4194,7 +4177,7 @@ static int nand_erase(struct mtd_info *mtd, struct erase_info *instr)
>  int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
>  		    int allowbbt)
>  {
> -	int page, status, pages_per_block, ret, chipnr;
> +	int page, pages_per_block, ret, chipnr;
>  	loff_t len;
>  
>  	pr_debug("%s: start = 0x%012llx, len = %llu\n",
> @@ -4246,17 +4229,11 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
>  		    (page + pages_per_block))
>  			chip->pagebuf = -1;
>  
> -		if (chip->legacy.erase)
> -			status = chip->legacy.erase(chip,
> -						    page & chip->pagemask);
> -		else
> -			status = single_erase(chip, page & chip->pagemask);
> -
> -		/* See if block erase succeeded */
> -		if (status) {
> +		ret = nand_erase_op(chip, (page & chip->pagemask) >>
> +				    (chip->phys_erase_shift - chip->page_shift));
> +		if (ret) {
>  			pr_debug("%s: failed erase, page 0x%08x\n",
>  					__func__, page);
> -			ret = -EIO;
>  			instr->fail_addr =
>  				((loff_t)page << chip->page_shift);
>  			goto erase_exit;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 33e240a..5e37534 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -936,7 +936,6 @@ static inline void nand_controller_init(struct nand_controller *nfc)
>   * @waitfunc: hardware specific function for wait on ready.
>   * @block_bad: check if a block is bad, using OOB markers
>   * @block_markbad: mark a block bad
> - * @erase: erase function
>   * @set_features: set the NAND chip features
>   * @get_features: get the NAND chip features
>   * @chip_delay: chip dependent delay for transferring data from array to read
> @@ -962,7 +961,6 @@ struct nand_legacy {
>  	int (*waitfunc)(struct nand_chip *chip);
>  	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
>  	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
> -	int (*erase)(struct nand_chip *chip, int page);
>  	int (*set_features)(struct nand_chip *chip, int feature_addr,
>  			    u8 *subfeature_para);
>  	int (*get_features)(struct nand_chip *chip, int feature_addr,

