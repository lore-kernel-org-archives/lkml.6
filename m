Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08595C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4230219C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y9YzBAQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4230219C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeHFFpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:45:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55986 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbeHFFpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=qPsd2eaJs7rzfqFdyYsjDqlyo1TFKdf7sAWS4BBbSvE=;
        b=y9YzBAQcjd5SyOxDRUlbLdY7QHKQ50hp7Jw61CEnXiSHTiq+4tRpwERrT1OnFyfnzimPFh8Cc1RWBoNbIQKkubRgduMDG0OQUHrYULuWFtNrPx3RRQOFm7xjp/tItHpeGZ1yOf/afHBPO18cKPuAg5861YMdzjoIAKg1SdSjwaE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fmWLK-0008UQ-J6; Mon, 06 Aug 2018 05:38:02 +0200
Date:   Mon, 6 Aug 2018 05:38:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Aditya Prayoga <aditya@kobol.io>
Cc:     linux-gpio@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Gauthier Provost <gauthier@kobol.io>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Gilmore <dennis@ausil.us>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM
 lines per GPIO chip
Message-ID: <20180806033802.GA32450@lunn.ch>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-2-git-send-email-aditya@kobol.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533522556-55055-2-git-send-email-aditya@kobol.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:29:15AM +0800, Aditya Prayoga wrote:

Hi Aditya

> +	item = kzalloc(sizeof(*item), GFP_KERNEL);
> +	if (!item)
> +		return -ENODEV;

ENOMEM would be better, since it is a memory allocation which is
failing.

>  
> -		ret = gpiod_direction_output(desc, 0);
> -		if (ret) {
> -			gpiochip_free_own_desc(desc);
> -			goto out;
> -		}
> +	spin_lock_irqsave(&mvpwm->lock, flags);
> +	desc = gpiochip_request_own_desc(&mvchip->chip,
> +					 pwm->hwpwm, "mvebu-pwm");
> +	if (IS_ERR(desc)) {
> +		ret = PTR_ERR(desc);
> +		goto out;
> +	}
>  
> -		mvpwm->gpiod = desc;
> +	ret = gpiod_direction_output(desc, 0);
> +	if (ret) {
> +		gpiochip_free_own_desc(desc);
> +		goto out;
>  	}
> +	item->gpiod = desc;
> +	item->device = pwm;
> +	INIT_LIST_HEAD(&item->node);
> +	list_add_tail(&item->node, &mvpwm->pwms);
>  out:
>  	spin_unlock_irqrestore(&mvpwm->lock, flags);
>  	return ret;

You don't cleanup item on the error path.

> @@ -630,12 +639,20 @@ static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
> +	struct mvebu_pwm_item *item, *tmp;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&mvpwm->lock, flags);
> -	gpiochip_free_own_desc(mvpwm->gpiod);
> -	mvpwm->gpiod = NULL;
> -	spin_unlock_irqrestore(&mvpwm->lock, flags);
> +	list_for_each_entry_safe(item, tmp, &mvpwm->pwms, node) {
> +		if (item->device == pwm) {
> +			spin_lock_irqsave(&mvpwm->lock, flags);
> +			gpiochip_free_own_desc(item->gpiod);
> +			item->gpiod = NULL;
> +			item->device = NULL;

Since you are about to free item, these two lines are pointless.

> +			list_del(&item->node);
> +			spin_unlock_irqrestore(&mvpwm->lock, flags);
> +			kfree(item);
> +		}
> +	}
>  }

   Andrew
