Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B6DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A2320880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bZjvRPNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfBTSFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:05:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33317 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:05:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so12299183pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsN1uex32LO7vi0l5cJ0Ov+raCKWcqCtyJagcC3G0Gk=;
        b=bZjvRPNU4cBo9W+sn0bb3gvu8Bbz/ghbX4ow1il1Foz+KvRVqCBiH6xUCJrACLN/aD
         oiZ0MbxDrEVoMfk40l99rOF1rKl/6u8lQU/mnNH3jBd4l81DeCJV0yoBPxyOqBDdQqGW
         vtO7nBuXJSvgmQ0bfm1e80u1aRtv+ts8bhYXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsN1uex32LO7vi0l5cJ0Ov+raCKWcqCtyJagcC3G0Gk=;
        b=CijbVfVoQCRkSo3kgybrQVE0aJIi7NiDeZyxBrcfh9jAokiCiRzaW8bIaCgtbd/BQ4
         UsNaFuJPcWXW2P92vnA8HWDfBM26l+dap3H84UEWAd6h+rFp/1F/dt5tN5Qk6pQHlCwq
         NfdRnre8PeAD9UnS+HnH6CnNpyIuthsU6UJMmUUswKeo8B9vscoDnGmhFu05SpNc6jUB
         TsDNc+9RYeAxZgsJscmMVrz5NKMimLgnpxShYSCUaJlrx3RD5tz0yOfMwaSErbzO6ERy
         8EBB8sVWRFTxjpMxL6Ta0eGHOgHAA+fVlGFjh9ilqWl2zF1H5732wH6fhsXvsFVSOakd
         ovmg==
X-Gm-Message-State: AHQUAuYeM/59cL9CAcELnEu7Ynt4u+a83DJPurlsw+rv80GvX8X6iOoV
        PpBgyKrH7RoZUEQGojKbl5niMA==
X-Google-Smtp-Source: AHgI3IbbrxE8Ks2aR9RLcwPXCHQLIzyZRQTd2MPrXrmnBq4rZT7TBApDmio9u5rwOmJ6GqScqHYaRg==
X-Received: by 2002:aa7:8508:: with SMTP id v8mr35846174pfn.14.1550685944196;
        Wed, 20 Feb 2019 10:05:44 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id e2sm32119209pga.92.2019.02.20.10.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:05:42 -0800 (PST)
Date:   Wed, 20 Feb 2019 10:05:40 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     egranata@chromium.org
Cc:     hdegoede@redhat.com, mika.westerberg@linux.intel.com,
        dtor@chromium.org, andy.shevchenko@gmail.com, rafael@kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org, gwendal@chromium.org,
        linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        egranata@google.com
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in
 platform_get_irq()
Message-ID: <20190220180538.GA42642@google.com>
References: <20190207185917.167829-1-egranata@google.com>
 <20190211190112.209286-1-egranata@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211190112.209286-1-egranata@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 11, 2019 at 11:01:12AM -0800, egranata@chromium.org wrote:
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
>  		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
>  	}
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

For ACPI devices, this changes the return code for a missing interrupt
0 from ENXIO to ENOENT, because acpi_dev_gpio_irq_get() uses ENOENT
instead of ENXIO. While ENXIO isn't exactly documented as the *specific*
error code for a missing interrupt in platform_get_irq(), there are
definitely drivers out there that are looking specifically for ENXIO
(grepping the tree finds several Rockchip platform drivers and a few
ethernet drivers at a minimum). And it also incidentally broke some
usage of the very driver you were trying to support
(drivers/platform/chrome/cros_ec_lpc.c).

I suspect a good strategy here would be to check
acpi_dev_gpio_irq_get()'s return codes here with something like:

	if (ret > 0 || ret == -EPROBE_DEFER)
		return ret;
	return -ENXIO;

Although, the gpiolib functions embedded in there also can return EIO,
so maybe something like this is better?

	if (ret == -ENOENT || ret == 0)
		return -ENXIO;
	return ret;

I'm kinda unsure what to do with error codes besides PROBE_DEFER or
"missing", since most users don't really have it in their mind that
platform_get_irq() can fail with EIO or similar.

Brian

> +
> +	return -ENXIO;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 
