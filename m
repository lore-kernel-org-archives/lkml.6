Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeCHVmf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:42:35 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35926 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeCHVma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:42:30 -0500
X-Google-Smtp-Source: AG47ELtgTwj89MtbeYJF4akgmsOmk+UlriWVbJxG58EmhFdHi/fBLVBecWxvc5Maf02p+rIw3beslQ==
Date: Thu, 8 Mar 2018 13:42:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Eric Long <eric.long@spreadtrum.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] watchdog: sprd_wdt: Fix error handling in
 sprd_wdt_enable()
Message-ID: <20180308214227.GA28321@roeck-us.net>
References: <1520544108-11145-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520544108-11145-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 12:21:48AM +0300, Alexey Khoroshilov wrote:
> If clk_prepare_enable(wdt->rtc_enable) fails,
> wdt->enable clock is left enabled.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sprd_wdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
> index a8b280ff33e0..b4d484a42b70 100644
> --- a/drivers/watchdog/sprd_wdt.c
> +++ b/drivers/watchdog/sprd_wdt.c
> @@ -154,8 +154,10 @@ static int sprd_wdt_enable(struct sprd_wdt *wdt)
>  	if (ret)
>  		return ret;
>  	ret = clk_prepare_enable(wdt->rtc_enable);
> -	if (ret)
> +	if (ret) {
> +		clk_disable_unprepare(wdt->enable);
>  		return ret;
> +	}
>  
>  	sprd_wdt_unlock(wdt->base);
>  	val = readl_relaxed(wdt->base + SPRD_WDT_CTRL);
> -- 
> 2.7.4
> 
