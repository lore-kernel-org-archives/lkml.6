Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F53C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D340C20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D340C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeJDEAh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:00:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49780 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725199AbeJDEAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:00:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D743D207F3; Wed,  3 Oct 2018 23:10:30 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 906762072B;
        Wed,  3 Oct 2018 23:10:20 +0200 (CEST)
Date:   Wed, 3 Oct 2018 23:10:21 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 8/8] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
Message-ID: <20181003231021.730ee909@bbrezillon>
In-Reply-To: <20181003193859.23928-8-ricardo.ribalda@gmail.com>
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
        <20181003193859.23928-8-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Oct 2018 21:38:59 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> Allow creating gpio-addr-flash via device-tree and not just via platform
> data.
> 
> Option parsing has been moved to separated functions.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/mtd/maps/gpio-addr-flash.c | 95 +++++++++++++++++++++++++++---
>  1 file changed, 87 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
> index 9e370e3158cd..1be2df81087a 100644
> --- a/drivers/mtd/maps/gpio-addr-flash.c
> +++ b/drivers/mtd/maps/gpio-addr-flash.c
> @@ -7,6 +7,7 @@
>   *
>   * Copyright © 2000 Nicolas Pitre <nico@cam.org>
>   * Copyright © 2005-2009 Analog Devices Inc.
> + * Copyright © 2018 Ricardo Ribalda <ricardo.ribalda@gmail.com>

Would you mind moving the copyright update to a separate patch?


> +
> +static void gf_device_parse_register(struct platform_device *pdev,
> +				     struct async_state *state)
> +{
> +	static const char * const part_probe_types[] = {
> +		"cmdlinepart", "RedBoot", "ofpart", "ofoldpart", NULL };
> +	struct device_node *dn;
> +
> +	dn = pdev->dev.of_node;
> +	if (!dn) {
> +		struct physmap_flash_data *pdata;
> +
> +		pdata = dev_get_platdata(&pdev->dev);
> +		mtd_device_parse_register(state->mtd, part_probe_types, NULL,
> +					  pdata->parts, pdata->nr_parts);
> +		return;
> +	}
> +
> +	mtd_device_parse_register(state->mtd, part_probe_types, NULL, NULL, 0);


Looks like you keep ignoring the mtd_device_parse_register() return.
Probably something you should fix at some point.

