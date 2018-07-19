Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FE9C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D9E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D9E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbeGSRWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:22:00 -0400
Received: from www381.your-server.de ([78.46.137.84]:35199 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbeGSRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:22:00 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1fgBwD-0005qg-4Z; Thu, 19 Jul 2018 18:37:57 +0200
Received: from [2003:8b:4817:700:8200:bff:fe9b:6612]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1fgBwC-000LlH-Vg; Thu, 19 Jul 2018 18:37:57 +0200
Subject: Re: [PATCH 4/4] iio: adc: xilinx: Use devm_ functions while
 requesting irq
To:     Manish Narani <manish.narani@xilinx.com>, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, michal.simek@xilinx.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     anirudh@xilinx.com, sgoud@xilinx.com
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-5-git-send-email-manish.narani@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <32791313-d317-c9c3-0760-34d4a4a691f9@metafoo.de>
Date:   Thu, 19 Jul 2018 18:37:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531912331-26431-5-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24763/Thu Jul 19 10:39:52 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1310,7 +1308,6 @@ static int xadc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct xadc *xadc = iio_priv(indio_dev);
> -	int irq = platform_get_irq(pdev, 0);
>  
>  	iio_device_unregister(indio_dev);
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
> @@ -1318,7 +1315,6 @@ static int xadc_remove(struct platform_device *pdev)
>  		iio_trigger_free(xadc->convst_trigger);
>  		iio_triggered_buffer_cleanup(indio_dev);
>  	}
> -	free_irq(irq, indio_dev);

This opens up a race condition. The IRQ needs to be freed before any of
these other things below the free_irq() are executed.

>  	clk_disable_unprepare(xadc->clk);
>  	cancel_delayed_work(&xadc->zynq_unmask_work);
>  	kfree(xadc->data);
> 

