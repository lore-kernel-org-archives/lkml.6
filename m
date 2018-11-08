Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED10ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44F820818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44F820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeKIGvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:51:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57387 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeKIGvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:51:21 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKrcm-0002Sz-KS; Thu, 08 Nov 2018 22:14:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKrcl-0007bu-Pp; Thu, 08 Nov 2018 22:13:59 +0100
Date:   Thu, 8 Nov 2018 22:13:59 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] gpio: mockup: add locking
Message-ID: <20181108211359.44scwickq4pxsuqy@pengutronix.de>
References: <20181108165255.9940-1-brgl@bgdev.pl>
 <20181108165255.9940-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108165255.9940-3-brgl@bgdev.pl>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 05:52:54PM +0100, Bartosz Golaszewski wrote:
> While no user reported any race condition problems with gpio-mockup,
> let's be on the safe side and use a mutex when performing any changes
> on the dummy chip structures.
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpio-mockup.c | 50 ++++++++++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 6a50f9f59c90..3cd92912c414 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -54,6 +54,7 @@ struct gpio_mockup_chip {
>  	struct gpio_mockup_line_status *lines;
>  	struct irq_sim irqsim;
>  	struct dentry *dbg_dir;
> +	struct mutex lock;
>  };
>  
>  struct gpio_mockup_dbgfs_private {
> @@ -82,29 +83,53 @@ static int gpio_mockup_range_ngpio(unsigned int index)
>  	return gpio_mockup_ranges[index * 2 + 1];
>  }
>  
> -static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
> +static int __gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
>  {
>  	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
>  
>  	return chip->lines[offset].value;
>  }
>  
> -static void gpio_mockup_set(struct gpio_chip *gc,
> -			    unsigned int offset, int value)
> +static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
> +	int val;
> +
> +	mutex_lock(&chip->lock);
> +	val = __gpio_mockup_get(gc, offset);
> +	mutex_unlock(&chip->lock);
> +
> +	return val;
> +}

I think this function doesn't need locking. I returns a single value and
if there is a race and some other process currently changes the value it
matters little if the return value is zero or not.

But even with this kept unchanged the patch looks good.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
