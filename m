Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BDEECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7581F20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7581F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeKERaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:30:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55217 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725745AbeKERaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:30:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6ECD4207CF; Mon,  5 Nov 2018 09:11:35 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 120162072A;
        Mon,  5 Nov 2018 09:11:25 +0100 (CET)
Date:   Mon, 5 Nov 2018 09:11:24 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] mtd: sa1100: avoid VLA in sa1100_setup_mtd
Message-ID: <20181105091124.6594ee53@bbrezillon>
In-Reply-To: <20181105075835.16234-1-boris.brezillon@bootlin.com>
References: <20181105075835.16234-1-boris.brezillon@bootlin.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 08:58:35 +0100
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Enabling -Wvla found another variable-length array with randconfig
> testing:
> 
> drivers/mtd/maps/sa1100-flash.c: In function 'sa1100_setup_mtd':
> drivers/mtd/maps/sa1100-flash.c:224:10: error: ISO C90 forbids variable length array 'cdev' [-Werror=vla]
> 
> Dynamically allocate the cdev array passed to mtd_concat_create()
> instead of using a VLA.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Olof Johansson <olof@lixom.net>
> ---
> Changes in v2:
> - Allocate cdev dynamically instead of having a fixed-size array
> 
> Hello,
> 
> I'm planning to queue this patch to the mtd/fixes PR. Arnd, Kees, feel

						    ^ I meant branch,
not PR, but this patch should also be part of the 4.20-rc2 fixes PR.

> free to add your R-b.
> 
> Regards,
> 
> Boris
> ---
>  drivers/mtd/maps/sa1100-flash.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
> index 784c6e1a0391..fd5fe12d7461 100644
> --- a/drivers/mtd/maps/sa1100-flash.c
> +++ b/drivers/mtd/maps/sa1100-flash.c
> @@ -221,7 +221,14 @@ static struct sa_info *sa1100_setup_mtd(struct platform_device *pdev,
>  		info->mtd = info->subdev[0].mtd;
>  		ret = 0;
>  	} else if (info->num_subdev > 1) {
> -		struct mtd_info *cdev[nr];
> +		struct mtd_info **cdev;
> +
> +		cdev = kmalloc_array(nr, sizeof(*cdev), GFP_KERNEL);
> +		if (!cdev) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
>  		/*
>  		 * We detected multiple devices.  Concatenate them together.
>  		 */
> @@ -230,6 +237,7 @@ static struct sa_info *sa1100_setup_mtd(struct platform_device *pdev,
>  
>  		info->mtd = mtd_concat_create(cdev, info->num_subdev,
>  					      plat->name);
> +		kfree(cdev);
>  		if (info->mtd == NULL) {
>  			ret = -ENXIO;
>  			goto err;

