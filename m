Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8114C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6833213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfAJW13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:27:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34623 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbfAJW13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:27:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B5F9C207B0; Thu, 10 Jan 2019 23:27:26 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 87B4820729;
        Thu, 10 Jan 2019 23:27:26 +0100 (CET)
Date:   Thu, 10 Jan 2019 23:27:26 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jan Kotas <jank@cadence.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: Add Cadence RTC driver
Message-ID: <20190110222726.GI2362@piout.net>
References: <20190108122242.12411-1-jank@cadence.com>
 <20190108122242.12411-3-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108122242.12411-3-jank@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 08/01/2019 12:22:42+0000, Jan Kotas wrote:
>  drivers/rtc/Kconfig       |  10 ++
>  drivers/rtc/Makefile      |   1 +
>  drivers/rtc/rtc-cadence.c | 404 ++++++++++++++++++++++++++++++++++++++++++++++

I would prefer a name that is a bit less generic, unless you can
guarantee this driver will be able to handle every RTCs from Cadence.

> +static int cdns_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct cdns_rtc *crtc = dev_get_drvdata(dev);
> +
> +	if (enabled) {
> +		writel((CDNS_RTC_AEI_SEC | CDNS_RTC_AEI_MIN | CDNS_RTC_AEI_HOUR
> +			| CDNS_RTC_AEI_DATE | CDNS_RTC_AEI_SEC),

CDNS_RTC_AEI_SEC is used twice here.

> +		       crtc->regs + CDNS_RTC_AENR);
> +		writel(CDNS_RTC_AEI_ALRM, crtc->regs + CDNS_RTC_IENR);
> +	} else {
> +		writel(0, crtc->regs + CDNS_RTC_AENR);
> +		writel(CDNS_RTC_AEI_ALRM, crtc->regs + CDNS_RTC_IDISR);
> +	}
> +
> +	return 0;
> +}
> +


> +static int cdns_rtc_probe(struct platform_device *pdev)
> +{
> +	struct cdns_rtc *crtc;
> +	struct resource *res;
> +	int ret;
> +	unsigned long ref_clk_freq;
> +
> +	crtc = devm_kzalloc(&pdev->dev, sizeof(*crtc), GFP_KERNEL);
> +	if (!crtc)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	crtc->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(crtc->regs))
> +		return PTR_ERR(crtc->regs);
> +
> +	crtc->irq = platform_get_irq(pdev, 0);
> +	if (crtc->irq < 0)
> +		return -EINVAL;
> +
> +	crtc->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(crtc->pclk)) {
> +		ret = PTR_ERR(crtc->pclk);
> +		dev_err(&pdev->dev,
> +			"Failed to retrieve the peripheral clock, %d\n", ret);
> +		return ret;
> +	}
> +
> +	crtc->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
> +	if (IS_ERR(crtc->ref_clk)) {
> +		ret = PTR_ERR(crtc->ref_clk);
> +		dev_err(&pdev->dev,
> +			"Failed to retrieve the reference clock, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(crtc->pclk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to enable the peripheral clock, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(crtc->ref_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to enable the reference clock, %d\n", ret);
> +		goto err_disable_pclk;
> +	}
> +
> +	ref_clk_freq = clk_get_rate(crtc->ref_clk);
> +	if ((ref_clk_freq != 1) && (ref_clk_freq != 100)) {
> +		dev_err(&pdev->dev,
> +			"Invalid reference clock frequency %lu Hz.\n",
> +			ref_clk_freq);
> +		ret = -EINVAL;
> +		goto err_disable_ref_clk;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, crtc->irq,
> +			       cdns_rtc_irq_handler, 0,
> +			       dev_name(&pdev->dev), &pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Unable to request interrupt for the device, %d\n",
> +			ret);
> +		goto err_disable_ref_clk;
> +	}
> +

You should use devm_rtc_allocate_device to allocate crtc->rtc_dev before
requesting the IRQ. Else, this leaves a race condition open.

Also, please set crtc->rtc_dev->range_min and crtc->rtc_dev->range_max
according to the fully contiguous range of time that is supported by the
RTC. You can use
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-range.c
to assist you.

> +	/* Always use 24-hour mode */
> +	writel(0, crtc->regs + CDNS_RTC_HMR);
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +	platform_set_drvdata(pdev, crtc);
> +	cdns_rtc_set_enabled(crtc, true);

Is that really necessary? I guess you could check whether it has already
been enabled to know whether the currently set time is valid so
cdns_rtc_read_time could return -EINVAL when it knows it isn't valid.
cdns_rtc_set_time will enable the RTC once the time has been set anyway.

> +
> +	crtc->rtc_dev = devm_rtc_device_register(&pdev->dev,
> +						 dev_name(&pdev->dev),
> +						 &cdns_rtc_ops,
> +						 THIS_MODULE);
> +	if (IS_ERR(crtc->rtc_dev)) {
> +		ret = PTR_ERR(crtc->rtc_dev);
> +		dev_err(&pdev->dev, "Unable to register the rtc device, %d\n",
> +			ret);
> +		goto err_stop_rtc;
> +	}
> +
> +	return 0;
> +
> +err_stop_rtc:
> +	cdns_rtc_set_enabled(crtc, false);
> +
> +err_disable_ref_clk:
> +	clk_disable_unprepare(crtc->ref_clk);
> +
> +err_disable_pclk:
> +	clk_disable_unprepare(crtc->pclk);
> +
> +	return ret;
> +}
> +
> +static int cdns_rtc_remove(struct platform_device *pdev)
> +{
> +	struct cdns_rtc *crtc = platform_get_drvdata(pdev);
> +
> +	cdns_rtc_alarm_irq_enable(&pdev->dev, 0);
> +	device_init_wakeup(&pdev->dev, 0);
> +
> +	clk_disable_unprepare(crtc->pclk);
> +	clk_disable_unprepare(crtc->ref_clk);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cdns_rtc_suspend(struct device *dev)
> +{
> +	struct cdns_rtc *crtc = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(crtc->irq);
> +
> +	return 0;
> +}
> +
> +static int cdns_rtc_resume(struct device *dev)
> +{
> +	struct cdns_rtc *crtc = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(crtc->irq);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cdns_rtc_pm_ops, cdns_rtc_suspend, cdns_rtc_resume);
> +
> +static const struct of_device_id cdns_rtc_of_match[] = {
> +	{ .compatible = "cdns,rtc-r109v3" },

Is r109v3 an IP name or a revision?

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, cdns_rtc_of_match);
> +
> +static struct platform_driver cdns_rtc_driver = {
> +	.driver = {
> +		.name = "cdns-rtc",
> +		.of_match_table = cdns_rtc_of_match,
> +		.pm = &cdns_rtc_pm_ops,
> +	},
> +	.probe = cdns_rtc_probe,
> +	.remove = cdns_rtc_remove,
> +};
> +module_platform_driver(cdns_rtc_driver);
> +
> +MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
> +MODULE_DESCRIPTION("Cadence RTC driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:cdns-rtc");
> -- 
> 2.15.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
