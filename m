Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137D020878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChxAtTP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137D020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbeLFLzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:55:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34272 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFLzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:55:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so178270ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 03:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBexcS4B7txLbvWKUeWQD5WxUUP+D2GevPZ089eJMQc=;
        b=ChxAtTP7bs8u8Rzf0vPr4V2IHY0mxHIKLll2gd22eGue5wadbXUmXOgggDF8q/NrIp
         MJAUaHVi78b2PqS6WlHbnjMeYE6TeBY5bEIQ8G98kfEAi0tIUtNXExqodssDDf0NUm8S
         PVTeXVhiWflESPGzPNUoMPif6D13hPDRWI72A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBexcS4B7txLbvWKUeWQD5WxUUP+D2GevPZ089eJMQc=;
        b=fbAb4C/VOKrU/4rLYcP+GwroHW4kGePyFxY5GlACcnVMTMbzXRfCgA2CjoBCgwKtTU
         iuh2pT5rlgq2aPBfb4f/72CPn1Qfzk+bnJDZBZZK1pdtWr1Dr7DO90UNtpE4vQ2AHt0s
         Iu18OUNdnSnMvgkDcYNTIF+5LzX942E1pDJpNNWzPXuQUQOUygGQl37yXR5diaeC66HV
         l3dQ3DnM7tmdSXWKcjnRbP2TCu9WwaGrT2E+vZnlP2OKxZMvT5uGzU8JSPcxF/+sTcdv
         1kFxo1oQ0yADu0ZgMp8dXrC6hZrcwzLRthf+uOtvh6JexZsx36by07FjMHy1kZKRgFnM
         2LVQ==
X-Gm-Message-State: AA+aEWYR5d6Xx4qPTIySoG6loMTHeq4iTvo2dDJNvp8TvQMbG9XtQSLp
        xL+J6i3WCKyIhz88BdBwa14h708q+ZNXF7hWcmoUqw==
X-Google-Smtp-Source: AFSGD/WIHUeGJ3d9gNuryIeeXfoJLSKkjMggMy1P5JPoFFWO5r98u6viooh9OwRR7Dc0vNxiKxv4DsQX5CNdWUEa/0g=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr18106803ljc.97.1544097304378;
 Thu, 06 Dec 2018 03:55:04 -0800 (PST)
MIME-Version: 1.0
References: <1544089549-23629-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1544089549-23629-1-git-send-email-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Dec 2018 12:54:52 +0100
Message-ID: <CACRpkda9UAGxMrP27qYe-ZC=3RehesAPsUAnt71Jx5Dd+rpSqQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix return value of gpio_to_desc() stub if !GPIOLIB
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 10:45 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> If CONFIG_GPOILIB is not set, the stub of gpio_to_desc() should return
> the same type of error as regular version: NULL.  All the callers
> compare the return value of gpio_to_desc() against NULL, so returned
> ERR_PTR would be treated as non-error case leading to dereferencing of
> error value.
>
> Fixes: 79a9becda894 ("gpiolib: export descriptor-based GPIO interface")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/linux/gpio/consumer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index ed070512b40e..3b01fbcafc94 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -505,7 +505,7 @@ static inline int gpiod_set_consumer_name(struct gpio_desc *desc,
>
>  static inline struct gpio_desc *gpio_to_desc(unsigned gpio)
>  {
> -       return ERR_PTR(-EINVAL);
> +       return NULL;

I suppose this is consistent with comitt:
22c403676dbbb7c6f186099527af7f065498ef45
"gpio: return NULL from gpiod_get_optional when GPIOLIB is disabled"

So in that way it should be fine.

I'm just wondering where you see this problem, because IMO
a driver that is using GPIO should either
depends on GPIOLIB or
select GPIOLIB
it is extremely uncommon for a GPIO line to actually be optional at
compile time (as opposed to optional at runtime) so I would very
much like to look closer at this.

Yours,
Linus Walleij
