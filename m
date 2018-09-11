Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ED5C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E2720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E2720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeIKQbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:31:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26043 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726563AbeIKQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:31:34 -0400
X-UUID: 4c2ea15926ee45c89260f0c39ff4f565-20180911
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <eddie.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1548744902; Tue, 11 Sep 2018 19:32:32 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 11 Sep 2018 19:32:26 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 11 Sep 2018 19:32:26 +0800
Message-ID: <1536665546.25102.1.camel@mtksdaap41>
Subject: Re: [PATCH 1/3] rtc: mt6397: fix possible race condition
From:   Eddie Huang <eddie.huang@mediatek.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Date:   Tue, 11 Sep 2018 19:32:26 +0800
In-Reply-To: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
References: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-09 at 22:38 +0200, Alexandre Belloni wrote:
> The IRQ is requested before the struct rtc is allocated and registered, but
> this struct is used in the IRQ handler. This may lead to a NULL pointer
> dereference.
> 
> Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
> before requesting the IRQ.
> 
> Cc: Eddie Huang <eddie.huang@mediatek.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index 385f8303bb41..e9a25ec4d434 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -332,6 +332,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, rtc);
>  
> +	rtc->rtc_dev = devm_rtc_allocate_device(rtc->dev);
> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
>  	ret = request_threaded_irq(rtc->irq, NULL,
>  				   mtk_rtc_irq_handler_thread,
>  				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> @@ -344,11 +348,11 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  
>  	device_init_wakeup(&pdev->dev, 1);
>  
> -	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> -					   &mtk_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc->rtc_dev)) {
> +	rtc->rtc_dev->ops = &mtk_rtc_ops;
> +
> +	ret = rtc_register_device(rtc->rtc_dev);
> +	if (ret) {
>  		dev_err(&pdev->dev, "register rtc device failed\n");
> -		ret = PTR_ERR(rtc->rtc_dev);
>  		goto out_free_irq;
>  	}
>  
> @@ -365,7 +369,6 @@ static int mtk_rtc_remove(struct platform_device *pdev)
>  {
>  	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
>  
> -	rtc_device_unregister(rtc->rtc_dev);
>  	free_irq(rtc->irq, rtc->rtc_dev);
>  	irq_dispose_mapping(rtc->irq);
>  

Thanks

Acked-by: Eddie Huang <eddie.huang@mediatek.com>



