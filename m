Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757260AbeEJMDS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:03:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40496 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757243AbeEJMDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:03:13 -0400
Date: Thu, 10 May 2018 14:03:11 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Jane Wan <Jane.Wan@nokia.com>
Cc: miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, marek.vasut@gmail.com,
        yamada.masahiro@socionext.com, prabhakar.kushwaha@nxp.com,
        shawnguo@kernel.org, jagdish.gediya@nxp.com,
        shreeya.patel23498@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ties.bos@nokia.com
Subject: Re: [PATCH v5 2/2] mtd: rawnand: use bit-wise majority to recover
 the contents of ONFI parameter
Message-ID: <20180510140311.02805561@bbrezillon>
In-Reply-To: <1525920400-11392-1-git-send-email-Jane.Wan@nokia.com>
References: <1525920400-11392-1-git-send-email-Jane.Wan@nokia.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jane,

Subject prefix should be "[PATCH v5] ...", the 2/2 is no longer valid
since you only have one patch here.

On Wed,  9 May 2018 19:46:40 -0700
Jane Wan <Jane.Wan@nokia.com> wrote:

> Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> CRC values, the bit-wise majority may be used to recover the contents of
> the parameter pages from the parameter page copies present.
> 
> Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> ---

There should be a changelog here describing what has changed in each
version of the patch.

>  drivers/mtd/nand/raw/nand_base.c |   46 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 72f3a89..a7c2507 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5086,6 +5086,34 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
>  	return ret;
>  }
>  
> +#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)

Not sure we need that macro, see below.

> +
> +/*
> + * Recover data with bit-wise majority
> + */
> +static void nand_bit_wise_majority(const void **srcbufs,
> +				   void *dstbuf,
> +				   unsigned int nbufs,
> +				   unsigned int bufsize)

I'd prefer to have nbufs just after srcbufs and named nsrcbufs:

static void nand_bit_wise_majority(const void **srcbufs,
				   unsigned int nsrcbufs,
				   void *dstbuf,
				   unsigned int bufsize)

> +{
> +	int i, j, k;
> +	u8 v, m;
> +	u8 *p;
> +
> +	p = *(u8 **)srcbufs;

Nope, I'd like to support the cases where srcbufs are not contiguous,
so that does not work.

> +	for (i = 0; i < bufsize; i++) {
> +		v = 0;

You can declare the v variable here, since its scope is limited to the
for loop. BTW, v, m, can't we pick better names? I guess v is for val,
but I'm not even sure what m stands for.

> +		for (j = 0; j < 8; j++) {
> +			m = 0;
> +			for (k = 0; k < nbufs; k++)
> +				m += GET_BIT(j, p[k*bufsize + i]);

			for (k = 0; k < nbufs; k++) {
				const u8 *srcbuf = srcbufs[j];

				if (srcbuf[i] & BIT(k))
					m++;
			}

> +			if (m > nbufs/2)

Space between operands and operators please

			if (m > nbufs / 2)

> +				v |= BIT(j);
> +		}
> +		((u8 *)dstbuf)[i] = v;
> +	}
> +}
> +
>  /*
>   * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
>   */
> @@ -5102,7 +5130,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
>  		return 0;
>  
>  	/* ONFI chip: allocate a buffer to hold its parameter page */
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
>  	if (!p)
>  		return -ENOMEM;
>  
> @@ -5113,21 +5141,29 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
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

		const void *srcbufs[3] = {p, p + 1, p + 2};

> -		pr_err("Could not find valid ONFI parameter page; aborting\n");
> -		goto free_onfi_param_page;
> +		pr_err("Could not find valid ONFI parameter page\n");
> +		pr_info("Recover ONFI params with bit-wise majority\n");
> +		nand_bit_wise_majority((const void **)&p, p, 3, sizeof(*p));

		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
				       sizeof(*p))

> +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
> +				le16_to_cpu(p->crc)) {
> +			pr_err("ONFI parameter recovery failed, aborting\n");
> +			goto free_onfi_param_page;
> +		}
>  	}
>  
>  	/* Check version */

Thanks,

Boris
