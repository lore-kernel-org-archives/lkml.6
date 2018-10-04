Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61938C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319442084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319442084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJDUCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:02:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38089 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbeJDUCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:02:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 42254207CC; Thu,  4 Oct 2018 15:09:00 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id EEDD0207C4;
        Thu,  4 Oct 2018 15:08:49 +0200 (CEST)
Date:   Thu, 4 Oct 2018 15:08:50 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/10] mtd: physmap_of: Release resources on error
Message-ID: <20181004150850.780f6d21@bbrezillon>
In-Reply-To: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Thu,  4 Oct 2018 15:01:01 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> During probe, if there was an error the memory region and the memory
> map were not properly released.
> 
> This can lead a system unusable if deferred probe is in use.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/mtd/maps/physmap_of_core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/maps/physmap_of_core.c b/drivers/mtd/maps/physmap_of_core.c
> index 4129535b8e46..062add8b3a6e 100644
> --- a/drivers/mtd/maps/physmap_of_core.c
> +++ b/drivers/mtd/maps/physmap_of_core.c
> @@ -241,10 +241,10 @@ static int of_flash_probe(struct platform_device *dev)
>  
>  		err = of_flash_probe_gemini(dev, dp, &info->list[i].map);
>  		if (err)
> -			goto err_out;
> +			goto err_out_release;
>  		err = of_flash_probe_versatile(dev, dp, &info->list[i].map);
>  		if (err)
> -			goto err_out;
> +			goto err_out_release;
>  
>  		err = -ENOMEM;
>  		info->list[i].map.virt = ioremap(info->list[i].map.phys,
> @@ -252,7 +252,7 @@ static int of_flash_probe(struct platform_device *dev)
>  		if (!info->list[i].map.virt) {
>  			dev_err(&dev->dev, "Failed to ioremap() flash"
>  				" region\n");
> -			goto err_out;
> +			goto err_out_release;
>  		}
>  
>  		simple_map_init(&info->list[i].map);
> @@ -290,7 +290,7 @@ static int of_flash_probe(struct platform_device *dev)
>  		err = -ENXIO;
>  		if (!info->list[i].mtd) {
>  			dev_err(&dev->dev, "do_map_probe() failed\n");
> -			goto err_out;
> +			goto err_out_iounmap;
>  		} else {
>  			info->list_size++;
>  		}
> @@ -329,6 +329,10 @@ static int of_flash_probe(struct platform_device *dev)
>  
>  	return 0;
>  
> +err_out_iounmap:
> +	iounmap(info->list[i].map.virt);
> +err_out_release:
> +	release_mem_region(res.start, resource_size(&res));
>  err_out:
>  	kfree(mtd_list);
>  err_flash_remove:

Please fix that using devm_ioremap_resource() instead.

Thanks,

Boris
