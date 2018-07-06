Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE34FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F20F24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F20F24001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeGFNi2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:38:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58260 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932362AbeGFNi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:38:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A399C2082B; Fri,  6 Jul 2018 15:38:24 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 71284207D4;
        Fri,  6 Jul 2018 15:38:14 +0200 (CEST)
Date:   Fri, 6 Jul 2018 15:38:15 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: Fix direct mode write
 timeouts
Message-ID: <20180706153815.741e2403@bbrezillon>
In-Reply-To: <20180630105421.550-1-vigneshr@ti.com>
References: <20180630105421.550-1-vigneshr@ti.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018 16:24:21 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Sometimes when writing large size files to flash in direct/memory mapped
> mode, it is seen that flash write enable command times out with error:
> [  503.146293] cadence-qspi 47040000.ospi: Flash command execution timed out.
> 
> This is because, we need to make sure previous direct write operation
> is complete by polling for IDLE bit in CONFIG_REG before starting the
> next operation.
> 
> Fix this by polling for IDLE bit after memory mapped write.
> 
> Fixes: a27f2eaf2b27 ("mtd: spi-nor: cadence-quadspi: Add support for direct access mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index c3f7aaa5d18f..d7e10b36a0b9 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -926,10 +926,12 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
>  	if (ret)
>  		return ret;
>  
> -	if (f_pdata->use_direct_mode)
> +	if (f_pdata->use_direct_mode) {
>  		memcpy_toio(cqspi->ahb_base + to, buf, len);
> -	else
> +		ret = cqspi_wait_idle(cqspi);
> +	} else {
>  		ret = cqspi_indirect_write_execute(nor, to, buf, len);
> +	}
>  	if (ret)
>  		return ret;
>  

