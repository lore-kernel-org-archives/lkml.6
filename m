Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbeD3ONi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:13:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52719 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753794AbeD3ONh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:13:37 -0400
Date: Mon, 30 Apr 2018 16:13:35 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Kees Cook <keescook@chromium.org>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] mtd: nftl: Remove VLA usage
Message-ID: <20180430161335.7616321e@bbrezillon>
In-Reply-To: <20180429150053.GA27374@beast>
References: <20180429150053.GA27374@beast>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2018 08:00:53 -0700
Kees Cook <keescook@chromium.org> wrote:

> On the quest to remove all stack VLAs from the kernel[1] this changes
> the check_free_sectors() routine to use a kmalloc()ed buffer instead
> of a large VLA stack buffer.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to mtd/next.

Thanks,

Boris

> ---
> v2: kmalloc() instead of stack buffer (Boris)
> ---
>  drivers/mtd/inftlmount.c | 23 ++++++++++++++++-------
>  drivers/mtd/nftlmount.c  | 23 ++++++++++++++++-------
>  2 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
> index aab4f68bd36f..2d598412972d 100644
> --- a/drivers/mtd/inftlmount.c
> +++ b/drivers/mtd/inftlmount.c
> @@ -334,28 +334,37 @@ static int memcmpb(void *a, int c, int n)
>  static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
>  	int len, int check_oob)
>  {
> -	u8 buf[SECTORSIZE + inftl->mbd.mtd->oobsize];
>  	struct mtd_info *mtd = inftl->mbd.mtd;
>  	size_t retlen;
> -	int i;
> +	int i, ret;
> +	u8 *buf;
> +
> +	buf = kmalloc(SECTORSIZE + mtd->oobsize, GFP_KERNEL);
> +	if (!buf)
> +		return -1;
>  
> +	ret = -1;
>  	for (i = 0; i < len; i += SECTORSIZE) {
>  		if (mtd_read(mtd, address, SECTORSIZE, &retlen, buf))
> -			return -1;
> +			goto out;
>  		if (memcmpb(buf, 0xff, SECTORSIZE) != 0)
> -			return -1;
> +			goto out;
>  
>  		if (check_oob) {
>  			if(inftl_read_oob(mtd, address, mtd->oobsize,
>  					  &retlen, &buf[SECTORSIZE]) < 0)
> -				return -1;
> +				goto out;
>  			if (memcmpb(buf + SECTORSIZE, 0xff, mtd->oobsize) != 0)
> -				return -1;
> +				goto out;
>  		}
>  		address += SECTORSIZE;
>  	}
>  
> -	return 0;
> +	ret = 0;
> +
> +out:
> +	kfree(buf);
> +	return ret;
>  }
>  
>  /*
> diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
> index a6fbfa4e5799..6281da3dadac 100644
> --- a/drivers/mtd/nftlmount.c
> +++ b/drivers/mtd/nftlmount.c
> @@ -272,28 +272,37 @@ static int memcmpb(void *a, int c, int n)
>  static int check_free_sectors(struct NFTLrecord *nftl, unsigned int address, int len,
>  			      int check_oob)
>  {
> -	u8 buf[SECTORSIZE + nftl->mbd.mtd->oobsize];
>  	struct mtd_info *mtd = nftl->mbd.mtd;
>  	size_t retlen;
> -	int i;
> +	int i, ret;
> +	u8 *buf;
> +
> +	buf = kmalloc(SECTORSIZE + mtd->oobsize, GFP_KERNEL);
> +	if (!buf)
> +		return -1;
>  
> +	ret = -1;
>  	for (i = 0; i < len; i += SECTORSIZE) {
>  		if (mtd_read(mtd, address, SECTORSIZE, &retlen, buf))
> -			return -1;
> +			goto out;
>  		if (memcmpb(buf, 0xff, SECTORSIZE) != 0)
> -			return -1;
> +			goto out;
>  
>  		if (check_oob) {
>  			if(nftl_read_oob(mtd, address, mtd->oobsize,
>  					 &retlen, &buf[SECTORSIZE]) < 0)
> -				return -1;
> +				goto out;
>  			if (memcmpb(buf + SECTORSIZE, 0xff, mtd->oobsize) != 0)
> -				return -1;
> +				goto out;
>  		}
>  		address += SECTORSIZE;
>  	}
>  
> -	return 0;
> +	ret = 0;
> +
> +out:
> +	kfree(buf);
> +	return ret;
>  }
>  
>  /* NFTL_format: format a Erase Unit by erasing ALL Erase Zones in the Erase Unit and
