Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2092AC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92B620644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92B620644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeJOQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:42:57 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51289 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:42:57 -0400
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="22434924"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 15 Oct 2018 01:58:36 -0700
Received: from [10.159.245.112] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Mon, 15 Oct 2018
 01:58:36 -0700
Subject: Re: [PATCH] usb: host: ohci-at91: fix request of irq for optional
 gpio
To:     Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "Cristian Birsan - M91496" <Cristian.Birsan@microchip.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181015083344.4157-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <6897566c-7a8b-e071-70df-8f730e93f087@microchip.com>
Date:   Mon, 15 Oct 2018 10:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015083344.4157-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2018 at 10:34, Tudor Ambarus - M18064 wrote:
> atmel,oc-gpio is optional. Request it's irq only when atmel,oc is set
> in device tree.
> 
> devm_gpiod_get_index_optional returns NULL if -ENOENT. Check its
> return value for NULL before error, because it is more probably that
> atmel,oc is not set.
> 
> This fixes the following errors on boards where atmel,oc is not set in
> device tree:
> [    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
> [    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
> [    0.970000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Yes, indeed:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
> Based on https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git,
> usb-next branch.
> 
>   drivers/usb/host/ohci-at91.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index e98673954020..ec6739ef3129 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -551,6 +551,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
>   		pdata->overcurrent_pin[i] =
>   			devm_gpiod_get_index_optional(&pdev->dev, "atmel,oc",
>   						      i, GPIOD_IN);
> +		if (!pdata->overcurrent_pin[i])
> +			continue;
>   		if (IS_ERR(pdata->overcurrent_pin[i])) {
>   			err = PTR_ERR(pdata->overcurrent_pin[i]);
>   			dev_err(&pdev->dev, "unable to claim gpio \"overcurrent\": %d\n", err);
> 


-- 
Nicolas Ferre
