Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C994C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA3C21A08
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA3C21A08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeGGJ7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 05:59:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51617 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751693AbeGGJ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 05:59:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A626F207AB; Sat,  7 Jul 2018 11:59:15 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6767820741;
        Sat,  7 Jul 2018 11:59:15 +0200 (CEST)
Date:   Sat, 7 Jul 2018 11:59:16 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: gpio_flash: add error handling for
 ioremap_nocache
Message-ID: <20180707115916.1bbe954c@bbrezillon>
In-Reply-To: <1529632343-70907-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528773302-37265-1-git-send-email-jiazhouyang09@gmail.com>
        <1529632343-70907-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 09:52:20 +0800
Zhouyang Jia <jiazhouyang09@gmail.com> wrote:

> When ioremap_nocache fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling ioremap_nocache.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>

Applied.

Thanks,

Boris

> ---
> v1->v2:
> - Move the test just after the ioremap_nocache() call.
> ---
>  drivers/mtd/maps/gpio-addr-flash.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
> index 385305e..9d97236 100644
> --- a/drivers/mtd/maps/gpio-addr-flash.c
> +++ b/drivers/mtd/maps/gpio-addr-flash.c
> @@ -239,6 +239,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
>  	state->map.bankwidth  = pdata->width;
>  	state->map.size       = state->win_size * (1 << state->gpio_count);
>  	state->map.virt       = ioremap_nocache(memory->start, state->map.size);
> +	if (!state->map.virt)
> +		return -ENOMEM;
> +
>  	state->map.phys       = NO_XIP;
>  	state->map.map_priv_1 = (unsigned long)state;
>  

