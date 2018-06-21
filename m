Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDC1C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44C224A0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E44C224A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933899AbeFUWVW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:21:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36405 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933187AbeFUWVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:21:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A69B620834; Fri, 22 Jun 2018 00:21:19 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6A131206D8;
        Fri, 22 Jun 2018 00:21:09 +0200 (CEST)
Date:   Fri, 22 Jun 2018 00:21:09 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: gpio_flash: add error handling for ioremap_nocache
Message-ID: <20180622002109.0cffb249@bbrezillon>
In-Reply-To: <1528773302-37265-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528773302-37265-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 11:15:00 +0800
Zhouyang Jia <jiazhouyang09@gmail.com> wrote:

> When ioremap_nocache fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling ioremap_nocache.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/mtd/maps/gpio-addr-flash.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
> index 385305e..7fbba02 100644
> --- a/drivers/mtd/maps/gpio-addr-flash.c
> +++ b/drivers/mtd/maps/gpio-addr-flash.c
> @@ -242,6 +242,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
>  	state->map.phys       = NO_XIP;
>  	state->map.map_priv_1 = (unsigned long)state;
>  
> +	if (!state->map.virt)
> +		return -ENOMEM;

Please move the test just after the ioremap_nocache() call. Also, I see
that iounmap() is never called. Probably a good opportunity to switch
to devm_ funcs.

> +
>  	platform_set_drvdata(pdev, state);
>  
>  	i = 0;

