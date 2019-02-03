Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBA7C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C684321773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549179020;
	bh=ks2ipiHZO/uli19qRFyFeK4eQsVOw+M0yb9vwKcyKyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aJ5pmu01JUuZqwYInu2CU/XjR/GXcxaVua7G+mvyJkjhfLI7O1szkEfy/bdYYJSVD
	 oPjzalEstlHczuhEwhSuNXiK8MyXSGxrG1xwADFmjcQetmI+c/E5osLyVtAP4Fdisn
	 ILROOmfJ3SL97appmnP2+UH0G+qHQjKj1512b6E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfBCHaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfBCHaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:30:19 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145EA2082E;
        Sun,  3 Feb 2019 07:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549179017;
        bh=ks2ipiHZO/uli19qRFyFeK4eQsVOw+M0yb9vwKcyKyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vt6nDFvjM/1AJfkvoon46cXaIwEVMxEnXrDG4pAFEWPjSR1B+cTUWDpYRVjo7yMQ1
         GdpWKGgJ99PR4RCuyQ4X5Zi5zLQA5nn9wwYbFLT3g0z0hNLhmuf2a3D5o7g119EGtA
         +9x3wLZYs7w0t8RR2rR85VEG4X6tsqSkNiFrJIT4=
Date:   Sun, 3 Feb 2019 08:30:04 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] mtd: rawnand: jz4780: Add ooblayout for the Qi
 Ben Nanonote
Message-ID: <20190203083004.390b96be@bbrezillon>
In-Reply-To: <20190202231926.2444-7-paul@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190202231926.2444-7-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Feb 2019 20:19:23 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> The Ben Nanonote from Qi Hardware expects a specific OOB layout on its
> NAND. If the "ingenic,oob-layout" device property is set to "qi,lb60",
> this specific OOB layout is used.

I'm really not a big fan of this ingenic,oob-layout property, it
encourages people to use new custom layouts which is just a pain to
maintain. I understand that we don't have the choice for this board as
it's already upstream, but maybe we can avoid adding this prop and
check the root compat (which should contain the board name). 

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v2: New patch
> 
>  drivers/mtd/nand/raw/ingenic/jz4780_nand.c | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
> index baebb9a5c7c8..4b304eceae8d 100644
> --- a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
> +++ b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
> @@ -346,6 +346,41 @@ static int jz4780_nand_init_chips(struct jz4780_nand_controller *nfc,
>  	return 0;
>  }
>  
> +static int qi_lb60_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				 struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +
> +	if (section || !ecc->total)
> +		return -ERANGE;
> +
> +	oobregion->length = ecc->total;
> +	oobregion->offset = 12;
> +
> +	return 0;
> +}
> +
> +static int qi_lb60_ooblayout_free(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->length = mtd->oobsize - ecc->total - 12;
> +	oobregion->offset = 12 + ecc->total;
> +
> +	return 0;
> +}
> +
> +const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops = {
> +	.ecc = qi_lb60_ooblayout_ecc,
> +	.free = qi_lb60_ooblayout_free,
> +};
> +
>  static int jz4725b_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				 struct mtd_oob_region *oobregion)
>  {
> @@ -409,6 +444,8 @@ static int jz4780_nand_probe(struct platform_device *pdev)
>  	if (!ret) {
>  		if (!strcmp(layout, "ingenic,jz4725b")) {
>  			nfc->oob_layout  = &jz4725b_ooblayout_ops;
> +		} else if (!strcmp(layout, "qi,lb60")) {
> +			nfc->oob_layout = &qi_lb60_ooblayout_ops;
>  		} else {
>  			dev_err(dev, "Unrecognized OOB layout %s\n", layout);
>  			return -EINVAL;

