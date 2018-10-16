Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DFCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE85320881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE85320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeJPRgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:36:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33794 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeJPRgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:36:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so24908308wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 02:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qiaavaWBwbzt5PAbqq2mbzkmAV/UfBJmAUnBT7JtiYg=;
        b=ohPbcxnoBnFwxAYYsMKIb1dWuNZSkSGDE1UMN/j4e1LMwrwpfmo6mQByE+kkyVg/AL
         r4uUtCwUE8aTIY0wRPog/g8Cpl+DSQFFrwD5q550aJJQBKZ1K+VvWzi3jLDuXJTs+I4j
         uz7RlUtmWQmHTSiw6N6axU9ycuNAdF1ccc8+CD3QKhv22dieaKkKTVKQ+PZOdpO1mCYj
         yxmPoFFjDbhdIquAhpD3q0PbhGC5wCOl8p1iDP444iRA46WcYf3ZYc9+Gt6A6oZQ1U+U
         gyOLJvd9zS6KgYC//56RpR01Ghtww2LJgEuqo424hh3kA4Oz0FWdEtVgEv3pKlANuHo2
         uACQ==
X-Gm-Message-State: ABuFfojUj41OHEnbl4/vcoHLn2qnVay3LGworApSRpNxbeTMhx3mpj2j
        DTZOY30PvaZ7dg/2Lt9Er7pzHQ==
X-Google-Smtp-Source: ACcGV61cMGNrg38kJUyHe44fvCkE0ZiNAEZSeu5d46mZDgjYErYcu5QpMTt+QDnPYJLrwGOc4eXOJg==
X-Received: by 2002:a1c:4385:: with SMTP id q127-v6mr16226271wma.28.1539683227343;
        Tue, 16 Oct 2018 02:47:07 -0700 (PDT)
Received: from [192.168.1.13] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id b71-v6sm14256343wma.13.2018.10.16.02.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 02:47:06 -0700 (PDT)
Subject: Re: [PATCH 2/3] driver core: add deferring probe reason to
 devices_deferred property
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>
References: <20181016072244.1216-1-a.hajda@samsung.com>
 <CGME20181016072249eucas1p28855602564eb74a771fe521712962680@eucas1p2.samsung.com>
 <20181016072244.1216-3-a.hajda@samsung.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <ee6a3c34-e0f7-e7f8-b904-b738948f22bb@redhat.com>
Date:   Tue, 16 Oct 2018 11:47:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181016072244.1216-3-a.hajda@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 09:22 AM, Andrzej Hajda wrote:
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c | 15 +++++++++------
>  drivers/base/dd.c   | 34 +++++++++++++++++++++++++++++++++-
>  3 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..6f9371bfe40b 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -75,6 +75,7 @@ struct device_private {
>  	struct klist_node knode_driver;
>  	struct klist_node knode_bus;
>  	struct list_head deferred_probe;
> +	char *deferred_probe_msg;
>  	struct device *device;
>  };
>  #define to_device_private_parent(obj)	\
> @@ -113,6 +114,8 @@ extern void device_release_driver_internal(struct device *dev,
>  extern void driver_detach(struct device_driver *drv);
>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>  extern void driver_deferred_probe_del(struct device *dev);
> +extern void __deferred_probe_set_msg(const struct device *dev, const char *fmt,
> +				     va_list args);
>  static inline int driver_match_device(struct device_driver *drv,
>  				      struct device *dev)
>  {
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 23fabefb217a..df9895adf11b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3076,6 +3076,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>   *
>   * This helper implements common pattern present in probe functions for error
>   * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * In case of -EPROBE_DEFER it sets defer probe reason.
>   * It replaces code sequence:
>   * 	if (err != -EPROBE_DEFER)
>   * 		dev_err(dev, ...);
> @@ -3091,15 +3092,17 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>  	struct va_format vaf;
>  	va_list args;
>  
> -	if (err != -EPROBE_DEFER) {
> -		va_start(args, fmt);
> +	va_start(args, fmt);
>  
> -		vaf.fmt = fmt;
> -		vaf.va = &args;
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
>  
> +	if (err != -EPROBE_DEFER)
>  		__dev_printk(KERN_ERR, dev, &vaf);
> -		va_end(args);
> -	}
> +	else
> +		__deferred_probe_set_msg(dev, fmt, args);
> +
> +	va_end(args);
>  
>  	return err;
>  }
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..e2f81e538d4b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -27,6 +27,7 @@
>  #include <linux/async.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
> +#include <linux/slab.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -132,6 +133,8 @@ void driver_deferred_probe_del(struct device *dev)
>  	if (!list_empty(&dev->p->deferred_probe)) {
>  		dev_dbg(dev, "Removed from deferred list\n");
>  		list_del_init(&dev->p->deferred_probe);
> +		kfree(dev->p->deferred_probe_msg);
> +		dev->p->deferred_probe_msg = NULL;
>  	}
>  	mutex_unlock(&deferred_probe_mutex);
>  }
> @@ -202,6 +205,32 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +/*
> + * __deferred_probe_set_msg() - Set defer probe reason message for device
> + */
> +void __deferred_probe_set_msg(const struct device *dev, const char *fmt,
> +				     va_list args)
> +{
> +	const int size = 128;
> +	char **p;
> +	int n;
> +
> +	mutex_lock(&deferred_probe_mutex);
> +
> +	p = &dev->p->deferred_probe_msg;
> +	if (!*p) {
> +		*p = kmalloc(size, GFP_KERNEL);
> +		if (!*p)
> +			goto end;
> +	}
> +	n = snprintf(*p, size, "%s %s: ", dev_driver_string(dev), dev_name(dev));
> +	if (n < size)
> +		vsnprintf(*p + n, size - n, fmt, args);

I wonder if the vsnprintf() return value should be checked and print a warning
if the message was truncated. Probably 128 is enough for most error messages?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
 
Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
