Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939620AbeE1PAU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932367AbeE1K1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:27:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, len.brown@intel.com,
        rui.zhang@intel.com, Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 026/329] x86/tsc: Allow TSC calibration without PIT
Date: Mon, 28 May 2018 11:59:15 +0200
Message-Id: <20180528100244.574645066@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 30c7e5b123673d5e570e238dbada2fb68a87212c ]

Zhang Rui reported that a Surface Pro 4 will fail to boot with
lapic=notscdeadline. Part of the problem is that that machine doesn't have
a PIT.

If, for some reason, the TSC init has to fall back to TSC calibration, it
relies on the PIT to be present.

Allow TSC calibration to reliably fall back to HPET.

The below results in an accurate TSC measurement when forced on a IVB:

  tsc: Unable to calibrate against PIT
  tsc: No reference (HPET/PMTIMER) available
  tsc: Unable to calibrate against PIT
  tsc: using HPET reference calibration
  tsc: Detected 2792.451 MHz processor

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: len.brown@intel.com
Cc: rui.zhang@intel.com
Link: https://lkml.kernel.org/r/20171222092243.333145937@infradead.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/i8259.h |    5 +++++
 arch/x86/kernel/tsc.c        |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -68,6 +68,11 @@ struct legacy_pic {
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
+static inline bool has_legacy_pic(void)
+{
+	return legacy_pic != &null_legacy_pic;
+}
+
 static inline int nr_legacy_irqs(void)
 {
 	return legacy_pic->nr_legacy_irqs;
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -24,6 +24,7 @@
 #include <asm/geode.h>
 #include <asm/apic.h>
 #include <asm/intel-family.h>
+#include <asm/i8259.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -456,6 +457,20 @@ static unsigned long pit_calibrate_tsc(u
 	unsigned long tscmin, tscmax;
 	int pitcnt;
 
+	if (!has_legacy_pic()) {
+		/*
+		 * Relies on tsc_early_delay_calibrate() to have given us semi
+		 * usable udelay(), wait for the same 50ms we would have with
+		 * the PIT loop below.
+		 */
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		return ULONG_MAX;
+	}
+
 	/* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
@@ -580,6 +595,9 @@ static unsigned long quick_pit_calibrate
 	u64 tsc, delta;
 	unsigned long d1, d2;
 
+	if (!has_legacy_pic())
+		return 0;
+
 	/* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
