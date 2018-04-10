Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeDJJNE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:13:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42011 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752469AbeDJJNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:13:02 -0400
Date: Tue, 10 Apr 2018 11:12:20 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 4/9] mtd: nand: qcom: fix null pointer access for erased
 buffer detection
Message-ID: <20180410111220.3873a24c@xps13>
In-Reply-To: <1522845745-6624-5-git-send-email-absahu@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
        <1522845745-6624-5-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Wed,  4 Apr 2018 18:12:20 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> parse_read_errors can be called with only oob buf also in which
> case data_buf will be NULL.  If data_buf is NULL, then don’t
> treat this page as completely erased in case of ECC uncorrectable
> error.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/mtd/nand/qcom_nandc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
> index 57c16a6..0ebcc55 100644
> --- a/drivers/mtd/nand/qcom_nandc.c
> +++ b/drivers/mtd/nand/qcom_nandc.c
> @@ -1607,9 +1607,11 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
>  			if (host->bch_enabled) {
>  				erased = (erased_cw & ERASED_CW) == ERASED_CW ?
>  					 true : false;

Why the parse_read_errors() function could not be called without
data_buf when using BCH? Are you sure the situation can only happen
without it?

Would the following apply here too, with a:

if (!data_buf) {
        erased = false;
} else {
        if (host->bch_enabled)
                ...
        else
                ...
}

> -			} else {
> +			} else if (data_buf) {
>  				erased = erased_chunk_check_and_fixup(data_buf,
>  								      data_len);
> +			} else {
> +				erased = false;
>  			}
>  
>  			if (erased) {
> @@ -1652,7 +1654,8 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
>  			max_bitflips = max(max_bitflips, stat);
>  		}
>  
> -		data_buf += data_len;
> +		if (data_buf)
> +			data_buf += data_len;
>  		if (oob_buf)
>  			oob_buf += oob_len + ecc->bytes;
>  	}

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
