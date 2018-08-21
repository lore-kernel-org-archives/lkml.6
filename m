Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE659C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BE021581
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BE021581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeHUMBv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:01:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35563 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeHUMBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:01:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EB09F20711; Tue, 21 Aug 2018 10:42:33 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id A17342072C;
        Tue, 21 Aug 2018 10:42:23 +0200 (CEST)
Date:   Tue, 21 Aug 2018 10:42:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: denali: do not pass zero maxchips to
 nand_scan()
Message-ID: <20180821104224.6aafb0bd@xps13>
In-Reply-To: <1534839799-14112-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534839799-14112-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 21 Aug
2018 17:23:19 +0900:

> Commit 49aa76b16676 ("mtd: rawnand: do not execute nand_scan_ident()
> if maxchips is zero") gave a new meaning for calling nand_scan_ident()
> with maxchips=0.
> 
> It is a special usage for some drivers such as docg4, but in fact
> the Denali driver may pass maxchips=0 to nand_scan() when the driver
> is enabled but no NAND chip is found on the board for some reasons.
> 
> If nand_scan_with_ids() is called with maxchips=0, nand_scan_ident()
> is skipped, i.e. nand_set_defaults() is skipped.  Therefore, the
> driver must have set chip->controller beforehand.  Otherwise,
> nand_attach() causes NULL pointer dereference.
> 
> In fact, the Denali controller knows the number of connected chips
> before calling nand_scan_ident(); if DEVICE_RESET fails, there is no
> chip in that chip select.  Then, denali_reset_banks() sets the maxchips
> to the number of detected chips.  If no chip is found, it is zero.
> 
> The reason of this trick was, as commit f486287d2372 ("mtd: nand:
> denali: fix bank reset function to detect the number of chips")
> explained, nand_scan_ident() issued Set Features (0xEF) command
> to all CS lines, some of which may not be connected with a chip.
> Then, the driver would wait until R/B# response, which never happens.
> 
> This problem was solved by commit 107b7d6a7ad4 ("mtd: rawnand: avoid
> setting again the timings to mode 0 after a reset").  In the current
> code, nand_setup_data_interface() is called from nand_scan_tail(),
> which is after the chip detection is done.
> 
> Remove the code that is causing NULL pointer dereference.  Now, the
> maxchips passed to nand_scan() is the maximum number of chip selects
> supported by the IP (typically 4 or 8).  Leave all the chip detection
> process to nand_scan_ident().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks for the fix.

Actually the docg4 driver is getting removed and the special handling
in nand_scan() about having 0 maxchips will also disappear.
Nonetheless, I think the below code was buggy and I would like to apply
the fix anyway.

> ---
> 
>  drivers/mtd/nand/raw/denali.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index ca18612..3e4b8e1 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -1086,7 +1086,6 @@ static void denali_reset_banks(struct denali_nand_info *denali)
>  	}
>  
>  	dev_dbg(denali->dev, "%d chips connected\n", i);
> -	denali->max_banks = i;
>  }
>  
>  static void denali_hw_init(struct denali_nand_info *denali)

Thanks,
Miquèl
