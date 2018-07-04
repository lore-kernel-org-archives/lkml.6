Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5AFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B2A24137
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B2A24137
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933898AbeGDI2n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:28:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38415 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932363AbeGDI2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:28:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2BA95207F4; Wed,  4 Jul 2018 10:28:39 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id CBA9D207BD;
        Wed,  4 Jul 2018 10:28:28 +0200 (CEST)
Date:   Wed, 4 Jul 2018 10:28:29 +0200
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
Subject: Re: [PATCH -next] mtd: spinand: Fix error return code in
 spinand_init()
Message-ID: <20180704102829.6b29c6cb@bbrezillon>
In-Reply-To: <1530693298-14271-1-git-send-email-weiyongjun1@huawei.com>
References: <1530693298-14271-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 08:34:58 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Fix to return error code -ENOMEM from the kzalloc() error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: c898e0526fb6 ("mtd: nand: Add core infrastructure to support SPI NANDs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/spi/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 17d207a..011683e 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -985,8 +985,10 @@ static int spinand_init(struct spinand_device *spinand)
>  	spinand->databuf = kzalloc(nanddev_page_size(nand) +
>  			       nanddev_per_page_oobsize(nand),
>  			       GFP_KERNEL);
> -	if (!spinand->databuf)
> +	if (!spinand->databuf) {
> +		ret = -ENOMEM;
>  		goto err_free_bufs;
> +	}
>  
>  	spinand->oobbuf = spinand->databuf + nanddev_page_size(nand);
> 

