Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6768DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCED21EC2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LBS+kid6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCED21EC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbeHIT5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:57:55 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36863 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbeHIT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:57:55 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so2840706plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2YIqz7RFrURXk73J6NzacpTb3IvrxVmNrMqfYibYhl0=;
        b=LBS+kid6TNmen/n6wLUoyJlXsvW0AcBYD3rjLmkBYZj5XY4k5tpiiv/sO16AnbWTDh
         075pTC2Il6H/1sRw/OHmwO1RoALNga9RyfVXuhdWV0KUFyDd4fdA3fBQjA+AnyTuReZK
         8q4u26vshyG38Zjd3oZD6Mb/IkNAku+93v0f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2YIqz7RFrURXk73J6NzacpTb3IvrxVmNrMqfYibYhl0=;
        b=L7mPeX7pCBzrH0gJJxI+VPXcY9TaPGO3byu+ie5meWEt4bTEeG08a+eqA/fSOekq55
         2Z43iPaE7UmPc0Pn0JH7m26cBKXKvK6w6VIG+p+/nl78kOCWl4g5zogxiIzrJCFK/t8r
         gs9xGU98y6yGK/pL3ZcTGdDpR69FJPFL1mcEX7qid+zyz1pwJYbN3DrCIg3Dca4F7mfY
         +8KaylS0Ckp2R0AAdrsm/SmumtLy/2wt5bVqfsVSBPJMT3/q/eplABVztfduz/feyjQu
         mT6dBunR3PSUEoWXdSUj9NE7OCbIAtp91xulXmBrnhLuwUgBmpNaS+dWQWT1bfjwqUC7
         MDtA==
X-Gm-Message-State: AOUpUlFp+MT7IVLDEswt5+av9dVZO6wLCFM2iPv8Z5zbXILBHVV7hK7q
        QruNkvCKFGkq1q/ff3+y55aDrw==
X-Google-Smtp-Source: AA+uWPxOl1scoP7zwyXdQqX2iPTzN5Ck7AUU9wmCecgeJdyEisxRzYfWmqnqSfdedt2SpxvRGwtWdw==
X-Received: by 2002:a17:902:28a6:: with SMTP id f35-v6mr2821250plb.240.1533835923206;
        Thu, 09 Aug 2018 10:32:03 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id w81-v6sm18469816pfk.92.2018.08.09.10.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 10:32:01 -0700 (PDT)
Date:   Thu, 9 Aug 2018 10:31:59 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 1/7] firmware: coreboot: Let OF core populate platform
 device
Message-ID: <20180809173158.GB129285@ban.mtv.corp.google.com>
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809171722.144325-2-swboyd@chromium.org>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 09, 2018 at 10:17:16AM -0700, Stephen Boyd wrote:
> Now that the /firmware/coreboot node in DT is populated by the core DT
> platform code with commit 3aa0582fdb82 ("of: platform: populate
> /firmware/ node from of_platform_default_populate_init()") we should and
> can remove the platform device creation here. Otherwise, the
> of_platform_device_create() call will fail, the coreboot of driver won't
> be registered, and this driver will never bind. At the same time, we
> should move this driver to use MODULE_DEVICE_TABLE so that module
> auto-load works properly when the coreboot device is auto-populated and
> we should drop the of_node handling that was presumably placed here to
> hold a reference to the DT node created during module init that no
> longer happens.

Yep, the of_node_put() was to complement of_find_compatible_node() which
was originally done in probe(), and then of_find_node_by_path() in
__init when it was upstreamed, and now it's no longer needed.

> 
> Cc: Wei-Ning Huang <wnhuang@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Reviewed-by: Sudeep Holla <Sudeep.Holla@arm.com>
> Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_platform_default_populate_init()")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/firmware/google/coreboot_table-of.c | 28 +++------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)

Change looks good:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks!

Now to go figure out how a simple bugfix managed to blow up into a
7-patch series... If this goes on any longer, patch 1 should probably go
by itself, to fix the regression.

Brian

> diff --git a/drivers/firmware/google/coreboot_table-of.c b/drivers/firmware/google/coreboot_table-of.c
> index f15bf404c579..9b90c0fa4a0b 100644
> --- a/drivers/firmware/google/coreboot_table-of.c
> +++ b/drivers/firmware/google/coreboot_table-of.c
> @@ -19,7 +19,6 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  
>  #include "coreboot_table.h"
> @@ -30,7 +29,6 @@ static int coreboot_table_of_probe(struct platform_device *pdev)
>  	void __iomem *ptr;
>  
>  	ptr = of_iomap(fw_dn, 0);
> -	of_node_put(fw_dn);
>  	if (!ptr)
>  		return -ENOMEM;
>  
> @@ -44,8 +42,9 @@ static int coreboot_table_of_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id coreboot_of_match[] = {
>  	{ .compatible = "coreboot" },
> -	{},
> +	{}
>  };
> +MODULE_DEVICE_TABLE(of, coreboot_of_match);
>  
>  static struct platform_driver coreboot_table_of_driver = {
>  	.probe = coreboot_table_of_probe,
> @@ -55,28 +54,7 @@ static struct platform_driver coreboot_table_of_driver = {
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
