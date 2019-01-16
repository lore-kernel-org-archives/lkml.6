Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A4DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795DE206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfAPVZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:25:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:32307 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbfAPVYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:24:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 13:24:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="117269588"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 13:24:34 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 2/3] x86/umwait: Setup umwait C0.2 state
Date:   Wed, 16 Jan 2019 13:18:37 -0800
Message-Id: <1547673522-226408-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UMWAIT or TPAUSE called by user process makes processor to reside in
a light-weight power/performance optimized state (C0.1 state) or an
improved power/performance optimized state (C0.2 state).

IA32_UMWAIT_CONTROL MSR register allows OS to set global maximum umwait
time and disable C0.2 on the processor.

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
 arch/x86/power/umwait.c          | 114 +++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 arch/x86/power/umwait.c

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 8e40c2446fd1..b56bfecae0de 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -59,6 +59,10 @@
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
index 37923d715741..62e2c609d1fe 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -8,3 +8,4 @@ CFLAGS_cpu.o	:= $(nostackp)
 
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
+obj-y				+= umwait.o
diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
new file mode 100644
index 000000000000..95b3867aac1e
--- /dev/null
+++ b/arch/x86/power/umwait.c
@@ -0,0 +1,114 @@
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
+	/* Add CPU global user wait interface to control umwait. */
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
2.19.1

