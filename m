Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29943C71134
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF452089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF452089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeJOXJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:09:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55270 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726526AbeJOXJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:09:27 -0400
Received: (qmail 2198 invoked by uid 2102); 15 Oct 2018 11:23:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Oct 2018 11:23:44 -0400
Date:   Mon, 15 Oct 2018 11:23:44 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Tudor.Ambarus@microchip.com
cc:     gregkh@linuxfoundation.org, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Cristian.Birsan@microchip.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: host: ohci-at91: fix request of irq for optional
 gpio
In-Reply-To: <20181015090001.5195-1-tudor.ambarus@microchip.com>
Message-ID: <Pine.LNX.4.44L0.1810151123330.1394-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 Tudor.Ambarus@microchip.com wrote:

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
> ---
> v2: fix typos in commit message s/it's/its, s/probably/probable
> 
> Based on https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git,
> usb-next branch.
> 
>  drivers/usb/host/ohci-at91.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index e98673954020..ec6739ef3129 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -551,6 +551,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
>  		pdata->overcurrent_pin[i] =
>  			devm_gpiod_get_index_optional(&pdev->dev, "atmel,oc",
>  						      i, GPIOD_IN);
> +		if (!pdata->overcurrent_pin[i])
> +			continue;
>  		if (IS_ERR(pdata->overcurrent_pin[i])) {
>  			err = PTR_ERR(pdata->overcurrent_pin[i]);
>  			dev_err(&pdev->dev, "unable to claim gpio \"overcurrent\": %d\n", err);

Acked-by: Alan Stern <stern@rowland.harvard.edu>

