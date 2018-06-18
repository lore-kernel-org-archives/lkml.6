Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CD9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78FF208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78FF208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934109AbeFRN6C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:58:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38181 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933659AbeFRN6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:58:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3C62020798; Mon, 18 Jun 2018 15:57:58 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id E27F520703;
        Mon, 18 Jun 2018 15:57:57 +0200 (CEST)
Date:   Mon, 18 Jun 2018 15:57:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Abhishek Sahu <absahu@codeaurora.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, <stable@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: fix return value check for bad block
 status
Message-ID: <20180618155757.6cbe0fae@xps13>
In-Reply-To: <1528880556-20348-1-git-send-email-absahu@codeaurora.org>
References: <1528880556-20348-1-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Wed, 13 Jun 2018 14:32:36 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> Positive return value from read_oob() is making false BAD
> blocks. For some of the NAND controllers, OOB bytes will be
> protected with ECC and read_oob() will return number of bitflips.
> If there is any bitflip in ECC protected OOB bytes for BAD block
> status page, then that block is getting treated as BAD.
> 
> Fixes: c120e75e0e7d ("mtd: nand: use read_oob() instead of cmdfunc() for bad block check")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index f28c3a5..4a73f73 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -440,7 +440,7 @@ static int nand_block_bad(struct mtd_info *mtd, loff_t ofs)
>  
>  	for (; page < page_end; page++) {
>  		res = chip->ecc.read_oob(mtd, chip, page);
> -		if (res)
> +		if (res < 0)
>  			return res;
>  
>  		bad = chip->oob_poi[chip->badblockpos];

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

I suppose this patch is a good candidate to be part of a future
mtd/fixes PR?

Regards,
Miquèl
