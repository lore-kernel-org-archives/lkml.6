Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2AAC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A3D218DE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546625668;
	bh=yl70YXMnOZY6TSWDtyNoEOT2T8HudqSdL5M+ycZzo4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g76FM96bj5Cx6yhml2FMd/n4RUy/jIaRiQP7X+OpgJW7QeB3JJ2eBcpqraCs4fwjQ
	 jUVJq+NbjqqQmhdf9pqZ5a/LJsG92v/3jSbnj46PpUgzgQiBZPEx1yFMPwMFHOUQIC
	 6PZ1vQoKK581QZ3cBTPhbfKc82ItH/0HwQm/w/sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfADSO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:14:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADSO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:14:27 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A32F218CD;
        Fri,  4 Jan 2019 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546625666;
        bh=yl70YXMnOZY6TSWDtyNoEOT2T8HudqSdL5M+ycZzo4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jeYfp4Ho0q+FsMu0WoOzLu7YvbSENGHAKm+xB0VKXFzxsC9HABESIKaFqUKil4Dpu
         hZxGPuLZn6CmiIm/ANuld9kef8WTWlPqogSo8GgkB4iHqX1zIlCO2DE8bARPPZ91nB
         YYk2Uc5tBCJNAU+XM23zZUtHJfiMzRoR/HpK+j4c=
Date:   Fri, 4 Jan 2019 19:14:15 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: sunxi: Use struct_size() in
 devm_kzalloc()
Message-ID: <20190104191415.126e4a07@bbrezillon>
In-Reply-To: <20190104172637.GA28084@embeddedor>
References: <20190104172637.GA28084@embeddedor>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Fri, 4 Jan 2019 11:26:37 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index e828ee50a201..f66fffe663bf 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -1870,10 +1870,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>  		return -EINVAL;
>  	}
>  
> -	chip = devm_kzalloc(dev,
> -			    sizeof(*chip) +
> -			    (nsels * sizeof(struct sunxi_nand_chip_sel)),
> -			    GFP_KERNEL);
> +	chip = devm_kzalloc(dev, struct_size(chip, sels, nsels), GFP_KERNEL);
>  	if (!chip) {
>  		dev_err(dev, "could not allocate chip\n");
>  		return -ENOMEM;

I posted the same patch a few days back [1].

[1]http://patchwork.ozlabs.org/patch/1013855/
