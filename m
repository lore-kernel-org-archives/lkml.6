Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA9220779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA9220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeGWP3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:29:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:43703 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388419AbeGWP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:29:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 07:27:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="242560354"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2018 07:27:36 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 4/7] x86/umwait_contro: Set global umwait maximum time limit and umwait C0.2 state
Date:   Mon, 23 Jul 2018 05:55:54 -0700
Message-Id: <1532350557-98388-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UMWAIT or TPAUSE called by user process makes processor to reside in
a light-weight power/performance optimized state (C0.1 state) or an
improved power/performance optimized state (C0.2 state).

IA32_UMWAIT_CONTROL MSR register allows OS to set global maximum umwait
time and disable C0.2 on the processor.

The maximum time value in IA32_UMWAIT_CONTROL[31-2] is set as zero which
means there is no global time limit for UMWAIT and TPAUSE instructions.
Each process sets its own umwait maximum time as the instructions operand.
We don't set a non-zero global umwait maximum time value to enforce user
wait timeout because we couldn't find any usage for it.

By default C0.2 is enabled so user wait instructions can enter the state
if user wants to save more power but wakeup time is slower. In some cases
e.g. real time, user wants to disable C0.2 and all C0.2 requests revert
to C0.1.

A new "/sys/devices/system/cpu/umwait_control/umwait_enable_c0_2" file is
created to allow user to check if C0.2 is enabled or disabled and also
allow user to enable or disable C0.2. Value "0" in the file means C0.2 is
disabled. Value "1" means C0.2 is enabled.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/msr-index.h |   4 ++
 arch/x86/power/Makefile          |   1 +
 arch/x86/power/umwait.c          | 116 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 arch/x86/power/umwait.c

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 68b2c3150de1..92ef30f0f62d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -58,6 +58,10 @@
 #define MSR_PLATFORM_INFO_CPUID_FAULT_BIT	31
 #define MSR_PLATFORM_INFO_CPUID_FAULT		BIT_ULL(MSR_PLATFORM_INFO_CPUID_FAULT_BIT)
 
+#define MSR_IA32_UMWAIT_CONTROL		0xe1
+#define UMWAIT_CONTROL_C02_BIT		0x0
+#define UMWAIT_CONTROL_C02_MASK		0x00000001
+
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index a4701389562c..d3dfa8a47983 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -8,3 +8,4 @@ CFLAGS_cpu.o	:= $(nostackp)
 
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o
+obj-y				+= umwait.o
diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
new file mode 100644
index 000000000000..7fb645c65f22
--- /dev/null
+++ b/arch/x86/power/umwait.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sysfs interface for umwait control
+ *
+ * Copyright (C) 2018, Intel Corporation.
+ *
+ * Author: Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include <linux/cpu.h>
+#include <asm/msr.h>
+
+static int umwait_enable_c0_2 = 1; /* 0: disable C0.2. 1: enable C0.2. */
+static DEFINE_MUTEX(umwait_lock);
+
+/* Return value that will be used to set umwait control MSR */
+static inline u32 umwait_control_val(void)
+{
+	/*
+	 * We do not set global umwait maximum time limit. So bits 31-2 are 0.
+	 *
+	 * Enable or disable C0.2 (bit 0) based on global setting on all CPUs.
+	 * When bit 0 is 1, C0.2 is disabled. Otherwise, C0.2 is enabled.
+	 * So value in bit 0 is opposite of umwait_enable_c0_2.
+	 */
+	return ~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK;
+}
+
+static ssize_t umwait_enable_c0_2_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	return sprintf(buf, "%d\n", umwait_enable_c0_2);
+}
+
+static ssize_t umwait_enable_c0_2_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	int enable_c0_2, cpu, ret;
+	u32 msr_val;
+
+	ret = kstrtou32(buf, 10, &enable_c0_2);
+	if (ret)
+		return ret;
+
+	if (enable_c0_2 != 1 && enable_c0_2 != 0)
+		return -EINVAL;
+
+	mutex_lock(&umwait_lock);
+
+	umwait_enable_c0_2 = enable_c0_2;
+	msr_val = umwait_control_val();
+	get_online_cpus();
+	/* All CPUs have same umwait control setting */
+	for_each_online_cpu(cpu)
+		wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
+	put_online_cpus();
+
+	mutex_unlock(&umwait_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(umwait_enable_c0_2);
+
+static struct attribute *umwait_attrs[] = {
+	&dev_attr_umwait_enable_c0_2.attr,
+	NULL
+};
+
+static struct attribute_group umwait_attr_group = {
+	.attrs = umwait_attrs,
+	.name = "umwait_control",
+};
+
+/* Set up umwait control MSR on this CPU using the current global setting. */
+static int umwait_cpu_online(unsigned int cpu)
+{
+	u32 msr_val;
+
+	mutex_lock(&umwait_lock);
+
+	msr_val = umwait_control_val();
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
+
+	mutex_unlock(&umwait_lock);
+
+	return 0;
+}
+
+static int __init umwait_init(void)
+{
+	struct device *dev;
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
+		return -ENODEV;
+
+	/* Add CPU global user wait interface to control umwait C0.2 state. */
+	dev = cpu_subsys.dev_root;
+	ret = sysfs_create_group(&dev->kobj, &umwait_attr_group);
+	if (ret)
+		return ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait/intel:online",
+				umwait_cpu_online, NULL);
+	if (ret < 0)
+		goto out_group;
+
+	return 0;
+out_group:
+	sysfs_remove_group(&dev->kobj, &umwait_attr_group);
+
+	return ret;
+}
+device_initcall(umwait_init);
-- 
2.5.0

