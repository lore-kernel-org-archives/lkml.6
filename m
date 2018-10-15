Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF61C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87642064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87642064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJOQ4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:56:45 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51135 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeJOQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:56:44 -0400
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="22435647"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Oct 2018 02:12:21 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Mon, 15 Oct 2018
 02:12:20 -0700
Subject: Re: [PATCH v2] usb: host: ohci-at91: fix request of irq for optional
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
References: <20181015090001.5195-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <40003ebc-2aee-d4fb-a813-68c1c92a9b7a@microchip.com>
Date:   Mon, 15 Oct 2018 11:12:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015090001.5195-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2018 at 11:00, Tudor Ambarus - M18064 wrote:
> atmel,oc-gpio is optional. Request its irq only when atmel,oc is set
> in device tree.
> 
> devm_gpiod_get_index_optional returns NULL if -ENOENT. Check its
> return value for NULL before error, because it is more probable that
> atmel,oc is not set.
> 
> This fixes the following errors on boards where atmel,oc is not set in
> device tree:
> [    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
> [    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
> [    0.970000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

As for v1 (patchwork friendly addition):
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Bye,
   Nicolas

> ---
> v2: fix typos in commit message s/it's/its, s/probably/probable
> 
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
