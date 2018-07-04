Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E39C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02907241C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02907241C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbeGDIZo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:25:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38292 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932290AbeGDIZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:25:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B64F120787; Wed,  4 Jul 2018 10:25:40 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6FEAB2084E;
        Wed,  4 Jul 2018 10:25:30 +0200 (CEST)
Date:   Wed, 4 Jul 2018 10:25:31 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Peter Pan <peterpandong@micron.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] mtd: spinand: Fix missing unlock on error path
Message-ID: <20180704102531.7af9a2e6@bbrezillon>
In-Reply-To: <1530692979-6274-1-git-send-email-weiyongjun1@huawei.com>
References: <1530692979-6274-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 08:29:39 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Add the missing unlock before return from function
> spinand_mtd_(read|write) in the error handling case.
> 
> Fixes: c898e0526fb6 ("mtd: nand: Add core infrastructure to support SPI NANDs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/mtd/nand/spi/core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 17d207a..8ac1ba95 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -560,12 +560,16 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>  
>  	nanddev_io_for_each_page(nand, from, ops, &iter) {
>  		ret = spinand_select_target(spinand, iter.req.pos.target);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&spinand->lock);
>  			return ret;
> +		}

Why not
		if (ret)
			break;

?

>  
>  		ret = spinand_ecc_enable(spinand, enable_ecc);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&spinand->lock);
>  			return ret;
> +		}

Ditto.

>  
>  		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
>  		if (ret < 0 && ret != -EBADMSG)
> @@ -609,11 +613,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
>  	nanddev_io_for_each_page(nand, to, ops, &iter) {
>  		ret = spinand_select_target(spinand, iter.req.pos.target);
>  		if (ret)
> -			return ret;
> +			break;
>  
>  		ret = spinand_ecc_enable(spinand, enable_ecc);
>  		if (ret)
> -			return ret;
> +			break;
>  
>  		ret = spinand_write_page(spinand, &iter.req);
>  		if (ret)
> 
