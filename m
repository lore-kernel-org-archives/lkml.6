Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEBIKR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:10:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40168 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbeEBIKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:10:14 -0400
Date: Wed, 2 May 2018 10:10:11 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>
Cc: Boris Brezillon <Boris.Brezillon@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "Bos, Ties (Nokia - US/Sunnyvale)" <ties.bos@nokia.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jagdish.gediya@nxp.com" <jagdish.gediya@nxp.com>,
        "shreeya.patel23498@gmail.com" <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH 1/2] Fix FSL NAND driver to read all ONFI parameter
 pages
Message-ID: <20180502101011.797e4ec4@xps13>
In-Reply-To: <VI1PR07MB161575ACAE380B18882E8EE981810@VI1PR07MB1615.eurprd07.prod.outlook.com>
References: <1524788396-32380-1-git-send-email-Jane.Wan@nokia.com>
        <1524788396-32380-2-git-send-email-Jane.Wan@nokia.com>
        <20180428134218.3ae857eb@xps13>
        <VI1PR07MB161575ACAE380B18882E8EE981810@VI1PR07MB1615.eurprd07.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jane,

On Tue, 1 May 2018 05:01:23 +0000, "Wan, Jane (Nokia - US/Sunnyvale)"
<jane.wan@nokia.com> wrote:

> Hi Miquèl and Boris,
> 
> Thank you for your response and feedback.  I've modified the fix based on your comments.  
> Please see the updated patch file at the end of this message (also in attachment).
> My answers to your comments/questions are inline in the previous message.

Usually we answer inline in each e-mail, then we post a new version
with a version counter incremented (use the '-v2- of 'git format-patch'
to add the '[PATCH v2 x/y]' prefix automatically). Reposting is
important as maintainers use 'patchwork' to follow the evolution of
each patch. So in your case, nothing shows that you posted a v2.

> 
> Here is the answer to Boris question in another email thread:
> 
> > What if some NANDs have 4 or more copies of the param page?  
>  [Jane] The ONFI spec defines that the parameter page and its two redundant copies are mandatory.  
> The additional redundant pages are optional.  Currently, the FSL NAND driver only reads the first 
> parameter page.  This patch is to fix the driver to meet the mandatory requirement in the spec. 
> We got a batch of particularly bad NAND chips recently and we needed these changes to make them 
> work reliably over temperature.  The patch was verified using these bad chips.

I think Boris' remark was much more general than just this use case.
The whole logic of tailoring ->cmdfunc() in each driver by guessing the
data length, while there is absolutely no indication of it in this hook
is broken. The core is moving to a new interface called ->exec_op(),
and we would welcome a migration of this driver to this hook, that
would be much much more easy to maintain for everyone.


Thanks,
Miquèl

> 
> Best regards,
> Jane
> 
> Updated patch:
> From 701de4146aa6355c951e97a77476e12d2da56d42 Mon Sep 17 00:00:00 2001
> From: Jane Wan <Jane.Wan@nokia.com>
> Date: Mon, 30 Apr 2018 13:30:46 -0700
> Subject: [PATCH 1/2] mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all
>  ONFI parameter pages
> 
> Per ONFI specification (Rev. 4.0), if the CRC of the first parameter page
> read is not valid, the host should read redundant parameter page copies.
> Fix FSL NAND driver to read the two redundant copies which are mandatory
> in the specification.
> 
> Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
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



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
