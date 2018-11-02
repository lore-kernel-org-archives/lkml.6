Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB56DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2DC2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCJs7P4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2DC2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeKCDCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:02:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39717 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeKCDCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:02:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so1295111pgv.6;
        Fri, 02 Nov 2018 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QKCaitxlJqt4EIIz5SZqT1ZEOYe/Y7IwYQ2KEGiyEm4=;
        b=TCJs7P4lWvsJKscvIhMxKNwE8oyCalYWaCnpMNUa0KzA2VFOKleBnFyBX52jNZsnFz
         nWaSFqn85C2JWXAFDD4u6KHZQBU1uGGqpJKDZcmWkGObal5X4CrkAT48Sp0eklvKSjX8
         1XPA9D4Gi5Hio+vGWCXWn/uhFRVahu4h0rF5McobLUr0UH+Mfx0KZSeHfuG7ujBfA8Xo
         QAyAPaboAuipzkWEBQX4MzTtSkz4/Y777M/DcojlGxH9VJpKCjOWhS6LAjkVOiqL7Hsc
         7YhVdeNTqm3LTYj1wHPPda8EdqyPjgSVnF9PsURwwH2+YY0Lx/V+7B+xrLgoPVRJ7HQp
         xpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QKCaitxlJqt4EIIz5SZqT1ZEOYe/Y7IwYQ2KEGiyEm4=;
        b=O9OL1X55qF4j0gpXQSJS0EFQ6NV8UfE/CW1J/3ekYiE8VkoEayN5CK+Uah83yawXVi
         lwwbIkyDvDNhZjfB1LN9e0TBgrO3Nj/1y6znK8wn/HuIbxrxg+Cfzkh7cPBZ4Zdl6gDa
         HEnwlWU+0qhX6Kxq7giSPNMOAEK4FOSo6sIuOhvM4GTTs2oKuEpjzQvcBJRM55FGJoFy
         G1SatcBTseUt2s7F9M03uMO0uUmYKVYCkhLFvbt5gTcx8Y1mfUM65lGYeyRkdk9FHd9b
         eZbh8YzbMDyCHBF2iwRPdsvGRSV3QVj0uFPebd0rErpgAVofjlKIvAiNzjbFK6a7I2EJ
         eBeA==
X-Gm-Message-State: AGRZ1gLV4btjh+S8X32TG3V+sY0C7w5hT0SKNbgcICYQKM1g8mZ0Bg6V
        Kat/2xuX8+XgAkvJlMdjIbY=
X-Google-Smtp-Source: AJdET5dtCO/QUU/Z/h6opybkEjbXWSoBoZiYA6cMwhEYmV23XCZWtuK0HpMdshp1MBQXF0PFlL/2pg==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr9071943pge.29.1541181278117;
        Fri, 02 Nov 2018 10:54:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b62-v6sm36616660pfa.159.2018.11.02.10.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 10:54:36 -0700 (PDT)
Date:   Fri, 2 Nov 2018 10:54:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] hwmon: (core) Add pm ops to hwmon class
Message-ID: <20181102175435.GA4749@roeck-us.net>
References: <20181025235122.3240-1-nicoleotsuka@gmail.com>
 <20181025235122.3240-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025235122.3240-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 04:51:18PM -0700, Nicolin Chen wrote:
> The hwmon core generates an extra child dev pointer for every
> registered hwmon driver so as to link the new device to hwmon
> class, and it exposes this new dev in /sys/class/hwmon/hwmon*/
> directory including a power directory for pm runtime. However,
> there is currently no way for hwmon drivers to link their own
> pm related information to this power directory, so it's always
> showing unsupported even if the driver implements the pm ops.
> 
> This is because pm_runtime core scans PM runtime callbacks in
> the dev->driver pointer while this new child dev doesn't have
> a driver pointer. It sounds easier to merely copy this driver
> pointer from the parent dev to the child dev, however, this'd
> create some problem like the same suspend() function might be
> called twice during system suspend cycle and the second call
> may fail since the device is already suspended, so the driver
> would have to work around to bypass one of the two callbacks.
> 
> Actually, pm_runtime core also scans a class-level pm pointer:
>          else if (dev->class && dev->class->pm)
>                   ops = dev->class->pm;
> 
> This means that hwmon class in the hwmon core could actually
> have its own generic pm callbacks so that a registered driver
> would have the capability to link their own callbacks to the
> hwmon core's.
> 
> So this patch adds a pm pointer to the hwmon class with some
> generic pm callbacks of system suspend/resume and pm_runtime
> suspend/resume, and also allows hwmon drivers to pass valid
> pm pointers through _with_info API when registering devices.
> 

Just to give an update: I am not happy with having to add hwmon
specific pm callbacks. That doesn't look right to me. I'll have
to spend time figuring out how other virtual devices handle this
situation. Unfortunately, time is always scarce, so this will likely
take a while.

Also, please note that I won't accept function macros. I understand
that are used a lot, especially in older hwmon drivers, but they just
make the code more difficult to read and often add unnecessary code.

Thanks,
Guenter

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog
> v3->v4:
>  * Dropped the risky pointer copies
>  * Added generic pm runtime callbacks to the hwmon class
> v2->v3:
>  * N/A
> v1->v2:
>  * Added device pointers
> 
>  drivers/hwmon/hwmon.c | 24 ++++++++++++++++++++++++
>  include/linux/hwmon.h |  2 ++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 975c95169884..10bbd36be4a5 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -20,6 +20,7 @@
>  #include <linux/idr.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/thermal.h>
> @@ -103,11 +104,34 @@ static void hwmon_dev_release(struct device *dev)
>  	kfree(to_hwmon_device(dev));
>  }
>  
> +#define HWMON_PM_FUNCTION(name)					\
> +static int __maybe_unused hwmon_##name(struct device *dev)	\
> +{								\
> +	struct hwmon_device *hwdev = to_hwmon_device(dev);	\
> +	const struct hwmon_chip_info *chip = hwdev->chip;	\
> +								\
> +	if (chip && chip->pm && chip->pm->name)			\
> +		return chip->pm->name(dev);			\
> +								\
> +	return 0;						\
> +}
> +
> +HWMON_PM_FUNCTION(suspend)
> +HWMON_PM_FUNCTION(resume)
> +HWMON_PM_FUNCTION(runtime_suspend)
> +HWMON_PM_FUNCTION(runtime_resume)
> +
> +static const struct dev_pm_ops hwmon_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(hwmon_suspend, hwmon_resume)
> +	SET_RUNTIME_PM_OPS(hwmon_runtime_suspend, hwmon_runtime_resume, NULL)
> +};
> +
>  static struct class hwmon_class = {
>  	.name = "hwmon",
>  	.owner = THIS_MODULE,
>  	.dev_groups = hwmon_dev_attr_groups,
>  	.dev_release = hwmon_dev_release,
> +	.pm = &hwmon_pm,
>  };
>  
>  static DEFINE_IDA(hwmon_ida);
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 99e0c1b0b5fb..edbeddb489f8 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -369,10 +369,12 @@ struct hwmon_channel_info {
>   * Chip configuration
>   * @ops:	Pointer to hwmon operations.
>   * @info:	Null-terminated list of channel information.
> + * @pm:		Pointer to dev_pm_ops callbacks.
>   */
>  struct hwmon_chip_info {
>  	const struct hwmon_ops *ops;
>  	const struct hwmon_channel_info **info;
> +	const struct dev_pm_ops *pm;
>  };
>  
>  /* hwmon_device_register() is deprecated */
> -- 
> 2.17.1
> 
