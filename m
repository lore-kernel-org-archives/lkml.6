Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA1CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA212088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA212088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756853AbeFPDJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 23:09:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:51107 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756854AbeFPDIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 23:08:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 20:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="233011920"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2018 20:07:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 4/8] cpuidle: Set up maximum umwait time and umwait states
Date:   Fri, 15 Jun 2018 20:06:11 -0700
Message-Id: <1529118375-90191-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UMWAIT or TPAUSE called by user process makes processor to reside in
a light-weight power/performance optimized state (C0.1 state) or an
improved power/performance optimized state (C0.2 state).

IA32_UMAIT_CONTROL MSR register control allows OS to set maximum umwait
time and disable C0.2 on the processor.

The maximum time value in IA32_UMWAIT_CONTROL[31-2] is set as zero which
means there is no global time limit for UMWAIT and TPAUSE instructions.
Each process sets its own umwait maximum time as the instructions operand.
We don't set a non-zero global umwait maximum time value to enforce user
wait timeout because we couldn't find any usage for it.

By default C0.2 is enabled so user wait can save more power but wakeup
time is slower. In some cases e.g. real time, user wants to disable C0.2
so that user wait saves less power but wakeup time is faster.

A new "/sys/devices/system/cpu/cpuidle/umwait_disable_c0_2" file is
created to allow user to check if C0.2 is enabled or disabled and also
allow user to enable or disable C0.2. Value "1" in the file means C0.2 is
disabled. Value "0" means C0.2 is enabled.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/msr-index.h |   4 ++
 arch/x86/power/Makefile          |   1 +
 arch/x86/power/umwait.c          | 106 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
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
index 000000000000..fd7b18d9ed02
--- /dev/null
+++ b/arch/x86/power/umwait.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * umwait.c - control user wait
+ *
+ * Copyright (c) 2018, Intel Corporation.
+ * Fenghua Yu <fenghua.yu@intel.com>
+ */
+/*
+ * umwait.c adds control of user wait states that user enters through user wait
+ * instructions umwait or tpause.
+ */
+#include <linux/cpu.h>
+#include <asm/msr.h>
+
+static int umwait_disable_c0_2;
+static DEFINE_MUTEX(umwait_lock);
+
+static ssize_t umwait_disable_c0_2_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return sprintf(buf, "%d\n", umwait_disable_c0_2);
+}
+
+static ssize_t umwait_disable_c0_2_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	int disable_c0_2, cpu, ret;
+	u32 msr_val;
+
+	ret = kstrtou32(buf, 10, &disable_c0_2);
+	if (ret)
+		return ret;
+	if (disable_c0_2 != 1 && disable_c0_2 != 0)
+		return -EINVAL;
+
+	mutex_lock(&umwait_lock);
+	umwait_disable_c0_2 = disable_c0_2;
+	/*
+	 * No global umwait maximum time limit (0 in bits 31-0).
+	 * Enable or disable C0.2 based on global setting (bit 0) on all CPUs.
+	 */
+	msr_val = umwait_disable_c0_2 & UMWAIT_CONTROL_C02_MASK;
+	for_each_online_cpu(cpu)
+		wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
+	mutex_unlock(&umwait_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(umwait_disable_c0_2);
+
+static struct attribute *umwait_attrs[] = {
+	&dev_attr_umwait_disable_c0_2.attr,
+	NULL
+};
+
+static struct attribute_group umwait_attr_group = {
+	.attrs = umwait_attrs,
+	.name = "user_wait",
+};
+
+/* Keep the umwait control MSR on this CPU with the current global setting. */
+static int umwait_cpu_online(unsigned int cpu)
+{
+	u32 msr_val;
+
+	mutex_lock(&umwait_lock);
+	/*
+	 * No global umwait maximum time limit (0 in bits 31-0).
+	 * Enable or disable C0.2 based on global setting (bit 0) on this CPU.
+	 */
+	msr_val = umwait_disable_c0_2 & UMWAIT_CONTROL_C02_MASK;
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_disable_c0_2, 0);
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
+	/* Add CPU global user wait interface to control umwait C0.2. */
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

