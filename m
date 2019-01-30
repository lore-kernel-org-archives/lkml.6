Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839E0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442C121473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfA3Xt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:49:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49285 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA3Xt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:49:58 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 36cded6a8c53d7d1; Thu, 31 Jan 2019 00:49:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] drivers core: cpu: add hotplug callback to update cpu_dev state to resumed
Date:   Thu, 31 Jan 2019 00:48:49 +0100
Message-ID: <2397404.eE4apdlqQK@aspire.rjw.lan>
In-Reply-To: <20190125150906.27614-1-sudeep.holla@arm.com>
References: <20190125130701.GA855@vmlxhi-102.adit-jv.com> <20190125150906.27614-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 25, 2019 4:09:06 PM CET Sudeep Holla wrote:
> The sysfs for the cpu caches are managed by adding devices with cpu
> as the parent in cpu_device_create() when secondary cpu is brought
> onlin. Generally when the secondary CPUs are hotplugged back is as part
> of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> hotplug state machine while the cpu device associated with that CPU is
> not yet ready to be resumed as the device_resume() call happens bit later.
> It's not really needed to set the flag is_prepared for cpu devices are
> they are mostly pseudo device and hotplug framework deals with state
> machine and not managed through the cpu device.
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
> Just fix the warning by updating the device state quite early.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Reported-by: Jisheng Zhang <jszhang@marvell.com>
> Reported-by: Steve Longerbeam <slongerbeam@gmail.com>
> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/cpu.c         | 20 +++++++++++++++++++-
>  include/linux/cpuhotplug.h |  1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> Hi Rafael,
> 
> This is getting reported for quite some time. Let me know if you have
> better solution to fix this harmless yet annoying warnings during system
> resume.

I'd rather have a flag in struct dev_pm_info that will cause the message to
be suppressed if set.

It could be used for other purposes too then in princple (like skipping the
creation of empty "power" attr groups in sysfs for devices that don't
need them etc.).


> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index eb9443d5bae1..ae0403528bff 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -80,6 +80,8 @@ void unregister_cpu(struct cpu *cpu)
> 
>  	device_unregister(&cpu->dev);
>  	per_cpu(cpu_sys_devices, logical_cpu) = NULL;
> +
> +	cpuhp_remove_state_nocalls(CPUHP_CPUDEV_PM_PREPARE);
>  	return;
>  }
> 
> @@ -355,6 +357,20 @@ static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
>  }
>  #endif
> 
> +static int cpu_dev_pm_unset_is_prepared(unsigned int cpu)
> +{
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +
> +	/*
> +	 * device_resume sets this for cpu_dev bit later but the child
> +	 * devices are resumes in the cpu hotplug state machine much
> +	 * before device_resume is called.
> +	 */
> +	if (cpu_dev)
> +		cpu_dev->power.is_prepared = false;
> +
> +	return 0;
> +}
>  /*
>   * register_cpu - Setup a sysfs device for a CPU.
>   * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
> @@ -392,7 +408,9 @@ int register_cpu(struct cpu *cpu, int num)
>  	dev_pm_qos_expose_latency_limit(&cpu->dev,
>  					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> 
> -	return 0;
> +	return cpuhp_setup_state_nocalls(CPUHP_CPUDEV_PM_PREPARE,
> +					 "base/cpu/dev_pm:prepare",
> +					 cpu_dev_pm_unset_is_prepared, NULL);
>  }
> 
>  struct device *get_cpu_device(unsigned cpu)
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index fd586d0301e7..2ecb4c9370ce 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -69,6 +69,7 @@ enum cpuhp_state {
>  	CPUHP_SLAB_PREPARE,
>  	CPUHP_MD_RAID5_PREPARE,
>  	CPUHP_RCUTREE_PREP,
> +	CPUHP_CPUDEV_PM_PREPARE,
>  	CPUHP_CPUIDLE_COUPLED_PREPARE,
>  	CPUHP_POWERPC_PMAC_PREPARE,
>  	CPUHP_POWERPC_MMU_CTX_PREPARE,
> --
> 2.17.1
> 
> 


