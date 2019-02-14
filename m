Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC93C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DDC2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438154AbfBNS3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:29:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49132 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbfBNS3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:29:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7EE9EBD;
        Thu, 14 Feb 2019 10:29:17 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C497C3F557;
        Thu, 14 Feb 2019 10:29:15 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3] drivers: base: add support to skip power management in device/driver model
Date:   Thu, 14 Feb 2019 18:29:10 +0000
Message-Id: <20190214182910.20600-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All device objects in the driver model contain fields that control the
handling of various power management activities. However, it's not
always useful. There are few instances where pseudo devices are added
to the model just to take advantage of many other features like
kobjects, udev events, and so on. One such example is cpu devices and
their caches.

The sysfs for the cpu caches are managed by adding devices with cpu
as the parent in cpu_device_create() when secondary cpu is brought
online. Generally when the secondary CPUs are hotplugged back in as part
of resume from suspend-to-ram, we call cpu_device_create() from the cpu
hotplug state machine while the cpu device associated with that CPU is
not yet ready to be resumed as the device_resume() call happens bit
later. It's not really needed to set the flag is_prepared for cpu
devices as they are mostly pseudo device and hotplug framework deals
with state machine and not managed through the cpu device.

This often results in annoying warning when resuming:
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
 cache: parent cpu1 should not be sleeping
CPU1 is up
CPU2: Booted secondary processor
 cache: parent cpu2 should not be sleeping
CPU2 is up
.... and so on.

So in order to fix these kind of errors, we could just completely avoid
doing any power management related initialisations and operations if
they are not used by these devices.

Lets add no_pm_required flags to indicate that the device doesn't
require any sort of pm activities and all of them can be completely
skipped. We can use the same flag to also avoid adding not used *power*
sysfs entries for these devices. For now, lets use this for cpu cache
devices.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cpu.c         |  1 +
 drivers/base/power/main.c  |  7 +++++++
 drivers/base/power/sysfs.c |  6 ++++++
 include/linux/device.h     | 10 ++++++++++
 include/linux/pm.h         |  1 +
 5 files changed, 25 insertions(+)

v2->v3:
	- renamed no_pm_required to no_pm
	- fixed the wrong comment in device_pm_add
	- add missing check in dpm_sysfs_remove reported by Eugeniu
	- added Ulf's reviewed-by tag

v1->v2:
	- dropped setting the flag for cpu devices, for now just cpu caches
	  will make use of this new flag.

RFC->v1:
	- dropped the idea of adding cpu hotplug callback to deal just
	  with cpu devices, instead add a new flag in the device pm_info
	  structure

[RFC] : https://marc.info/?l=linux-pm&m=154842896407904&w=2
[v1] : https://marc.info/?l=linux-pm&m=154946578717730&w=2
[v2] : https://marc.info/?l=linux-pm&m=155005931507485&w=2

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index eb9443d5bae1..6ce93a52bf3f 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -427,6 +427,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
 	dev->parent = parent;
 	dev->groups = groups;
 	dev->release = device_create_release;
+	device_set_pm_not_required(dev);
 	dev_set_drvdata(dev, drvdata);

 	retval = kobject_set_name_vargs(&dev->kobj, fmt, args);
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 0992e67e862b..6a473004abe6 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -124,6 +124,10 @@ void device_pm_unlock(void)
  */
 void device_pm_add(struct device *dev)
 {
+	/* Skip pm setup/initialisation */
+	if (device_pm_not_required(dev))
+		return;
+
 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
 	device_pm_check_callbacks(dev);
@@ -142,6 +146,9 @@ void device_pm_add(struct device *dev)
  */
 void device_pm_remove(struct device *dev)
 {
+	if (device_pm_not_required(dev))
+		return;
+
 	pr_debug("PM: Removing info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
 	complete_all(&dev->power.completion);
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d713738ce796..5e8d4867c4da 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -648,6 +648,10 @@ int dpm_sysfs_add(struct device *dev)
 {
 	int rc;

+	/* No need to create pm sysfs if explicitly disabled */
+	if (device_pm_not_required(dev))
+		return 0;
+
 	rc = sysfs_create_group(&dev->kobj, &pm_attr_group);
 	if (rc)
 		return rc;
@@ -727,6 +731,8 @@ void rpm_sysfs_remove(struct device *dev)

 void dpm_sysfs_remove(struct device *dev)
 {
+	if (device_pm_not_required(dev))
+		return;
 	sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_group);
 	dev_pm_qos_constraints_destroy(dev);
 	rpm_sysfs_remove(dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..53028636fe39 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1165,6 +1165,16 @@ static inline bool device_async_suspend_enabled(struct device *dev)
 	return !!dev->power.async_suspend;
 }

+static inline bool device_pm_not_required(struct device *dev)
+{
+	return dev->power.no_pm;
+}
+
+static inline void device_set_pm_not_required(struct device *dev)
+{
+	dev->power.no_pm = true;
+}
+
 static inline void dev_pm_syscore_device(struct device *dev, bool val)
 {
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 0bd9de116826..8869ce7b5fa6 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -592,6 +592,7 @@ struct dev_pm_info {
 	bool			is_suspended:1;	/* Ditto */
 	bool			is_noirq_suspended:1;
 	bool			is_late_suspended:1;
+	bool			no_pm:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
 	u32			driver_flags;
--
2.17.1

