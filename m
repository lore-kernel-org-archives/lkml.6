Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86A1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7047C27A63
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7047C27A63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeF2FF0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:05:26 -0400
Received: from www381.your-server.de ([78.46.137.84]:51033 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeF2FFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:05:24 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1fYlaw-0002Hz-Kd; Fri, 29 Jun 2018 07:05:18 +0200
Received: from [188.174.115.198] (helo=[192.168.178.33])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1fYlaw-000Bh0-EN; Fri, 29 Jun 2018 07:05:18 +0200
Subject: Re: [PATCH] staging:iio:adc:ad7280a: Use GFP_ATOMIC in interrupt
 handler
To:     Karim Eshapa <karim.eshapa@gmail.com>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180628235503.4464-1-karim.eshapa@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3ac43cff-5f4e-579a-574e-14ac865c37e1@metafoo.de>
Date:   Fri, 29 Jun 2018 07:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628235503.4464-1-karim.eshapa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24705/Thu Jun 28 22:42:44 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 01:55 AM, Karim Eshapa wrote:
> Use GFP_ATOMIC rather GFP_KERNEL in interrupt handler,
> as GFP_KERNEL may sleep according to slab allocator.

This is a threaded interrupt. Sleeping is OK.

> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index b736275c10f5..25c4fbc303f7 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -692,7 +692,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  	unsigned int *channels;
>  	int i, ret;
>  
> -	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
> +	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_ATOMIC);
>  	if (!channels)
>  		return IRQ_HANDLED;
>  
> 

