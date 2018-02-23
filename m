Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeBWDgT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:36:19 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32015 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750995AbeBWDgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:36:17 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37186969"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@kernel.org>, <ebiederm@xmission.com>,
        <bhe@redhat.com>, <andy.shevchenko@gmail.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v2] x86/apic: Move pending intr check code into it's own function
Date: Fri, 23 Feb 2018 11:35:57 +0800
Message-ID: <20180223033557.31116-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: ED1384B32D88.A213E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the pending interrupt check code is mixed with the local APIC setup code,
that looks messy.

Extract the related code, move it into a new function named
apic_pending_intr_clear().

bonus cleanups from Andy Shevchenko's suggestions:

  - for() -> for_each_set_bit()
  - printk() -> pr_err()

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
changlog:
v1 --> v2:
  -do some cleanup suggested by Andy
  -rebase the patch on the tip/master tree

 arch/x86/kernel/apic/apic.c | 99 ++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 84b244ec49ed..687457d9df41 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1408,6 +1408,57 @@ static void lapic_setup_esr(void)
 			oldvalue, value);
 }
 
+static void apic_pending_intr_clear(void)
+{
+	long long max_loops = cpu_khz ? cpu_khz : 1000000;
+	unsigned long long tsc = 0, ntsc;
+	unsigned int queued;
+	unsigned long value;
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
+			for_each_set_bit(j, &value, 32) {
+				if (j) {
+					ack_APIC_irq();
+					acked++;
+				}
+			}
+		}
+		if (acked > 256) {
+			pr_err("LAPIC pending interrupts after %d EOI\n",
+				acked);
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
@@ -1417,13 +1468,7 @@ static void lapic_setup_esr(void)
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
@@ -1475,45 +1520,7 @@ static void setup_local_APIC(void)
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
-- 
2.14.3
