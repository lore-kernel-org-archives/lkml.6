Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D1DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675B82186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfBLH3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:29:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35060 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfBLH3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:29:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id b17so1313105eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 23:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKyg29G4Az6thYz0DtsQzwE8vHe9QL+MPXuv2VvZShE=;
        b=pF9GZT8ylfMkAUfUEOywtRMsWW0ndhIvP9e5w5a0WP5weD3c5HJ1x6Cbyz36QUHp16
         nCQ7N1wNuNT9B0EK5UyfozrFEsE66Mmgr+VTA8SEipi5KeWf6yHWdkIOBUp1u1iV+Nk5
         FoUIKA36XA5AbEtX2WIJZNy8fdwgp840wYATMb6q+mDAcS2Yjxh87vlaxEwUA7qpIusg
         1tkqCeyxhjKh8g8Ddrv0AS+vgtco7DWf3yJSFg2zoqZxOajsMrw9hHbEvA0J7XyUDp69
         OhNKWLNxgySYuL1DQnE4OXWUGKNwxoseIKPWR2/WsOalADRHJ/2IfeEtHkADhz4m251G
         sAEQ==
X-Gm-Message-State: AHQUAuZfZQFgh204HUPljt6/3UOPFJPFiZcTTzXc9U7owY7LKhtO4Ul+
        sif3N4pzqH2j+C9eHbPxMtbZjQ==
X-Google-Smtp-Source: AHgI3IbT2XdUEMfJxKkxsTQGG3J15hsLG3mwGNdyLVlTA1qpPvGZBgTqPeyGVeiaSfS+PldZv6MrlQ==
X-Received: by 2002:a50:d94a:: with SMTP id u10mr1899467edj.214.1549956593800;
        Mon, 11 Feb 2019 23:29:53 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b14sm3512812edt.6.2019.02.11.23.29.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 23:29:52 -0800 (PST)
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in
 platform_get_irq()
To:     egranata@chromium.org, mika.westerberg@linux.intel.com,
        dtor@chromium.org, andy.shevchenko@gmail.com, rafael@kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org, gwendal@chromium.org,
        linux-acpi@vger.kernel.org, briannorris@chromium.org,
        andriy.shevchenko@linux.intel.com
Cc:     egranata@google.com
References: <20190207185917.167829-1-egranata@google.com>
 <20190211190112.209286-1-egranata@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <de453c38-a7f9-62bf-72f6-40ac7a76456f@redhat.com>
Date:   Tue, 12 Feb 2019 08:29:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211190112.209286-1-egranata@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-02-19 20:01, egranata@chromium.org wrote:
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

Looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Changes in v2:
>   - only support IRQ index 0
> 
>   drivers/base/platform.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4d..0d3611cd1b3bc 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -127,7 +127,20 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>   		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
>   	}
>   
> -	return r ? r->start : -ENXIO;
> +	if (r)
> +		return r->start;
> +
> +	/*
> +	 * For the index 0 interrupt, allow falling back to GpioInt
> +	 * resources. While a device could have both Interrupt and GpioInt
> +	 * resources, making this fallback ambiguous, in many common cases
> +	 * the device will only expose one IRQ, and this fallback
> +	 * allows a common code path across either kind of resource.
> +	 */
> +	if (num == 0 && has_acpi_companion(&dev->dev))
> +		return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> +
> +	return -ENXIO;
>   #endif
>   }
>   EXPORT_SYMBOL_GPL(platform_get_irq);
> 
