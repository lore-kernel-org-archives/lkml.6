Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716B7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEAB2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G8woGgtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfBLIVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:21:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47012 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfBLIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:21:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C8L0uK017793;
        Tue, 12 Feb 2019 02:21:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549959660;
        bh=h6nS8KEQuvXeKjc1JlLi0g/d54xykSlMo2wQ9Y5khW8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G8woGgtwnBgQJHWLUihd0zPqGXIvr9SWe1bcsMxAOIp+HkcIKbruECEQk96pOL0Xg
         DP+XUgnHtARTSgNjioexGfpmpJrhiwT2+e29nYqXcdjNMKyxa1d+Al83cnU7k+03nI
         WCYMFb8rnHszLjN3ZM7h8s12yR59oPiRfOa3G+Lk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C8L0Kb103259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 02:21:00 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 02:21:00 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 02:21:00 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C8KtGQ015182;
        Tue, 12 Feb 2019 02:20:56 -0600
Subject: Re: [PATCH v2 5/8] usb: ohci-da8xx: add vbus and overcurrent gpios
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190211103702.4277-1-brgl@bgdev.pl>
 <20190211103702.4277-6-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <39ef1cac-85d3-9307-7d17-faf0ac196bf3@ti.com>
Date:   Tue, 12 Feb 2019 13:50:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211103702.4277-6-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/19 4:06 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There are two users upstream which register external callbacks for
> switching the port power on/off and overcurrent protection. Both
> users only use two GPIOs for that. Instead of having that functionality
> in the board files, move the logic into the OHCI driver - including
> the interrupt handler for overcurrent detection.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>  drivers/usb/host/ohci-da8xx.c | 99 ++++++++++++++++++-----------------
>  1 file changed, 50 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index e8ede0b5e3f0..80c23307fbfe 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -12,6 +12,7 @@
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>

Added the new include in alphabetical order. With that minor fix, series
is applied to my v5.1/soc branch.

Thanks,
Sekhar
