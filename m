Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96602087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96602087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeH1SST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:18:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49052 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbeH1SST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:18:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6A9C0206F6; Tue, 28 Aug 2018 16:26:23 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 28CFA20618;
        Tue, 28 Aug 2018 16:26:13 +0200 (CEST)
Date:   Tue, 28 Aug 2018 16:26:11 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mtd: maps: gpio-addr-flash: Fix ioremapped size
Message-ID: <20180828162611.2f45e5c9@bbrezillon>
In-Reply-To: <20180821143152.32293-3-ricardo.ribalda@gmail.com>
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
        <20180821143152.32293-3-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 16:31:46 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> We should only iomap the area of the chip that is memory mapped.
> Otherwise we could be mapping devices beyond the memory space or that
> belong to other devices.
> 

Can you add

Fixes: ebd71e3a4861 ("mtd: maps: gpio-addr-flash: fix warnings and make more portable")

and in case you want to backport the fix:

Cc: <stable@vger.kernel.org>

> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/mtd/maps/gpio-addr-flash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
> index 17be47f72973..6de16e81994c 100644
> --- a/drivers/mtd/maps/gpio-addr-flash.c
> +++ b/drivers/mtd/maps/gpio-addr-flash.c
> @@ -234,7 +234,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
>  	state->map.copy_to    = gf_copy_to;
>  	state->map.bankwidth  = pdata->width;
>  	state->map.size       = state->win_size * (1 << state->gpio_count);
> -	state->map.virt       = ioremap_nocache(memory->start, state->map.size);
> +	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
>  	if (!state->map.virt)
>  		return -ENOMEM;
>  

