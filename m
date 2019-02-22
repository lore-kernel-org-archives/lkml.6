Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E435A2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550826213;
	bh=SHOUV5YgmPTTsRIJ5dVg58v8V8iEAH23q9SYqYbUUe0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AOhyb0wNvW3JS3B/sc3YEUTf6FQcF0OzIc6umHw47FVHtWk3w1m14Tja7aCGBn8Z/
	 MNd19j9v5JXZ9zlQyrT2yeKdMLyeOXeRiaI4ly1udBxlaUTNx1F6ejpxLe5cjBU66b
	 J2QKGFTknGND4IS/K2O8c2XydyZKZaJdK5ycSkgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfBVJDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:03:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45796 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBVJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:03:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so1236862ota.12;
        Fri, 22 Feb 2019 01:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSkverAyxMwCuZ2Iu7FV1sQ+1Iwtx2BX8MR9tlPAuYU=;
        b=plEffk0gTDa3D74nq8jO2oXK6f6abxIsXV7Kfrg4bTIEDLW/Z31OwhD4t6RHhY6p5j
         2Fo0wZm/41eo3LOQuMUm31IDptUjb2+fR5BzHq8u/L0S88GtNQKZ8J8d2kPikGAChjf4
         VJ4smW6qf588QEUDvf0wg5b7yEiiCC6aJB9iaoVLLXFCrs7+jwoHfgdGJ1DAyKK52qac
         ApGY36zv1yOMPfORAonxSeSdNT26S2Px3cP1JvmUzEWwnKx81Cbq00F5ngZFXXyskFkg
         Fc4ES1dRe2eCcCxDp1CLMYEFv4/ASuQpUTIhw9qXHHKaGYorsuNZ4PIuT22Y5GZvO5wk
         S5LQ==
X-Gm-Message-State: AHQUAuYq5tnDk2finveoCCAjXkP48feC52nansksZ6o20VRH3fftklrU
        L3Eaxnsh+laqmVhfZAHRMzOF8cxD1jeIbU0xYuI=
X-Google-Smtp-Source: AHgI3IaM5CwFvSUIdRsS2M/wP6wz7lfYkR18adXO/4keHUbk8fiwgcRzQ5eYiuCp7kWizowl7s4pYcFdl25lgrKCGq8=
X-Received: by 2002:a9d:7cd3:: with SMTP id r19mr2095727otn.139.1550826209827;
 Fri, 22 Feb 2019 01:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20190220180538.GA42642@google.com> <20190221193429.161300-1-egranata@chromium.org>
In-Reply-To: <20190221193429.161300-1-egranata@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Feb 2019 10:03:18 +0100
Message-ID: <CAJZ5v0i5KeFN3s1Uydgxre_6-DkS2qH7rAzppk_tGddVm6r4XQ@mail.gmail.com>
Subject: Re: [PATCH v3] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
To:     Enrico Granata <egranata@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Enrico Granata <egranata@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 8:34 PM <egranata@chromium.org> wrote:
>
> From: Enrico Granata <egranata@chromium.org>
>
> ACPI 5 added support for GpioInt resources as a way to provide
> information about interrupts mediated via a GPIO controller.
>
> Several device buses (e.g. SPI, I2C) have support for retrieving
> an IRQ specified via this type of resource, and providing it
> directly to the driver as an IRQ number.
>
> This is not currently done for the platform drivers, as platform_get_irq()
> does not try to parse GpioInt() resources. This requires drivers to
> either have to support only one possible IRQ resource, or to have code
> in place to try both as a failsafe.
>
> While there is a possibility of ambiguity for devices that exposes
> multiple IRQs, it is easy and feasible to support the common case
> of devices that only expose one IRQ which would be of either type
> depending on the underlying system's architecture.
>
> This commit adds support for parsing a GpioInt resource in order
> to fulfill a request for the index 0 IRQ for a platform device.
>
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> ---
> Changes in v3:
>  - ensured that -ENOENT return from acpi_dev_gpio_irq_get is not propagated
>    upwards, as some drivers expect platform_get_irq to return either a valid
>    IRQ or -ENXIO and will break otherwise
>
>  drivers/base/platform.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4d..afd8b916303e4 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -127,7 +127,24 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>                 irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
>         }
>
> -       return r ? r->start : -ENXIO;
> +       if (r)
> +               return r->start;
> +
> +       /*
> +        * For the index 0 interrupt, allow falling back to GpioInt
> +        * resources. While a device could have both Interrupt and GpioInt
> +        * resources, making this fallback ambiguous, in many common cases
> +        * the device will only expose one IRQ, and this fallback
> +        * allows a common code path across either kind of resource.
> +        */
> +       if (num == 0 && has_acpi_companion(&dev->dev)) {
> +               int ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> +
> +               if (ret > 0 || ret == -EPROBE_DEFER)

Can't 0 be a valid GPIO IRQ?

> +                       return ret;
> +       }
> +
> +       return -ENXIO;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
> --
