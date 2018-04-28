Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759890AbeD1LmX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 07:42:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59485 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759801AbeD1LmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 07:42:22 -0400
Date: Sat, 28 Apr 2018 13:42:18 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jane Wan <Jane.Wan@nokia.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ties.bos@nokia.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <Boris.Brezillon@bootlin.com>
Subject: Re: [PATCH 1/2] Fix FSL NAND driver to read all ONFI parameter
 pages
Message-ID: <20180428134218.3ae857eb@xps13>
In-Reply-To: <1524788396-32380-2-git-send-email-Jane.Wan@nokia.com>
References: <1524788396-32380-1-git-send-email-Jane.Wan@nokia.com>
        <1524788396-32380-2-git-send-email-Jane.Wan@nokia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jane,

You forgot to Cc the right maintainers, please
use ./scripts/get_maintainer.pl for that.

> Signed-off-by: Jane Wan <Jane.Wan@nokia.com>

Please add a description of what your are doing in the commit message.
The description in the cover letter is good, you can copy the relevant
section here.

> ---
>  drivers/mtd/nand/fsl_ifc_nand.c |   10 ++++++----

Also, just for you to know, files have moved in a raw/ subdirectory, so
please rebase on top of 4.17-rc1 and prefix the commit title with
"mtd: rawnand: fsl_ifc:".

>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
> index ca36b35..a3cf6ca 100644
> --- a/drivers/mtd/nand/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/fsl_ifc_nand.c
> @@ -413,6 +413,7 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
>  	struct fsl_ifc_mtd *priv = chip->priv;
>  	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
>  	struct fsl_ifc_runtime __iomem *ifc = ctrl->rregs;
> +	int len;
>  
>  	/* clear the read buffer */
>  	ifc_nand_ctrl->read_bytes = 0;
> @@ -462,11 +463,12 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
>  		ifc_out32(column, &ifc->ifc_nand.row3);
>  
>  		/*
> -		 * although currently it's 8 bytes for READID, we always read
> -		 * the maximum 256 bytes(for PARAM)
> +		 * For READID, read 8 bytes that are currently used.
> +		 * For PARAM, read all 3 copies of 256-bytes pages.
>  		 */
> -		ifc_out32(256, &ifc->ifc_nand.nand_fbcr);
> -		ifc_nand_ctrl->read_bytes = 256;
> +		len = (command == NAND_CMD_PARAM) ? (3 * 256) : 8;

There is already a "command == NAND_CMD_PARAM" condition above, you
might want to use it.

> +		ifc_out32(len, &ifc->ifc_nand.nand_fbcr);
> +		ifc_nand_ctrl->read_bytes = len;
>  
>  		set_addr(mtd, 0, 0, 0);
>  		fsl_ifc_run_command(mtd);

The overall ->cmdfunc() approach of this driver is horrible. However
this fixes its implementation to match the current state of the core,
so I guess it is fine.

Regards,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
