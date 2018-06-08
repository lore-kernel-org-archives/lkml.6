Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cR0nDO66GlsrWwAAmS7hNA
	; Fri, 08 Jun 2018 17:20:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E664D607DC; Fri,  8 Jun 2018 17:20:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3F5D9601D2;
	Fri,  8 Jun 2018 17:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F5D9601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeFHRUx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:20:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:12634 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932130AbeFHRUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:20:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 10:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="231035296"
Received: from nzou1-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.254.60])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2018 10:20:42 -0700
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), intel-sgx-kernel-dev@lists.01.org (open list:INTEL SGX)
Subject: [PATCH v11 07/13] x86, sgx: detect Intel SGX
Date: Fri,  8 Jun 2018 19:09:42 +0200
Message-Id: <20180608171216.26521-8-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Intel(R) SGX is a set of CPU instructions that can be used by applications
to set aside private regions of code and data. The code outside the enclave
is disallowed to access the memory inside the enclave by the CPU access
control.

This commit adds the check for SGX to arch/x86 and a new config option,
INTEL_SGX_CORE. Exposes a boolean variable 'sgx_enabled' to query whether
or not the SGX support is available.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/Kconfig                | 19 ++++++++++++
 arch/x86/include/asm/sgx.h      | 25 ++++++++++++++++
 arch/x86/include/asm/sgx_pr.h   | 20 +++++++++++++
 arch/x86/kernel/cpu/Makefile    |  1 +
 arch/x86/kernel/cpu/intel_sgx.c | 53 +++++++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+)
 create mode 100644 arch/x86/include/asm/sgx.h
 create mode 100644 arch/x86/include/asm/sgx_pr.h
 create mode 100644 arch/x86/kernel/cpu/intel_sgx.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492b871a..42015d5366ef 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1925,6 +1925,25 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config INTEL_SGX_CORE
+	prompt "Intel SGX core functionality"
+	def_bool n
+	depends on X86_64 && CPU_SUP_INTEL
+	help
+	Intel Software Guard eXtensions (SGX) is a set of CPU instructions
+	that allows ring 3 applications to create enclaves; private regions
+	of memory that are protected, by hardware, from unauthorized access
+	and/or modification.
+
+	This option enables kernel recognition of SGX, high-level management
+	of the Enclave Page Cache (EPC), tracking and writing of SGX Launch
+	Enclave Hash MSRs, and allows for virtualization of SGX via KVM. By
+	iteslf, this option does not provide SGX support to userspace.
+
+	For details, see Documentation/x86/intel_sgx.rst
+
+	If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
new file mode 100644
index 000000000000..fa3e6e0eb8af
--- /dev/null
+++ b/arch/x86/include/asm/sgx.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-18 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+// Suresh Siddha <suresh.b.siddha@intel.com>
+// Sean Christopherson <sean.j.christopherson@intel.com>
+
+#ifndef _ASM_X86_SGX_H
+#define _ASM_X86_SGX_H
+
+#include <linux/types.h>
+
+#define SGX_CPUID 0x12
+
+enum sgx_cpuid {
+	SGX_CPUID_CAPABILITIES	= 0,
+	SGX_CPUID_ATTRIBUTES	= 1,
+	SGX_CPUID_EPC_BANKS	= 2,
+};
+
+extern bool sgx_enabled;
+
+#endif /* _ASM_X86_SGX_H */
diff --git a/arch/x86/include/asm/sgx_pr.h b/arch/x86/include/asm/sgx_pr.h
new file mode 100644
index 000000000000..876dc44c2ccc
--- /dev/null
+++ b/arch/x86/include/asm/sgx_pr.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+// Suresh Siddha <suresh.b.siddha@intel.com>
+// Serge Ayoun <serge.ayoun@intel.com>
+// Shay Katz-zamir <shay.katz-zamir@intel.com>
+
+#ifndef _ASM_X86_SGX_PR_H
+#define _ASM_X86_SGX_PR_H
+
+#include <linux/printk.h>
+#include <linux/ratelimit.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "intel_sgx: " fmt
+
+#endif /* _ASM_X86_SGX_PR_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index a66229f51b12..9552ff5b4ec3 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 
 obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o intel_rdt_ctrlmondata.o
+obj-$(CONFIG_INTEL_SGX_CORE)		+= intel_sgx.o
 
 obj-$(CONFIG_X86_MCE)			+= mcheck/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/intel_sgx.c b/arch/x86/kernel/cpu/intel_sgx.c
new file mode 100644
index 000000000000..db6b315334f4
--- /dev/null
+++ b/arch/x86/kernel/cpu/intel_sgx.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+// Suresh Siddha <suresh.b.siddha@intel.com>
+// Serge Ayoun <serge.ayoun@intel.com>
+// Shay Katz-zamir <shay.katz-zamir@intel.com>
+// Sean Christopherson <sean.j.christopherson@intel.com>
+
+#include <asm/sgx.h>
+#include <asm/sgx_pr.h>
+#include <linux/freezer.h>
+#include <linux/highmem.h>
+#include <linux/kthread.h>
+#include <linux/ratelimit.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+
+bool sgx_enabled __ro_after_init = false;
+EXPORT_SYMBOL(sgx_enabled);
+
+static __init bool sgx_is_enabled(void)
+{
+	unsigned long fc;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return false;
+
+	if (!boot_cpu_has(X86_FEATURE_SGX))
+		return false;
+
+	if (!boot_cpu_has(X86_FEATURE_SGX1))
+		return false;
+
+	rdmsrl(MSR_IA32_FEATURE_CONTROL, fc);
+	if (!(fc & FEATURE_CONTROL_LOCKED))
+		return false;
+
+	if (!(fc & FEATURE_CONTROL_SGX_ENABLE))
+		return false;
+
+	return true;
+}
+
+static __init int sgx_init(void)
+{
+	sgx_enabled = sgx_is_enabled();
+	return 0;
+}
+
+arch_initcall(sgx_init);
-- 
2.17.0
