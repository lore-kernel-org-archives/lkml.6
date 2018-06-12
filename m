Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 63BABC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4F6208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KNC3WZBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4F6208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934932AbeFLBtT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:49:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42199 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934105AbeFLBtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:49:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so11198074pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 18:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v37gdavf2VQmJJ8osLq0Bkh3fO7Q/9k0xI5EtWz/06w=;
        b=KNC3WZBAQJqcOfS6jTNvCX/9JNRAiWIkG1+Szr/1P8i/HSuWfLOH/tdpd/d5zXHfoV
         aOMgg9W4+7mdOQJmSbYxFfoyOLJLkC2PDRkFRzZS4Q0quvfXidgE1OWyoCX6DfC8GkyW
         DHi9O9vkP8WFOwfnOxvd0wdVIm8L6Kwy3Nmn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v37gdavf2VQmJJ8osLq0Bkh3fO7Q/9k0xI5EtWz/06w=;
        b=UYSRJ06Civd4TEZK6vrWcau5ChDZwEpXRsQMVxq8kgGy88fajBX9aVI+EkMtKyKM4s
         ja1ChKKcRrChe54ha4FGTMiI0lXYzABakYz9I1RMcENu+qjjZwND8NXDWsa87tR7ZD33
         xA+ROMIbTiCPcbMXbRLK9I3pAM2VwKRpLa+5uJzXBcaksYu92u9pOIyJEfn2NnCTJM/R
         UNjTUv+KbQw3RnpvkByqW8VX2OhWSu+hwjMjXLVe1xgK1pAft7/20p0PCa6aK5ODd8Dz
         sP9gVU4eGKo+ww1iNmMj2ItAaWW2sV50ooRnOvQqd8xocQoQPjjYzL4AMDS8M/1o0w7E
         fPog==
X-Gm-Message-State: APt69E1c9OcFRBN1DFPqiDfpOv+0fEWiv7vhh1cPKSgvIHFolJ+MQoAi
        IahWLvqcRJ8ayKq588rhjbQM/Q==
X-Google-Smtp-Source: ADUXVKKXhFPt2sWFUs2Y3qh0wbEvtsi3YZ6sxrk53jm3DyM8VVh5Ls3+e+CkOd7KU7aIGLkELbbn8w==
X-Received: by 2002:a63:6f8a:: with SMTP id k132-v6mr1374635pgc.153.1528768156399;
        Mon, 11 Jun 2018 18:49:16 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id 14-v6sm71061463pgc.63.2018.06.11.18.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 18:49:15 -0700 (PDT)
Date:   Mon, 11 Jun 2018 18:49:13 -0700
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
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2 09/11] misc: throttler: Add core support for
 non-thermal throttling
Message-ID: <20180612014911.GA35749@rodete-desktop-imager.corp.google.com>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-10-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607181214.30338-10-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A few comments, but I didn't get to finish a thorough review yet.


On Thu, Jun 07, 2018 at 11:12:12AM -0700, Matthias Kaehlcke wrote:
> The purpose of the throttler is to provide support for non-thermal
> throttling. Throttling is triggered by external event, e.g. the
> detection of a high battery discharge current, close to the OCP limit
> of the battery. The throttler is only in charge of the throttling, not
> the monitoring, which is done by another (possibly platform specific)
> driver.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - completely reworked the driver to support configuration through OPPs, which
>   requires a more dynamic handling
> - added sysfs attribute to set the level for debugging and testing
> - Makefile: depend on Kconfig option to traverse throttler directory
> - Kconfig: removed 'default n'
> - added SPDX line instead of license boiler-plate
> - added entry to MAINTAINERS file
> 
> 
>  MAINTAINERS                     |   7 +
>  drivers/misc/Kconfig            |   1 +
>  drivers/misc/Makefile           |   1 +
>  drivers/misc/throttler/Kconfig  |  14 +
>  drivers/misc/throttler/Makefile |   1 +
>  drivers/misc/throttler/core.c   | 642 ++++++++++++++++++++++++++++++++
>  include/linux/throttler.h       |  11 +
>  7 files changed, 677 insertions(+)
>  create mode 100644 drivers/misc/throttler/Kconfig
>  create mode 100644 drivers/misc/throttler/Makefile
>  create mode 100644 drivers/misc/throttler/core.c
>  create mode 100644 include/linux/throttler.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92e47b5b0480..f9550e5680ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13938,6 +13938,13 @@ T:	git git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
>  S:	Maintained
>  F:	drivers/platform/x86/thinkpad_acpi.c
>  
> +THROTTLER DRIVERS
> +M:	Matthias Kaehlcke <mka@chromium.org>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/misc/throttler/
> +F:	include/linux/throttler.h
> +
>  THUNDERBOLT DRIVER
>  M:	Andreas Noever <andreas.noever@gmail.com>
>  M:	Michael Jamet <michael.jamet@intel.com>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 5d713008749b..691d9625d83c 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -513,4 +513,5 @@ source "drivers/misc/echo/Kconfig"
>  source "drivers/misc/cxl/Kconfig"
>  source "drivers/misc/ocxl/Kconfig"
>  source "drivers/misc/cardreader/Kconfig"
> +source "drivers/misc/throttler/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 20be70c3f118..b549ccad5215 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_MISC_RTSX)		+= cardreader/
> +obj-$(CONFIG_THROTTLER)		+= throttler/
> diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
> new file mode 100644
> index 000000000000..e561f1df5085
> --- /dev/null
> +++ b/drivers/misc/throttler/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +menuconfig THROTTLER
> +	bool "Throttler support"
> +	depends on OF
> +	select CPU_FREQ
> +	select PM_DEVFREQ

I'm curious whether we're actually truly compile-time dependent on
{CPU,DEV}FREQ? It seems like those subsystems mostly stub out stuff so
they fall back to no-ops if not built in.

I know that's not very useful for your existing throttler, since it
wouldn't be very effective if one or both were disabled.

> +	help
> +	  This option enables core support for non-thermal throttling of CPUs
> +	  and devfreq devices.
> +
> +	  Note that you also need a event monitor module usually called
> +	  *_throttler.
> +
> diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
> new file mode 100644
> index 000000000000..c8d920cee315
> --- /dev/null
> +++ b/drivers/misc/throttler/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_THROTTLER)		+= core.o
> diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
> new file mode 100644
> index 000000000000..15b50c111032
> --- /dev/null
> +++ b/drivers/misc/throttler/core.c
> @@ -0,0 +1,642 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Core code for non-thermal throttling
> + *
> + * Copyright (C) 2018 Google, Inc.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/cpumask.h>
> +#include <linux/devfreq.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/sort.h>
> +#include <linux/slab.h>
> +#include <linux/throttler.h>
> +
> +/*
> + * Non-thermal throttling: throttling of system components in response to
> + * external events (e.g. high battery discharge current).
> + *
> + * The throttler supports throttling through cpufreq and devfreq. Multiple
> + * levels of throttling can be configured. At level 0 no throttling is
> + * active on behalf of the throttler, for values > 0 throttling is typically
> + * configured to be increasingly aggressive with each level.
> + * The number of throttling levels is not limited by the throttler (though
> + * it is likely limited by the throttling devices). It is not necessary to
> + * configure the same number of levels for all throttling devices. If the
> + * requested throttling level for a device is higher than the maximum level
> + * of the device the throttler will select the maximum throttling level of
> + * the device.
> + *
> + * Non-thermal throttling is split in two parts:
> + *
> + * - throttler core
> + *   - parses the thermal policy
> + *   - applies throttling settings for a requested level of throttling
> + *
> + * - event monitor driver
> + *   - monitors events that trigger throttling
> + *   - determines the throttling level (often limited to on/off)
> + *   - asks throttler core to apply throttling settings
> + *
> + * It is possible for a system to have more than one throttler and the
> + * throttlers may make use of the same throttling devices, in case of
> + * conflicting settings for a device the more aggressive values will be
> + * applied.
> + *
> + */
> +
> +#define ci_to_throttler(ci) \
> +	container_of(ci, struct throttler, devfreq.class_iface)
> +
> +// #define DEBUG_THROTTLER

Did you mean to leave your debug code in? Seems like you have some
related dead code under #ifdefs.

(If you do want this, maybe it'd be better under debugfs, until somebody
really wants to formalize and document it.)

> +
> +struct thr_freq_table {
> +	uint32_t *freqs;
> +	int n_entries;
> +};
> +
> +struct cpufreq_thrdev {
> +	uint32_t cpu;
> +	struct thr_freq_table freq_table;
> +	struct list_head node;
> +};
> +
> +struct devfreq_thrdev {
> +	struct devfreq *devfreq;
> +	struct thr_freq_table freq_table;
> +	struct throttler *thr;
> +	struct notifier_block nb;
> +	struct list_head node;
> +};
> +
> +struct __thr_cpufreq {
> +	struct list_head list;
> +	cpumask_t cm_initialized;
> +	cpumask_t cm_ignore;
> +	struct notifier_block nb;
> +};
> +
> +struct __thr_devfreq {
> +	struct list_head list;
> +	struct class_interface class_iface;
> +};
> +
> +struct throttler {
> +	struct device *dev;
> +	int level;
> +	struct __thr_cpufreq cpufreq;
> +	struct __thr_devfreq devfreq;
> +	struct mutex lock;
> +};
> +
> +static inline int cmp_freqs(const void *a, const void *b)
> +{
> +	const uint32_t *pa = a, *pb = b;
> +
> +	if (*pa < *pb)
> +		return 1;
> +	else if (*pa > *pb)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int thr_handle_devfreq_event(struct notifier_block *nb,
> +				    unsigned long event, void *data);
> +
> +static unsigned long thr_get_throttling_freq(struct thr_freq_table *ft,
> +					     int level)
> +{
> +	if (level == 0) {
> +		WARN(true, "level == 0");
> +		return ULONG_MAX;
> +	}
> +
> +	if (level <= ft->n_entries)
> +		return ft->freqs[level - 1];
> +	else
> +		return ft->freqs[ft->n_entries - 1];
> +}
> +
> +static int thr_init_freq_table(struct throttler *thr, struct device *opp_dev,
> +			       struct thr_freq_table *ft)
> +{
> +	struct device_node *np_opp_desc, *np_opp;
> +	int nchilds;
> +	uint32_t *freqs;
> +	int nfreqs = 0;
> +	int err = 0;
> +
> +	np_opp_desc = dev_pm_opp_of_get_opp_desc_node(opp_dev);
> +	if (!np_opp_desc)
> +		return -EINVAL;
> +
> +	nchilds = of_get_child_count(np_opp_desc);
> +	if (!nchilds) {
> +		err = -EINVAL;
> +		goto out_node_put;
> +	}
> +
> +	freqs = kzalloc(nchilds * sizeof(uint32_t), GFP_KERNEL);
> +	if (!freqs) {
> +		err = -ENOMEM;
> +		goto out_node_put;
> +	}
> +
> +	/* determine which OPPs are used by this throttler (if any) */
> +	for_each_child_of_node(np_opp_desc, np_opp) {
> +		int num_thr;
> +		int i;
> +
> +		num_thr = of_property_count_u32_elems(np_opp, "opp-throttlers");
> +		if (num_thr < 0)
> +			continue;
> +
> +		for (i = 0; i < num_thr; i++) {
> +			struct device_node *np_thr;
> +			struct platform_device *pdev;
> +
> +			np_thr = of_parse_phandle(np_opp, "opp-throttlers", i);
> +			if (!np_thr) {
> +				dev_err(thr->dev,
> +					"failed to parse phandle %d: %s\n", i,
> +					np_opp->full_name);
> +				continue;
> +			}
> +
> +			pdev = of_find_device_by_node(np_thr);
> +			if (!pdev) {
> +				dev_err(thr->dev,
> +					"could not find throttler dev: %s\n",
> +					 np_thr->full_name);
> +				of_node_put(np_thr);
> +				continue;
> +			}
> +
> +			/* OPP is used by this throttler */
> +			if (&pdev->dev == thr->dev) {

So you're assuming that all throttlers are platform devices? Seems
slightly shaky; I could easily imagine a similar device that's a SPI or
I2C device.

> +				u64 rate;
> +
> +				err = of_property_read_u64(np_opp, "opp-hz",
> +							   &rate);
> +				if (!err) {
> +					freqs[nfreqs] = rate;
> +					nfreqs++;
> +				} else {
> +					dev_err(thr->dev,
> +						"opp-hz not found: %s\n",
> +						np_opp->full_name);
> +				}
> +			}
> +
> +			of_node_put(np_thr);
> +			put_device(&pdev->dev);
> +		}
> +	}
> +
> +	if (nfreqs > 0) {
> +		/* sort frequencies in descending order */
> +		sort(freqs, nfreqs, sizeof(*freqs), cmp_freqs, NULL);
> +
> +		ft->n_entries = nfreqs;
> +		ft->freqs = devm_kzalloc(thr->dev,
> +				  nfreqs * sizeof(*freqs), GFP_KERNEL);
> +		if (!ft->freqs) {
> +			err = -ENOMEM;
> +			goto out_free;
> +		}
> +
> +		memcpy(ft->freqs, freqs, nfreqs * sizeof(*freqs));
> +	} else {
> +		err = -ENODEV;
> +	}
> +
> +out_free:
> +	kfree(freqs);
> +
> +out_node_put:
> +	of_node_put(np_opp_desc);
> +
> +	return err;
> +}

[...]

Brian
