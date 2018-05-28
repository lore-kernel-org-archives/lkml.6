Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034695AbeE1PmB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:42:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44592 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965409AbeE1Plv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:41:51 -0400
X-Google-Smtp-Source: ADUXVKIRrqsITqC+Ba6c5djv7RRoOaCaH+DqUYNpElz1xgJLt5thwTo9UatL9fDJXqem4yXVCGqj1g==
Date: Mon, 28 May 2018 17:41:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: dwc3: of_simple: don't call
 pm_runtime_set_active()
Message-ID: <20180528152030.GA3261@localhost>
References: <1527518174-27860-1-git-send-email-rogerq@ti.com>
 <1527518174-27860-2-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527518174-27860-2-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 05:36:14PM +0300, Roger Quadros wrote:
> Don't call pm_runtime_set_active() as it will prevent the device
> from being activated in the next pm_runtime_get_sync() call.
> 
> Also call pm_runtime_get_sync() before of_platform_populate().

This paragraph describes what you do, but not why do it.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index e98d221..2cbb5c0 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -121,6 +121,9 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_resetc_assert;
>  
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);

This breaks runtime pm as you now get a second round of clock enables
which are never balanced on runtime suspend (the clocks are first
enabled in dwc3_of_simple_clk_init() above and with your change again in
dwc3_of_simple_runtime_resume()).

On the other hand, we currently return from probe() with a positive RPM
count so perhaps the RPM callbacks can just be removed altogether (i.e.
unless some other entity drops that count at some point before
remove()).

>  	ret = of_platform_populate(np, NULL, NULL, dev);
>  	if (ret) {
>  		for (i = 0; i < simple->num_clocks; i++) {
> @@ -131,10 +134,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  		goto err_resetc_assert;
>  	}
>  
> -	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> -	pm_runtime_get_sync(dev);
> -
>  	return 0;
>  
>  err_resetc_assert:

Also note that there's currently a use-after-free in remove(), where
pm_runtime_put_sync() is called after the clocks have been put.
Something like the below (untested) patch should fix it.

Johan


>From 35c384c31010c344d403c26fc0a1dde0fd68ef4a Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 28 May 2018 17:31:45 +0200
Subject: [PATCH] usb: dwc3: of-simple: fix use-after-free on remove

The clocks have already been explicitly disabled and put as part of
remove() so the runtime suspend callback must not be run when balancing
the runtime PM usage count before returning.

Fixes: 16adc674d0d6 ("usb: dwc3: add generic OF glue layer")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index cb2ee96fd3e8..b9c869cd6585 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -165,8 +165,9 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
 
 	reset_control_put(simple->resets);
 
-	pm_runtime_put_sync(dev);
+	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 	return 0;
 }
-- 
2.17.0
