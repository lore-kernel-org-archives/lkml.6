Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755718AbeCWKuW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:50:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43440 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751841AbeCWKuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:50:19 -0400
Date: Fri, 23 Mar 2018 11:50:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: sean.wang@mediatek.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org,
        lee.jones@linaro.org, a.zummo@towertech.it, eddie.huang@mediatek.com,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/16] rtc: mediatek: convert to use device managed
 functions
Message-ID: <20180323105017.GI3417@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
 <fbfb1852838820c198d55bc74940a74f1d0b53ed.1521794177.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbfb1852838820c198d55bc74940a74f1d0b53ed.1521794177.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2018 at 17:15:06 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Use device managed operation to simplify error handling, reduce source
> code size, and reduce the likelyhood of bugs, and remove our removal
> callback which contains anything already done by device managed functions.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index cefb83b..bfc5d6f 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -14,6 +14,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/rtc.h>
> @@ -328,10 +329,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, rtc);
>  
> -	ret = request_threaded_irq(rtc->irq, NULL,
> -				   mtk_rtc_irq_handler_thread,
> -				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> -				   "mt6397-rtc", rtc);
> +	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> +					mtk_rtc_irq_handler_thread,
> +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> +					"mt6397-rtc", rtc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
>  			rtc->irq, ret);
> @@ -340,30 +341,15 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  
>  	device_init_wakeup(&pdev->dev, 1);
>  
> -	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> -					   &mtk_rtc_ops, THIS_MODULE);
> +	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, "mt6397-rtc",
> +						&mtk_rtc_ops, THIS_MODULE);

You should probably switch to devm_rtc_allocate_device() and
rtc_register_device instead of devm_rtc_device_register.

>  	if (IS_ERR(rtc->rtc_dev)) {
>  		dev_err(&pdev->dev, "register rtc device failed\n");
>  		ret = PTR_ERR(rtc->rtc_dev);
> -		goto out_free_irq;
> +		return ret;

ret doesn't seem necessary anymore here.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
