Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CE5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A216B20821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfBFPlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:41:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54696 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfBFPle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:41:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1125A80D;
        Wed,  6 Feb 2019 07:41:34 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67A1C3F675;
        Wed,  6 Feb 2019 07:41:32 -0800 (PST)
Date:   Wed, 6 Feb 2019 15:41:25 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
Message-ID: <20190206154125.GA27663@e107155-lin>
References: <20190206150935.12140-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206150935.12140-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(completely forgot to add people who reported original issue, cc-ing now)

On Wed, Feb 06, 2019 at 03:09:35PM +0000, Sudeep Holla wrote:
> All device objects in the driver model contain fields that control the
> handling of various power management activities. However, it's not
> always useful. There are few instances where pseudo devices are added
> to the model just to take advantage of many other features like
> kobjects, udev events, and so on. One such example is cpu devices and
> their caches.
> 
> The sysfs for the cpu caches are managed by adding devices with cpu
> as the parent in cpu_device_create() when secondary cpu is brought
> online. Generally when the secondary CPUs are hotplugged back in as part
> of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> hotplug state machine while the cpu device associated with that CPU is
> not yet ready to be resumed as the device_resume() call happens bit
> later. It's not really needed to set the flag is_prepared for cpu
> devices as they are mostly pseudo device and hotplug framework deals
> with state machine and not managed through the cpu device.
> 
> This often results in annoying warning when resuming:
> Enabling non-boot CPUs ...
> CPU1: Booted secondary processor
>  cache: parent cpu1 should not be sleeping
> CPU1 is up
> CPU2: Booted secondary processor
>  cache: parent cpu2 should not be sleeping
> CPU2 is up
> .... and so on.
> 
> So in order to fix these kind of errors, we could just completely avoid
> doing any power management related initialisations and operations if
> they are not used by these devices.
> 
> Lets add no_pm_required flags to indicate that the device doesn't
> require any sort of pm activities and all of them can be completely
> skipped. We can use the same flag to also avoid adding not used *power*
> sysfs entries for these devices.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/cpu.c         |  2 ++
>  drivers/base/power/main.c  |  7 +++++++
>  drivers/base/power/sysfs.c |  4 ++++
>  include/linux/device.h     | 10 ++++++++++
>  include/linux/pm.h         |  1 +
>  5 files changed, 24 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index eb9443d5bae1..ccec353aa24c 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -379,6 +379,7 @@ int register_cpu(struct cpu *cpu, int num)
>  	cpu->dev.bus->uevent = cpu_uevent;
>  #endif
>  	cpu->dev.groups = common_cpu_attr_groups;
> +	device_set_pm_not_required(&cpu->dev);
>  	if (cpu->hotpluggable)
>  		cpu->dev.groups = hotplugable_cpu_attr_groups;
>  	error = device_register(&cpu->dev);
> @@ -427,6 +428,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
>  	dev->parent = parent;
>  	dev->groups = groups;
>  	dev->release = device_create_release;
> +	device_set_pm_not_required(dev);
>  	dev_set_drvdata(dev, drvdata);
>  
>  	retval = kobject_set_name_vargs(&dev->kobj, fmt, args);
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 0992e67e862b..2a29c3d4e240 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -124,6 +124,10 @@ void device_pm_unlock(void)
>   */
>  void device_pm_add(struct device *dev)
>  {
> +	/* No need to create pm sysfs if explicitly specified as not required */
> +	if (device_pm_not_required(dev))
> +		return;
> +
>  	pr_debug("PM: Adding info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>  	device_pm_check_callbacks(dev);
> @@ -142,6 +146,9 @@ void device_pm_add(struct device *dev)
>   */
>  void device_pm_remove(struct device *dev)
>  {
> +	if (device_pm_not_required(dev))
> +		return;
> +
>  	pr_debug("PM: Removing info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>  	complete_all(&dev->power.completion);
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index d713738ce796..6cd159b51114 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -648,6 +648,10 @@ int dpm_sysfs_add(struct device *dev)
>  {
>  	int rc;
>  
> +	/* No need to create pm sysfs if explicitly disabled */
> +	if (device_pm_not_required(dev))
> +		return 0;
> +
>  	rc = sysfs_create_group(&dev->kobj, &pm_attr_group);
>  	if (rc)
>  		return rc;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6cb4640b6160..739d0b62e4d4 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1165,6 +1165,16 @@ static inline bool device_async_suspend_enabled(struct device *dev)
>  	return !!dev->power.async_suspend;
>  }
>  
> +static inline bool device_pm_not_required(struct device *dev)
> +{
> +	return dev->power.no_pm_required;
> +}
> +
> +static inline void device_set_pm_not_required(struct device *dev)
> +{
> +	dev->power.no_pm_required = true;
> +}
> +
>  static inline void dev_pm_syscore_device(struct device *dev, bool val)
>  {
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 0bd9de116826..300ab9f0b858 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -592,6 +592,7 @@ struct dev_pm_info {
>  	bool			is_suspended:1;	/* Ditto */
>  	bool			is_noirq_suspended:1;
>  	bool			is_late_suspended:1;
> +	bool			no_pm_required:1;
>  	bool			early_init:1;	/* Owned by the PM core */
>  	bool			direct_complete:1;	/* Owned by the PM core */
>  	u32			driver_flags;
> -- 
> 2.17.1
> 
