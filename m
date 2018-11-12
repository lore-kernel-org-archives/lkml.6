Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C45DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3CF224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNU1TtHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3CF224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbeKMBI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:08:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33961 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMBI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:08:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so7947832ljd.1;
        Mon, 12 Nov 2018 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tyMrkRtUG69IxsZ1tw1UQO7Nv6EDQFmUVdCdrxt5zPg=;
        b=tNU1TtHCpF2+QJn3uIqNdQj3WrKE1K+0eI+wO97TUV/n9eRwd7FfqWH9UOxwjjk0Mi
         Umefok/3IMbx6Qpxr+utC4SYAVSQIX2HtCE0v55nZGg6RXyxKaJUJ+z8Ky6mSVEy5qhf
         Ph5TF8rJQ+d7/0plaagzGJymNpp2BmxxPct4KSF7f6Z0oY9TW9S8UJjq0H6YZ8ILw+Ug
         2AVTOWLP96P7AVIUg++KQY+HycyblyI0JjTMj+/ZM2V4gjKs+piwdo8prsK9rbqmUVBV
         GD3PEUskWwKEyaDSgUq5iXHdo6cjpA4QVubgVcnJjREkcrVLzOiVpCwSkhgeC/XSYX+y
         VZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tyMrkRtUG69IxsZ1tw1UQO7Nv6EDQFmUVdCdrxt5zPg=;
        b=pihs2Pofl71oQ1KxByYstL0aEmDds53cFXe+tdPPy7lNacC4cSx4kf3R3i6kWN28Lm
         1LdJo7og39yicaRs6wirsZM4PkgPws4+7o5Q6dGNshbs4NNTvYrI1ZkhhcKdIG4qQezw
         WHpBLixOqErLcW4G+usKK8pPZ7wqPHbBk9yep62llAh+h1NtR8+ElDk7qxdQ1AW1gp0W
         5RBUj0cCLyPGITzoeg9kVj+W/+RiacMTuszYdX16PnqZG1FBEx0JJHNjJddKP9HBqhQx
         6vuKv2Bq0ph/aJJS2fAF8eXIUMEClJEz6RTS40ujgqj+WdFDaK+akDPRF5pGuqdqJAwI
         lbtw==
X-Gm-Message-State: AGRZ1gIixWTWG04+35vsfPaGxRr3FVAd7rjCbZ+8uROmkqdcVInK09c3
        GcIrgdriwtTef7tanKKVgpU=
X-Google-Smtp-Source: AJdET5f41JAKg1LsaEiCRicC7LlvvQFFq9YlM+eUW1PkUE6ciNRjOI1xcurtOGmE2wygBfApUeepoA==
X-Received: by 2002:a2e:484:: with SMTP id a4-v6mr939235ljf.27.1542035714315;
        Mon, 12 Nov 2018 07:15:14 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q6sm936322lfh.52.2018.11.12.07.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:15:13 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gMDvh-00033P-4s; Mon, 12 Nov 2018 16:15:09 +0100
Date:   Mon, 12 Nov 2018 16:15:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH] greybus: gpio: switch GPIO portions to use
 GPIOLIB_IRQCHIP
Message-ID: <20181112151509.GH13311@localhost>
References: <20181109074735.GA5998@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109074735.GA5998@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 01:17:41PM +0530, Nishad Kamdar wrote:
> Convert the GPIO driver to use the GPIO irqchip library
> GPIOLIB_IRQCHIP instead of reimplementing the same.

Thanks for picking this up. Linus W took a stab at it a couple of years
ago, but it was never completed. You may want to take a look at that
thread:

	https://lkml.kernel.org/r/1476054589-28422-1-git-send-email-linus.walleij@linaro.org

> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/greybus/Kconfig |   1 +
>  drivers/staging/greybus/gpio.c  | 123 ++++++--------------------------
>  2 files changed, 21 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
> index ab096bcef98c..b571e4e8060b 100644
> --- a/drivers/staging/greybus/Kconfig
> +++ b/drivers/staging/greybus/Kconfig
> @@ -148,6 +148,7 @@ if GREYBUS_BRIDGED_PHY
>  config GREYBUS_GPIO
>  	tristate "Greybus GPIO Bridged PHY driver"
>  	depends on GPIOLIB
> +	select GPIOLIB_IRQCHIP
>  	---help---
>  	  Select this option if you have a device that follows the
>  	  Greybus GPIO Bridged PHY Class specification.
> diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
> index b1d4698019a1..32c228bad33a 100644
> --- a/drivers/staging/greybus/gpio.c
> +++ b/drivers/staging/greybus/gpio.c
> @@ -9,9 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/gpio.h>
> -#include <linux/irq.h>

I think you should keep irq.h even if the gpio header currently provides
it.

> -#include <linux/irqdomain.h>

Similarly for this one, if you still rely on it.

> +#include <linux/gpio/driver.h>
>  #include <linux/mutex.h>
>  
>  #include "greybus.h"
> @@ -40,8 +38,6 @@ struct gb_gpio_controller {
>  	struct gpio_chip	chip;
>  	struct irq_chip		irqc;
>  	struct irq_chip		*irqchip;

This should not be needed any more either.

> -	struct irq_domain	*irqdomain;
> -	unsigned int		irq_base;
>  	irq_flow_handler_t	irq_handler;
>  	unsigned int		irq_default_type;

Neither should these two.

>  	struct mutex		irq_lock;
> @@ -365,6 +361,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
>  {
>  	struct gb_connection *connection = op->connection;
>  	struct gb_gpio_controller *ggc = gb_connection_get_data(connection);
> +	struct gpio_chip *gc = &ggc->chip;

Please name the pointer 'chip' as in the rest of the driver to avoid
confusion with 'ggc'. But looks like you don't need it at all.

>  	struct device *dev = &ggc->gbphy_dev->dev;
>  	struct gb_message *request;
>  	struct gb_gpio_irq_event_request *event;
> @@ -391,7 +388,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
>  		return -EINVAL;
>  	}
>  
> -	irq = irq_find_mapping(ggc->irqdomain, event->which);
> +	irq = irq_find_mapping(gc->irq.domain, event->which);
>  	if (!irq) {
>  		dev_err(dev, "failed to find IRQ\n");
>  		return -EINVAL;
> @@ -506,68 +503,6 @@ static int gb_gpio_controller_setup(struct gb_gpio_controller *ggc)
>  	return ret;
>  }

> -/**
> - * gb_gpio_irqchip_remove() - removes an irqchip added to a gb_gpio_controller
> - * @ggc: the gb_gpio_controller to remove the irqchip from
> - *
> - * This is called only from gb_gpio_remove()
> - */
> -static void gb_gpio_irqchip_remove(struct gb_gpio_controller *ggc)
> -{
> -	unsigned int offset;
> -
> -	/* Remove all IRQ mappings and delete the domain */
> -	if (ggc->irqdomain) {
> -		for (offset = 0; offset < (ggc->line_max + 1); offset++)
> -			irq_dispose_mapping(irq_find_mapping(ggc->irqdomain,
> -							     offset));
> -		irq_domain_remove(ggc->irqdomain);
> -	}
> -
> -	if (ggc->irqchip)
> -		ggc->irqchip = NULL;
> -}
> -
>  /**
>   * gb_gpio_irqchip_add() - adds an irqchip to a gpio chip
>   * @chip: the gpio chip to add the irqchip to
> @@ -595,8 +530,7 @@ static int gb_gpio_irqchip_add(struct gpio_chip *chip,
>  			 unsigned int type)
>  {
>  	struct gb_gpio_controller *ggc;
> -	unsigned int offset;
> -	unsigned int irq_base;
> +	unsigned int err;
>  
>  	if (!chip || !irqchip)
>  		return -EINVAL;
> @@ -606,35 +540,21 @@ static int gb_gpio_irqchip_add(struct gpio_chip *chip,
>  	ggc->irqchip = irqchip;
>  	ggc->irq_handler = handler;
>  	ggc->irq_default_type = type;
> -	ggc->irqdomain = irq_domain_add_simple(NULL,
> -					ggc->line_max + 1, first_irq,
> -					&gb_gpio_domain_ops, chip);
> -	if (!ggc->irqdomain) {
> -		ggc->irqchip = NULL;
> -		return -EINVAL;
> -	}
>  
> -	/*
> -	 * Prepare the mapping since the irqchip shall be orthogonal to
> -	 * any gpio calls. If the first_irq was zero, this is
> -	 * necessary to allocate descriptors for all IRQs.
> -	 */
> -	for (offset = 0; offset < (ggc->line_max + 1); offset++) {
> -		irq_base = irq_create_mapping(ggc->irqdomain, offset);
> -		if (offset == 0)
> -			ggc->irq_base = irq_base;
> +	err = gpiochip_irqchip_add(chip,
> +				   irqchip,
> +				   first_irq,
> +				   ggc->irq_handler,
> +				   type

Don't break the line here.

> +				   );
> +	if (err) {
> +		ggc->irqchip = NULL;
> +		return err;
>  	}
>  
>  	return 0;
>  }

Drop this function as well and call gpiochip_irqchip_add() from probe().

> -static int gb_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
> -{
> -	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
> -
> -	return irq_find_mapping(ggc->irqdomain, offset);
> -}
> -
>  static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
>  			 const struct gbphy_device_id *id)
>  {
> @@ -693,7 +613,6 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
>  	gpio->get = gb_gpio_get;
>  	gpio->set = gb_gpio_set;
>  	gpio->set_config = gb_gpio_set_config;
> -	gpio->to_irq = gb_gpio_to_irq;
>  	gpio->base = -1;		/* Allocate base dynamically */
>  	gpio->ngpio = ggc->line_max + 1;
>  	gpio->can_sleep = true;
> @@ -702,24 +621,23 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
>  	if (ret)
>  		goto exit_line_free;
>  
> -	ret = gb_gpio_irqchip_add(gpio, irqc, 0,
> -				   handle_level_irq, IRQ_TYPE_NONE);
> +	ret = gpiochip_add(gpio);
>  	if (ret) {
> -		dev_err(&gbphy_dev->dev, "failed to add irq chip: %d\n", ret);
> +		dev_err(&gbphy_dev->dev, "failed to add gpio chip: %d\n", ret);
>  		goto exit_line_free;
>  	}
>  
> -	ret = gpiochip_add(gpio);
> +	ret = gb_gpio_irqchip_add(gpio, irqc, 0,
> +				  handle_level_irq, IRQ_TYPE_NONE);

As you may have noted, we had the registration order reversed here to
handle a (theoretical) race, which may or may not only have been an
issue for the old 3.10 vendor kernel this was developed against. I've
forgotten the details, but see:

	88f6ba61f25b ("greybus: gpio: create irqdomain before registering gpio controller")

It's possibly an issue also for mainline, but this is indeed the
registration order all other drivers use (even if they tend not to be
hotpluggable).

>  	if (ret) {
> -		dev_err(&gbphy_dev->dev, "failed to add gpio chip: %d\n", ret);
> -		goto exit_gpio_irqchip_remove;
> +		dev_err(&gbphy_dev->dev, "failed to add irq chip: %d\n", ret);
> +		gpiochip_remove(gpio);

Please use an error label for this.

> +		goto exit_line_free;
>  	}
>  
>  	gbphy_runtime_put_autosuspend(gbphy_dev);
>  	return 0;
>  
> -exit_gpio_irqchip_remove:
> -	gb_gpio_irqchip_remove(ggc);
>  exit_line_free:
>  	kfree(ggc->lines);
>  exit_connection_disable:

Thanks,
Johan
