Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933470AbeD1MGo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 08:06:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59590 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759827AbeD1MGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 08:06:42 -0400
Date: Sat, 28 Apr 2018 14:06:38 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jane Wan <Jane.Wan@nokia.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ties.bos@nokia.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <Boris.Brezillon@bootlin.com>
Subject: Re: [PATCH 2/2] Use bit-wise majority to recover the contents of
 ONFI parameter
Message-ID: <20180428140638.2e2c04dd@xps13>
In-Reply-To: <1524788396-32380-3-git-send-email-Jane.Wan@nokia.com>
References: <1524788396-32380-1-git-send-email-Jane.Wan@nokia.com>
        <1524788396-32380-3-git-send-email-Jane.Wan@nokia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jane,

Same comments as before, please: get the right maintainers, add a
commit log, rebase and fix the title prefix.

Have you ever needed/tried this algorithm before? 

On Thu, 26 Apr 2018 17:19:56 -0700, Jane Wan
<Jane.Wan@nokia.com> wrote:

> Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> ---
>  drivers/mtd/nand/nand_base.c |   35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index c2e1232..161b523 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -3153,8 +3153,10 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
>  					int *busw)
>  {
>  	struct nand_onfi_params *p = &chip->onfi_params;
> -	int i, j;
> -	int val;
> +	int i, j, k, len, val;
> +	uint8_t copy[3][256], v8;

Please use u8 instead of uint8_t (./scripts/checkpatch.pl --strict will
give you the list of styling issues to fix.

I don't think you should allocate that much space on the stack, please
use dynamic allocation.

> +
> +	len = (sizeof(*p) > 256) ? 256 : sizeof(*p);

This is a maximum derivation, there are helpers for that.

I am not sure this is relevant, won't you read only 256 bytes anyway?

>  
>  	/* Try ONFI for unknown chip or LP */
>  	chip->cmdfunc(mtd, NAND_CMD_READID, 0x20, -1);
> @@ -3170,11 +3172,36 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
>  				le16_to_cpu(p->crc)) {
>  			break;
>  		}

Space.

> +		pr_err("CRC of parameter page %d is not valid\n", i);
> +		for (j = 0; j < len; j++)
> +			copy[i][j] = ((uint8_t *)p)[j];

'copy' is maybe not a meaningful name.

>  	}
>  
>  	if (i == 3) {
> -		pr_err("Could not find valid ONFI parameter page; aborting\n");
> -		return 0;
> +		pr_err("Could not find valid ONFI parameter page\n");
> +		pr_info("Recover ONFI parameters with bit-wise majority\n");
> +		for (j = 0; j < len; j++) {
> +			if (copy[0][j] == copy[1][j] ||
> +			    copy[0][j] == copy[2][j]) {
> +				((uint8_t *)p)[j] = copy[0][j];
> +			} else if (copy[1][j] == copy[2][j]) {
> +				((uint8_t *)p)[j] = copy[1][j];
> +			} else {
> +				((uint8_t *)p)[j] = 0;
> +				for (k = 0; k < 8; k++) {
> +					v8 = (copy[0][j] >> k) & 0x1;

v8 could be declared in the else statement of in the for loop.
The name could also be changed.

> +					v8 += (copy[1][j] >> k) & 0x1;
> +					v8 += (copy[2][j] >> k) & 0x1;
> +					if (v8 > 1)
> +						((uint8_t *)p)[j] |= (1 << k);

Please use the BIT() macro.

> +				}
> +			}
> +		}

Space.

> +		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) !=
> +		    le16_to_cpu(p->crc)) {
> +			pr_err("ONFI parameter recovery failed, aborting\n");
> +			return 0;
> +		}
>  	}
>  
>  	/* Check version */

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
