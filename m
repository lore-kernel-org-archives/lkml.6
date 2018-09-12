Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C098C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB3F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hvvScPVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB3F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeILSFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:05:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60332 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeILSFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=doOt6MvCFxEjQ6amDN7VFxjMhw7Rb31g6Fp2XG3fVJE=;
        b=hvvScPVYsnh87eLRHtklb39tL1HghPoqNtotgKxKvi82+6TxQ9h0bhAB/Saoq5mROS/sfBNaeiJ0Hyrpnb8bOyyYi0HE1DssrSVZTdlUUPKV29guekFtLAVzXAvYClR36TJdC+WBMMHyZJHdFm65MEb1Q1I5FTtUpFCv7adavhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g04lS-0006k4-K3; Wed, 12 Sep 2018 15:01:02 +0200
Date:   Wed, 12 Sep 2018 15:01:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Aditya Prayoga <aditya@kobol.io>
Cc:     linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Gauthier Provost <gauthier@kobol.io>,
        Dennis Gilmore <dennis@ausil.us>
Subject: Re: [PATCH v2 1/1] gpio: mvebu: Add support for multiple PWM lines
 per GPIO chip
Message-ID: <20180912130102.GB24595@lunn.ch>
References: <1536727915-113932-1-git-send-email-aditya@kobol.io>
 <1536727915-113932-2-git-send-email-aditya@kobol.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536727915-113932-2-git-send-email-aditya@kobol.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
>  	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
>  	struct gpio_desc *desc;
> +	struct mvebu_pwm *counter;
>  	unsigned long flags;
>  	int ret = 0;
>  
>  	spin_lock_irqsave(&mvpwm->lock, flags);
>  
> -	if (mvpwm->gpiod) {
> -		ret = -EBUSY;
> -	} else {
> -		desc = gpiochip_request_own_desc(&mvchip->chip,
> -						 pwm->hwpwm, "mvebu-pwm");
> -		if (IS_ERR(desc)) {
> -			ret = PTR_ERR(desc);
> +	counter = mvpwm;
> +	if (counter->gpiod) {
> +		counter = mvebu_pwm_get_avail_counter();
> +		if (!counter) {
> +			ret = -EBUSY;

I don't understand this bit of code. Please could you explain what is
going on.

>  			goto out;
>  		}
>  
> -		ret = gpiod_direction_output(desc, 0);
> -		if (ret) {
> -			gpiochip_free_own_desc(desc);
> -			goto out;
> -		}
> +		pwm->chip_data = counter;
> +	}
>  
> -		mvpwm->gpiod = desc;
> +	desc = gpiochip_request_own_desc(&mvchip->chip,
> +					 pwm->hwpwm, "mvebu-pwm");
> +	if (IS_ERR(desc)) {
> +		ret = PTR_ERR(desc);
> +		goto out;
>  	}
> +
> +	ret = gpiod_direction_output(desc, 0);
> +	if (ret) {
> +		gpiochip_free_own_desc(desc);
> +		goto out;
> +	}
> +
> +	regmap_update_bits(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
> +			   mvchip->offset, BIT(pwm->hwpwm),
> +			   counter->id ? BIT(pwm->hwpwm) : 0);
> +	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
> +		    mvchip->offset, &counter->blink_select);
> +
> +	counter->gpiod = desc;
>  out:
>  	spin_unlock_irqrestore(&mvpwm->lock, flags);
>  	return ret;
> @@ -632,6 +666,11 @@ static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
>  	unsigned long flags;
>  
> +	if (pwm->chip_data) {
> +		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
> +		pwm->chip_data = NULL;
> +	}
> +
>  	spin_lock_irqsave(&mvpwm->lock, flags);
>  	gpiochip_free_own_desc(mvpwm->gpiod);
>  	mvpwm->gpiod = NULL;
> @@ -648,6 +687,9 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
>  	unsigned long flags;
>  	u32 u;
>  
> +	if (pwm->chip_data)
> +		mvpwm = (struct mvebu_pwm *) pwm->chip_data;
> +

You should not need a cast here, if chip_data is a void *.

What is pwm->chip_data is a NULL? Don't you then use an uninitialized
mvpwm?

	Andrew
