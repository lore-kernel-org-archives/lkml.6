Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645ECC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3399A20828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuPgZpdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeL3RQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:16:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44362 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeL3RQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:16:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so11906936plt.11;
        Sun, 30 Dec 2018 09:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brQI5fj0uhmb8/TGIYm6CuOLijCOJYHnplKy2RgejWQ=;
        b=BuPgZpdLZo828+lc22AA41zmHzqkaMRhYP3upvRpotauiSA0BcO+N7zY9hD4wDyNRE
         +u3WTsZ6zPLb6BGeXutFMPSYBiDazo0LbVlnPTJ1dMNlRZ0p1H90+fuelhZ5R83i+TLl
         6Ze3hxb6+RtxLZhtK0GFE66FGvATXI16GOOQFbWXV8JEQIoxRqnmTH3FTQW89nkR7L1S
         LH0GsEog7vaDiePG8haEU63+ZnJwQWpUW+qo/ooh0fbq7YQOri87s3QL/vya1qw+AtPt
         nM1l72F4I+8drvONEUlBInW3iIUB6IjWOo57Kxc8VHoq1IagYL0WAfcmGi7ghaTo3BHh
         p7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=brQI5fj0uhmb8/TGIYm6CuOLijCOJYHnplKy2RgejWQ=;
        b=P4wt5DCmWoPsR2thyEF7SRFGgzUJIYl/36DixCfZEoIaFsLQSLvGgrV0sJO3EG2hHy
         /Kj8bvaKTSnr7M8E9Kun0XmKeW3ySV4ffgILOKIwTbqZvq/t57TN5NMikvPJi2YJcTkK
         LV+iozzuiKxeZVdENRoymR7eYrUaLSrXb/fcnE3ZC3dOvGm6F5c3BIxfF7k+jxpyMrVN
         FjNZVPXu7y5ToQz9yY7pvl+D2TzoVt4Nhz6Z239ig/paCSUSnP6C8WXaIY3obV9QvaR+
         17yS9zVpX6XLqbW1ct2wjcgN+cMhYEZGPMzhRuNVKEgNcBpML8g9odfcpgt41fpdLVU+
         gQJg==
X-Gm-Message-State: AJcUukfOE/AIGYxFxwvYLl1tGvlkcIUqtne+ZTAv4VdjdLHeq/HemeC1
        GVtyEqGE9f8QxxK3FgjNeRs=
X-Google-Smtp-Source: ALg8bN4STj67qfaPwKf23UhqC1VPC2J3hJRIlIqSKEzOPx/6PuHJqZk2bm+4xWyrfEsh8nR7j2u+ag==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr34754100plo.257.1546190210063;
        Sun, 30 Dec 2018 09:16:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 125sm82959308pfd.124.2018.12.30.09.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:16:48 -0800 (PST)
Date:   Sun, 30 Dec 2018 09:16:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     NeilBrown <neil@brown.name>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compilation problem for mt7621_wdt.c and rt2880_wdt.c
Message-ID: <20181230171647.GA8311@roeck-us.net>
References: <87va3baecv.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va3baecv.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 02:21:52PM +1100, NeilBrown wrote:
> 
> These files need
>    #include <linux/mod_devicetable.h>
> to compile correctly.
> 
> Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mt7621_wdt.c | 1 +
>  drivers/watchdog/rt2880_wdt.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index 5c4a764717c4..81208cd3f4ec 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -17,6 +17,7 @@
>  #include <linux/watchdog.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
>  
>  #include <asm/mach-ralink/ralink_regs.h>
>  
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index 98967f0a7d10..db7c57d82cfd 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -18,6 +18,7 @@
>  #include <linux/watchdog.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
>  
>  #include <asm/mach-ralink/ralink_regs.h>
>  
> -- 
> 2.14.0.rc0.dirty
> 


