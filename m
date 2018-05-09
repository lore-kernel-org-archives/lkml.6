Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965281AbeEIPzy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:55:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34880 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964984AbeEIPzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:55:52 -0400
Date: Wed, 9 May 2018 17:55:39 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Jane Wan <Jane.Wan@nokia.com>
Cc: miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, marek.vasut@gmail.com,
        yamada.masahiro@socionext.com, prabhakar.kushwaha@nxp.com,
        shawnguo@kernel.org, jagdish.gediya@nxp.com,
        shreeya.patel23498@gmail.com, ties.bos@nokia.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mtd: rawnand: fsl_ifc: fix FSL NAND driver to
 read all ONFI parameter pages
Message-ID: <20180509175539.5791831e@bbrezillon>
In-Reply-To: <1525814394-30067-1-git-send-email-Jane.Wan@nokia.com>
References: <1525814394-30067-1-git-send-email-Jane.Wan@nokia.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 May 2018 14:19:53 -0700
Jane Wan <Jane.Wan@nokia.com> wrote:

> Per ONFI specification (Rev. 4.0), if the CRC of the first parameter page
> read is not valid, the host should read redundant parameter page copies.
> Fix FSL NAND driver to read the two redundant copies which are mandatory
> in the specification.
> 
> Signed-off-by: Jane Wan <Jane.Wan@nokia.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/nand/raw/fsl_ifc_nand.c |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
> index 61aae02..98aac1f 100644
> --- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
> @@ -342,9 +342,16 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
>  
>  	case NAND_CMD_READID:
>  	case NAND_CMD_PARAM: {
> +		/*
> +		 * For READID, read 8 bytes that are currently used.
> +		 * For PARAM, read all 3 copies of 256-bytes pages.
> +		 */
> +		int len = 8;
>  		int timing = IFC_FIR_OP_RB;
> -		if (command == NAND_CMD_PARAM)
> +		if (command == NAND_CMD_PARAM) {
>  			timing = IFC_FIR_OP_RBCD;
> +			len = 256 * 3;
> +		}
>  
>  		ifc_out32((IFC_FIR_OP_CW0 << IFC_NAND_FIR0_OP0_SHIFT) |
>  			  (IFC_FIR_OP_UA  << IFC_NAND_FIR0_OP1_SHIFT) |
> @@ -354,12 +361,8 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
>  			  &ifc->ifc_nand.nand_fcr0);
>  		ifc_out32(column, &ifc->ifc_nand.row3);
>  
> -		/*
> -		 * although currently it's 8 bytes for READID, we always read
> -		 * the maximum 256 bytes(for PARAM)
> -		 */
> -		ifc_out32(256, &ifc->ifc_nand.nand_fbcr);
> -		ifc_nand_ctrl->read_bytes = 256;
> +		ifc_out32(len, &ifc->ifc_nand.nand_fbcr);
> +		ifc_nand_ctrl->read_bytes = len;
>  
>  		set_addr(mtd, 0, 0, 0);
>  		fsl_ifc_run_command(mtd);
