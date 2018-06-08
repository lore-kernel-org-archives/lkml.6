Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kXYjLKuNGlv6QQAAmS7hNA
	; Fri, 08 Jun 2018 14:09:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5FAA5608B8; Fri,  8 Jun 2018 14:09:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 57FE36089E;
	Fri,  8 Jun 2018 14:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57FE36089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeFHOJ0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:09:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42710 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeFHOJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:09:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1E92D264440
Subject: Re: [PATCH v2 11/11] misc: throttler: Add Chrome OS EC throttler
To: Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-12-mka@chromium.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e1681e0f-2141-12a7-bed1-4d27a43ac9e8@collabora.com>
Date: Fri, 8 Jun 2018 16:09:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607181214.30338-12-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 07/06/18 20:12, Matthias Kaehlcke wrote:
> The driver subscribes to throttling events from the Chrome OS
> embedded controller and enables/disables system throttling based
> on these events.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes in v2:
> - added SPDX line instead of license boiler-plate
> - use macro to avoid splitting line
> - changed variable name for throttler from 'cte' to 'ce_thr'
> - formatting fixes
> - Kconfig: removed odd dashes around 'help'
> - added 'Reviewed-by' tag
> 
> Note: I finally decided to keep 'Chrome OS' instead of changing it
> to 'ChromeOS'. Both are currently used in the kernel, the latter is
> currently more prevalent, however the official name is 'Chrome OS',
> so there is no good reason to keep introducing the 'alternative' name.
> 

I am pretty sure that somebody from Google told me the contrary, so

¯\_(ツ)_/¯

Anyway, you will probably know better than me :)

>  drivers/misc/throttler/Kconfig             |  14 +++
>  drivers/misc/throttler/Makefile            |   1 +
>  drivers/misc/throttler/cros_ec_throttler.c | 116 +++++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 drivers/misc/throttler/cros_ec_throttler.c
> 
> diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
> index e561f1df5085..da6fb70b96d9 100644
> --- a/drivers/misc/throttler/Kconfig
> +++ b/drivers/misc/throttler/Kconfig
> @@ -12,3 +12,17 @@ menuconfig THROTTLER
>  	  Note that you also need a event monitor module usually called
>  	  *_throttler.
>  
> +if THROTTLER
> +
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
> +endif # THROTTLER
> +
> diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
> index c8d920cee315..d9b2a77dabc9 100644
> --- a/drivers/misc/throttler/Makefile
> +++ b/drivers/misc/throttler/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_THROTTLER)		+= core.o
> +obj-$(CONFIG_CROS_EC_THROTTLER)	+= cros_ec_throttler.o
> diff --git a/drivers/misc/throttler/cros_ec_throttler.c b/drivers/misc/throttler/cros_ec_throttler.c
> new file mode 100644
> index 000000000000..432135c55600
> --- /dev/null
> +++ b/drivers/misc/throttler/cros_ec_throttler.c
> @@ -0,0 +1,116 @@
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
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	if (!np) {
> +		/* should never happen */
> +		return -EINVAL;
> +	}
> +
> +	ce_thr = devm_kzalloc(dev, sizeof(*ce_thr), GFP_KERNEL);
> +	if (!ce_thr)
> +		return -ENOMEM;
> +
> +	ce_thr->ec = dev_get_drvdata(pdev->dev.parent);
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
> +#ifdef CONFIG_OF
> +static const struct of_device_id cros_ec_throttler_of_match[] = {
> +	{ .compatible = "google,cros-ec-throttler" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, cros_ec_throttler_of_match);
> +#endif /* CONFIG_OF */
> +
> +static struct platform_driver cros_ec_throttler_driver = {
> +	.driver = {
> +		.name = "cros-ec-throttler",
> +		.of_match_table = of_match_ptr(cros_ec_throttler_of_match),
> +	},
> +	.probe		= cros_ec_throttler_probe,
> +	.remove		= cros_ec_throttler_remove,
> +};
> +
> +module_platform_driver(cros_ec_throttler_driver);
> +
> +MODULE_LICENSE("GPL");

Something that I learnt recently. To match the SPDX-license tag you should set
this to "GPL v2" [1]

 *	"GPL"				[GNU Public License v2 or later]
 *	"GPL v2"			[GNU Public License v2]

[1] https://elixir.bootlin.com/linux/v4.17/source/include/linux/module.h#L172

> +MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
> +MODULE_DESCRIPTION("Chrome OS EC Throttler");
> 

Best regards,
 Enric
