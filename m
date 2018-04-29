Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbeD2JQK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 05:16:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41171 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751356AbeD2JQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 05:16:08 -0400
Date: Sun, 29 Apr 2018 11:16:05 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: nftl: Remove VLA usage
Message-ID: <20180429111605.4cdf5ab2@bbrezillon>
In-Reply-To: <20180423203500.GA36488@beast>
References: <20180423203500.GA36488@beast>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Mon, 23 Apr 2018 13:35:00 -0700
Kees Cook <keescook@chromium.org> wrote:

> On the quest to remove all VLAs from the kernel[1] this changes the
> check_free_sectors() routine to use the same stack buffer for both
> data byte checks (SECTORSIZE) and oob byte checks (oobsize). Since
> these regions aren't needed at the same time, they don't need to be
> consecutively allocated. Additionally, while it's possible for oobsize
> to be large, it is unlikely to be larger than the actual SECTORSIZE. As
> such, remove the VLA, adjust offsets and add a sanity check to make sure
> we never get a pathological oobsize.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/mtd/inftlmount.c | 11 ++++++++---
>  drivers/mtd/nftlmount.c  | 11 ++++++++---
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
> index aab4f68bd36f..9cdae7f0fc2e 100644
> --- a/drivers/mtd/inftlmount.c
> +++ b/drivers/mtd/inftlmount.c
> @@ -334,7 +334,7 @@ static int memcmpb(void *a, int c, int n)
>  static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
>  	int len, int check_oob)
>  {
> -	u8 buf[SECTORSIZE + inftl->mbd.mtd->oobsize];
> +	u8 buf[SECTORSIZE];

Could we instead move to dynamic allocation. I mean, SECTORSIZE is 512
bytes, so only with this function we consume 1/16 of the stack. Not to
mention that some MTD drivers might want to do DMA on buffer passed by
the MTD user, and if the buffer is on the stack they'll have to use a
bounce buffer instead.

Regards,

Boris

>  	struct mtd_info *mtd = inftl->mbd.mtd;
>  	size_t retlen;
>  	int i;
> @@ -346,10 +346,15 @@ static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
>  			return -1;
>  
>  		if (check_oob) {
> +			if (mtd->oobsize > sizeof(buf)) {
> +				pr_warn("MTD oobsize > SECTORSIZE: %d\n",
> +					mtd->oobsize);
> +				return -1;
> +			}
>  			if(inftl_read_oob(mtd, address, mtd->oobsize,
> -					  &retlen, &buf[SECTORSIZE]) < 0)
> +					  &retlen, buf) < 0)
>  				return -1;
> -			if (memcmpb(buf + SECTORSIZE, 0xff, mtd->oobsize) != 0)
> +			if (memcmpb(buf, 0xff, mtd->oobsize) != 0)
>  				return -1;
>  		}
>  		address += SECTORSIZE;
> diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
> index a6fbfa4e5799..e6eba7f3fdf5 100644
> --- a/drivers/mtd/nftlmount.c
> +++ b/drivers/mtd/nftlmount.c
> @@ -272,7 +272,7 @@ static int memcmpb(void *a, int c, int n)
>  static int check_free_sectors(struct NFTLrecord *nftl, unsigned int address, int len,
>  			      int check_oob)
>  {
> -	u8 buf[SECTORSIZE + nftl->mbd.mtd->oobsize];
> +	u8 buf[SECTORSIZE];
>  	struct mtd_info *mtd = nftl->mbd.mtd;
>  	size_t retlen;
>  	int i;
> @@ -284,10 +284,15 @@ static int check_free_sectors(struct NFTLrecord *nftl, unsigned int address, int
>  			return -1;
>  
>  		if (check_oob) {
> +			if (mtd->oobsize > sizeof(buf)) {
> +				pr_warn("MTD oobsize > SECTORSIZE: %d\n",
> +					mtd->oobsize);
> +				return -1;
> +			}
>  			if(nftl_read_oob(mtd, address, mtd->oobsize,
> -					 &retlen, &buf[SECTORSIZE]) < 0)
> +					 &retlen, buf) < 0)
>  				return -1;
> -			if (memcmpb(buf + SECTORSIZE, 0xff, mtd->oobsize) != 0)
> +			if (memcmpb(buf, 0xff, mtd->oobsize) != 0)
>  				return -1;
>  		}
>  		address += SECTORSIZE;
