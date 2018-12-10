Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95426C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502B82082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Di/n32i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502B82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeLJGi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:38:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44796 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:38:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so9169122wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pvrR+VaVCx5fOzI3ao59RjiYJnrfT9XJJoLAOvvO+uw=;
        b=Di/n32i032S3gsp2E7WYLYTMzapLCJzztStLV/l/GRg3lzpUEzGGeK3zb08qKtQ6Ad
         Y5UkGqziKXxd1c1IueqVfv835cKdfh0Zpt7g4FJQCEdvIjczaDV9f8VJ438S+u+SN6da
         QqmHMMiri3PWE/YTsz09wdI8t4x8HtgrHs+n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pvrR+VaVCx5fOzI3ao59RjiYJnrfT9XJJoLAOvvO+uw=;
        b=MYcZ6jsR0zo6ZkVQpJs5gh3M9tCEOBgy35CvIRWe1vIN6e9dJybJSzybQJCRJObqNb
         wK/FueGxlIi2AssuH1drqoh1+VAcGg6XnrJAH6/LaauJ/7LXYFoU4g+l6F7M02iAGY8X
         P2IBHoRy+c4myuDIA8+LMpkp+fhHghlrBocoZ4gZ5mxYBy9Kpiuuq+QXJjZ/pyJP0u7f
         WvY2qeBFTp0R72sQSUXkmH5ZGeYeIeKn8lXRW9SiVCBJh37VqawCLnFi8rFMK7gMHFTE
         PbjgLRnjq2Bc0d936vVpZYLyI2cuu/eVtWHvM6SYxSnupIVyQXTInLET0qyPk40M1wxZ
         iMBg==
X-Gm-Message-State: AA+aEWaxFkNkR6iKl5Mdi0flww+DFKJLhSfFOldyjc00ZCxVh4674def
        tO8l57qlg2SBcokRtEJEbqcumC9sKf4=
X-Google-Smtp-Source: AFSGD/V2nx3ESd+Akqq0Zg+uRUygqBU7Gz1xFBRQHmbkYwfhcnWJyfwaneVPOYHQEhpnGwXZ0D4Mkg==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr8266848wrv.287.1544423935768;
        Sun, 09 Dec 2018 22:38:55 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id r77sm20649055wmd.22.2018.12.09.22.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:38:55 -0800 (PST)
Date:   Mon, 10 Dec 2018 06:38:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 17/18] mfd: wm8350-core: drop unused MODULE_ tags from
 non-modular code
Message-ID: <20181210063853.GU26661@dell>
References: <1544213465-16259-1-git-send-email-paul.gortmaker@windriver.com>
 <1544213465-16259-18-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544213465-16259-18-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Dec 2018, Paul Gortmaker wrote:

> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config MFD_WM8350
> drivers/mfd/Kconfig:    bool
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> We replace module.h with init.h and export.h ; the latter since the
> file does export some symbols.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: patches@opensource.cirrus.com
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

When you submit this patch again (collecting more Acks or
what-have-you), please re-order your tags chronologically.

Your SoB here should represent the first time you submitted the patch,
therefore it would be impossible for Linus to review the patch on the
ML *before* you sent it.

> ---
>  drivers/mfd/wm8350-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/wm8350-core.c b/drivers/mfd/wm8350-core.c
> index 8a07c5634aee..e6434a4d7439 100644
> --- a/drivers/mfd/wm8350-core.c
> +++ b/drivers/mfd/wm8350-core.c
> @@ -13,7 +13,8 @@
>   */
>  
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/bug.h>
>  #include <linux/device.h>
> @@ -466,6 +467,3 @@ void wm8350_device_exit(struct wm8350 *wm8350)
>  	wm8350_irq_exit(wm8350);
>  }
>  EXPORT_SYMBOL_GPL(wm8350_device_exit);
> -
> -MODULE_DESCRIPTION("WM8350 AudioPlus PMIC core driver");
> -MODULE_LICENSE("GPL");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
