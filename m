Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id k8KqETcnGVtldQAAmS7hNA
	; Thu, 07 Jun 2018 12:38:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5827A608C1; Thu,  7 Jun 2018 12:38:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B9181607E7;
	Thu,  7 Jun 2018 12:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9181607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeFGMiN convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 08:38:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42414 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753078AbeFGMiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:38:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 342432075D; Thu,  7 Jun 2018 14:38:10 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id CC5B120012;
        Thu,  7 Jun 2018 14:37:59 +0200 (CEST)
Date: Thu, 7 Jun 2018 14:37:59 +0200
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
        Archit Taneja <architt@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 01/16] mtd: rawnand: helper function for setting up
 ECC configuration
Message-ID: <20180607143759.361edb3f@xps13>
In-Reply-To: <44d4939cf8411a0dc693b8dd11fb57c7@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-2-git-send-email-absahu@codeaurora.org>
        <20180526095807.5caf5800@xps13>
        <44d4939cf8411a0dc693b8dd11fb57c7@codeaurora.org>
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

On Mon, 28 May 2018 11:16:29 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> On 2018-05-26 14:12, Miquel Raynal wrote:
> > Hi Abhishek,  
> > > On Fri, 25 May 2018 17:51:29 +0530, Abhishek Sahu  
> > <absahu@codeaurora.org> wrote:  
> > >> commit 2c8f8afa7f92 ("mtd: nand: add generic helpers to check,  
> >> match, maximize ECC settings") provides generic helpers which
> >> drivers can use for setting up ECC parameters.  
> >> >> Since same board can have different ECC strength nand chips so  
> >> following is the logic for setting up ECC strength and ECC step
> >> size, which can be used by most of the drivers.  
> >> >> 1. If both ECC step size and ECC strength are already set  
> >>    (usually by DT) then just check whether this setting
> >>    is supported by NAND controller.
> >> 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength
> >>    supported by NAND controller.
> >> 3. Otherwise, try to match the ECC step size and ECC strength closest
> >>    to the chip's requirement. If available OOB size can't fit the chip
> >>    requirement then select maximum ECC strength which can be fit with
> >>    available OOB size.  
> >> >> This patch introduces nand_ecc_choose_conf function which calls the  
> >> required helper functions for the above logic. The drivers can use
> >> this single function instead of calling the 3 helper functions
> >> individually.  
> >> >> CC: Masahiro Yamada <yamada.masahiro@socionext.com>  
> >> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> >> ---
> >> * Changes from v2:  
> >> >>   1. Renamed function to nand_ecc_choose_conf.  
> >>   2. Minor code reorganization to remove warning and 2 function calls
> >>      for nand_maximize_ecc.  
> >> >> * Changes from v1:  
> >>   NEW PATCH  
> >> >>  drivers/mtd/nand/raw/nand_base.c | 42 >> ++++++++++++++++++++++++++++++++++++++++  
> >>  drivers/mtd/nand/raw/nand_base.c | 31 +++++++++++++++++++++++++++++++
> >>  include/linux/mtd/rawnand.h      |  3 +++
> >>  2 files changed, 34 insertions(+)  
> >> >> diff --git a/drivers/mtd/nand/raw/nand_base.c >> b/drivers/mtd/nand/raw/nand_base.c  
> >> index 72f3a89..e52019d 100644
> >> --- a/drivers/mtd/nand/raw/nand_base.c
> >> +++ b/drivers/mtd/nand/raw/nand_base.c
> >> @@ -6249,6 +6249,37 @@ int nand_maximize_ecc(struct nand_chip *chip,
> >>  }
> >>  EXPORT_SYMBOL_GPL(nand_maximize_ecc);  
> >> >> +/**  
> >> + * nand_ecc_choose_conf - Set the ECC strength and ECC step size
> >> + * @chip: nand chip info structure
> >> + * @caps: ECC engine caps info structure
> >> + * @oobavail: OOB size that the ECC engine can use
> >> + *
> >> + * Choose the ECC configuration according to following logic
> >> + *
> >> + * 1. If both ECC step size and ECC strength are already set (usually >> by DT)
> >> + *    then check if it is supported by this controller.
> >> + * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
> >> + * 3. Otherwise, try to match the ECC step size and ECC strength >> closest
> >> + *    to the chip's requirement. If available OOB size can't fit the >> chip
> >> + *    requirement then fallback to the maximum ECC step size and ECC >> strength.
> >> + *
> >> + * On success, the chosen ECC settings are set.
> >> + */
> >> +int nand_ecc_choose_conf(struct nand_chip *chip,
> >> +			 const struct nand_ecc_caps *caps, int oobavail)
> >> +{
> >> +	if (chip->ecc.size && chip->ecc.strength)
> >> +		return nand_check_ecc_caps(chip, caps, oobavail);
> >> +
> >> +	if (!(chip->ecc.options & NAND_ECC_MAXIMIZE) &&
> >> +	    !nand_match_ecc_req(chip, caps, oobavail))
> >> +		return 0;
> >> +
> >> +	return nand_maximize_ecc(chip, caps, oobavail);
> > > I personally don't mind if nand_maximize_ecc() is called twice in  
> > the function if it clarifies the logic. Maybe the following will be
> > more clear for the user?  
> 
>   Thanks Miquel.
>   Both the implementations are fine.
>   The above implementation (which was in Denali NAND driver) code was also
>   clear. We can go for any of these implementation.
> 
>   Shall I update this ?

Yes, please :)

> 
> > > 	if (chip->ecc.size && chip->ecc.strength)  
> > 		return nand_check_ecc_caps(chip, caps, oobavail);  
> > > 	if (chip->ecc.options & NAND_ECC_MAXIMIZE)  
> > 		return nand_maximize_ecc(chip, caps, oobavail);  
> > > 	if (!nand_match_ecc_req(chip, caps, oobavail))  
> > 		return 0;  
> > > 	return nand_maximize_ecc(chip, caps, oobavail);
> > > Also, I'm not sure we should just error out when nand_check_ecc_caps()  
> > fails. What about something more robust, like:
> >   
>   But again, It will lead in overriding the DT ECC strength parameter.
>   We started our discussion from that point. :-)

As Boris said, let's error out instead of overriding the DT ECC
parameters.


Thanks,
Miquèl
