Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eAFXGyRCHltZeAAAmS7hNA
	; Mon, 11 Jun 2018 09:49:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 50190607BB; Mon, 11 Jun 2018 09:49:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A358260351;
	Mon, 11 Jun 2018 09:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A358260351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeFKJtU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:49:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47381 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932453AbeFKJtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:49:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C3DDE207A5; Mon, 11 Jun 2018 11:49:16 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6461B203D9;
        Mon, 11 Jun 2018 11:49:16 +0200 (CEST)
Date: Mon, 11 Jun 2018 11:49:16 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc: linux-mtd@lists.infradead.org, boris.brezillon@free-electrons.com,
        frieder.schrempf@exceet.de, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        marek.vasut@gmail.com, prabhakar.kushwaha@nxp.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>
Subject: Re: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Message-ID: <20180611114916.351ed272@bbrezillon>
In-Reply-To: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

Unrelated note: no need to send your patches to both
boris.brezillo@free-electrons.com and boris.brezillo@bootlin.com, just
use the latter.

On Mon, 11 Jun 2018 14:48:14 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Honour max_data_size for spi-nor writes

^ This is no longer relevant.

> In new spi-mem framework, data size to be written is being calculated
> using spi_mem_adjust_op_size().
> This can return value less than nor->page_size.
> 
> Add check value of data size return from API spi_mem_adjust_op_size()
> with the actual requested data size and write, max, only supported
> data size.

This part is not clear.

Also, I'd prefer to have this patch split in 2:
1/ one patch removing the check in spi_nor_write()
2/ and the second patch removing the while() loop in m25p80_write()

How about the following commit messages for those 2 patches:

1:
"
mtd: spi-nor: Support controllers with limited TX FIFO size

Some SPI controllers can't write nor->page_size bytes in a single step
because their TX FIFO is too small.

Allow nor->write() to return a size that is smaller than the requested
write size to gracefully handle this case.
"

2:
"
mtd: devices: m25p80: Make sure WRITE_EN is issued before each write

Some SPI controllers can't write nor->page_size bytes in a single step
because their TX FIFO is too small, but when that happens we should
make sure a WRITE_EN command is issued before each write access.

The core is already taking care of that, so all we have to do here is
return the actual number of bytes that were written during the
spi_mem_exec_op() operation.
"

> 
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  drivers/mtd/devices/m25p80.c  | 23 ++++++++---------------
>  drivers/mtd/spi-nor/spi-nor.c |  7 -------
>  2 files changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index e84563d..60224fe 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -72,7 +72,6 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
>  				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
>  				   SPI_MEM_OP_DUMMY(0, 1),
>  				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
> -	size_t remaining = len;
>  	int ret;
>  
>  	/* get transfer protocols. */
> @@ -84,22 +83,16 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
>  	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
>  		op.addr.nbytes = 0;
>  
> -	while (remaining) {
> -		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
> -		ret = spi_mem_adjust_op_size(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> -
> -		ret = spi_mem_exec_op(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> +	ret = spi_mem_adjust_op_size(flash->spimem, &op);
> +	if (ret)
> +		return ret;
> +	op.data.nbytes = len < op.data.nbytes ? len : op.data.nbytes;
>  
> -		op.addr.val += op.data.nbytes;
> -		remaining -= op.data.nbytes;
> -		op.data.buf.out += op.data.nbytes;
> -	}
> +	ret = spi_mem_exec_op(flash->spimem, &op);
> +	if (ret)
> +		return ret;
>  
> -	return len;
> +	return op.data.nbytes;
>  }
>  
>  /*
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 5bfa36e..3e63543 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  			goto write_err;
>  		*retlen += written;
>  		i += written;
> -		if (written != page_remain) {
> -			dev_err(nor->dev,
> -				"While writing %zu bytes written %zd bytes\n",
> -				page_remain, written);
> -			ret = -EIO;
> -			goto write_err;
> -		}
>  	}
>  
>  write_err:
