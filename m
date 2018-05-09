Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934895AbeEIOTl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:19:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59714 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932701AbeEIOTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:19:40 -0400
Date: Wed, 9 May 2018 16:19:28 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Jane Wan <Jane.Wan@nokia.com>
Cc: miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, marek.vasut@gmail.com,
        yamada.masahiro@socionext.com, prabhakar.kushwaha@nxp.com,
        shawnguo@kernel.org, jagdish.gediya@nxp.com,
        shreeya.patel23498@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ties.bos@nokia.com
Subject: Re: [PATCH v4 2/2] mtd: rawnand: use bit-wise majority to recover
 the contents of ONFI parameter
Message-ID: <20180509161928.149a42a7@bbrezillon>
In-Reply-To: <1525814394-30067-2-git-send-email-Jane.Wan@nokia.com>
References: <1525814394-30067-1-git-send-email-Jane.Wan@nokia.com>
        <1525814394-30067-2-git-send-email-Jane.Wan@nokia.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 May 2018 14:19:54 -0700
Jane Wan <Jane.Wan@nokia.com> wrote:

> Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> CRC values, the bit-wise majority may be used to recover the contents of
> the parameter pages from the parameter page copies present.
> 
> Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c |   49 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 72f3a89..dfc341c 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5086,6 +5086,38 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
>  	return ret;
>  }
>  
> +#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
> +
> +/*
> + * Recover NAND parameter page with bit-wise majority
> + */
> +static int onfi_recover_param(struct nand_onfi_params *p, int pages)

I had something more generic in mind:

static void nand_bit_wise_majority(const void **srcbufs,
				   void *dstbuf,
				   unsigned int nbufs,
				   unsigned int bufsize)
{
	...
}

And then you do the crc check in nand_flash_detect_onfi().

The reason I'm asking that is because I'm almost sure we'll re-use this
functions for extended param pages, and also for vendor specific data
(we already have a byte-wise majority check in the hynix driver, so I
wouldn't be surprised if other vendors decided to use a bit-wise
approach for some of their OTP area).

> +{
> +	int i, j, k;
> +	u8 v, m;
> +	u8 *buf;
> +
> +	buf = (u8 *)p;
> +	for (i = 0; i < sizeof(*p); i++) {
> +		v = 0;
> +		for (j = 0; j < 8; j++) {
> +			m = 0;
> +			for (k = 0; k < pages; k++)
> +				m += GET_BIT(j, buf[k*sizeof(*p) + i]);
> +			if (m > pages/2)
> +				v |= BIT(j);
> +		}
> +		((u8 *)p)[i] = v;
> +	}
> +
> +	if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) ==
> +			le16_to_cpu(p->crc)) {
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
>   */
> @@ -5102,7 +5134,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
>  		return 0;
>  
>  	/* ONFI chip: allocate a buffer to hold its parameter page */
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
>  	if (!p)
>  		return -ENOMEM;
>  
> @@ -5113,21 +5145,28 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
>  	}
>  
>  	for (i = 0; i < 3; i++) {
> -		ret = nand_read_data_op(chip, p, sizeof(*p), true);
> +		ret = nand_read_data_op(chip, &p[i], sizeof(*p), true);
>  		if (ret) {
>  			ret = 0;
>  			goto free_onfi_param_page;
>  		}
>  
> -		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) ==
> +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)&p[i], 254) ==
>  				le16_to_cpu(p->crc)) {
> +			if (i)
> +				memcpy(p, &p[i], sizeof(*p));
>  			break;
>  		}
>  	}
>  
>  	if (i == 3) {
> -		pr_err("Could not find valid ONFI parameter page; aborting\n");
> -		goto free_onfi_param_page;
> +		pr_err("Could not find valid ONFI parameter page\n");
> +		pr_info("Recover ONFI params with bit-wise majority\n");
> +		ret = onfi_recover_param(p, 3);
> +		if (ret == 0) {
> +			pr_err("ONFI parameter recovery failed, aborting\n");
> +			goto free_onfi_param_page;
> +		}
>  	}
>  
>  	/* Check version */
