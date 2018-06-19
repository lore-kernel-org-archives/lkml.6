Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB025C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6BF2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6BF2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937321AbeFSE4A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:56:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56466 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937085AbeFSEz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:55:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B14D5207D4; Tue, 19 Jun 2018 06:55:56 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7AA1A2079D;
        Tue, 19 Jun 2018 06:55:56 +0200 (CEST)
Date:   Tue, 19 Jun 2018 06:55:55 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Message-ID: <20180619065555.1900487c@bbrezillon>
In-Reply-To: <0caaea1b4f5a4b45b436833424c4c8c8@svr-chch-ex1.atlnz.lc>
References: <20180618045255.8015-1-chris.packham@alliedtelesis.co.nz>
        <20180618151450.3e740270@xps13>
        <f16525ea6b534123bda64b09e818ce6d@svr-chch-ex1.atlnz.lc>
        <0caaea1b4f5a4b45b436833424c4c8c8@svr-chch-ex1.atlnz.lc>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, 19 Jun 2018 01:44:24 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> On 19/06/18 12:35, Chris Packham wrote:
> > On 19/06/18 01:15, Miquel Raynal wrote:  
> >> Hi Chris,
> >>
> >> On Mon, 18 Jun 2018 16:52:53 +1200, Chris Packham
> >> <chris.packham@alliedtelesis.co.nz> wrote:
> >>  
> >>> Hi,
> >>>
> >>> I'm looking at adding support for the Micron MT29F1G08ABAFAWP-ITE:F chip
> >>> to one of our boards which uses the Marvell NFCv2 controller.
> >>>
> >>> This particular chip is a bit odd in that the datasheet states support
> >>> for ONFI 1.0 but the revision number field is 00 00. It also is marked
> >>> ABAFA but reports internally as ABAGA. Finally it has internal 8-bit ECC
> >>> which cannot be disabled.  
> >>
> >> Boris and I agree that in this case, the chip should not be probed if
> >> ecc->type != ON_DIE (and eventually NONE).
> >>
> >> This should be handled in the Micron driver.
> >>
> >> Also, what is the returned value of micron_supports_on_die_ecc() (with
> >> patch 1/2)?  
> > 
> > micron_supports_on_die_ecc() returns MICRON_ON_DIE_UNSUPPORTED.
> > Technically this chip should be MICRON_ON_DIE_MANDATORY since it can't
> > be disabled but that wouldn't be much help since that would still result
> > in -EINVAL. I'll dig into micron_supports_on_die_ecc() and see if I can
> > find something in the datasheet to use.
> >   
> 
> Some further debugging. Nothing (in 4.17) calls 
> set_bit(ONFI_FEATURE_ON_DIE_ECC) so I don't think 
> micron_supports_on_die_ecc() can return anything other than 
> MICRON_ON_DIE_UNSUPPORTED, unless I'm missing something for how the 
> {get,set}_feature_list is populated.

Nope you're not. Looks like we broke Micron on-die ECC in 4.17.

> 
> With the onfi.version fix and the following
> 
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -66,7 +66,9 @@ static int micron_nand_onfi_init(struct nand_chip *chip)
> 
>          if (p->supports_set_get_features) {
>                  set_bit(ONFI_FEATURE_ADDR_READ_RETRY, p->set_feature_list);
> +               set_bit(ONFI_FEATURE_ON_DIE_ECC, p->set_feature_list);
>                  set_bit(ONFI_FEATURE_ADDR_READ_RETRY, p->get_feature_list);
> +               set_bit(ONFI_FEATURE_ON_DIE_ECC, p->get_feature_list);
>          }

Can you send a patch containing only the above changes with the
Cc-stable and Fixes tags?

> @@ -240,7 +246,7 @@ static int micron_supports_on_die_ecc(struct 
> nand_chip *chip)
>           * Some Micron NANDs have an on-die ECC of 4/512, some other
> -         * 8/512. We only support the former.
> +         * 8/512.
>           */
> -       if (chip->ecc_strength_ds != 4)
> +       if (chip->ecc_strength_ds != 4 && chip->ecc_strength_ds != 8)
>                  return MICRON_ON_DIE_UNSUPPORTED;
>

This should be done in a separate patch.
 
> I can get micron_supports_on_die_ecc() to return MICRON_ON_DIE_SUPPORTED.
> 

That's weird. You should have MICRON_ON_DIE_MANDATORY here. Could it be
that the ONFI_FEATURE_ON_DIE_ECC_EN bit does not really reflect the ECC
engine state? If that's the case, we'll have to change the way we
detect if on-die ECC is supported/mandatory/not-supported (based on the
model name stored in the ONFI param page?).

> Then I run into a problem with the marvell_nand.c which currently 
> doesn't handle NAND_ECC_ON_DIE which is easily fixed.

Yep, adding that to the new driver should be pretty easy.

> 
> But then I have the issue that I need to handle systems with either type 
> of ECC scheme ("on-die" or "hw") which I'm not sure is even possible 
> within the dts.

You mean having the same dts for both setup. Indeed, that's not
supported right now.

> 
> I'll re-base against 4.18-rc1 and send what I have so-far.

Cool. I'm particularly interested by the SET/GET_FEATURE(ECC) fix.

Thanks,

Boris
