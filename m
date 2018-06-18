Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3EEC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3392083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j0fQLrnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3392083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937023AbeFRXeb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:34:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34824 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbeFRXe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:34:28 -0400
Received: by mail-pg0-f67.google.com with SMTP id 15-v6so8250402pge.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uq5GnuknAAuVMErOeG/clwmQ1Hbl24AzKMgJcXNwzCU=;
        b=j0fQLrnjxCbSkCQKXjhnSY3lAVO1CWGHgImqBYTqNDxAe7DZCqDksnYQhSS8F1MJ8j
         5tLjmWhwaPlbeKHR+EQFJqReZuKFw5jV596gxm4YyYtKQvrp+6V0NzK9TlgwjSnVoR0h
         G4YIe7h3NYC/+HCqcl9R3AfCNn/cZdl0mbjIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uq5GnuknAAuVMErOeG/clwmQ1Hbl24AzKMgJcXNwzCU=;
        b=O591ajiRNtfp6c37P3nB7IVGig6ldDvIf4u1vH+ykbz7gnemkRnK6LsQ8R7Qaiwn7U
         c+vie8obMkqATLYDYF0QGkmoQ/JvonSoAE91ILjwD4Pr+M9KFnzLI7ujHK9pFbG0iPAB
         25MNxIIPM3nF7NQgTl+hJ+iEu3KdF5pwEZxTebJSSdSuFIcgdKkZZ0fvuUeJ5wLSfQCF
         YYJARnD3bYNSPmI+u1S3vtpD6QoB1RyjzI29oWFO+y/toEQKQXohYCIjNlk95R21IgaU
         aQTfEs3fH0KEz1/zxsvK2NAEr/xX8LAs+YodS6KMr/Rnhxre+JydDsq8gTZpfOaej9yw
         181g==
X-Gm-Message-State: APt69E0SYlBBI67eEKEt5r/iy5icvv94n9wtTeD0esA9UZVKB5Wl4mZx
        IPRPdnD304dUvVOJ7LbS+iFAPg==
X-Google-Smtp-Source: ADUXVKJ+GbA45lDIM1bhQEHanPGMZHle+UQmiiuTM/Mxh7xlo60ctCvii3j3SgdsdNG+5kAPS4eFng==
X-Received: by 2002:a63:3641:: with SMTP id d62-v6mr12398615pga.18.1529364868397;
        Mon, 18 Jun 2018 16:34:28 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id l8-v6sm29597642pfb.102.2018.06.18.16.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 16:34:27 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:34:24 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 11/12] misc: throttler: Add Chrome OS EC throttler
Message-ID: <20180618233423.GC154056@rodete-desktop-imager.corp.google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-12-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614194712.102134-12-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 14, 2018 at 12:47:11PM -0700, Matthias Kaehlcke wrote:
> The driver subscribes to throttling events from the Chrome OS
> embedded controller and enables/disables system throttling based
> on these events.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

One suggestion, and otherwise:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
> Changes in v3:
> - change module license to GPL v2 as in the SPDX identifier
> - don't instantiate the throttler through the DT (instantiation
>   by CrOS EC MFD in a separate patch)
> 
> Changes in v2:
> - added SPDX line instead of license boiler-plate
> - use macro to avoid splitting line
> - changed variable name for throttler from 'cte' to 'ce_thr'
> - formatting fixes
> - Kconfig: removed odd dashes around 'help'
> - added 'Reviewed-by' tag
> 
>  drivers/misc/throttler/Kconfig             |  10 ++
>  drivers/misc/throttler/Makefile            |   1 +
>  drivers/misc/throttler/cros_ec_throttler.c | 109 +++++++++++++++++++++
>  3 files changed, 120 insertions(+)
>  create mode 100644 drivers/misc/throttler/cros_ec_throttler.c
> 
> diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
> index 8b2e63b2ef48..ef984c96f67b 100644
> --- a/drivers/misc/throttler/Kconfig
> +++ b/drivers/misc/throttler/Kconfig
> @@ -20,4 +20,14 @@ menuconfig THROTTLER_DEBUG
>  
>  	  Choose N unless you want to debug throttler drivers.
>  
> +config CROS_EC_THROTTLER
> +	tristate "Throttler event monitor for the Chrome OS Embedded Controller"
> +	depends on MFD_CROS_EC
> +	help
> +	  This driver adds support to throttle the system in reaction to
> +	  Chrome OS EC events.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cros_ec_throttler.
> +
>  endif # THROTTLER
> diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
> index c8d920cee315..d9b2a77dabc9 100644
> --- a/drivers/misc/throttler/Makefile
> +++ b/drivers/misc/throttler/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_THROTTLER)		+= core.o
> +obj-$(CONFIG_CROS_EC_THROTTLER)	+= cros_ec_throttler.o
> diff --git a/drivers/misc/throttler/cros_ec_throttler.c b/drivers/misc/throttler/cros_ec_throttler.c
> new file mode 100644
> index 000000000000..f1e9fc0a6284
> --- /dev/null
> +++ b/drivers/misc/throttler/cros_ec_throttler.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for throttling triggered by events from the Chrome OS Embedded
> + * Controller.
> + *
> + * Copyright (C) 2018 Google, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/throttler.h>
> +
> +#define nb_to_ce_thr(nb) container_of(nb, struct cros_ec_throttler, nb)
> +
> +struct cros_ec_throttler {
> +	struct cros_ec_device *ec;
> +	struct throttler *throttler;
> +	struct notifier_block nb;
> +};
> +
> +static int cros_ec_throttler_event(struct notifier_block *nb,
> +	unsigned long queued_during_suspend, void *_notify)
> +{
> +	struct cros_ec_throttler *ce_thr = nb_to_ce_thr(nb);
> +	u32 host_event;
> +
> +	host_event = cros_ec_get_host_event(ce_thr->ec);
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_THROTTLE_START)) {
> +		throttler_set_level(ce_thr->throttler, 1);
> +
> +		return NOTIFY_OK;
> +	} else if (host_event &
> +		   EC_HOST_EVENT_MASK(EC_HOST_EVENT_THROTTLE_STOP)) {
> +		throttler_set_level(ce_thr->throttler, 0);
> +
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int cros_ec_throttler_probe(struct platform_device *pdev)
> +{
> +	struct cros_ec_throttler *ce_thr;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ce_thr = devm_kzalloc(dev, sizeof(*ce_thr), GFP_KERNEL);
> +	if (!ce_thr)
> +		return -ENOMEM;
> +
> +	ce_thr->ec = dev_get_drvdata(pdev->dev.parent);
> +
> +	/*
> +	 * The core code uses the DT node of the throttler to identify its
> +	 * throttling devices and rates. The CrOS EC throttler is a sub-device
> +	 * of the CrOS EC MFD device and doesn't have its own device node. Use
> +	 * the node of the MFD device instead.
> +	 */
> +	dev->of_node = dev->parent->of_node;

It might be better to get the appropriate 'parent' (and of_node) pointer
via the 'cros_ec_device' you retrieve above, since the parent might be
different depending on my suggestions in patch 12...I think.

Brian

> +
> +	ce_thr->throttler = throttler_setup(dev);
> +	if (IS_ERR(ce_thr->throttler))
> +		return PTR_ERR(ce_thr->throttler);
> +
> +	dev_set_drvdata(dev, ce_thr);
> +
> +	ce_thr->nb.notifier_call = cros_ec_throttler_event;
> +	ret = blocking_notifier_chain_register(&ce_thr->ec->event_notifier,
> +					       &ce_thr->nb);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register notifier\n");
> +		throttler_teardown(ce_thr->throttler);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_ec_throttler_remove(struct platform_device *pdev)
> +{
> +	struct cros_ec_throttler *ce_thr = platform_get_drvdata(pdev);
> +
> +	blocking_notifier_chain_unregister(&ce_thr->ec->event_notifier,
> +					   &ce_thr->nb);
> +
> +	throttler_teardown(ce_thr->throttler);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_ec_throttler_driver = {
> +	.driver = {
> +		.name = "cros-ec-throttler",
> +	},
> +	.probe		= cros_ec_throttler_probe,
> +	.remove		= cros_ec_throttler_remove,
> +};
> +
> +module_platform_driver(cros_ec_throttler_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
> +MODULE_DESCRIPTION("Chrome OS EC Throttler");
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 
