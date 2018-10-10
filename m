Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B56C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A93D214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nG8JEiXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A93D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeJJUdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:33:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V1Or9IcvzPWoE3fjpS8sDUeLdeWlf74rJQF5TYKgC30=; b=nG8JEiXKat2wX9iutR968y2cA
        WicpTH3zWrGW9wzJ7Gep/kr8RQBRzNqTizlxUQTrIqm/EcNqNmH24Rm70dXnxnf7EzsUDWIhNEBBG
        LpDV8T/w4yCoZ2HcITw/2YWvCOVrwRXIfmJ9+dJxTQf3x3rmz44hpNcMsOtfiWPbr/mOI4OYJUBRY
        RZGwIsUZEHyvxqPAdVe7QADYE9U5i/KJlBm44ppRrSwrV/7XbjW3hA4qqsV8hrATTwzygIWbtVi6D
        7e0V3G4tIN3zLlk1Ql5ieZlO2DTNK4NmRBu1j6TSUuDjX6fwszK/YSA1rrbOjRUmVIg/hijxu71Uo
        TKIq8JREQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAEGv-0001o7-6S; Wed, 10 Oct 2018 13:11:29 +0000
Date:   Wed, 10 Oct 2018 06:11:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        hch@infradead.org
Subject: Re: [RFC 2/4] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20181010131128.GA29142@infradead.org>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for getting these drivers submitted upstream!

I don't really know anything about PWM, so just some random nitpicking
below..

> +	iowrite32(frac, pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));

* already has a higher precedence than +, so no need for the inner
braces.

> +	duty = ioread32(pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));

Same here.

> +	/* (1 << (16+scale)) * 10^9/rate = real_period */
	unsigned long scalePow = (pwm->approx_period * (u64)rate) / 1000000000;

no camcel case, please.

> +	int scale = ilog2(scalePow) - 16;
> +
> +	scale = clamp(scale, 0, 0xf);

Why not:

	int scale = clamp(ilog2(scale_pow) - 16, 0, 0xf);

> +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
> +				     unsigned long event, void *data)
> +{
> +	struct clk_notifier_data *ndata = data;
> +	struct sifive_pwm_device *pwm = container_of(nb,
> +						     struct sifive_pwm_device,
> +						     notifier);

I don't think there are any guidlines, but I always prefer to just move
the whole container_of onto a new line:

	struct sifive_pwm_device *pwm =
		container_of(nb, struct sifive_pwm_device, notifier);

> +static struct platform_driver sifive_pwm_driver = {
> +	.probe = sifive_pwm_probe,
> +	.remove = sifive_pwm_remove,
> +	.driver = {
> +		.name = "pwm-sifivem",
> +		.of_match_table = of_match_ptr(sifive_pwm_of_match),
> +	},
> +};

What about using tabs to align this a little more nicely?

static struct platform_driver sifive_pwm_driver = {
	.probe			= sifive_pwm_probe,
	.remove			= sifive_pwm_remove,
	.driver = {
		.name		= "pwm-sifivem",
		.of_match_table	= of_match_ptr(sifive_pwm_of_match),
	},
};
