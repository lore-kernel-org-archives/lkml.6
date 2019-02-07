Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B699CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814F02086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549566152;
	bh=fACLnY8u/wJRnIcjZlG/bAS2Rz9fNq/sl1iZ7KkRbW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XsmsufTc708ySPaMdJZvSCNmlJV9y4cwGcXAnlWiNJQ9TfJLUmk3dYiEvPn4RXnYC
	 NnZeQRVBfJgPw/5Up0kX5bQqXtWQzt9K5gCUemziaZqJMv0nupUTpQDIy+jC5viOr0
	 jIvmCYdVGn3Ao3MsTqYfiZkmHPONKYH+ICKzU0H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBGTCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:02:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35894 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:02:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so1702165otk.3;
        Thu, 07 Feb 2019 11:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATuQNtfQB+jx0mV+gxdxKVmlgyEl4yf6a8d+axcKEzM=;
        b=NZddSPwNpYjMIj7dDjtqYM2hbZB+rQcyQSWPKM5kH0+yDYwXY5aPpQfQt8u8wVl+6x
         mqSGYtakkdxTeVmtxHO8d/BjR6G1DZrDe5J24xYhoMPAiMHFiXU0Zv8I3p81SpYvOAea
         5r61zMcVxBZBM+ZrmY1Xcf6lMc895BcPpjsoT9o1wZATI95dZVVEjjPe8OoDjuuVfw2v
         E8R+zyAbpY0GhQClo1vO8pRfUz3+Yfq9ai/aHVhNi6DX8AJBtpz2655iWx7+QmYrWWg3
         wSln4RBb8eCj/y0WoEipgJxeH439qRJ8NLg3fePsoplW17mK2nAqvCTEovo46FOEaFbx
         25Dw==
X-Gm-Message-State: AHQUAuZ52+44UbU+Fwa2U1HYiZ76pRxgIbI0H29uGW0MizOAdN8/0hOe
        TO2PKz4lHcWlR71MQFw/A0Izj4IiUFhfwpmcOBE=
X-Google-Smtp-Source: AHgI3Ibw5mOsny1Sy3JVL8cnx3XgpRnmQnBXSUvcJzcMjNcndLhbqgG97pL213guOjLD+wdCu8IW94wwwMgAwiStDUo=
X-Received: by 2002:aca:c591:: with SMTP id v139mr1159294oif.76.1549566149850;
 Thu, 07 Feb 2019 11:02:29 -0800 (PST)
MIME-Version: 1.0
References: <20190207185917.167829-1-egranata@google.com>
In-Reply-To: <20190207185917.167829-1-egranata@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Feb 2019 20:02:18 +0100
Message-ID: <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
To:     egranata@google.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gwendal@chromium.org, Dmitry Torokhov <dtor@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mika Westerberg
+Andy Shevchenko
+Hans de Goede

On Thu, Feb 7, 2019 at 7:59 PM <egranata@google.com> wrote:
>
> From: Enrico Granata <egranata@chromium.org>
>
> ACPI 5 added support for GpioInt resources as a way to provide
> information about interrupts mediated via a GPIO controller.
>
> Several device buses (e.g. SPI, I2C) have support for retrieving
> an IRQ specified via this type of resource, and providing it
> directly to the driver as an IRQ number.
> This is not currently done for the platform drivers, as platform_get_irq()
> does not try to parse GpioInt() resources.
>
> This commit adds that functionality.
>
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> ---
>  drivers/base/platform.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4d..c50c4f9033aef 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -127,7 +127,17 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>                 irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
>         }
>
> -       return r ? r->start : -ENXIO;
> +       if (r)
> +               return r->start;
> +
> +       /*
> +        * If no IRQ was found, try to parse ACPI GpioInt resources
> +        * as a last resort.
> +        */
> +       if (has_acpi_companion(&dev->dev))
> +               return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> +
> +       return -ENXIO;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
> --
> 2.20.1.611.gfbb209baf1-goog
>
