Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeB1OMz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:12:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbeB1OMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:12:54 -0500
Date: Wed, 28 Feb 2018 06:12:45 -0800
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3@git.kernel.org>
Cc: andy.shevchenko@gmail.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, douly.fnst@cn.fujitsu.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, douly.fnst@cn.fujitsu.com,
        mingo@kernel.org, andy.shevchenko@gmail.com, hpa@zytor.com,
        tglx@linutronix.de
In-Reply-To: <20180226023957.22861-1-douly.fnst@cn.fujitsu.com>
References: <20180226023957.22861-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Move pending intr check code into it's own
 function
Git-Commit-ID: 2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3
Gitweb:     https://git.kernel.org/tip/2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Mon, 26 Feb 2018 10:39:56 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 15:09:11 +0100

x86/apic: Move pending intr check code into it's own function

The pending interrupt check code is mixed with the local APIC setup code,
that looks messy.

Extract the related code, move it into a new function named
apic_pending_intr_clear().

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: bhe@redhat.com
Cc: ebiederm@xmission.com
Link: https://lkml.kernel.org/r/20180226023957.22861-1-douly.fnst@cn.fujitsu.com

---
 arch/x86/kernel/apic/apic.c | 98 ++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 2ceac9f6c5d7..3fda9734db25 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1408,6 +1408,56 @@ static void lapic_setup_esr(void)
 			oldvalue, value);
 }
 
+static void apic_pending_intr_clear(void)
+{
+	long long max_loops = cpu_khz ? cpu_khz : 1000000;
+	unsigned long long tsc = 0, ntsc;
+	unsigned int value, queued;
+	int i, j, acked = 0;
+
+	if (boot_cpu_has(X86_FEATURE_TSC))
+		tsc = rdtsc();
+	/*
+	 * After a crash, we no longer service the interrupts and a pending
+	 * interrupt from previous kernel might still have ISR bit set.
+	 *
+	 * Most probably by now CPU has serviced that pending interrupt and
+	 * it might not have done the ack_APIC_irq() because it thought,
+	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
+	 * does not clear the ISR bit and cpu thinks it has already serivced
+	 * the interrupt. Hence a vector might get locked. It was noticed
+	 * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
+	 */
+	do {
+		queued = 0;
+		for (i = APIC_ISR_NR - 1; i >= 0; i--)
+			queued |= apic_read(APIC_IRR + i*0x10);
+
+		for (i = APIC_ISR_NR - 1; i >= 0; i--) {
+			value = apic_read(APIC_ISR + i*0x10);
+			for (j = 31; j >= 0; j--) {
+				if (value & (1<<j)) {
+					ack_APIC_irq();
+					acked++;
+				}
+			}
+		}
+		if (acked > 256) {
+			printk(KERN_ERR "LAPIC pending interrupts after %d EOI\n",
+			       acked);
+			break;
+		}
+		if (queued) {
+			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
+				ntsc = rdtsc();
+				max_loops = (cpu_khz << 10) - (ntsc - tsc);
+			} else
+				max_loops--;
+		}
+	} while (queued && max_loops > 0);
+	WARN_ON(max_loops <= 0);
+}
+
 /**
  * setup_local_APIC - setup the local APIC
  *
@@ -1417,13 +1467,7 @@ static void lapic_setup_esr(void)
 static void setup_local_APIC(void)
 {
 	int cpu = smp_processor_id();
-	unsigned int value, queued;
-	int i, j, acked = 0;
-	unsigned long long tsc = 0, ntsc;
-	long long max_loops = cpu_khz ? cpu_khz : 1000000;
-
-	if (boot_cpu_has(X86_FEATURE_TSC))
-		tsc = rdtsc();
+	unsigned int value;
 
 	if (disable_apic) {
 		disable_ioapic_support();
@@ -1475,45 +1519,7 @@ static void setup_local_APIC(void)
 	value &= ~APIC_TPRI_MASK;
 	apic_write(APIC_TASKPRI, value);
 
-	/*
-	 * After a crash, we no longer service the interrupts and a pending
-	 * interrupt from previous kernel might still have ISR bit set.
-	 *
-	 * Most probably by now CPU has serviced that pending interrupt and
-	 * it might not have done the ack_APIC_irq() because it thought,
-	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
-	 * does not clear the ISR bit and cpu thinks it has already serivced
-	 * the interrupt. Hence a vector might get locked. It was noticed
-	 * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
-	 */
-	do {
-		queued = 0;
-		for (i = APIC_ISR_NR - 1; i >= 0; i--)
-			queued |= apic_read(APIC_IRR + i*0x10);
-
-		for (i = APIC_ISR_NR - 1; i >= 0; i--) {
-			value = apic_read(APIC_ISR + i*0x10);
-			for (j = 31; j >= 0; j--) {
-				if (value & (1<<j)) {
-					ack_APIC_irq();
-					acked++;
-				}
-			}
-		}
-		if (acked > 256) {
-			printk(KERN_ERR "LAPIC pending interrupts after %d EOI\n",
-			       acked);
-			break;
-		}
-		if (queued) {
-			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
-				ntsc = rdtsc();
-				max_loops = (cpu_khz << 10) - (ntsc - tsc);
-			} else
-				max_loops--;
-		}
-	} while (queued && max_loops > 0);
-	WARN_ON(max_loops <= 0);
+	apic_pending_intr_clear();
 
 	/*
 	 * Now that we are all set up, enable the APIC
