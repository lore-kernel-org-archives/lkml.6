Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 907A7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C567208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C567208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935082AbeFMBBl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:01:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:64691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935046AbeFMBBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283489"
Received: from voyager.sc.intel.com ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 18:01:33 -0700
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
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 11/23] x86/hpet: Configure the timer used by the hardlockup detector
Date:   Tue, 12 Jun 2018 17:57:31 -0700
Message-Id: <1528851463-21140-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the initial configuration of the timer to be used by the
hardlockup detector. The main focus of this configuration is to provide an
interrupt for the timer.

Two types of interrupt can be assigned to the timer. First, attempt to
assign a message-signaled interrupt. This implies creating the HPET MSI
domain; only if it was not created when HPET timers are used for event
timers. The data structures needed to allocate the MSI interrupt in the
domain are also created.

If message-signaled interrupts cannot be used, assign a legacy IO APIC
interrupt via the ACPI Global System Interrupts.

The resulting interrupt configuration, along with the timer instance, and
frequency are then made available to the hardlockup detector in a struct
via the new function hpet_hardlockup_detector_assign_timer().

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h |  16 +++++++
 arch/x86/kernel/hpet.c      | 112 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 9fd112a..33309b7 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -118,6 +118,22 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
 
 #endif /* CONFIG_HPET_EMULATE_RTC */
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_HPET
+struct hpet_hld_data {
+	u32		num;
+	u32		irq;
+	u32		flags;
+	u64		ticks_per_second;
+};
+
+extern struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void);
+#else
+static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
+{
+	return NULL;
+}
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_HPET */
+
 #else /* CONFIG_HPET_TIMER */
 
 static inline int hpet_enable(void) { return 0; }
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 99d4972..fda6e19 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/i8253.h>
+#include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/hpet.h>
 #include <linux/init.h>
@@ -36,6 +37,7 @@ bool					hpet_msi_disable;
 
 #ifdef CONFIG_PCI_MSI
 static unsigned int			hpet_num_timers;
+static struct irq_domain		*hpet_domain;
 #endif
 static void __iomem			*hpet_virt_address;
 
@@ -177,6 +179,115 @@ do {								\
 		_hpet_print_config(__func__, __LINE__);	\
 } while (0)
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_HPET
+static
+int hpet_hardlockup_detector_assign_legacy_irq(struct hpet_hld_data *hdata)
+{
+	unsigned long v;
+	int gsi, hwirq;
+
+	/* Obtain interrupt pins that can be used by this timer. */
+	v = hpet_readq(HPET_Tn_CFG(HPET_WD_TIMER_NR));
+	v = (v & Tn_INT_ROUTE_CAP_MASK) >> Tn_INT_ROUTE_CAP_SHIFT;
+
+	/*
+	 * In PIC mode, skip IRQ0-4, IRQ6-9, IRQ12-15 which is always used by
+	 * legacy device. In IO APIC mode, we skip all the legacy IRQS.
+	 */
+	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC)
+		v &= ~0xf3df;
+	else
+		v &= ~0xffff;
+
+	for_each_set_bit(hwirq, &v, HPET_MAX_IRQ) {
+		if (hwirq >= NR_IRQS) {
+			hwirq = HPET_MAX_IRQ;
+			break;
+		}
+
+		gsi = acpi_register_gsi(NULL, hwirq, ACPI_LEVEL_SENSITIVE,
+					ACPI_ACTIVE_LOW);
+		if (gsi > 0)
+			break;
+	}
+
+	if (hwirq >= HPET_MAX_IRQ)
+		return -ENODEV;
+
+	hdata->irq = hwirq;
+	return 0;
+}
+
+static int hpet_hardlockup_detector_assign_msi_irq(struct hpet_hld_data *hdata)
+{
+	struct hpet_dev *hdev;
+	int hwirq;
+
+	if (hpet_msi_disable)
+		return -ENODEV;
+
+	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	hdev->flags |= HPET_DEV_FSB_CAP;
+	hdev->num = hdata->num;
+	sprintf(hdev->name, "hpet_hld");
+
+	/* Domain may exist if CPU does not have Always-Running APIC Timers. */
+	if (!hpet_domain) {
+		hpet_domain = hpet_create_irq_domain(hpet_blockid);
+		if (!hpet_domain)
+			return -EPERM;
+	}
+
+	hwirq = hpet_assign_irq(hpet_domain, hdev, hdev->num);
+	if (hwirq <= 0) {
+		kfree(hdev);
+		return -ENODEV;
+	}
+
+	hdata->irq = hwirq;
+	hdata->flags |= HPET_DEV_FSB_CAP;
+
+	hdev->irq = hwirq;
+
+	return 0;
+}
+
+struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
+{
+	struct hpet_hld_data *hdata;
+	int ret = -ENODEV;
+	unsigned int cfg;
+
+	hdata = kzalloc(sizeof(*hdata), GFP_KERNEL);
+	if (!hdata)
+		return NULL;
+
+	hdata->num = HPET_WD_TIMER_NR;
+
+	cfg = hpet_readl(HPET_Tn_CFG(HPET_WD_TIMER_NR));
+
+	hdata->ticks_per_second = hpet_get_ticks_per_sec(hpet_readq(HPET_ID));
+
+	/* Try first an MSI interrupt or fallback to IO APIC. */
+	if (cfg & HPET_TN_FSB_CAP)
+		ret = hpet_hardlockup_detector_assign_msi_irq(hdata);
+
+	if (!ret)
+		return hdata;
+
+	ret = hpet_hardlockup_detector_assign_legacy_irq(hdata);
+	if (ret) {
+		kfree(hdata);
+		return NULL;
+	}
+
+	return hdata;
+}
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_HPET */
+
 /*
  * When the hpet driver (/dev/hpet) is enabled, we need to reserve
  * timer 0 and timer 1 in case of RTC emulation. Timer 2 is reserved in case
@@ -450,7 +561,6 @@ static struct clock_event_device hpet_clockevent = {
 
 static DEFINE_PER_CPU(struct hpet_dev *, cpu_hpet_dev);
 static struct hpet_dev	*hpet_devs;
-static struct irq_domain *hpet_domain;
 
 void hpet_msi_unmask(struct irq_data *data)
 {
-- 
2.7.4

