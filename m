Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030559AbeBNUml (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:42:41 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:38475 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934933AbeBNUmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:42:38 -0500
Date: Wed, 14 Feb 2018 21:42:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] rtc: gemini/ftrtc010: disable clk on error paths in
 ftrtc010_rtc_probe()
Message-ID: <20180214204226.GE8219@piout.net>
References: <1517607957-5664-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517607957-5664-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 03/02/2018 at 00:45:57 +0300, Alexey Khoroshilov wrote:
> ftrtc010_rtc_probe() leaves clks enabled in case of errors.
> The patch adds proper disabling code.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/rtc/rtc-ftrtc010.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
> index af8d6beae20c..67a0aadf488c 100644
> --- a/drivers/rtc/rtc-ftrtc010.c
> +++ b/drivers/rtc/rtc-ftrtc010.c
> @@ -147,33 +147,52 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
>  		ret = clk_prepare_enable(rtc->extclk);
>  		if (ret) {
>  			dev_err(dev, "failed to enable EXTCLK\n");
> -			return ret;
> +			goto err_pclk;
>  		}
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res)
> -		return -ENODEV;
> +	if (!res) {
> +		ret = -ENODEV;
> +		goto err_extclk;
> +	}
>  
>  	rtc->rtc_irq = res->start;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> +	if (!res) {
> +		ret = -ENODEV;
> +		goto err_extclk;
> +	}
>  
>  	rtc->rtc_base = devm_ioremap(dev, res->start,
>  				     resource_size(res));
> -	if (!rtc->rtc_base)
> -		return -ENOMEM;
> +	if (!rtc->rtc_base) {
> +		ret = -ENOMEM;
> +		goto err_extclk;
> +	}
>  
>  	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
>  			       IRQF_SHARED, pdev->name, dev);
>  	if (unlikely(ret))
> -		return ret;
> +		goto err_extclk;
> 

To simplify the error handling, it is probably simpler to move the
clk_prepare_enable here.
 
>  	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
>  					   &ftrtc010_rtc_ops, THIS_MODULE);
> -	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
> +	if (IS_ERR(rtc->rtc_dev)) {
> +		ret = PTR_ERR(rtc->rtc_dev);
> +		goto err_extclk;
> +	}
> +
> +	return 0;
> +
> +err_extclk:
> +	if (!IS_ERR(rtc->extclk))
> +		clk_disable_unprepare(rtc->extclk);
> +err_pclk:
> +	if (!IS_ERR(rtc->pclk))
> +		clk_disable_unprepare(rtc->pclk);
> +	return ret;
>  }
>  
>  static int ftrtc010_rtc_remove(struct platform_device *pdev)
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
