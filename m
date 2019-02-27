Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB24C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED70621850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfB0QGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:06:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:24160 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbfB0QF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:05:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 08:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303011741"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 08:05:56 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [RFC PATCH v2 14/14] x86/watchdog: Add a shim hardlockup detector
Date:   Wed, 27 Feb 2019 08:05:18 -0800
Message-Id: <1551283518-18922-15-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic hardlockup detector is based on perf. It also provides a set
of weak stubs that CPU architectures can override. Add a shim hardlockup
detector for x86 that selects between perf and hpet implementations.

Specifically, this shim implementation is needed for the HPET-based
hardlockup detector; it can also be used for future implementations.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/Kconfig.debug         |  4 ++
 arch/x86/kernel/Makefile       |  1 +
 arch/x86/kernel/watchdog_hld.c | 78 ++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 arch/x86/kernel/watchdog_hld.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 3a2845a29e8a..5e5f4d2330af 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -169,10 +169,14 @@ config IOMMU_LEAK
 config HAVE_MMIOTRACE_SUPPORT
 	def_bool y
 
+config X86_HARDLOCKUP_DETECTOR
+	bool
+
 config X86_HARDLOCKUP_DETECTOR_HPET
 	bool "Use HPET Timer for Hard Lockup Detection"
 	select SOFTLOCKUP_DETECTOR
 	select HARDLOCKUP_DETECTOR
+	select X86_HARDLOCKUP_DETECTOR
 	depends on HPET_TIMER && HPET && X86_64
 	help
 	  Say y to enable a hardlockup detector that is driven by an High-
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 9d610e8a9224..5372453fe2a7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
+obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR) += watchdog_hld.o
 obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) += watchdog_hld_hpet.o
 obj-$(CONFIG_APB_TIMER)		+= apb_timer.o
 
diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..a2f6190dbce0
--- /dev/null
+++ b/arch/x86/kernel/watchdog_hld.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A shim hardlockup detector. It simply overrides the weak stubs of the
+ * generic implementation.
+ *
+ * Copyright (C) Intel Corporation 2019
+ */
+
+#include <linux/nmi.h>
+#include <asm/hpet.h>
+
+enum x86_hardlockup_detector {
+	X86_HARDLOCKUP_DETECTOR_PERF,
+	X86_HARDLOCKUP_DETECTOR_HPET,
+};
+
+static enum __read_mostly x86_hardlockup_detector detector_type;
+
+int watchdog_nmi_enable(unsigned int cpu)
+{
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_PERF) {
+		hardlockup_detector_perf_enable();
+		return 0;
+	}
+
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET) {
+		hardlockup_detector_hpet_enable();
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+void watchdog_nmi_disable(unsigned int cpu)
+{
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_PERF) {
+		hardlockup_detector_perf_disable();
+		return;
+	}
+
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET) {
+		hardlockup_detector_hpet_disable();
+		return;
+	}
+}
+
+int __init watchdog_nmi_probe(void)
+{
+	int ret;
+
+	/*
+	 * Try first with the HPET hardlockup detector. It will only
+	 * succeed if selected at build time and the nmi_watchdog
+	 * command-line parameter is configured. This ensure that the
+	 * perf-based detector is used by default, if selected at
+	 * build time.
+	 */
+	ret = hardlockup_detector_hpet_init();
+	if (!ret) {
+		detector_type = X86_HARDLOCKUP_DETECTOR_HPET;
+		return ret;
+	}
+
+	ret = hardlockup_detector_perf_init();
+	if (!ret) {
+		detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
+		return ret;
+	}
+
+	return ret;
+}
+
+void watchdog_nmi_stop(void)
+{
+	/* Only the HPET lockup detector defines a stop function. */
+	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
+		hardlockup_detector_hpet_enable();
+}
-- 
2.17.1

