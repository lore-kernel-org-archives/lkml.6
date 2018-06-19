Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6225CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2573E20883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2573E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755849AbeFSGCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:02:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57939 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755376AbeFSGCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:02:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 590BA20799; Tue, 19 Jun 2018 08:02:34 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 14E6820850;
        Tue, 19 Jun 2018 08:02:24 +0200 (CEST)
Date:   Tue, 19 Jun 2018 08:02:24 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH v2 3/6] mtd: rawnand: micron: add fixup for ONFI
 revision
Message-ID: <20180619080224.3bc1efa3@bbrezillon>
In-Reply-To: <20180619053125.16792-4-chris.packham@alliedtelesis.co.nz>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
        <20180619053125.16792-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 17:31:22 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Some Micron NAND chips (MT29F1G08ABAFAWP-ITE:F) report 00 00 for the
> revision number field of the ONFI parameter page. Rather than rejecting
> these outright assume ONFI version 1.0 if the revision number is 00 00.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> This is now qualified on vendor == MICRON. I haven't qualified this
> based on specific chips the ABAFA (id=d1) and ABBFA (id=a1) variants are
> documented to have this behaviour.
> 
> Changes in v2:
> - use fixup_onfi_param_page
> 
>  drivers/mtd/nand/raw/nand_micron.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index 0af45b134c0c..e582c9e61715 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -287,6 +287,14 @@ static int micron_nand_init(struct nand_chip *chip)
>  	return 0;
>  }
>  
> +static void micron_fixup_onfi_param_page(struct nand_chip *chip,
> +					 struct nand_onfi_params *p)
> +{

Could you add a comment repeating what you have in your commit message
here?

With this addressed

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> +	if (le16_to_cpu(p->revision) == 0)
> +		p->revision = cpu_to_le16(1 << 1);
> +}
> +
>  const struct nand_manufacturer_ops micron_nand_manuf_ops = {
>  	.init = micron_nand_init,
> +	.fixup_onfi_param_page = micron_fixup_onfi_param_page,
>  };

