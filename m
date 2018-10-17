Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C6ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6E52145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6E52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeJRCN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:13:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34510 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbeJRCN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:13:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E6FA420729; Wed, 17 Oct 2018 20:16:33 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id B3EAC208C7;
        Wed, 17 Oct 2018 20:16:23 +0200 (CEST)
Date:   Wed, 17 Oct 2018 20:16:25 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: atmel-ssc: Fix section annotation on
 atmel_ssc_get_driver_data
Message-ID: <20181017181625.GW17341@piout.net>
References: <20181017170901.13119-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017170901.13119-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2018 10:09:02-0700, Nathan Chancellor wrote:
> After building the kernel with Clang, the following section mismatch
> warning appears:
> 
> WARNING: vmlinux.o(.text+0x3bf19a6): Section mismatch in reference from
> the function ssc_probe() to the function
> .init.text:atmel_ssc_get_driver_data()
> The function ssc_probe() references
> the function __init atmel_ssc_get_driver_data().
> This is often because ssc_probe lacks a __init
> annotation or the annotation of atmel_ssc_get_driver_data is wrong.
> 
> Remove __init from atmel_ssc_get_driver_data to get rid of the mismatch.
> 

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

I would add:

Fixes: 5c86ac695c7e ("ASoC: atmel-ssc: use module_platform_driver macro")

> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Alternatively, ssc_probe could be marked as __init, I don't think there
> is any way for the probe to defer. I decided to go with the more
> conservative option first but I'm happy to respin if necessary.
> 

A probe function should never be marked __init, unless you ensure there
is no way to bind/unbind the driver at runtime.

> Thanks!
> 
>  drivers/misc/atmel-ssc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index b2a0340f277e..d8e3cc2dc747 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -132,7 +132,7 @@ static const struct of_device_id atmel_ssc_dt_ids[] = {
>  MODULE_DEVICE_TABLE(of, atmel_ssc_dt_ids);
>  #endif
>  
> -static inline const struct atmel_ssc_platform_data * __init
> +static inline const struct atmel_ssc_platform_data *
>  	atmel_ssc_get_driver_data(struct platform_device *pdev)
>  {
>  	if (pdev->dev.of_node) {
> -- 
> 2.19.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
