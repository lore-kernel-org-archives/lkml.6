Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 79D1EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FD520660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FD520660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935263AbeFMBF5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:05:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:64688 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933125AbeFMBBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283474"
Received: from voyager.sc.intel.com ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 18:01:31 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 07/23] x86/hpet: Expose more functions to read and write registers
Date:   Tue, 12 Jun 2018 17:57:27 -0700
Message-Id: <1528851463-21140-8-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the registers in the HPET hardware have a width of 64 bits. 64-bit
access functions are needed mostly to read the counter and write the
comparator in a single read or write. Also, 64-bit accesses can be used to
to read parameters located in the higher bits of some registers (such as
the timer period and the IO APIC pins that can be asserted by the timer)
without the need of masking and shifting the register values.

64-bit read and write functions are added. These functions, along with the
existing hpet_writel(), are exposed via the HPET header to be used by other
kernel subsystems.

Thus far, the only consumer of these functions will the HPET-based
hardlockup detector, which will only be available in 64-bit builds. Thus,
the 64-bit access functions are wrapped in CONFIG_X86_64.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h | 10 ++++++++++
 arch/x86/kernel/hpet.c      | 12 +++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 67385d5..9e0afde 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -72,6 +72,11 @@ extern int is_hpet_enabled(void);
 extern int hpet_enable(void);
 extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
+extern void hpet_writel(unsigned int d, unsigned int a);
+#ifdef CONFIG_X86_64
+extern unsigned long hpet_readq(unsigned int a);
+extern void hpet_writeq(unsigned long d, unsigned int a);
+#endif
 extern void force_hpet_resume(void);
 
 struct irq_data;
@@ -109,6 +114,11 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
 static inline int hpet_enable(void) { return 0; }
 static inline int is_hpet_enabled(void) { return 0; }
 #define hpet_readl(a) 0
+#define hpet_writel(d, a)
+#ifdef CONFIG_X86_64
+#define hpet_readq(a) 0
+#define hpet_writeq(d, a)
+#endif
 #define default_setup_hpet_msi	NULL
 
 #endif
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 8ce4212..3fa1d3f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -64,12 +64,22 @@ inline unsigned int hpet_readl(unsigned int a)
 	return readl(hpet_virt_address + a);
 }
 
-static inline void hpet_writel(unsigned int d, unsigned int a)
+inline void hpet_writel(unsigned int d, unsigned int a)
 {
 	writel(d, hpet_virt_address + a);
 }
 
 #ifdef CONFIG_X86_64
+inline unsigned long hpet_readq(unsigned int a)
+{
+	return readq(hpet_virt_address + a);
+}
+
+inline void hpet_writeq(unsigned long d, unsigned int a)
+{
+	writeq(d, hpet_virt_address + a);
+}
+
 #include <asm/pgtable.h>
 #endif
 
-- 
2.7.4

