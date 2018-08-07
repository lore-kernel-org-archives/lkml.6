Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB8AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D32E2168C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RJE6+PGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D32E2168C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeHGX5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:57:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39790 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeHGX5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:57:30 -0400
Received: by mail-pl0-f67.google.com with SMTP id w14-v6so53716plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/wSB16VyS3VlLE3061ezrJo0BvGRjdsaHKrAqB2zrRA=;
        b=RJE6+PGuB11s0MD5ztt8occHPwntgunby9WO1QA77WMm2ylSUqfgDdeiKP4J3iMkFi
         9MEyhpi1t1hUr90wXnWsh/Z1qo34LncT/aFxXR8dHIRu+2BmUnOB3s8KW9OlBxrmU1h2
         YAjz6R5j4j283iSth7syHZwXI04i1lLG7aKQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/wSB16VyS3VlLE3061ezrJo0BvGRjdsaHKrAqB2zrRA=;
        b=OW2hGthLF7V4os5kPd3KXLT1Tm/jE1tqaAInAr5TCVZ/mo1yRi/Bi6BCinsQJzi1il
         hd0yrlanP0sVA4c6s0rD6IFBXukvFcuduV2nSFHIjR5xriIKudqX0I14VZQT+TQL6H79
         foIalJOG2tuwXSeu0llhM732SgsJ6de7YBeraCiuMGGU3hmpZ2Qj/R5BKPqKbg169Qxd
         F0o+7+VXpggA/BEeEcM/1iXI5s7xuIF9+BY4c4YYFjUidx/C3Vuzy9j0GJ4NImy3p6Zi
         VY/ksGk5h/lmhsuoGE+8vVCuSB3/8PMC7H7BVXRf77vstCheDp6D3Uyvlohnm7jJ+3LL
         EK+Q==
X-Gm-Message-State: AOUpUlF+xmDdoMxtakJtOuk1mWQURt8o6OiPxf9PCBKgBoihKlf9APan
        Dalc4XFEOMI31MtvmYRTqD5VDg==
X-Google-Smtp-Source: AA+uWPxjUQPcaVdCTgSoRKyJ++tAAOXnY/TaFkhe6jTnUg14EKDQY2QG229AMniHje/lyvvoumbo/g==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6-v6mr99847plt.251.1533678067323;
        Tue, 07 Aug 2018 14:41:07 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id p11-v6sm3773518pfj.72.2018.08.07.14.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:41:05 -0700 (PDT)
Date:   Tue, 7 Aug 2018 14:41:04 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Escande <thierry.escande@collabora.com>
Subject: Re: [PATCH] firmware: coreboot: Let OF core populate platform device
Message-ID: <20180807214102.GA218251@ban.mtv.corp.google.com>
References: <20180806171047.227835-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806171047.227835-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Although I already 'Reviewed' this, I noticed another problem when I
went to look again:

On Mon, Aug 06, 2018 at 10:10:47AM -0700, Stephen Boyd wrote:
> Now that the /firmware/coreboot node in DT is populated by the core DT
> platform code with commit 3aa0582fdb82 ("of: platform: populate
> /firmware/ node from of_platform_default_populate_init()") we should and
> can remove the platform device creation here. Otherwise, the
> of_platform_device_create() call will fail, the coreboot of driver won't
> be registered, and this driver will never bind. At the same time, we can
> move this driver to use platform device APIs instead of DT specific ones
> and drop the of_node handling that was presumably placed there to hold a
> reference to the DT node created during module init.
> 
> Cc: Wei-Ning Huang <wnhuang@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/firmware/google/coreboot_table-of.c | 39 +++++----------------
>  1 file changed, 9 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/firmware/google/coreboot_table-of.c b/drivers/firmware/google/coreboot_table-of.c
> index f15bf404c579..270f112bdc54 100644
> --- a/drivers/firmware/google/coreboot_table-of.c
> +++ b/drivers/firmware/google/coreboot_table-of.c
> @@ -18,21 +18,20 @@
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/of_platform.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "coreboot_table.h"
>  
>  static int coreboot_table_of_probe(struct platform_device *pdev)
>  {
> -	struct device_node *fw_dn = pdev->dev.of_node;
>  	void __iomem *ptr;
> +	struct resource *res;
>  
> -	ptr = of_iomap(fw_dn, 0);
> -	of_node_put(fw_dn);
> -	if (!ptr)
> -		return -ENOMEM;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ptr = devm_ioremap_resource(&pdev->dev, res);

You're making this a devm_* ioremap, but coreboot_table_exit() will
handle unmapping this for you already. So you're introducing a potential
double-unmap.

> +	if (IS_ERR(ptr))
> +		return PTR_ERR(ptr);
>  
>  	return coreboot_table_init(&pdev->dev, ptr);
>  }
> @@ -44,8 +43,9 @@ static int coreboot_table_of_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id coreboot_of_match[] = {
>  	{ .compatible = "coreboot" },
> -	{},
> +	{}

...and since I had a *real* comment, I'll mention this bit I noticed
previously...this diff seems a bit superfluous. I understand we don't
really want to extend this list beyond the NULL terminator, but
normally, I'd expect we leave it alone.

Brian

>  };
> +MODULE_DEVICE_TABLE(of, coreboot_of_match);
>  
>  static struct platform_driver coreboot_table_of_driver = {
>  	.probe = coreboot_table_of_probe,
> @@ -55,28 +55,7 @@ static struct platform_driver coreboot_table_of_driver = {
>  		.of_match_table = coreboot_of_match,
>  	},
>  };
> -
> -static int __init platform_coreboot_table_of_init(void)
> -{
> -	struct platform_device *pdev;
> -	struct device_node *of_node;
> -
> -	/* Limit device creation to the presence of /firmware/coreboot node */
> -	of_node = of_find_node_by_path("/firmware/coreboot");
> -	if (!of_node)
> -		return -ENODEV;
> -
> -	if (!of_match_node(coreboot_of_match, of_node))
> -		return -ENODEV;
> -
> -	pdev = of_platform_device_create(of_node, "coreboot_table_of", NULL);
> -	if (!pdev)
> -		return -ENODEV;
> -
> -	return platform_driver_register(&coreboot_table_of_driver);
> -}
> -
> -module_init(platform_coreboot_table_of_init);
> +module_platform_driver(coreboot_table_of_driver);
>  
>  MODULE_AUTHOR("Google, Inc.");
>  MODULE_LICENSE("GPL");
> -- 
> Sent by a computer through tubes
> 
