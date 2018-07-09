Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447B8C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B0120873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B0120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeGIQML (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:12:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33817 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754538AbeGIQMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:12:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EA85B20876; Mon,  9 Jul 2018 18:12:07 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 90EF12079F;
        Mon,  9 Jul 2018 18:12:07 +0200 (CEST)
Date:   Mon, 9 Jul 2018 18:12:06 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: rawnand: davinci: fix build testing on 64-bit
Message-ID: <20180709181206.3422a8fb@bbrezillon>
In-Reply-To: <20180709155730.2422841-1-arnd@arndb.de>
References: <20180709155730.2422841-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon,  9 Jul 2018 17:57:02 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Now that we can build this driver everywhere, we run into a couple
> of warnings like:
> 
> drivers/mtd/nand/raw/davinci_nand.c: In function 'nand_davinci_correct_4bit':
> drivers/mtd/nand/raw/davinci_nand.c:322:21: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> 
> In all cases, this is harmless and we just need to cast to an uintptr_t
> rather than an unsigned 32-bit integer.
> 
> Fixes: 347af8918e8a ("mtd: rawnand: davinci: Allow selection of this driver when COMPILE_TEST=y")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Actually, I have all those fixes in my nand/api-cleanup branch [1]. I
was planning on sending a v2 of my COMPILE_TEST series to address
those problems before activating COMPILE_TEST on those drivers (Miquel
already dropped the patches activating COMPILE_TEST on sunxi, davinci
and atmel).

Regards,

Boris

[1]https://github.com/bbrezillon/linux-0day/commits/nand/api-cleanup

> ---
>  drivers/mtd/nand/raw/davinci_nand.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
> index cd12e5abafde..c638bd60eb0b 100644
> --- a/drivers/mtd/nand/raw/davinci_nand.c
> +++ b/drivers/mtd/nand/raw/davinci_nand.c
> @@ -102,7 +102,7 @@ static void nand_davinci_hwcontrol(struct mtd_info *mtd, int cmd,
>  				   unsigned int ctrl)
>  {
>  	struct davinci_nand_info	*info = to_davinci_nand(mtd);
> -	uint32_t			addr = info->current_cs;
> +	uintptr_t			addr = info->current_cs;
>  	struct nand_chip		*nand = mtd_to_nand(mtd);
>  
>  	/* Did the control lines change? */
> @@ -122,7 +122,7 @@ static void nand_davinci_hwcontrol(struct mtd_info *mtd, int cmd,
>  static void nand_davinci_select_chip(struct mtd_info *mtd, int chip)
>  {
>  	struct davinci_nand_info	*info = to_davinci_nand(mtd);
> -	uint32_t			addr = info->ioaddr;
> +	uintptr_t			addr = info->ioaddr;
>  
>  	/* maybe kick in a second chipselect */
>  	if (chip > 0)
> @@ -319,7 +319,7 @@ static int nand_davinci_correct_4bit(struct mtd_info *mtd,
>  	/* Unpack ten bytes into eight 10 bit values.  We know we're
>  	 * little-endian, and use type punning for less shifting/masking.
>  	 */
> -	if (WARN_ON(0x01 & (unsigned) ecc_code))
> +	if (WARN_ON(0x01 & (uintptr_t)ecc_code))
>  		return -EINVAL;
>  	ecc16 = (unsigned short *)ecc_code;
>  
> @@ -441,9 +441,9 @@ static void nand_davinci_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
>  {
>  	struct nand_chip *chip = mtd_to_nand(mtd);
>  
> -	if ((0x03 & ((unsigned)buf)) == 0 && (0x03 & len) == 0)
> +	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
>  		ioread32_rep(chip->IO_ADDR_R, buf, len >> 2);
> -	else if ((0x01 & ((unsigned)buf)) == 0 && (0x01 & len) == 0)
> +	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
>  		ioread16_rep(chip->IO_ADDR_R, buf, len >> 1);
>  	else
>  		ioread8_rep(chip->IO_ADDR_R, buf, len);
> @@ -454,9 +454,9 @@ static void nand_davinci_write_buf(struct mtd_info *mtd,
>  {
>  	struct nand_chip *chip = mtd_to_nand(mtd);
>  
> -	if ((0x03 & ((unsigned)buf)) == 0 && (0x03 & len) == 0)
> +	if ((0x03 & ((uintptr_t)buf)) == 0 && (0x03 & len) == 0)
>  		iowrite32_rep(chip->IO_ADDR_R, buf, len >> 2);
> -	else if ((0x01 & ((unsigned)buf)) == 0 && (0x01 & len) == 0)
> +	else if ((0x01 & ((uintptr_t)buf)) == 0 && (0x01 & len) == 0)
>  		iowrite16_rep(chip->IO_ADDR_R, buf, len >> 1);
>  	else
>  		iowrite8_rep(chip->IO_ADDR_R, buf, len);
> @@ -680,7 +680,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
>  	info->chip.bbt_md	= pdata->bbt_md;
>  	info->timing		= pdata->timing;
>  
> -	info->ioaddr		= (uint32_t __force) vaddr;
> +	info->ioaddr		= (uintptr_t __force) vaddr;
>  
>  	info->current_cs	= info->ioaddr;
>  	info->core_chipsel	= pdata->core_chipsel;

