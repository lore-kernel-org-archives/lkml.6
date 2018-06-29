Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C33C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9B027FB3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9B027FB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965344AbeF2Ofv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:35:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:9673 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754928AbeF2Oeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:34:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 07:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="51490712"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2018 07:34:45 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 1/4] x86/split_lock: Enumerate #AC exception for split locked access feature
Date:   Fri, 29 Jun 2018 07:33:24 -0700
Message-Id: <1530282807-66555-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alignment Check (#AC) exception for split lock is supported on Tremont
and future processors. We need to enumerate the feature on processors.

Bit 29 in MSR TEST_CTL 0x33 can only be set on processors that support
the feature. On processors not supporting the feature, the bit is reserved
(i.e. cannot be set as one) or the MSR doesn't exist.

To detect the feature, attempt to set the bit in the MSR. If the writing
succeeds, the feature is available. Otherwise, the feature is not
supported on this platform.

test_ctl.c is created to contain majority of split lock code. Hopefully
more features related to MSR_TEST_CTL will be added to the file and
share some code with split lock in future.

More information on the bit 29 and MSR TEST_CTL can be found in the latest
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h         |  1 +
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  4 ++++
 arch/x86/kernel/cpu/Makefile       |  1 +
 arch/x86/kernel/cpu/test_ctl.c     | 46 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/setup.c            |  2 ++
 6 files changed, 55 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/test_ctl.c

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc86b062..bd64380d598b 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -40,4 +40,5 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+void detect_ac_split_lock(void);
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5701f5cecd31..c1bc06542e78 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -219,6 +219,7 @@
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
+#define X86_FEATURE_AC_SPLIT_LOCK	( 7*32+29) /* #AC exception for split locked access */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 68b2c3150de1..7b9496850370 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -39,6 +39,10 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTL					0x00000033
+#define MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT		29
+#define MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK		BIT(29)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 347137e80bf5..22a3fa26bfd4 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_MICROCODE)			+= microcode/
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
+obj-y					+= test_ctl.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
new file mode 100644
index 000000000000..af1822469c94
--- /dev/null
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Enable #AC exception for split locked accesses in TEST_CTL MSR
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author:
+ *	Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include <linux/printk.h>
+#include <linux/cpufeature.h>
+#include <asm/msr.h>
+
+/* Detect feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
+void detect_ac_split_lock(void)
+{
+	u64 val, orig_val;
+	int ret;
+
+	/* Attempt to read the MSR. If the MSR doesn't exist, reading fails. */
+	ret = rdmsrl_safe(MSR_TEST_CTL, &val);
+	if (ret)
+		return;
+
+	orig_val = val;
+
+	/* Turn on the split lock bit */
+	val |= MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+
+	/*
+	 * Attempt to set bit 29 in the MSR. The bit is set successfully
+	 * only on processors that support #AC for split lock.
+	 */
+	ret = wrmsrl_safe(MSR_TEST_CTL, val);
+	if (ret)
+		return;
+
+	/* The feature is supported on CPU. */
+	setup_force_cpu_cap(X86_FEATURE_AC_SPLIT_LOCK);
+
+	/*
+	 * Need to restore split lock setting to original firmware setting
+	 * before leaving.
+	 */
+	wrmsrl(MSR_TEST_CTL, orig_val);
+}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2f86d883dd95..18de4e35a4e5 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -953,6 +953,8 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	detect_ac_split_lock();
+
 	if (efi_enabled(EFI_BOOT))
 		efi_memblock_x86_reserve_range();
 #ifdef CONFIG_MEMORY_HOTPLUG
-- 
2.5.0

