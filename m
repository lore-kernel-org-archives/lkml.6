Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD835C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D652184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549963149;
	bh=ajk0LeW1otM04pqudG4EBIm6uN/9uqNST1pYz0wbOfw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FoXIu5Ny8Ia0m2IjpVaoW92OxmkJeLDEERuubGbCObzxfGE8vcfJLBAd80ITGwzid
	 gGDoX+KSYNkaI9h/Ri63Vvyke2fJSZckkdqZ2bwy9v2MCZJGqZAZvl0TZtDeSCGow1
	 9U3dtwMuU/Eo3CHpW8Dgek56SOsqA0hwbFjxBguQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfBLJTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:19:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45186 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfBLJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:19:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so3126287ota.12;
        Tue, 12 Feb 2019 01:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0gm1ct1GpvF7e0EXjgxM9d850vtv1Vo01QN7Y5bkGQ=;
        b=InmyC2g6rOZNoqhgzWBAAT2W7IltNntqNkBUgNBXGOncMpmiBVOUrYQSIaEOvT9OvP
         /Caq8US8JQYIbYX2wcKwU/mGJokrVRduV2CcoIRm4MKzCI1S0t5W4GrTBYsnmlPpGxsL
         PGstiWqURL6UvyqSMCedb3TECILyRf+p3Q7d+LKKlAf6kDseu17c3N73gfHNRqLWmMp/
         oI8IjRgVVeboUhnvyoXzljdSUD/JRfdIshQEPGtUSwgHOHsbGxWYl4UpDvzx3Rg9gQt0
         IQQs6HHAojDko8hl2pC67bcNRKaLTUiUB1iA9ai8ab7Jgc/tqx3UkRU5vgqLSzr5O0RD
         dPAg==
X-Gm-Message-State: AHQUAuZeMQ9VKme+HWYOZurgl/SjS6tawFUFABbfiOwcirpRQTB81e67
        uYp2DuPxsio7FVcB4uWRxN7ZKa3iGdq1hW8Iva0=
X-Google-Smtp-Source: AHgI3IbFEDJbOIyoIh0rqe3I/8G7lKGECBjbh1HXWvlfiJOqOB1wOsKA7+mNszV9xSsoPW7h50ftsaWCaiM66cyFBbI=
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr124030oth.124.1549963146211;
 Tue, 12 Feb 2019 01:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20190207185917.167829-1-egranata@google.com> <20190211190112.209286-1-egranata@chromium.org>
In-Reply-To: <20190211190112.209286-1-egranata@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 10:18:53 +0100
Message-ID: <CAJZ5v0jEf-PVxbrUABX2BrsNEFq3-aqU-_Zztmzssq9gNu4LxQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
To:     Enrico Granata <egranata@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Enrico Granata <egranata@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 8:01 PM <egranata@chromium.org> wrote:
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

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes in v2:
>  - only support IRQ index 0
>
>  drivers/base/platform.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4d..0d3611cd1b3bc 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -127,7 +127,20 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
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
> +       if (num == 0 && has_acpi_companion(&dev->dev))
> +               return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> +
> +       return -ENXIO;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
> --
> 2.20.1.791.gb4d0f1c61a-goog
>
