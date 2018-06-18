Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5B2C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2784F20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P7IcfU3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2784F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937077AbeFRX7a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:59:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33084 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936965AbeFRX71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:59:27 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so9364250plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oyG7ox8gHf5Ad5jznLiLamw0GcMfVfYUr6zgxEdBJAs=;
        b=P7IcfU3x0wRsbn00ib7SDusEJuebkIFCvm2VnwyNVgRio5cug4pHVW6U5Yhj4ob6ye
         OIdf2ijO4BEAogdGgeXnHtdLaI9M5w8gGZQxDZJJV69k3J7zW+ANI2EebHQ5Xi+xSaAp
         K64tSZsLYx8xIDOcyOVRLVNKu4VvX5h8S5ZUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyG7ox8gHf5Ad5jznLiLamw0GcMfVfYUr6zgxEdBJAs=;
        b=lboPnN4o2nB5owNKQ2B6y6uUIPJrvDOUoIlzjpkuHXZl+U5/mzo4ElfzaURRE2op1+
         QEpwqufZ9DRMi6i8FskYKWv+Bw1Zb2d6lIgVnpql2oeLyxm7oUZVCC1T3UeJnL0bCMkr
         HK0Czk5fliaAVa7M/PxlosjgOoqnSM3QTRBE3yZSCMBVy3Ho3q2TUmN1qHAsmwgxhdFP
         1JKRURUO2RegqltJHuDfsJGpB3hvKgu2tweaGAVomuUWbBYqgchjidjbElp5FqACRDVs
         35KHDUJRZW+6fWl1VEshjNF/WgcF9P78PNX02g1lX/M2YSx9Dv2QYEW0/GlscB82T4s6
         roTA==
X-Gm-Message-State: APt69E1TKcaIr+z8j2UVjkGbe6DZRzaUoNJas303aImAuzPxT2K8BqEQ
        gOnA5MPpUO4TM4D2eXKfHBcUEA==
X-Google-Smtp-Source: ADUXVKLmFcyEWz8MLTxDehF/UXWwH05WvXArFvPAH3xCncNQwnjL3HjMfovzU6Rih79zzs79Sao/EQ==
X-Received: by 2002:a17:902:206:: with SMTP id 6-v6mr16276902plc.294.1529366367229;
        Mon, 18 Jun 2018 16:59:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s14-v6sm23269112pfh.116.2018.06.18.16.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 16:59:26 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:59:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
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
Message-ID: <20180618235925.GX88063@google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-11-mka@chromium.org>
 <20180618230324.GA154056@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180618230324.GA154056@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:03:25PM -0700, Brian Norris wrote:
> Hi Matthias,
> 
> On Thu, Jun 14, 2018 at 12:47:10PM -0700, Matthias Kaehlcke wrote:
> > The purpose of the throttler is to provide support for non-thermal
> > throttling. Throttling is triggered by external event, e.g. the
> > detection of a high battery discharge current, close to the OCP limit
> > of the battery. The throttler is only in charge of the throttling, not
> > the monitoring, which is done by another (possibly platform specific)
> > driver.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> I have a few more comments.

Thanks for the review and testing!

> > diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
> > new file mode 100644
> > index 000000000000..52350d846654
> > --- /dev/null
> > +++ b/drivers/misc/throttler/core.c
> > +static void thr_devfreq_init(struct device *dev, void *data)
> > +{
> > +	struct throttler *thr = data;
> > +	struct thr_freq_table ft;
> > +	struct devfreq_thrdev *dftd;
> > +	int err;
> > +
> > +	WARN_ON(!mutex_is_locked(&thr->lock));
> > +
> > +	err = thr_init_freq_table(thr, dev->parent, &ft);
> > +	if (err) {
> > +		if (err == -ENODEV)
> > +			return;
> > +
> > +		thr_err(thr, "failed to init frequency table of device %s: %d",
> > +			dev_name(dev), err);
> > +		return;
> > +	}
> > +
> > +	dftd = devm_kzalloc(thr->dev, sizeof(*dftd), GFP_KERNEL);
> > +	if (!dftd) {
> > +		thr_err(thr, "%s: out of memory\n", __func__);
> 
> I think it's considered bad form to roll your own OOM messages. It's
> assumed the memory manager will complain loudly enough for you already.

Ok, I'll remove the OOM logs.

> > +static void thr_cpufreq_update_policy(struct throttler *thr)
> > +{
> > +	struct cpufreq_thrdev *cftd;
> > +
> > +	WARN_ON(!mutex_is_locked(&thr->lock));
> > +
> > +	list_for_each_entry(cftd, &thr->cpufreq.list, node) {
> > +		struct cpufreq_policy *policy = cpufreq_cpu_get(cftd->cpu);
> > +
> > +		if (!policy) {
> > +			thr_warn(thr, "CPU%d does have no cpufreq policy!\n",
> 
> s/does have/has/

Ack

> > +void throttler_set_level(struct throttler *thr, int level)
> > +{
> > +	struct devfreq_thrdev *dftd;
> 
> This driver doesn't really handle negative levels very well (it might
> even read garbage memory?). You might either make the whole driver use
> unsigned values (and parse with an unsigned kstrtoX helper below), or
> else just reject negative values in this function.

Negative values for level make no sense in this driver, so using
unsigned values seems a reasonable solutions.

> > +
> > +	if (level == thr->level)
> 
> It seems like this should be inside the lock.

Can do, but I'm not sure it is strictly necessary. ->level is only
changed in calls originated by the throttler itself (this function and
throttler_teardown()), it would require a really bad 'monitor' driver
to have an actual race.

Mainly I wanted to avoid the seemingly unnecessary mutex_unlock() in
the return path ;-)

> > +static ssize_t thr_level_read(struct file *file, char __user *user_buf,
> > +			      size_t count, loff_t *ppos)
> > +{
> > +	struct throttler *thr = file->f_inode->i_private;
> > +	char buf[5];
> > +	int len;
> > +
> > +	len = scnprintf(buf, sizeof(buf), "%d\n", thr->level);
> 
> Hold the throttler mutex around this read?

Not necessary IMO. Reading the integer value is an atomic operation,
holding the mutex doesn't really change the fact that the value could
change right after userspace read it.

> > +struct throttler *throttler_setup(struct device *dev)
> > +{
> > +	struct throttler *thr;
> > +	struct device_node *np = dev->of_node;
> > +	struct class_interface *ci;
> > +	int cpu;
> > +	int err;
> > +
> > +	if (!np)
> > +		/* should never happen */
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	thr = devm_kzalloc(dev, sizeof(*thr), GFP_KERNEL);
> > +	if (!thr)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	mutex_init(&thr->lock);
> > +	thr->dev = dev;
> > +
> > +	cpumask_clear(&thr->cpufreq.cm_ignore);
> > +	cpumask_clear(&thr->cpufreq.cm_initialized);
> > +
> > +	INIT_LIST_HEAD(&thr->cpufreq.list);
> > +	INIT_LIST_HEAD(&thr->devfreq.list);
> > +
> > +	thr->cpufreq.nb.notifier_call = thr_handle_cpufreq_event;
> > +	err = cpufreq_register_notifier(&thr->cpufreq.nb,
> > +					CPUFREQ_POLICY_NOTIFIER);
> > +	if (err < 0) {
> > +		thr_err(thr, "failed to register cpufreq notifier\n");
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +	/*
> > +	 * The CPU throttling configuration is parsed at runtime, when the
> > +	 * cpufreq policy notifier is called for a CPU that hasn't been
> > +	 * initialized yet.
> > +	 *
> > +	 * This is done for two reasons:
> > +	 * -  when the throttler is probed the CPU might not yet have a policy
> > +	 * -  CPUs that were offline at probe time might be hotplugged
> > +	 *
> > +	 * The notifier is called then the policy is added/set
> > +	 */
> > +	for_each_online_cpu(cpu) {
> > +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > +
> > +		if (!policy)
> > +			continue;
> > +
> > +		cpufreq_update_policy(cpu);
> > +		cpufreq_cpu_put(policy);
> > +	}
> > +
> > +	/*
> > +	 * devfreq devices can be added and removed at runtime, hence they
> > +	 * must also be handled dynamically. The class_interface notifies us
> > +	 * whenever a device is added or removed. When the interface is
> > +	 * registered ci->add_dev() is called for all existing devfreq
> > +	 * devices.
> > +	 */
> > +	ci = &thr->devfreq.class_iface;
> > +	ci->class = devfreq_class;
> > +	ci->add_dev = thr_handle_devfreq_added;
> > +	ci->remove_dev = thr_handle_devfreq_removed;
> > +
> > +	err = class_interface_register(ci);
> > +	if (err) {
> > +		thr_err(thr, "failed to register devfreq class interface: %d\n",
> > +			err);
> > +		cpufreq_unregister_notifier(&thr->cpufreq.nb,
> > +					    CPUFREQ_POLICY_NOTIFIER);
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +#ifdef CONFIG_THROTTLER_DEBUG
> > +	thr->debugfs.dir = debugfs_create_dir(dev_name(thr->dev), NULL);
> 
> Remove this dir in throttler_teardown()?

Oops, I thought I did that already ...

> > +void throttler_teardown(struct throttler *thr)
> > +{
> > +	struct devfreq_thrdev *dftd;
> > +	int level;
> > +
> > +	mutex_lock(&thr->lock);
> > +
> > +	level = thr->level;
> > +	thr->level = 0;
> > +
> > +	class_interface_unregister(&thr->devfreq.class_iface);
> 
> This can deadlock. You're holding the throttler mutex and then this
> grabs the class mutex; but add/remove notifications will be holding the
> class mutex while making calls that grab the throttler mutex. IOW, you
> have ABBA (not the band).
> 
> Also, if there are any active devfreq devices attached...you definitely
> deadlock (simple AA), since we directly call ->remove_dev() on them
> here. See this locked-up task:
> 
> [ 4440.118203] [<ffffffc0002158a0>] __switch_to+0x90/0x9c
> [ 4440.118221] [<ffffffc000954f40>] __schedule+0x3cc/0x860
> [ 4440.118232] [<ffffffc000954b14>] schedule+0x4c/0xac
> [ 4440.118243] [<ffffffc0009553f8>] schedule_preempt_disabled+0x24/0x40
> [ 4440.118255] [<ffffffc000956ac8>] __mutex_lock_common+0x194/0x3b0
> [ 4440.118267] [<ffffffc000956348>] __mutex_lock_slowpath+0x38/0x44
> [ 4440.118278] [<ffffffc00095630c>] mutex_lock+0x6c/0x70
> [ 4440.118293] [<ffffffc00062c444>] thr_handle_devfreq_removed+0x2c/0xa0
> [ 4440.118307] [<ffffffc000606dbc>] class_interface_unregister+0x74/0xc4
> [ 4440.118318] [<ffffffc00062c4ec>] throttler_teardown+0x34/0xac
> [ 4440.118328] [<ffffffc00062cb60>] cros_ec_throttler_remove+0x30/0x40
> [ 4440.118341] [<ffffffc000607a60>] platform_drv_remove+0x28/0x50
> [ 4440.118355] [<ffffffc000605974>] device_release_driver_internal+0x120/0x1b0
> [ 4440.118367] [<ffffffc000605a28>] device_release_driver+0x24/0x30
> [ 4440.118380] [<ffffffc000604b50>] unbind_store+0x6c/0xa4
> [ 4440.118392] [<ffffffc000604a4c>] drv_attr_store+0x3c/0x54
> [ 4440.118409] [<ffffffc0003bd4e0>] sysfs_kf_write+0x50/0x68
> [ 4440.118424] [<ffffffc00044233c>] kernfs_fop_write+0xdc/0x188
> [ 4440.118436] [<ffffffc00042762c>] __vfs_write+0xfc/0x10c
> [ 4440.118446] [<ffffffc000427950>] SyS_write+0xf0/0x278
> [ 4440.118460] [<ffffffc000203e44>] el0_svc_naked+0x34/0x38
> 
> I got there with this:
> 
>   echo cros-ec-throttler.1.auto > /sys/bus/platform/drivers/cros-ec-throttler/unbind

Thanks for testing and providing detailed information, I'll revisit
the locking.

> > +	if (level) {
> > +		/* unthrottle CPUs */
> > +		if (!list_empty(&thr->cpufreq.list))
> 
> You don't technically need the list_empty() check, since you do
> list_for_each_entry() within thr_cpufreq_update_policy().

True, but it also does no/very little harm and the
list_for_each_entry() is hidden in thr_cpufreq_update_policy(). I
think the small overhead of the extra check in a function that is
executed at most once per throttler is justified by the improved
readability (no need to confirm that thr_cpufreq_update_policy() does
nothing if cpufreq is not involved in throttling_

> > +		/* unthrottle devfreq devices */
> > +		list_for_each_entry(dftd, &thr->devfreq.list, node) {
> > +			mutex_lock(&dftd->devfreq->lock);
> > +			update_devfreq(dftd->devfreq);
> > +			mutex_unlock(&dftd->devfreq->lock);
> > +		}
> 
> I wonder if the 'update' step deserves its own function, since the
> cpufreq/devfreq updates are repeated in throttler_set_level().

Sounds good.

> > +	}
> > +
> > +	cpufreq_unregister_notifier(&thr->cpufreq.nb,
> > +				    CPUFREQ_POLICY_NOTIFIER);
> 
> Is there a chance of deadlock here? This is a blocking unregistration
> here, and we're holding the lock which a notifier call might be holding.
> I think it's actually be OK to just do the unregistration outside the
> lock?
> 
> Altogether, I think your unregistration needs to be something like:
> 
>  1) set the 'level' to a "none" value that can't be overwritten (e.g.,
>  set_level() rejects it), under the threshold lock
>  2) update cpufreq and devfreq, so the non-limits take hold
>  3) release the threshold lock
>  4) unregister the devfreq class and all notifiers, outside the
>  threshold lock
> 
> Or maybe you come up with some other way that avoids all the above.

Thanks for your analysis and suggestions. I'll revisit the various
locking scenarios.
