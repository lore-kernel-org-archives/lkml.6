Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F09C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0C6218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfAYPJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:09:19 -0500
Received: from foss.arm.com ([217.140.101.70]:48734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfAYPJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:09:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E63DBA78;
        Fri, 25 Jan 2019 07:09:18 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 494403F5C1;
        Fri, 25 Jan 2019 07:09:17 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC PATCH] drivers core: cpu: add hotplug callback to update cpu_dev state to resumed
Date:   Fri, 25 Jan 2019 15:09:06 +0000
Message-Id: <20190125150906.27614-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125130701.GA855@vmlxhi-102.adit-jv.com>
References: <20190125130701.GA855@vmlxhi-102.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs for the cpu caches are managed by adding devices with cpu
as the parent in cpu_device_create() when secondary cpu is brought
onlin. Generally when the secondary CPUs are hotplugged back is as part
of resume from suspend-to-ram, we call cpu_device_create() from the cpu
hotplug state machine while the cpu device associated with that CPU is
not yet ready to be resumed as the device_resume() call happens bit later.
It's not really needed to set the flag is_prepared for cpu devices are
they are mostly pseudo device and hotplug framework deals with state
machine and not managed through the cpu device.

This often results in annoying warning when resuming:
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
 cache: parent cpu1 should not be sleeping
CPU1 is up
CPU2: Booted secondary processor
 cache: parent cpu2 should not be sleeping
CPU2 is up
.... and so on.

Just fix the warning by updating the device state quite early.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Reported-by: Jisheng Zhang <jszhang@marvell.com>
Reported-by: Steve Longerbeam <slongerbeam@gmail.com>
Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cpu.c         | 20 +++++++++++++++++++-
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

Hi Rafael,

This is getting reported for quite some time. Let me know if you have
better solution to fix this harmless yet annoying warnings during system
resume.

Regards,
Sudeep

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index eb9443d5bae1..ae0403528bff 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -80,6 +80,8 @@ void unregister_cpu(struct cpu *cpu)

 	device_unregister(&cpu->dev);
 	per_cpu(cpu_sys_devices, logical_cpu) = NULL;
+
+	cpuhp_remove_state_nocalls(CPUHP_CPUDEV_PM_PREPARE);
 	return;
 }

@@ -355,6 +357,20 @@ static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
 }
 #endif

+static int cpu_dev_pm_unset_is_prepared(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	/*
+	 * device_resume sets this for cpu_dev bit later but the child
+	 * devices are resumes in the cpu hotplug state machine much
+	 * before device_resume is called.
+	 */
+	if (cpu_dev)
+		cpu_dev->power.is_prepared = false;
+
+	return 0;
+}
 /*
  * register_cpu - Setup a sysfs device for a CPU.
  * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
@@ -392,7 +408,9 @@ int register_cpu(struct cpu *cpu, int num)
 	dev_pm_qos_expose_latency_limit(&cpu->dev,
 					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);

-	return 0;
+	return cpuhp_setup_state_nocalls(CPUHP_CPUDEV_PM_PREPARE,
+					 "base/cpu/dev_pm:prepare",
+					 cpu_dev_pm_unset_is_prepared, NULL);
 }

 struct device *get_cpu_device(unsigned cpu)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index fd586d0301e7..2ecb4c9370ce 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -69,6 +69,7 @@ enum cpuhp_state {
 	CPUHP_SLAB_PREPARE,
 	CPUHP_MD_RAID5_PREPARE,
 	CPUHP_RCUTREE_PREP,
+	CPUHP_CPUDEV_PM_PREPARE,
 	CPUHP_CPUIDLE_COUPLED_PREPARE,
 	CPUHP_POWERPC_PMAC_PREPARE,
 	CPUHP_POWERPC_MMU_CTX_PREPARE,
--
2.17.1

