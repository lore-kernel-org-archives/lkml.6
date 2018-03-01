Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966858AbeCAJRL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:17:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44593 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966724AbeCAJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:17:08 -0500
Date: Thu, 1 Mar 2018 01:17:00 -0800
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-3ea9e7ae1a2038b9fdff729861c9b4af0087024f@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        andy.shevchenko@gmail.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
        douly.fnst@cn.fujitsu.com, tglx@linutronix.de, hpa@zytor.com,
        andy.shevchenko@gmail.com
In-Reply-To: <20180301055930.2396-3-douly.fnst@cn.fujitsu.com>
References: <20180301055930.2396-3-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Modernize the pending interrupt code
Git-Commit-ID: 3ea9e7ae1a2038b9fdff729861c9b4af0087024f
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

Commit-ID:  3ea9e7ae1a2038b9fdff729861c9b4af0087024f
Gitweb:     https://git.kernel.org/tip/3ea9e7ae1a2038b9fdff729861c9b4af0087024f
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Thu, 1 Mar 2018 13:59:29 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Mar 2018 10:12:20 +0100

x86/apic: Modernize the pending interrupt code

The pending interrupt check code is old, update the following:

  - Use for_each_set_bit() instead of open coding it
  - Replace printk() with pr_err()
  - Get rid of printk line breaks
  - Make curly braces balanced

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: bhe@redhat.com
Cc: ebiederm@xmission.com
Link: https://lkml.kernel.org/r/20180301055930.2396-3-douly.fnst@cn.fujitsu.com

---
 arch/x86/kernel/apic/apic.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 69d2936e3154..7a347d7450b6 100644
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
@@ -1435,24 +1436,22 @@ static void apic_pending_intr_clear(void)
 
 		for (i = APIC_ISR_NR - 1; i >= 0; i--) {
 			value = apic_read(APIC_ISR + i*0x10);
-			for (j = 31; j >= 0; j--) {
-				if (value & (1<<j)) {
-					ack_APIC_irq();
-					acked++;
-				}
+			for_each_set_bit(j, &value, 32) {
+				ack_APIC_irq();
+				acked++;
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
