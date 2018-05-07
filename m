Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeEGIRC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:17:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45661 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeEGIQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:16:59 -0400
Date: Mon, 7 May 2018 10:16:46 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 01/14] mtd: rawnand: helper function for setting up
 ECC parameters
Message-ID: <20180507101646.3df649b0@bbrezillon>
In-Reply-To: <1525350041-22995-2-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
        <1525350041-22995-2-git-send-email-absahu@codeaurora.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 May 2018 17:50:28 +0530
Abhishek Sahu <absahu@codeaurora.org> wrote:

> commit 2c8f8afa7f92 ("mtd: nand: add generic helpers to check,
> match, maximize ECC settings") provides generic helpers which
> drivers can use for setting up ECC parameters.
> 
> Since same board can have different ECC strength nand chips so
> following is the logic for setting up ECC strength and ECC step
> size, which can be used by most of the drivers.
> 
> 1. If both ECC step size and ECC strength are already set
>    (usually by DT) then just check whether this setting
>    is supported by NAND controller.
> 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength
>    supported by NAND controller.
> 3. Otherwise, try to match the ECC step size and ECC strength closest
>    to the chip's requirement. If available OOB size can't fit the chip
>    requirement then select maximum ECC strength which can be fit with
>    available OOB size with warning.
> 
> This patch introduces nand_ecc_param_setup function which calls the
> required helper functions for the above logic. The drivers can use
> this single function instead of calling the 3 helper functions
> individually.
> 
> CC: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v1:
> 
>   NEW PATCH
> 
>  drivers/mtd/nand/raw/nand_base.c | 42 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/rawnand.h      |  3 +++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 72f3a89..dd7a984 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -6249,6 +6249,48 @@ int nand_maximize_ecc(struct nand_chip *chip,
>  }
>  EXPORT_SYMBOL_GPL(nand_maximize_ecc);
>  
> +/**
> + * nand_ecc_param_setup - Set the ECC strength and ECC step size
> + * @chip: nand chip info structure
> + * @caps: ECC engine caps info structure
> + * @oobavail: OOB size that the ECC engine can use
> + *
> + * Choose the ECC strength according to following logic
> + *
> + * 1. If both ECC step size and ECC strength are already set (usually by DT)
> + *    then check if it is supported by this controller.
> + * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
> + * 3. Otherwise, try to match the ECC step size and ECC strength closest
> + *    to the chip's requirement. If available OOB size can't fit the chip
> + *    requirement then fallback to the maximum ECC step size and ECC strength
> + *    and print the warning.
> + *
> + * On success, the chosen ECC settings are set.
> + */
> +int nand_ecc_param_setup(struct nand_chip *chip,
> +			 const struct nand_ecc_caps *caps, int oobavail)

Can we rename this function "nand_ecc_choose_conf()".
