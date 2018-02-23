Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBWHyx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:54:53 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11991 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750776AbeBWHyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:54:52 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37192425"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@kernel.org>, <ebiederm@xmission.com>,
        <bhe@redhat.com>, <andy.shevchenko@gmail.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v3 2/2] x86/apic: Replace common tools with new ones
Date: Fri, 23 Feb 2018 15:54:30 +0800
Message-ID: <20180223075430.12395-2-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180223075430.12395-1-douly.fnst@cn.fujitsu.com>
References: <20180223075430.12395-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: F0E8D48AE762.A55C9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pending interrupt check code is old, update the following code.

  -Replace for() with for_each_set_bit()
  -Replace printk() with pr_err()

Also merge the printk's code in one line and make curly braces balanced

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/apic/apic.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index be223ebd1bb3..b303b29c71ca 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1412,7 +1412,8 @@ static void apic_pending_intr_clear(void)
 {
 	long long max_loops = cpu_khz ? cpu_khz : 1000000;
 	unsigned long long tsc = 0, ntsc;
-	unsigned int value, queued;
+	unsigned int queued;
+	unsigned long value;
 	int i, j, acked = 0;
 
 	if (boot_cpu_has(X86_FEATURE_TSC))
@@ -1435,24 +1436,24 @@ static void apic_pending_intr_clear(void)
 
 		for (i = APIC_ISR_NR - 1; i >= 0; i--) {
 			value = apic_read(APIC_ISR + i*0x10);
-			for (j = 31; j >= 0; j--) {
-				if (value & (1<<j)) {
+			for_each_set_bit(j, &value, 32) {
+				if (j) {
 					ack_APIC_irq();
 					acked++;
 				}
 			}
 		}
 		if (acked > 256) {
-			printk(KERN_ERR "LAPIC pending interrupts after %d EOI\n",
-			       acked);
+			pr_err("LAPIC pending interrupts after %d EOI\n", acked);
 			break;
 		}
 		if (queued) {
 			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
 				ntsc = rdtsc();
 				max_loops = (cpu_khz << 10) - (ntsc - tsc);
-			} else
+			} else {
 				max_loops--;
+			}
 		}
 	} while (queued && max_loops > 0);
 	WARN_ON(max_loops <= 0);
-- 
2.14.3
