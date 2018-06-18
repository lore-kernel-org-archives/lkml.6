Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62306C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E09C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E09C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbeFRNFZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:05:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36292 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932657AbeFRNFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:05:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 53ADD2071B; Mon, 18 Jun 2018 15:05:22 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id DD10520650;
        Mon, 18 Jun 2018 15:05:21 +0200 (CEST)
Date:   Mon, 18 Jun 2018 15:05:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH 1/2] mtd: rawnand: handle ONFI revision number field
 being 0
Message-ID: <20180618150521.067ef156@xps13>
In-Reply-To: <20180618045255.8015-2-chris.packham@alliedtelesis.co.nz>
References: <20180618045255.8015-1-chris.packham@alliedtelesis.co.nz>
        <20180618045255.8015-2-chris.packham@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Mon, 18 Jun 2018 16:52:54 +1200, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> Some Micron NAND chips (MT29F1G08ABAFAWP-ITE:F) report 00 00 for the
> revision number field of the ONFI parameter page. Rather than rejecting
> these outright assume ONFI version 1.0 if the revision number is 00 00.
> 

Thanks for getting your hands into this.

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> At the moment I haven't qualified this check on anything, I should
> probably at least include vendor == MICRON.

The more I think about it the more I convince myself that this is not
needed. If the 4 first bytes are "ONFI", then the chip is ONFI...

Then what you do below is simple and readable and (sadly) probably
right.

> 
> As far as I can tell revision number == 0 is not permitted by the ONFI
> spec but this wouldn't be the first time a vendor has ignored a spec. On
> the other hand maybe I'm reading the spec wrong and someone here will
> say "oh 0 means ...".
> 
>  drivers/mtd/nand/raw/nand_base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 0cd3e216b95c..1691c7005ae4 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5184,6 +5184,8 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
>  		chip->parameters.onfi.version = 20;
>  	else if (val & (1 << 1))
>  		chip->parameters.onfi.version = 10;
> +	else if (val == 0)
> +		chip->parameters.onfi.version = 10;
>  
>  	if (!chip->parameters.onfi.version) {
>  		pr_info("unsupported ONFI version: %d\n", val);

Regards,
Miquèl
