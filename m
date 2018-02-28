Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeB1ONW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:13:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbeB1ONV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:13:21 -0500
Date: Wed, 28 Feb 2018 06:13:12 -0800
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-ea5dfef5a890c9e6e47bdddfc23c4a4ba0c1bea1@git.kernel.org>
Cc: andy.shevchenko@gmail.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        douly.fnst@cn.fujitsu.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        andy.shevchenko@gmail.com, douly.fnst@cn.fujitsu.com,
        tglx@linutronix.de
In-Reply-To: <20180226023957.22861-2-douly.fnst@cn.fujitsu.com>
References: <20180226023957.22861-2-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Replace common tools with new ones
Git-Commit-ID: ea5dfef5a890c9e6e47bdddfc23c4a4ba0c1bea1
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

Commit-ID:  ea5dfef5a890c9e6e47bdddfc23c4a4ba0c1bea1
Gitweb:     https://git.kernel.org/tip/ea5dfef5a890c9e6e47bdddfc23c4a4ba0c1bea1
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Mon, 26 Feb 2018 10:39:57 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 15:09:11 +0100

x86/apic: Replace common tools with new ones

The pending interrupt check code is old, update the following.

  -Replace for-if pair with for_each_set_bit()
  -Replace printk() with pr_err()

Also merge the printk's code in one line and make curly braces balanced

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: bhe@redhat.com
Cc: ebiederm@xmission.com
Link: https://lkml.kernel.org/r/20180226023957.22861-2-douly.fnst@cn.fujitsu.com

---
 arch/x86/kernel/apic/apic.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 3fda9734db25..4704a3541b11 100644
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
