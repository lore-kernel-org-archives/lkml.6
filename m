Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75827C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4680820700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CTdLOnm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfBVRG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:06:27 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37436 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:06:25 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so2337349edv.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jGN1arh//Fz4L0rPV1ZrSWNLIUIbq1fZVNA8z4ndRc=;
        b=CTdLOnm9VhO8PQK7DD1ts86OzQ9T6t+lMioVZfxV4dRpXYvIgHAknXflil0d2Skyjc
         g444DALb1FiYdWddDUksZR5475s14f+FF+Y8cBp0Kc9PH6T9CAd7xLs5gDYWVz5Rw+bB
         7NghqK/9i8umm4U4Kh5jfMCIML9ZToa1ZOwZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jGN1arh//Fz4L0rPV1ZrSWNLIUIbq1fZVNA8z4ndRc=;
        b=Bpmrr4xq4nxufO0GaWhtivmGzd2+MkxBAgdVr/NUbfXzxiw7ku0BFeVPVXVrPHEVVJ
         /zzqEcCoqcgMpEWgC9KcG1HJT4MXBPQ23XAsjKkQ3BVKyAsvvO227Q2+x6/b2ZJxmY19
         sUPkNT2MI+1ueYxqrO00sZ8fWPhIq5WNWIHmyFC5u7AvSkOdeZ70YGmKm+adOhGWxUmg
         VegEJgOiA3V1Le5Upucu5rCtbYftxKeU5xV4epMEdGRoKaCXYDnzRjikFOT6AW6qhYLg
         T8tuu9uLaeDMfQZl1S5sLSQ16cgzAI8/8rlx6Hue0QI7rNrKykofgDnp4VAS5iWg26zY
         q38g==
X-Gm-Message-State: AHQUAuaYmhV6xS0IifEKaLz7k38ljBcHxm4Ef97WNYgYTmW+QEYYOtDr
        AqCZyE3ksWuzoAnSjnje5frDI3Asies=
X-Google-Smtp-Source: AHgI3IaCGgcWGLnm+3xZkCCeb8iWGcf4UJZBz/98g36ly51dpQ30IxseVGVfqi2Jcc9hAlR4Nb9ung==
X-Received: by 2002:a50:95f2:: with SMTP id x47mr19225eda.270.1550855182525;
        Fri, 22 Feb 2019 09:06:22 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id j24-v6sm352751ejd.53.2019.02.22.09.06.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 09:06:18 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id m35so2304789ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:06:18 -0800 (PST)
X-Received: by 2002:a05:6402:171a:: with SMTP id y26mr4124734edu.72.1550855178015;
 Fri, 22 Feb 2019 09:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20190220180538.GA42642@google.com> <20190221193429.161300-1-egranata@chromium.org>
 <CAJZ5v0i5KeFN3s1Uydgxre_6-DkS2qH7rAzppk_tGddVm6r4XQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i5KeFN3s1Uydgxre_6-DkS2qH7rAzppk_tGddVm6r4XQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 22 Feb 2019 09:06:05 -0800
X-Gmail-Original-Message-ID: <CA+ASDXObuA4rMz_JeM3Mu933Z=uccmb7_-DFp048v_Cir=GqAQ@mail.gmail.com>
Message-ID: <CA+ASDXObuA4rMz_JeM3Mu933Z=uccmb7_-DFp048v_Cir=GqAQ@mail.gmail.com>
Subject: Re: [PATCH v3] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Fri, Feb 22, 2019 at 1:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 21, 2019 at 8:34 PM <egranata@chromium.org> wrote:
> >
> > From: Enrico Granata <egranata@chromium.org>
> >
> > ACPI 5 added support for GpioInt resources as a way to provide
> > information about interrupts mediated via a GPIO controller.
> >
> > Several device buses (e.g. SPI, I2C) have support for retrieving
> > an IRQ specified via this type of resource, and providing it
> > directly to the driver as an IRQ number.
> >
> > This is not currently done for the platform drivers, as platform_get_irq()
> > does not try to parse GpioInt() resources. This requires drivers to
> > either have to support only one possible IRQ resource, or to have code
> > in place to try both as a failsafe.
> >
> > While there is a possibility of ambiguity for devices that exposes
> > multiple IRQs, it is easy and feasible to support the common case
> > of devices that only expose one IRQ which would be of either type
> > depending on the underlying system's architecture.
> >
> > This commit adds support for parsing a GpioInt resource in order
> > to fulfill a request for the index 0 IRQ for a platform device.
> >
> > Signed-off-by: Enrico Granata <egranata@chromium.org>
> > ---
> > Changes in v3:
> >  - ensured that -ENOENT return from acpi_dev_gpio_irq_get is not propagated
> >    upwards, as some drivers expect platform_get_irq to return either a valid
> >    IRQ or -ENXIO and will break otherwise

I hope there are no other lurking ways in which this might break things...

Reviewed-by: Brian Norris <briannorris@chromium.org>

> >  drivers/base/platform.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 1c958eb33ef4d..afd8b916303e4 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -127,7 +127,24 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> >                 irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
> >         }
> >
> > -       return r ? r->start : -ENXIO;
> > +       if (r)
> > +               return r->start;
> > +
> > +       /*
> > +        * For the index 0 interrupt, allow falling back to GpioInt
> > +        * resources. While a device could have both Interrupt and GpioInt
> > +        * resources, making this fallback ambiguous, in many common cases
> > +        * the device will only expose one IRQ, and this fallback
> > +        * allows a common code path across either kind of resource.
> > +        */
> > +       if (num == 0 && has_acpi_companion(&dev->dev)) {
> > +               int ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> > +
> > +               if (ret > 0 || ret == -EPROBE_DEFER)
>
> Can't 0 be a valid GPIO IRQ?

acpi_dev_gpio_irq_get() claims:

 * Return: Linux IRQ number (> %0) on success, negative errno on failure.

Should I trust the documentation? It seems like yes, I should:

int gpiod_to_irq(const struct gpio_desc *desc)
{
...
                /* Zero means NO_IRQ */
                if (!retirq)
                        return -ENXIO;


Brian

> > +                       return ret;
> > +       }
> > +
> > +       return -ENXIO;
> >  #endif
> >  }
> >  EXPORT_SYMBOL_GPL(platform_get_irq);
> > --
