Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F30DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B60B20652
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B60B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeH0Wc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:32:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49677 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbeH0Wc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:32:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7185F2079D; Mon, 27 Aug 2018 20:45:11 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3D931208C7;
        Mon, 27 Aug 2018 20:44:39 +0200 (CEST)
Date:   Mon, 27 Aug 2018 20:44:35 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mtd: rawnand: docg4: Remove wrong __init annotations
Message-ID: <20180827204435.0ecfcacf@bbrezillon>
In-Reply-To: <20180823214345.20949-1-geert@linux-m68k.org>
References: <20180823214345.20949-1-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 23:43:45 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> If gcc (e.g. 4.1.2) decides not to inline init_mtd_structs() and
> read_id_reg(), this will cause section mismatches, and crashes:
> 
>     WARNING: drivers/mtd/nand/raw/docg4.o(.text+0xc10): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:init_mtd_structs()
>     The function docg4_attach_chip() references
>     the function __init init_mtd_structs().
>     This is often because docg4_attach_chip lacks a __init
>     annotation or the annotation of init_mtd_structs is wrong.
> 
>     WARNING: drivers/mtd/nand/raw/docg4.o(.text+0xc3e): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:read_id_reg()
>     The function docg4_attach_chip() references
>     the function __init read_id_reg().
>     This is often because docg4_attach_chip lacks a __init
>     annotation or the annotation of read_id_reg is wrong.
> 
> Fix this by dropping the now incorrect __init annotations from
> init_mtd_structs() and read_id_reg().
> 
> Fixes: 66a38478dcc5b5a3 ("mtd: rawnand: docg4: convert driver to nand_scan()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Queued to mtd/master.

Thanks,

Boris

> ---
>  drivers/mtd/nand/raw/docg4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
> index a3f04315c05c54e6..427fcbc1b71c0551 100644
> --- a/drivers/mtd/nand/raw/docg4.c
> +++ b/drivers/mtd/nand/raw/docg4.c
> @@ -1218,7 +1218,7 @@ static int docg4_resume(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static void __init init_mtd_structs(struct mtd_info *mtd)
> +static void init_mtd_structs(struct mtd_info *mtd)
>  {
>  	/* initialize mtd and nand data structures */
>  
> @@ -1290,7 +1290,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
>  
>  }
>  
> -static int __init read_id_reg(struct mtd_info *mtd)
> +static int read_id_reg(struct mtd_info *mtd)
>  {
>  	struct nand_chip *nand = mtd_to_nand(mtd);
>  	struct docg4_priv *doc = nand_get_controller_data(nand);

