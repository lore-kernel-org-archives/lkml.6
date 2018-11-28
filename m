Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA95C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45864206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45864206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeK2BnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:43:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34139 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeK2BnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:43:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BD351209A7; Wed, 28 Nov 2018 15:41:21 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9A36E20791;
        Wed, 28 Nov 2018 15:41:04 +0100 (CET)
Date:   Wed, 28 Nov 2018 15:41:04 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Message-ID: <20181128154104.577d5923@bbrezillon>
In-Reply-To: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
References: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 07:44:52 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> Fix the size of the buffer allocated to store the in-memory BBT.
> This bug was previously hidden by a different bug, that was fixed in
> d098093ba06e.
> 
> Fixes: 9c3736a3de21 ("mtd: nand: Add core infrastructure to deal with NAND devices")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Looks like your From header does not match the SoB tag
('Frieder Schrempf' vs 'Schrempf Frieder') and checkpatch does not like
that. I'll fix it when applying, but maybe you should fix
your .gitconfig to make them match.

> ---
>  drivers/mtd/nand/bbt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
> index 56cde38..c12497f 100644
> --- a/drivers/mtd/nand/bbt.c
> +++ b/drivers/mtd/nand/bbt.c
> @@ -27,7 +27,8 @@ int nanddev_bbt_init(struct nand_device *nand)
>  	unsigned int nwords = DIV_ROUND_UP(nblocks * bits_per_block,
>  					   BITS_PER_LONG);
>  
> -	nand->bbt.cache = kzalloc(nwords, GFP_KERNEL);
> +	nand->bbt.cache = kzalloc(nwords * (BITS_PER_LONG / BITS_PER_BYTE),
> +				  GFP_KERNEL);
>  	if (!nand->bbt.cache)
>  		return -ENOMEM;
>  

