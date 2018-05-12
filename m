Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbeELIUy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 04:20:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33722 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeELIUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 04:20:53 -0400
Date: Sat, 12 May 2018 10:20:40 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Jane Wan <Jane.Wan@nokia.com>
Cc: miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, marek.vasut@gmail.com,
        yamada.masahiro@socionext.com, prabhakar.kushwaha@nxp.com,
        shawnguo@kernel.org, jagdish.gediya@nxp.com,
        shreeya.patel23498@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ties.bos@nokia.com
Subject: Re: [PATCH v6] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
Message-ID: <20180512102040.3e5c2cbe@bbrezillon>
In-Reply-To: <1525987717-31675-1-git-send-email-Jane.Wan@nokia.com>
References: <1525987717-31675-1-git-send-email-Jane.Wan@nokia.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 14:28:37 -0700
Jane Wan <Jane.Wan@nokia.com> wrote:

> Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> CRC values, the bit-wise majority may be used to recover the contents of
> the parameter pages from the parameter page copies present.
> 
> Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> ---
> v6: support the cases that srcbufs are not contiguous
> v5: make the bit-wise majority functon generic
> v4: move the bit-wise majority code in a separate function
> v3: fix warning message detected by kbuild test robot
> v2: rebase the changes on top of v4.17-rc1
> 
>  drivers/mtd/nand/raw/nand_base.c |   52 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 72f3a89..acf905c 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5087,6 +5087,35 @@ static int nand_flash_detect_ext_param_page(struct nand_chip *chip,
>  }
>  
>  /*
> + * Recover data with bit-wise majority
> + */
> +static void nand_bit_wise_majority(const void **srcbufs,
> +				   unsigned int nsrcbufs,
> +				   void *dstbuf,
> +				   unsigned int bufsize)
> +{
> +	int i, j, k;
> +
> +	for (i = 0; i < bufsize; i++) {
> +		u8 cnt, val;
> +
> +		val = 0;
> +		for (j = 0; j < 8; j++) {
> +			cnt = 0;
> +			for (k = 0; k < nsrcbufs; k++) {
> +				const u8 *srcbuf = srcbufs[k];
> +
> +				if (srcbuf[i] & BIT(j))
> +					cnt++;
> +			}
> +			if (cnt > nsrcbufs / 2)
> +				val |= BIT(j);
> +		}
> +		((u8 *)dstbuf)[i] = val;
> +	}
> +}
> +
> +/*
>   * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
>   */
>  static int nand_flash_detect_onfi(struct nand_chip *chip)
> @@ -5102,7 +5131,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
>  		return 0;
>  
>  	/* ONFI chip: allocate a buffer to hold its parameter page */
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
>  	if (!p)
>  		return -ENOMEM;
>  
> @@ -5113,21 +5142,34 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
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
> +		const void *srcbufs[3] = {p, p + 1, p + 2};
> +
> +		pr_err("Could not find valid ONFI parameter page\n");

Maybe pr_warn() here

> +		pr_info("Recover ONFI params with bit-wise majority\n");

and maybe you can pack the 2 messages:

		pr_warn("Could not find a valid ONFI parameter page, trying bit-wise majority to recover it");

> +
> +		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
> +				       sizeof(*p));
> +
> +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
> +				le16_to_cpu(p->crc)) {
> +			pr_err("ONFI parameter recovery failed, aborting\n");
> +			goto free_onfi_param_page;
> +		}
>  	}
>  
>  	/* Check version */
