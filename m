Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA0FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975DE215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975DE215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeI0RxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:53:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50904 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbeI0RxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:53:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ABFDA2071E; Thu, 27 Sep 2018 13:35:23 +0200 (CEST)
Received: from bbrezillon (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        by mail.bootlin.com (Postfix) with ESMTPSA id 867FB20711;
        Thu, 27 Sep 2018 13:35:13 +0200 (CEST)
Date:   Thu, 27 Sep 2018 13:35:13 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 3/8] mtd: maps: gpio-addr-flash: Use devm_* functions
Message-ID: <20180927133513.487666f0@bbrezillon>
In-Reply-To: <20180905143643.9871-4-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
        <20180905143643.9871-4-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Sep 2018 16:36:38 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> @@ -234,9 +234,11 @@ static int gpio_flash_probe(struct platform_device *pdev)
>  	state->map.copy_to    = gf_copy_to;
>  	state->map.bankwidth  = pdata->width;
>  	state->map.size       = state->win_size * (1 << state->gpio_count);
> -	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
> -	if (!state->map.virt)
> -		return -ENOMEM;
> +	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
> +	if (IS_ERR(state->map.virt)) {
> +		dev_err(&pdev->dev, "failed to map memory\n");

You can drop this error message, devm_ioremap_resource() already takes
care of that (no need to send a new version, I'll fix it when applying).

> +		return PTR_ERR(state->map.virt);
> +	}

