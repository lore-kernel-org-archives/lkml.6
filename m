Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107EAC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5022083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IivzJvyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5022083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755444AbeFRXDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:03:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40059 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755329AbeFRXDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:03:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so9833806plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aPllUrZzMlNGX8MeeCQMwFduYB7bvMdoSl2iZI2XBJ0=;
        b=IivzJvyD5LJWNTnimSo5yst1myBt+bDvJhrsr8rfu0YrmbhZw2xLCHBrOWmQ8mUNJW
         l7FTWD5LCN/f/nZwPKx42vuXotN+46fjkhFhuzMwvw77y44H3i77dDfdiXOf2IPqYCuY
         cPTB3pu7say8oOvIJAZ4nSb6paIEuBGc37OmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aPllUrZzMlNGX8MeeCQMwFduYB7bvMdoSl2iZI2XBJ0=;
        b=A6B33WGvOpBGBQy6lStBJd1cEVax9gB4mOeoL2t7JScxdQhxGcH7DPoIFVeo7rkCOw
         JIUOa1MsfPE3vdo8Q6m9OpZVGkLMgpvbjFH8WbXzmnMrgi5vnoTo4k9wL9z0Yz4YWtyS
         5MykqTQhqMMYwOgfW7I6LtkBnJZDooCgPY0eDJyjJx8lvJG3FRJwb331JiMq1czU7dSx
         kkP9JtPXz4FWB3QA1/txmYA7HrJ6AR001BrNWwXX7ZxQ4K+ftqHtbUomI8rlFgPeQB3n
         W4QCd+Nk5fQMvxqMSpv0Ry7jP3bV0Zc9Bq6tBf0pP0eKK9S1pzdFfJ3rrfeZZ4nor8vy
         6TVg==
X-Gm-Message-State: APt69E2/zIeqDPrw3LmboCCirPIAVetfwuxEbglIqxuRKR21XsifLrJq
        Up8yB+tMllR6MsuzMh1ri1JgUQ==
X-Google-Smtp-Source: ADUXVKIw45S4YCJrLU0RhaovyUuF+7K81bS6Ld2zCrLpakLqPVm7WVhA6smbFxaqOl6NPYDbBCEN/w==
X-Received: by 2002:a17:902:8f82:: with SMTP id z2-v6mr16074411plo.203.1529363009304;
        Mon, 18 Jun 2018 16:03:29 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id b22-v6sm23282405pfi.144.2018.06.18.16.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 16:03:27 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:03:25 -0700
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
Subject: Re: [PATCH v3 10/12] misc: throttler: Add core support for
 non-thermal throttling
Message-ID: <20180618230324.GA154056@rodete-desktop-imager.corp.google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-11-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614194712.102134-11-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, Jun 14, 2018 at 12:47:10PM -0700, Matthias Kaehlcke wrote:
> The purpose of the throttler is to provide support for non-thermal
> throttling. Throttling is triggered by external event, e.g. the
> detection of a high battery discharge current, close to the OCP limit
> of the battery. The throttler is only in charge of the throttling, not
> the monitoring, which is done by another (possibly platform specific)
> driver.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

I have a few more comments.

> ---
> Changes in v3:
> - Kconfig: don't select CPU_FREQ and PM_DEVFREQ
> - added CONFIG_THROTTLER_DEBUG option
> - changed 'level' sysfs attribute to debugfs
> - introduced thr_<level> macros for logging
> - added debug logs
> - added field clamp_freq to struct cpufreq_thrdev and devfreq_thrdev
>   to keep track of the current frequency limits and avoid spammy logs
> 
> Changes in v2:
> - completely reworked the driver to support configuration through OPPs, which
>   requires a more dynamic handling
> - added sysfs attribute to set the level for debugging and testing
> - Makefile: depend on Kconfig option to traverse throttler directory
> - Kconfig: removed 'default n'
> - added SPDX line instead of license boiler-plate
> - added entry to MAINTAINERS file
> 
>  MAINTAINERS                     |   7 +
>  drivers/misc/Kconfig            |   1 +
>  drivers/misc/Makefile           |   1 +
>  drivers/misc/throttler/Kconfig  |  23 ++
>  drivers/misc/throttler/Makefile |   1 +
>  drivers/misc/throttler/core.c   | 687 ++++++++++++++++++++++++++++++++
>  include/linux/throttler.h       |  21 +
>  7 files changed, 741 insertions(+)
>  create mode 100644 drivers/misc/throttler/Kconfig
>  create mode 100644 drivers/misc/throttler/Makefile
>  create mode 100644 drivers/misc/throttler/core.c
>  create mode 100644 include/linux/throttler.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc241b04d1bd..db359af7cb1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14090,6 +14090,13 @@ T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
>  S:	Maintained
>  F:	drivers/media/platform/am437x/
>  
> +THROTTLER DRIVERS
> +M:	Matthias Kaehlcke <mka@chromium.org>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/misc/throttler/
> +F:	include/linux/throttler.h
> +
>  TI BANDGAP AND THERMAL DRIVER
>  M:	Eduardo Valentin <edubezval@gmail.com>
>  M:	Keerthy <j-keerthy@ti.com>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3726eacdf65d..717fa3bd0e09 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -527,4 +527,5 @@ source "drivers/misc/echo/Kconfig"
>  source "drivers/misc/cxl/Kconfig"
>  source "drivers/misc/ocxl/Kconfig"
>  source "drivers/misc/cardreader/Kconfig"
> +source "drivers/misc/throttler/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index af22bbc3d00c..0f4ecc6a7532 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_MISC_RTSX)		+= cardreader/
> +obj-$(CONFIG_THROTTLER)		+= throttler/
> diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
> new file mode 100644
> index 000000000000..8b2e63b2ef48
> --- /dev/null
> +++ b/drivers/misc/throttler/Kconfig
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +menuconfig THROTTLER
> +	bool "Throttler support"
> +	depends on OF
> +	help
> +	  This option enables core support for non-thermal throttling of CPUs
> +	  and devfreq devices.
> +
> +	  Note that you also need a event monitor module usually called
> +	  *_throttler.
> +
> +if THROTTLER
> +
> +menuconfig THROTTLER_DEBUG
> +	bool "Enable throttler debugging"
> +	help
> +	  This option enables throttler debugging features like additional
> +	  logging and a debugfs attribute for setting the logging level.
> +
> +	  Choose N unless you want to debug throttler drivers.
> +
> +endif # THROTTLER
> diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
> new file mode 100644
> index 000000000000..c8d920cee315
> --- /dev/null
> +++ b/drivers/misc/throttler/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_THROTTLER)		+= core.o
> diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
> new file mode 100644
> index 000000000000..52350d846654
> --- /dev/null
> +++ b/drivers/misc/throttler/core.c
> @@ -0,0 +1,687 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Core code for non-thermal throttling
> + *
> + * Copyright (C) 2018 Google, Inc.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpumask.h>
> +#include <linux/debugfs.h>
> +#include <linux/devfreq.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +#include <linux/sort.h>
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
> +struct thr_freq_table {
> +	uint32_t *freqs;
> +	int n_entries;
> +};
> +
> +struct cpufreq_thrdev {
> +	uint32_t cpu;
> +	struct thr_freq_table freq_table;
> +	uint32_t clamp_freq;
> +	struct list_head node;
> +};
> +
> +struct devfreq_thrdev {
> +	struct devfreq *devfreq;
> +	struct thr_freq_table freq_table;
> +	uint32_t clamp_freq;
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
> +struct __thr_debugfs {
> +	struct dentry *dir;
> +	struct dentry *attr_level;
> +};
> +
> +struct throttler {
> +	struct device *dev;
> +	int level;
> +	struct __thr_cpufreq cpufreq;
> +	struct __thr_devfreq devfreq;
> +	struct mutex lock;
> +#ifdef CONFIG_THROTTLER_DEBUG
> +	struct __thr_debugfs debugfs;
> +#endif
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
> +
> +			np_thr = of_parse_phandle(np_opp, "opp-throttlers", i);
> +			if (!np_thr) {
> +				thr_err(thr,
> +					"failed to parse phandle %d: %s\n", i,
> +					np_opp->full_name);
> +				continue;
> +			}
> +
> +			if (thr->dev->of_node == np_thr) {
> +				u64 rate;
> +
> +				err = of_property_read_u64(np_opp, "opp-hz",
> +							   &rate);
> +				if (!err) {
> +					freqs[nfreqs] = rate;
> +					nfreqs++;
> +
> +					thr_dbg(thr,
> +						"OPP %s (%llu MHz) is used for throttling\n",
> +						np_opp->full_name,
> +						rate / 1000000);
> +
> +				} else {
> +					thr_err(thr, "opp-hz not found: %s\n",
> +						np_opp->full_name);
> +				}
> +			}
> +
> +			of_node_put(np_thr);
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
> +
> +static void thr_cpufreq_init(struct throttler *thr, int cpu)
> +{
> +	struct device *cpu_dev;
> +	struct thr_freq_table ft;
> +	struct cpufreq_thrdev *cpufreq_dev;
> +	int err;
> +
> +	WARN_ON(!mutex_is_locked(&thr->lock));
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev) {
> +		dev_err_ratelimited(thr->dev, "failed to get CPU %d\n", cpu);
> +		return;
> +	}
> +
> +	err = thr_init_freq_table(thr, cpu_dev, &ft);
> +	if (err) {
> +		/* CPU is not throttled or initialization failed */
> +		if (err != -ENODEV)
> +			thr_err(thr, "failed to initialize CPU %d: %d", cpu,
> +				err);
> +
> +		cpumask_set_cpu(cpu, &thr->cpufreq.cm_ignore);
> +		return;
> +	}
> +
> +	cpufreq_dev = devm_kzalloc(thr->dev, sizeof(*cpufreq_dev), GFP_KERNEL);
> +	if (!cpufreq_dev) {
> +		thr_err(thr, "%s: out of memory\n", __func__);
> +		return;
> +	}
> +
> +	cpufreq_dev->cpu = cpu;
> +	memcpy(&cpufreq_dev->freq_table, &ft, sizeof(ft));
> +	list_add_tail(&cpufreq_dev->node, &thr->cpufreq.list);
> +
> +	cpumask_set_cpu(cpu, &thr->cpufreq.cm_initialized);
> +}
> +
> +static void thr_devfreq_init(struct device *dev, void *data)
> +{
> +	struct throttler *thr = data;
> +	struct thr_freq_table ft;
> +	struct devfreq_thrdev *dftd;
> +	int err;
> +
> +	WARN_ON(!mutex_is_locked(&thr->lock));
> +
> +	err = thr_init_freq_table(thr, dev->parent, &ft);
> +	if (err) {
> +		if (err == -ENODEV)
> +			return;
> +
> +		thr_err(thr, "failed to init frequency table of device %s: %d",
> +			dev_name(dev), err);
> +		return;
> +	}
> +
> +	dftd = devm_kzalloc(thr->dev, sizeof(*dftd), GFP_KERNEL);
> +	if (!dftd) {
> +		thr_err(thr, "%s: out of memory\n", __func__);

I think it's considered bad form to roll your own OOM messages. It's
assumed the memory manager will complain loudly enough for you already.

> +		return;
> +	}
> +
> +	dftd->thr = thr;
> +	dftd->devfreq = container_of(dev, struct devfreq, dev);
> +	memcpy(&dftd->freq_table, &ft, sizeof(ft));
> +
> +	dftd->nb.notifier_call = thr_handle_devfreq_event;
> +	err = devm_devfreq_register_notifier(thr->dev, dftd->devfreq,
> +				     &dftd->nb, DEVFREQ_POLICY_NOTIFIER);
> +	if (err < 0) {
> +		thr_err(thr, "failed to register devfreq notifier\n");
> +		devm_kfree(thr->dev, dftd);
> +		return;
> +	}
> +
> +	list_add_tail(&dftd->node, &thr->devfreq.list);
> +
> +	thr_dbg(thr, "device '%s' is used for throttling\n",
> +		dev_name(dev));
> +}
> +
> +static int thr_handle_cpufreq_event(struct notifier_block *nb,
> +				unsigned long event, void *data)
> +{
> +	struct throttler *thr =
> +		container_of(nb, struct throttler, cpufreq.nb);
> +	struct cpufreq_policy *policy = data;
> +	struct cpufreq_thrdev *cftd;
> +
> +	if (event != CPUFREQ_ADJUST)
> +		return 0;
> +
> +	mutex_lock(&thr->lock);
> +
> +	if (cpumask_test_cpu(policy->cpu, &thr->cpufreq.cm_ignore))
> +		goto out;
> +
> +	if (!cpumask_test_cpu(policy->cpu, &thr->cpufreq.cm_initialized)) {
> +		thr_cpufreq_init(thr, policy->cpu);
> +
> +		if (cpumask_test_cpu(policy->cpu, &thr->cpufreq.cm_ignore))
> +			goto out;
> +
> +		thr_dbg(thr, "CPU%d is used for throttling\n", policy->cpu);
> +	}
> +
> +	/*
> +	 * Can't do this check earlier, otherwise we might miss CPU policies
> +	 * that are added after setup().
> +	 */
> +	if (thr->level == 0) {
> +		list_for_each_entry(cftd, &thr->cpufreq.list, node) {
> +			if (cftd->cpu != policy->cpu)
> +				continue;
> +
> +			if (cftd->clamp_freq != 0) {
> +				thr_dbg(thr, "unthrottling CPU%d\n", cftd->cpu);
> +				cftd->clamp_freq = 0;
> +			}
> +		}
> +
> +		goto out;
> +	}
> +
> +	list_for_each_entry(cftd, &thr->cpufreq.list, node) {
> +		unsigned long clamp_freq;
> +
> +		if (cftd->cpu != policy->cpu)
> +			continue;
> +
> +		clamp_freq = thr_get_throttling_freq(&cftd->freq_table,
> +						     thr->level) / 1000;
> +		if (cftd->clamp_freq != clamp_freq) {
> +			thr_dbg(thr, "throttling CPU%d to %lu MHz\n", cftd->cpu,
> +				clamp_freq / 1000);
> +			cftd->clamp_freq = clamp_freq;
> +		}
> +
> +		if (clamp_freq < policy->max)
> +			cpufreq_verify_within_limits(policy, 0, clamp_freq);
> +	}
> +
> +out:
> +	mutex_unlock(&thr->lock);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +/*
> + * Notifier called by devfreq. Can't acquire thr->lock since it might
> + * already be held by throttler_set_level(). It isn't necessary to
> + * acquire the lock for the following reasons:
> + *
> + * Only the devfreq_thrdev and thr->level are accessed in this function.
> + * The devfreq device won't go away (or change) during the execution of
> + * this function, since we are called from the devfreq core. Theoretically
> + * thr->level could change and we'd apply an outdated setting, however in
> + * this case the function would run again shortly after and apply the
> + * correct value.
> + */
> +static int thr_handle_devfreq_event(struct notifier_block *nb,
> +				    unsigned long event, void *data)
> +{
> +	struct devfreq_thrdev *dftd =
> +		container_of(nb, struct devfreq_thrdev, nb);
> +	struct throttler *thr = dftd->thr;
> +	struct devfreq_policy *policy = data;
> +	unsigned long clamp_freq;
> +
> +	if (event != DEVFREQ_ADJUST)
> +		return NOTIFY_DONE;
> +
> +	if (thr->level == 0) {
> +		if (dftd->clamp_freq != 0) {
> +			thr_dbg(thr, "unthrottling '%s'\n",
> +				dev_name(&dftd->devfreq->dev));
> +			dftd->clamp_freq = 0;
> +		}
> +
> +		return NOTIFY_DONE;
> +	}
> +
> +	clamp_freq = thr_get_throttling_freq(&dftd->freq_table, thr->level);
> +	if (clamp_freq != dftd->clamp_freq) {
> +		thr_dbg(thr, "throttling '%s' to %lu MHz\n",
> +			dev_name(&dftd->devfreq->dev), clamp_freq / 1000000);
> +		dftd->clamp_freq = clamp_freq;
> +	}
> +
> +	if (clamp_freq < policy->max)
> +		devfreq_verify_within_limits(policy, 0, clamp_freq);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static void thr_cpufreq_update_policy(struct throttler *thr)
> +{
> +	struct cpufreq_thrdev *cftd;
> +
> +	WARN_ON(!mutex_is_locked(&thr->lock));
> +
> +	list_for_each_entry(cftd, &thr->cpufreq.list, node) {
> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cftd->cpu);
> +
> +		if (!policy) {
> +			thr_warn(thr, "CPU%d does have no cpufreq policy!\n",

s/does have/has/

> +				 cftd->cpu);
> +			continue;
> +		}
> +
> +		/*
> +		 * The lock isn't really needed in this function, the list
> +		 * of cpufreq devices can be extended, but no items are
> +		 * deleted during the lifetime of the throttler. Releasing
> +		 * the lock is necessary since cpufreq_update_policy() ends
> +		 * up calling thr_handle_cpufreq_event(), which needs to
> +		 * acquire the lock.
> +		 */
> +		mutex_unlock(&thr->lock);
> +		cpufreq_update_policy(cftd->cpu);
> +		mutex_lock(&thr->lock);
> +
> +		cpufreq_cpu_put(policy);
> +	}
> +}
> +
> +static int thr_handle_devfreq_added(struct device *dev,
> +				    struct class_interface *ci)
> +{
> +	struct throttler *thr = ci_to_throttler(ci);
> +
> +	mutex_lock(&thr->lock);
> +	thr_devfreq_init(dev, thr);
> +	mutex_unlock(&thr->lock);
> +
> +	return 0;
> +}
> +
> +static void thr_handle_devfreq_removed(struct device *dev,
> +				       struct class_interface *ci)
> +{
> +	struct devfreq_thrdev *dftd;
> +	struct throttler *thr = ci_to_throttler(ci);
> +
> +	mutex_lock(&thr->lock);
> +
> +	list_for_each_entry(dftd, &thr->devfreq.list, node) {
> +		if (dev == &dftd->devfreq->dev) {
> +			list_del(&dftd->node);
> +			devm_kfree(thr->dev, dftd->freq_table.freqs);
> +			devm_kfree(thr->dev, dftd);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&thr->lock);
> +}
> +
> +void throttler_set_level(struct throttler *thr, int level)
> +{
> +	struct devfreq_thrdev *dftd;

This driver doesn't really handle negative levels very well (it might
even read garbage memory?). You might either make the whole driver use
unsigned values (and parse with an unsigned kstrtoX helper below), or
else just reject negative values in this function.

> +
> +	if (level == thr->level)

It seems like this should be inside the lock.

> +		return;
> +
> +	mutex_lock(&thr->lock);
> +
> +	thr_dbg(thr, "throttling level: %d\n", level);
> +	thr->level = level;
> +
> +	if (!list_empty(&thr->cpufreq.list))
> +		thr_cpufreq_update_policy(thr);
> +
> +	list_for_each_entry(dftd, &thr->devfreq.list, node) {
> +		mutex_lock(&dftd->devfreq->lock);
> +		update_devfreq(dftd->devfreq);
> +		mutex_unlock(&dftd->devfreq->lock);
> +	}
> +
> +	mutex_unlock(&thr->lock);
> +}
> +EXPORT_SYMBOL_GPL(throttler_set_level);
> +
> +#ifdef CONFIG_THROTTLER_DEBUG
> +
> +static ssize_t thr_level_read(struct file *file, char __user *user_buf,
> +			      size_t count, loff_t *ppos)
> +{
> +	struct throttler *thr = file->f_inode->i_private;
> +	char buf[5];
> +	int len;
> +
> +	len = scnprintf(buf, sizeof(buf), "%d\n", thr->level);

Hold the throttler mutex around this read?

> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}
> +
> +static ssize_t thr_level_write(struct file *file,
> +				 const char __user *user_buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	int rc;
> +	int level;
> +	struct throttler *thr = file->f_inode->i_private;
> +
> +	rc = kstrtoint_from_user(user_buf, count, 10, &level);
> +	if (rc)
> +		return rc;
> +
> +	throttler_set_level(thr, level);
> +
> +	return count;
> +}
> +
> +static const struct file_operations level_debugfs_ops = {
> +	.owner = THIS_MODULE,
> +	.read = thr_level_read,
> +	.write = thr_level_write,
> +};
> +#endif
> +
> +struct throttler *throttler_setup(struct device *dev)
> +{
> +	struct throttler *thr;
> +	struct device_node *np = dev->of_node;
> +	struct class_interface *ci;
> +	int cpu;
> +	int err;
> +
> +	if (!np)
> +		/* should never happen */
> +		return ERR_PTR(-EINVAL);
> +
> +	thr = devm_kzalloc(dev, sizeof(*thr), GFP_KERNEL);
> +	if (!thr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&thr->lock);
> +	thr->dev = dev;
> +
> +	cpumask_clear(&thr->cpufreq.cm_ignore);
> +	cpumask_clear(&thr->cpufreq.cm_initialized);
> +
> +	INIT_LIST_HEAD(&thr->cpufreq.list);
> +	INIT_LIST_HEAD(&thr->devfreq.list);
> +
> +	thr->cpufreq.nb.notifier_call = thr_handle_cpufreq_event;
> +	err = cpufreq_register_notifier(&thr->cpufreq.nb,
> +					CPUFREQ_POLICY_NOTIFIER);
> +	if (err < 0) {
> +		thr_err(thr, "failed to register cpufreq notifier\n");
> +		return ERR_PTR(err);
> +	}
> +
> +	/*
> +	 * The CPU throttling configuration is parsed at runtime, when the
> +	 * cpufreq policy notifier is called for a CPU that hasn't been
> +	 * initialized yet.
> +	 *
> +	 * This is done for two reasons:
> +	 * -  when the throttler is probed the CPU might not yet have a policy
> +	 * -  CPUs that were offline at probe time might be hotplugged
> +	 *
> +	 * The notifier is called then the policy is added/set
> +	 */
> +	for_each_online_cpu(cpu) {
> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +
> +		if (!policy)
> +			continue;
> +
> +		cpufreq_update_policy(cpu);
> +		cpufreq_cpu_put(policy);
> +	}
> +
> +	/*
> +	 * devfreq devices can be added and removed at runtime, hence they
> +	 * must also be handled dynamically. The class_interface notifies us
> +	 * whenever a device is added or removed. When the interface is
> +	 * registered ci->add_dev() is called for all existing devfreq
> +	 * devices.
> +	 */
> +	ci = &thr->devfreq.class_iface;
> +	ci->class = devfreq_class;
> +	ci->add_dev = thr_handle_devfreq_added;
> +	ci->remove_dev = thr_handle_devfreq_removed;
> +
> +	err = class_interface_register(ci);
> +	if (err) {
> +		thr_err(thr, "failed to register devfreq class interface: %d\n",
> +			err);
> +		cpufreq_unregister_notifier(&thr->cpufreq.nb,
> +					    CPUFREQ_POLICY_NOTIFIER);
> +		return ERR_PTR(err);
> +	}
> +
> +#ifdef CONFIG_THROTTLER_DEBUG
> +	thr->debugfs.dir = debugfs_create_dir(dev_name(thr->dev), NULL);

Remove this dir in throttler_teardown()?

> +	if (IS_ERR(thr->debugfs.dir)) {
> +		thr_warn(thr, "failed to create debugfs directory: %ld\n",
> +			 PTR_ERR(thr->debugfs.dir));
> +		thr->debugfs.dir = NULL;
> +		goto skip_debugfs;
> +	}
> +
> +	thr->debugfs.attr_level = debugfs_create_file("level", 0644,
> +						      thr->debugfs.dir, thr,
> +						      &level_debugfs_ops);
> +	if (IS_ERR(thr->debugfs.dir)) {
> +		thr_warn(thr, "failed to create debugfs attribute: %ld\n",
> +			 PTR_ERR(thr->debugfs.attr_level));
> +		debugfs_remove(thr->debugfs.dir);
> +		thr->debugfs.dir = NULL;
> +	}
> +
> +skip_debugfs:
> +#endif
> +
> +	return thr;
> +}
> +EXPORT_SYMBOL_GPL(throttler_setup);
> +
> +void throttler_teardown(struct throttler *thr)
> +{
> +	struct devfreq_thrdev *dftd;
> +	int level;
> +
> +	mutex_lock(&thr->lock);
> +
> +	level = thr->level;
> +	thr->level = 0;
> +
> +	class_interface_unregister(&thr->devfreq.class_iface);

This can deadlock. You're holding the throttler mutex and then this
grabs the class mutex; but add/remove notifications will be holding the
class mutex while making calls that grab the throttler mutex. IOW, you
have ABBA (not the band).

Also, if there are any active devfreq devices attached...you definitely
deadlock (simple AA), since we directly call ->remove_dev() on them
here. See this locked-up task:

[ 4440.118203] [<ffffffc0002158a0>] __switch_to+0x90/0x9c
[ 4440.118221] [<ffffffc000954f40>] __schedule+0x3cc/0x860
[ 4440.118232] [<ffffffc000954b14>] schedule+0x4c/0xac
[ 4440.118243] [<ffffffc0009553f8>] schedule_preempt_disabled+0x24/0x40
[ 4440.118255] [<ffffffc000956ac8>] __mutex_lock_common+0x194/0x3b0
[ 4440.118267] [<ffffffc000956348>] __mutex_lock_slowpath+0x38/0x44
[ 4440.118278] [<ffffffc00095630c>] mutex_lock+0x6c/0x70
[ 4440.118293] [<ffffffc00062c444>] thr_handle_devfreq_removed+0x2c/0xa0
[ 4440.118307] [<ffffffc000606dbc>] class_interface_unregister+0x74/0xc4
[ 4440.118318] [<ffffffc00062c4ec>] throttler_teardown+0x34/0xac
[ 4440.118328] [<ffffffc00062cb60>] cros_ec_throttler_remove+0x30/0x40
[ 4440.118341] [<ffffffc000607a60>] platform_drv_remove+0x28/0x50
[ 4440.118355] [<ffffffc000605974>] device_release_driver_internal+0x120/0x1b0
[ 4440.118367] [<ffffffc000605a28>] device_release_driver+0x24/0x30
[ 4440.118380] [<ffffffc000604b50>] unbind_store+0x6c/0xa4
[ 4440.118392] [<ffffffc000604a4c>] drv_attr_store+0x3c/0x54
[ 4440.118409] [<ffffffc0003bd4e0>] sysfs_kf_write+0x50/0x68
[ 4440.118424] [<ffffffc00044233c>] kernfs_fop_write+0xdc/0x188
[ 4440.118436] [<ffffffc00042762c>] __vfs_write+0xfc/0x10c
[ 4440.118446] [<ffffffc000427950>] SyS_write+0xf0/0x278
[ 4440.118460] [<ffffffc000203e44>] el0_svc_naked+0x34/0x38

I got there with this:

  echo cros-ec-throttler.1.auto > /sys/bus/platform/drivers/cros-ec-throttler/unbind

> +
> +	if (level) {
> +		/* unthrottle CPUs */
> +		if (!list_empty(&thr->cpufreq.list))

You don't technically need the list_empty() check, since you do
list_for_each_entry() within thr_cpufreq_update_policy().

> +			thr_cpufreq_update_policy(thr);
> +
> +		/* unthrottle devfreq devices */
> +		list_for_each_entry(dftd, &thr->devfreq.list, node) {
> +			mutex_lock(&dftd->devfreq->lock);
> +			update_devfreq(dftd->devfreq);
> +			mutex_unlock(&dftd->devfreq->lock);
> +		}

I wonder if the 'update' step deserves its own function, since the
cpufreq/devfreq updates are repeated in throttler_set_level().

> +	}
> +
> +	cpufreq_unregister_notifier(&thr->cpufreq.nb,
> +				    CPUFREQ_POLICY_NOTIFIER);

Is there a chance of deadlock here? This is a blocking unregistration
here, and we're holding the lock which a notifier call might be holding.
I think it's actually be OK to just do the unregistration outside the
lock?

Altogether, I think your unregistration needs to be something like:

 1) set the 'level' to a "none" value that can't be overwritten (e.g.,
 set_level() rejects it), under the threshold lock
 2) update cpufreq and devfreq, so the non-limits take hold
 3) release the threshold lock
 4) unregister the devfreq class and all notifiers, outside the
 threshold lock

Or maybe you come up with some other way that avoids all the above.

Brian

> +
> +	mutex_unlock(&thr->lock);
> +}
> +EXPORT_SYMBOL_GPL(throttler_teardown);
> diff --git a/include/linux/throttler.h b/include/linux/throttler.h
> new file mode 100644
> index 000000000000..a29d99f581da
> --- /dev/null
> +++ b/include/linux/throttler.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_THROTTLER_H__
> +#define __LINUX_THROTTLER_H__
> +
> +struct throttler;
> +
> +extern struct throttler *throttler_setup(struct device *dev);
> +extern void throttler_teardown(struct throttler *thr);
> +extern void throttler_set_level(struct throttler *thr, int level);
> +
> +#ifdef CONFIG_THROTTLER_DEBUG
> +#define thr_dbg(thr, fmt, ...) dev_info(thr->dev, fmt, ##__VA_ARGS__)
> +#else
> +#define thr_dbg(thr, fmt, ...) dev_dbg(thr->dev, fmt, ##__VA_ARGS__)
> +#endif
> +
> +#define thr_info(thr, fmt, ...) dev_info(thr->dev, fmt, ##__VA_ARGS__)
> +#define thr_warn(thr, fmt, ...) dev_warn(thr->dev, fmt, ##__VA_ARGS__)
> +#define thr_err(thr, fmt, ...) dev_warn(thr->dev, fmt, ##__VA_ARGS__)
> +
> +#endif /* __LINUX_THROTTLER_H__ */
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 
