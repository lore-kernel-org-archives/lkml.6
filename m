Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8626C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3745217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfB0QFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:05:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:6599 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbfB0QFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:05:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 08:05:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303011642"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 08:05:44 -0800
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
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC PATCH v2 04/14] x86/hpet: Reserve timer for the HPET hardlockup detector
Date:   Wed, 27 Feb 2019 08:05:08 -0800
Message-Id: <1551283518-18922-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HPET timer 2 will be used to drive the HPET-based hardlockup detector.
Reserve such timer to ensure it cannot be used by user space programs or
clock events.

When looking for MSI-capable timers for clock events, skip timer 2 if
the HPET hardlockup detector is selected.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h |  3 +++
 arch/x86/kernel/hpet.c      | 19 ++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 9e0afde47587..3266796f7b60 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -61,6 +61,9 @@
  */
 #define HPET_MIN_PERIOD		100000UL
 
+/* Timer used for the hardlockup detector */
+#define HPET_WD_TIMER_NR 2
+
 /* hpet memory map physical address */
 extern unsigned long hpet_address;
 extern unsigned long force_hpet_address;
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index ee439d84e83b..e9e18bf7e65d 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -182,7 +182,8 @@ do {								\
 
 /*
  * When the hpet driver (/dev/hpet) is enabled, we need to reserve
- * timer 0 and timer 1 in case of RTC emulation.
+ * timer 0 and timer 1 in case of RTC emulation. Timer 2 is reserved in case
+ * the HPET-based hardlockup detector is used.
  */
 #ifdef CONFIG_HPET
 
@@ -192,7 +193,7 @@ static void hpet_reserve_platform_timers(unsigned int id)
 {
 	struct hpet __iomem *hpet = hpet_virt_address;
 	struct hpet_timer __iomem *timer = &hpet->hpet_timers[2];
-	unsigned int nrtimers, i;
+	unsigned int nrtimers, i, start_timer;
 	struct hpet_data hd;
 
 	nrtimers = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
@@ -207,6 +208,13 @@ static void hpet_reserve_platform_timers(unsigned int id)
 	hpet_reserve_timer(&hd, 1);
 #endif
 
+	if (IS_ENABLED(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET)) {
+		hpet_reserve_timer(&hd, HPET_WD_TIMER_NR);
+		start_timer = HPET_WD_TIMER_NR + 1;
+	} else {
+		start_timer = HPET_WD_TIMER_NR;
+	}
+
 	/*
 	 * NOTE that hd_irq[] reflects IOAPIC input pins (LEGACY_8254
 	 * is wrong for i8259!) not the output IRQ.  Many BIOS writers
@@ -215,7 +223,7 @@ static void hpet_reserve_platform_timers(unsigned int id)
 	hd.hd_irq[0] = HPET_LEGACY_8254;
 	hd.hd_irq[1] = HPET_LEGACY_RTC;
 
-	for (i = 2; i < nrtimers; timer++, i++) {
+	for (i = start_timer; i < nrtimers; timer++, i++) {
 		hd.hd_irq[i] = (readl(&timer->hpet_config) &
 			Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
 	}
@@ -627,6 +635,11 @@ static void hpet_msi_capability_lookup(unsigned int start_timer)
 		struct hpet_dev *hdev = &hpet_devs[num_timers_used];
 		unsigned int cfg = hpet_readl(HPET_Tn_CFG(i));
 
+		/* Do not use timer reserved for the HPET watchdog. */
+		if (IS_ENABLED(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) &&
+		    i == HPET_WD_TIMER_NR)
+			continue;
+
 		/* Only consider HPET timer with MSI support */
 		if (!(cfg & HPET_TN_FSB_CAP))
 			continue;
-- 
2.17.1

