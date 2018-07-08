Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D8C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 12:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2017E208A3
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 12:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2017E208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933053AbeGHMEw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 08:04:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34059 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932892AbeGHMEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 08:04:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D597C20737; Sun,  8 Jul 2018 14:04:48 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 96CAF203B4;
        Sun,  8 Jul 2018 14:04:48 +0200 (CEST)
Date:   Sun, 8 Jul 2018 14:04:49 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: rawnand: docg4: specify bits_per_cell
Message-ID: <20180708140449.31efdc59@bbrezillon>
In-Reply-To: <48cec9b431a42375cd9033b225f3573002574f17.1531045014.git.cerg2010cerg2010@mail.ru>
References: <cover.1531045014.git.cerg2010cerg2010@mail.ru>
        <48cec9b431a42375cd9033b225f3573002574f17.1531045014.git.cerg2010cerg2010@mail.ru>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Jul 2018 14:29:24 +0300
Sergey Larin <cerg2010cerg2010@mail.ru> wrote:

> This fixes WARN() in nand_is_slc().
> 
> DoC G4 is 2-bit MLC, so set bits_per_cell value according to this.

What you do here implies "no UBI on docg4". To be honest, I'm pretty
sure there's an FTL in there, which clearly does not make it a good
candidate for the raw NAND framework. Not to mention that it's not even
using the same instruction set which forced developers of this driver
to guess what the core was trying to do in the ->cmdfunc()
implementation and convert it to docg4 operations. This approach is
going against the recent evolution of the raw NAND framework
(deprecating ->cmdfunc() in favor of ->exec_op()).

I'd really like to see this driver moved outside of
drivers/mtd/nand/raw/. If it really has NAND constraints, you could
re-use the interface agnostic NAND framework (include/linux/nand.h) and
add a new driver under drivers/mtd/nand/diskonchip/docg4.c.

That's the very reason I asked if you if you had access to this HW. I
can help you with the development part, but I can't test.

> 
> Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
> ---
>  drivers/mtd/nand/raw/docg4.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
> index bbed8ea7858c..82d97a16e246 100644
> --- a/drivers/mtd/nand/raw/docg4.c
> +++ b/drivers/mtd/nand/raw/docg4.c
> @@ -1250,6 +1250,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
>  	nand->pagemask = 0x3ffff;
>  	nand->badblockpos = NAND_LARGE_BADBLOCK_POS;
>  	nand->badblockbits = 8;
> +	nand->bits_per_cell = 2;
>  	nand->ecc.mode = NAND_ECC_HW_SYNDROME;
>  	nand->ecc.size = DOCG4_PAGE_SIZE;
>  	nand->ecc.prepad = 8;

