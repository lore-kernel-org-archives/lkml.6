Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CC821480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TSvUZXNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CC821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeIYUUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:20:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16461 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeIYUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:20:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5baa42470000>; Tue, 25 Sep 2018 07:12:23 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Sep 2018 07:12:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Sep 2018 07:12:17 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Sep
 2018 14:12:15 +0000
Subject: Re: [PATCH 4.14 156/173] gpiolib: Respect error code of
 ->get_direction()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <stable@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20180924113114.334025954@linuxfoundation.org>
 <20180924113126.730832814@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <dfdf04ac-2413-ccf3-a8ea-407674cc6b08@nvidia.com>
Date:   Tue, 25 Sep 2018 15:12:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924113126.730832814@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537884743; bh=uhZo8b4NZKBIo3cHRBBL44pojBeyGLNS2uQtD7kDG9U=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TSvUZXNcw+7dawWmhfi5CBuA7wmI6Int39N+X161tyNf/EXFZzvdVJplbVTxzGvYs
         /p4PDC+Q4Y6YeCKt3kEefzjNzkxIw009jAbzrB02llgYhdyl+0B5umBz7FigT6v8Wr
         dqAUK21PUZbqQmRjD59VjmCT68/fimX0grjiIRvVv6lODDxeBNhBfo8mZ0kVY8PVST
         ouuydzeZP2+28eYx8ACddKO2TU3/WNzD8xsfTQL0QY4youjZQyDrumvZPmCHuS6sbf
         H9kdEGRGT6othgsf0EilUIsg6AEdCa2pnrCz+BYy2uu2EalIPN91NBANJugxVzatks
         Cw+Lx3IRYFLKg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 24/09/18 12:53, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [ Upstream commit 36b312792b97933dc07abe074f50941199bd357c ]
> 
> In case we try to lock GPIO pin as IRQ when something going wrong
> we print a misleading message.
> 
> Correct this by checking an error code from ->get_direction() in
> gpiochip_lock_as_irq() and printing a corresponding message.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpio/gpiolib.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2811,6 +2811,12 @@ int gpiochip_lock_as_irq(struct gpio_chi
>  	if (!chip->can_sleep && chip->get_direction) {
>  		int dir = chip->get_direction(chip, offset);
>  
> +		if (dir < 0) {
> +			chip_err(chip, "%s: cannot get GPIO direction\n",
> +				 __func__);
> +			return dir;
> +		}
> +
>  		if (dir)
>  			clear_bit(FLAG_IS_OUT, &desc->flags);
>  		else

This change is causing a boot regression on Tegra20 and Tegra30. After
this change was merged in mainline there was a fix for Tegra [0] that
was also needed.

On Tegra the above change causes the allocation of GPIOs to fail and
looks like this then exposes another bug somewhere else that finally
leads to a system crash.

If this is needed for stable, then we will need the fix for Tegra as well.

Cheers
Jon

[0] https://lkml.org/lkml/2018/7/17/871

-- 
nvpublic
