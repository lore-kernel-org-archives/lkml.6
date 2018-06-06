Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C99660555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932949AbeFFQYO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:24:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:61010 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753059AbeFFQXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:23:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="62323482"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/8] x86/segments/32: Introduce CPU_NUMBER segment
Date: Wed,  6 Jun 2018 09:23:18 -0700
Message-Id: <1528302199-29619-8-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new entry will be equivalent to that of x86-64 which
stores CPU number. The entry is placed in segment 23 in GDT
by bumping down 23-28 by one, which are all kernel-internal
segments and so have no impact on user space.

CPU_NUMBER segment will always be at '%ss (USER_DS) + 80'
for the default (flat, initial) user space %ss. %ss is
specified than %ds because it is less likely to be changed
as 64-bit has %ss defined.

Suggested-by: H. Peter <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/segment.h | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 492e3d1..fca55d7 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -77,14 +77,14 @@
  *  20 - PNPBIOS support						<=== cacheline #6
  *  21 - PNPBIOS support
  *  22 - PNPBIOS support
- *  23 - APM BIOS support
+ *  23 - CPU number
  *  24 - APM BIOS support						<=== cacheline #7
  *  25 - APM BIOS support
  *
- *  26 - ESPFIX small SS
- *  27 - per-cpu			[ offset to per-cpu data area ]
- *  28 - stack_canary-20		[ for stack protector ]		<=== cacheline #8
- *  29 - unused
+ *  26 - APM BIOS support
+ *  27 - ESPFIX small SS
+ *  28 - per-cpu			[ offset to per-cpu data area ] <=== cacheline #8
+ *  29 - stack_canary-20		[ for stack protector ]
  *  30 - unused
  *  31 - TSS for double fault handler
  */
@@ -102,11 +102,12 @@
 #define GDT_ENTRY_PNPBIOS_DS		20
 #define GDT_ENTRY_PNPBIOS_TS1		21
 #define GDT_ENTRY_PNPBIOS_TS2		22
-#define GDT_ENTRY_APMBIOS_BASE		23
+#define GDT_ENTRY_CPU_NUMBER		23
+#define GDT_ENTRY_APMBIOS_BASE		24
 
-#define GDT_ENTRY_ESPFIX_SS		26
-#define GDT_ENTRY_PERCPU		27
-#define GDT_ENTRY_STACK_CANARY		28
+#define GDT_ENTRY_ESPFIX_SS		27
+#define GDT_ENTRY_PERCPU		28
+#define GDT_ENTRY_STACK_CANARY		29
 
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
@@ -140,6 +141,13 @@
 /* another data segment: */
 #define PNP_TS2				(GDT_ENTRY_PNPBIOS_TS2*8)
 
+/*
+ * CPU_NUMBER segment is at '%ss + 80' for the default (flat, initial)
+ * user space %ss (for 64-bit as well). Using %ss than %ds for less
+ * likely to be changed as defined in 64-bit too.
+ */
+#define __CPU_NUMBER_SEG		(GDT_ENTRY_CPU_NUMBER*8 + 3)
+
 #ifdef CONFIG_SMP
 # define __KERNEL_PERCPU		(GDT_ENTRY_PERCPU*8)
 #else
@@ -206,6 +214,10 @@
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
 #define __USER32_DS			__USER_DS
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
+/*
+ * CPU_NUMBER segment at '%ss (USER_DS) + 80',
+ * like 32-bit for the same reason
+ */
 #define __CPU_NUMBER_SEG		(GDT_ENTRY_CPU_NUMBER*8 + 3)
 
 #endif
-- 
2.7.4
