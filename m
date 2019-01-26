Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DB7C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30963218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548496351;
	bh=NvJwRTne2XBLYpaa43t+2CusW49FJOtCICODfrZ8D+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hHponmA47gATHAUTbpHkW7+Ho7Vq9dkhZU9PTUF3KEWQTN2MUagvLekqsFOzbKJpT
	 GC2Yk8E97T5UqEye2ZcXxbvgb9hPYrXUcDfXwhdqEQdKN7AJ+q1NfpwJJb0tVtoELj
	 sxWfSEffF7nhCt1S9WByhpeTjzVwM9zTxIuIH62A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfAZJw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfAZJwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:52:22 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7AB6214C6;
        Sat, 26 Jan 2019 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548496341;
        bh=NvJwRTne2XBLYpaa43t+2CusW49FJOtCICODfrZ8D+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J6+IFAvHadi5Fi32frk9X7fK1WAk40QgNpSHA0k9lP4yAwtg+q75FN/2WBsMTmjWb
         i8zrnYxIiyCA89WyCGeQAdyq5ve9VJeRVOLZO5vmuDH8id2dV5IZiRpv0vXbPPiQXC
         xqPXfIhWlalcWpADrK3nL+ua4wFYWKRa9o8afNpg=
Date:   Sat, 26 Jan 2019 10:52:08 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mtd: rawnand: mark expected switch fall-throughs
Message-ID: <20190126105208.221a2051@bbrezillon>
In-Reply-To: <20190125210950.GA27855@embeddedor>
References: <20190125210950.GA27855@embeddedor>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 15:09:50 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
> index 933d1a629c51..d33e15dc4cdc 100644
> --- a/drivers/mtd/nand/raw/nandsim.c
> +++ b/drivers/mtd/nand/raw/nandsim.c
> @@ -2251,9 +2251,10 @@ static int __init ns_init_module(void)
>  
>  	switch (bbt) {
>  	case 2:
> -		 chip->bbt_options |= NAND_BBT_NO_OOB;
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +		/* fall through */
>  	case 1:
> -		 chip->bbt_options |= NAND_BBT_USE_FLASH;
> +		chip->bbt_options |= NAND_BBT_USE_FLASH;

You miss a '/* fall through */' here.

>  	case 0:
>  		break;
>  	default:
