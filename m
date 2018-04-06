Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeDFMbh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:31:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54544 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeDFMbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:31:35 -0400
Date: Fri, 6 Apr 2018 14:31:33 +0200
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
Subject: Re: [PATCH 1/9] mtd: nand: qcom: use the ecc strength from device
 parameter
Message-ID: <20180406143133.67f33d33@xps13>
In-Reply-To: <1522845745-6624-2-git-send-email-absahu@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
        <1522845745-6624-2-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Wed,  4 Apr 2018 18:12:17 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> Currently the driver uses the ECC strength specified in
> device tree. The ONFI or JEDEC device parameter page
> contains the ‘ECC correctability’ field which indicates the
> number of bits that the host should be able to correct per
> 512 bytes of data.

This is misleading. This field is not about the controller but rather
the chip requirements in terms of minimal strength for nominal use.

> The ecc correctability is assigned in
> chip parameter during device probe time. QPIC/EBI2 NAND
> supports 4/8-bit ecc correction. The Same kind of board
> can have different NAND parts so use the ecc strength
> from device parameter (if its non zero) instead of
> device tree.

That is not what you do.

What you do is forcing the strength to be 8-bit per ECC chunk if the
NAND chip requires at least 8-bit/chunk strength.

The DT property is here to force a strength. Otherwise, Linux will
propose to the NAND controller to use the minimum strength required by
the chip (from either the ONFI/JEDEC parameter page or from a static
table).

IMHO, you have two solutions:
1/ Remove these properties from the board DT (breaks DT backward
compatibility though);
2/ Create another DT for the board.

However, there is something to do in this driver: the strength chosen
should be limited to the controller capabilities (8-bit/512B if I
understand correctly). In this case you have two options: either you
limit the strength like the size [1] if (ecc->strength > 8); or you
just limit the maximum strength to 8 like this [2] and the core will
spawn a warning in the dmesg telling that the ECC strength used is
below the NAND chip requirements.

Thanks,
Miquèl

[1] https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/qcom_nandc.c#L2332
[2] http://code.bulix.org/nyf63w-315268


> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/mtd/nand/qcom_nandc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
> index 563b759..8dd40de 100644
> --- a/drivers/mtd/nand/qcom_nandc.c
> +++ b/drivers/mtd/nand/qcom_nandc.c
> @@ -2334,6 +2334,14 @@ static int qcom_nand_host_setup(struct qcom_nand_host *host)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Read the required ecc strength from NAND device and overwrite
> +	 * the device tree ecc strength for devices which require
> +	 * ecc correctability bits >= 8
> +	 */
> +	if (chip->ecc_strength_ds >= 8)
> +		ecc->strength = 8;
> +
>  	wide_bus = chip->options & NAND_BUSWIDTH_16 ? true : false;
>  
>  	if (ecc->strength >= 8) {



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
