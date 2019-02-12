Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A841CC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8043620823
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfBLMqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:46:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:49733 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfBLMqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:46:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 04:46:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="274417410"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 12 Feb 2019 04:46:09 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1gtXRv-0001kG-Kx; Tue, 12 Feb 2019 14:46:07 +0200
Date:   Tue, 12 Feb 2019 14:46:07 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     egranata@chromium.org
Cc:     hdegoede@redhat.com, mika.westerberg@linux.intel.com,
        dtor@chromium.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        gwendal@chromium.org, linux-acpi@vger.kernel.org,
        briannorris@chromium.org, egranata@google.com
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in
 platform_get_irq()
Message-ID: <20190212124607.GI9224@smile.fi.intel.com>
References: <20190207185917.167829-1-egranata@google.com>
 <20190211190112.209286-1-egranata@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211190112.209286-1-egranata@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Yes, let's go this way as a compromise to get major of the cases working.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

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
> +
> +	return -ENXIO;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 

-- 
With Best Regards,
Andy Shevchenko


