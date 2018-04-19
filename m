Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeDSUG3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:06:29 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51065 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbeDSUG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:06:27 -0400
Date: Thu, 19 Apr 2018 13:06:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Michal Simek <michal.simek@xilinx.com>, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 59/61] watchdog: simplify getting .drvdata
Message-ID: <20180419200623.GB24732@roeck-us.net>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-60-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-60-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:06:29PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/watchdog/cadence_wdt.c   | 6 ++----
>  drivers/watchdog/of_xilinx_wdt.c | 6 ++----
>  drivers/watchdog/wdat_wdt.c      | 6 ++----
>  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index 3ec1f418837d..c3924356d173 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -418,8 +418,7 @@ static void cdns_wdt_shutdown(struct platform_device *pdev)
>   */
>  static int __maybe_unused cdns_wdt_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
> +	struct cdns_wdt *wdt = dev_get_drvdata(dev);
>  
>  	if (watchdog_active(&wdt->cdns_wdt_device)) {
>  		cdns_wdt_stop(&wdt->cdns_wdt_device);
> @@ -438,8 +437,7 @@ static int __maybe_unused cdns_wdt_suspend(struct device *dev)
>  static int __maybe_unused cdns_wdt_resume(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
> +	struct cdns_wdt *wdt = dev_get_drvdata(dev);
>  
>  	if (watchdog_active(&wdt->cdns_wdt_device)) {
>  		ret = clk_prepare_enable(wdt->clk);
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 4acbe05e27bb..d3f7eb046678 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -268,8 +268,7 @@ static int xwdt_remove(struct platform_device *pdev)
>   */
>  static int __maybe_unused xwdt_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct xwdt_device *xdev = platform_get_drvdata(pdev);
> +	struct xwdt_device *xdev = dev_get_drvdata(dev);
>  
>  	if (watchdog_active(&xdev->xilinx_wdt_wdd))
>  		xilinx_wdt_stop(&xdev->xilinx_wdt_wdd);
> @@ -285,8 +284,7 @@ static int __maybe_unused xwdt_suspend(struct device *dev)
>   */
>  static int __maybe_unused xwdt_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct xwdt_device *xdev = platform_get_drvdata(pdev);
> +	struct xwdt_device *xdev = dev_get_drvdata(dev);
>  	int ret = 0;
>  
>  	if (watchdog_active(&xdev->xilinx_wdt_wdd))
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 0da9943d405f..56ad19608a9b 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -447,8 +447,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int wdat_wdt_suspend_noirq(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct wdat_wdt *wdat = platform_get_drvdata(pdev);
> +	struct wdat_wdt *wdat = dev_get_drvdata(dev);
>  	int ret;
>  
>  	if (!watchdog_active(&wdat->wdd))
> @@ -475,8 +474,7 @@ static int wdat_wdt_suspend_noirq(struct device *dev)
>  
>  static int wdat_wdt_resume_noirq(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct wdat_wdt *wdat = platform_get_drvdata(pdev);
> +	struct wdat_wdt *wdat = dev_get_drvdata(dev);
>  	int ret;
>  
>  	if (!watchdog_active(&wdat->wdd))
> -- 
> 2.11.0
> 
