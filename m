Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9590C2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9590C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeK0UZ1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:25:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59913 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbeK0UZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:25:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CF764207AD; Tue, 27 Nov 2018 10:28:07 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8721520736;
        Tue, 27 Nov 2018 10:27:57 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:27:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Message-ID: <20181127102757.6adc5649@xps13>
In-Reply-To: <9365718c-4993-7e3b-1519-8fef0c08c0db@kontron.de>
References: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
        <20181127092232.3a6d1661@bbrezillon>
        <9365718c-4993-7e3b-1519-8fef0c08c0db@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Tue, 27 Nov
2018 08:30:24 +0000:

> On 27.11.18 09:22, Boris Brezillon wrote:
> > On Tue, 27 Nov 2018 07:44:52 +0000
> > Schrempf Frieder <frieder.schrempf@kontron.de> wrote:
> >   
> >> Fix the size of the buffer allocated to store the in-memory BBT.
> >> This bug was previously hidden by a different bug, that was fixed in
> >> d098093ba06e.  
> > 
> > Oops :-/.
> >   
> >>
> >> Fixes: 9c3736a3de21 ("mtd: nand: Add core infrastructure to deal with NAND devices")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >> ---
> >>   drivers/mtd/nand/bbt.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
> >> index 56cde38..c12497f 100644
> >> --- a/drivers/mtd/nand/bbt.c
> >> +++ b/drivers/mtd/nand/bbt.c
> >> @@ -27,7 +27,8 @@ int nanddev_bbt_init(struct nand_device *nand)
> >>   	unsigned int nwords = DIV_ROUND_UP(nblocks * bits_per_block,
> >>   					   BITS_PER_LONG);
> >>   
> >> -	nand->bbt.cache = kzalloc(nwords, GFP_KERNEL);
> >> +	nand->bbt.cache = kzalloc(nwords * (BITS_PER_LONG / BITS_PER_BYTE),  
> > 
> > I prefer
> > 
> > 					 * sizeof(*nand->bbt.cache)
> > If you're okay with this change, I'll fix it when applying (no need to
> > send a new version).  
> 
> Sure, that's ok.

I also prefer with the sizeof() operator. Thanks for fixing this!

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
