Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 024F9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61F6208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61F6208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935339AbeFMKiS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:38:18 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48010 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935273AbeFMKiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:38:06 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id B3F35285DB; Wed, 13 Jun 2018 06:38:02 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <41d5af43b69616f4427a268af9e8568b09936afd.1528885172.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528885172.git.fthain@telegraphics.com.au>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 12/12] macintosh/via-pmu: Disambiguate interrupt statistics
Date:   Wed, 13 Jun 2018 06:38:02 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the event counters are overloaded which makes it very
difficult to interpret their values.

Counter 0 is supposed to report CB1 interrupts but it can also count
PMU_INT_WAITING_CHARGER events.

Counter 1 is supposed to report GPIO interrupts but it can also count
other events (depending upon the value of the PMU_INT_ADB bit).

Disambiguate these statistics with dedicated counters for GPIO and
CB1 interrupts.

Comments in the MkLinux source code say that the type 0 and type 1
interrupts are model-specific. Label them as "unknown".

This change to the contents of /proc/pmu/interrupts is by necessity
visible in userland. However, packages which interact with the PMU
(that is, pbbuttonsd, pmac-utils and pmud) don't open this file.
AFAIK, user software has no need to poll these counters.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
The file now looks like this,

  0:          0 (Unknown interrupt (type 0))
  1:          0 (Unknown interrupt (type 1))
  2:          0 (PC-Card eject button)
  3:         23 (Sound/Brightness button)
  4:         74 (ADB message)
  5:          0 (Battery state change)
  6:          0 (Environment interrupt)
  7:        121 (Tick timer)
  8:          0 (Ghost interrupt (zero len))
  9:          1 (Empty interrupt (empty mask))
 10:          2 (Max irqs in a row)
 11:        194 (Total CB1 triggered events)
 12:          0 (Total GPIO1 triggered events)

rather than this,

  0:        194 (Total CB1 triggered events)
  1:          0 (Total GPIO1 triggered events)
  2:          0 (PC-Card eject button)
  3:         23 (Sound/Brightness button)
  4:         74 (ADB message)
  5:          0 (Battery state change)
  6:          0 (Environment interrupt)
  7:        121 (Tick timer)
  8:          0 (Ghost interrupt (zero len))
  9:          1 (Empty interrupt (empty mask))
 10:          2 (Max irqs in a row)

If some parser exists for this file, and if this change is problematic,
we could increment the driver version number in /proc/pmu/info, to
correspond with the format change.
---
 drivers/macintosh/via-pmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 730c10f7fbb7..44919b3b56e0 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -172,7 +172,9 @@ static int drop_interrupts;
 static int option_lid_wakeup = 1;
 #endif /* CONFIG_SUSPEND && CONFIG_PPC32 */
 static unsigned long async_req_locks;
-static unsigned int pmu_irq_stats[11];
+
+#define NUM_IRQ_STATS 13
+static unsigned int pmu_irq_stats[NUM_IRQ_STATS];
 
 static struct proc_dir_entry *proc_pmu_root;
 static struct proc_dir_entry *proc_pmu_info;
@@ -884,9 +886,9 @@ static const struct file_operations pmu_info_proc_fops = {
 static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
 {
 	int i;
-	static const char *irq_names[] = {
-		"Total CB1 triggered events",
-		"Total GPIO1 triggered events",
+	static const char *irq_names[NUM_IRQ_STATS] = {
+		"Unknown interrupt (type 0)",
+		"Unknown interrupt (type 1)",
 		"PC-Card eject button",
 		"Sound/Brightness button",
 		"ADB message",
@@ -895,10 +897,12 @@ static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
 		"Tick timer",
 		"Ghost interrupt (zero len)",
 		"Empty interrupt (empty mask)",
-		"Max irqs in a row"
+		"Max irqs in a row",
+		"Total CB1 triggered events",
+		"Total GPIO1 triggered events",
         };
 
-	for (i=0; i<11; i++) {
+	for (i = 0; i < NUM_IRQ_STATS; i++) {
 		seq_printf(m, " %2u: %10u (%s)\n",
 			     i, pmu_irq_stats[i], irq_names[i]);
 	}
@@ -1659,7 +1663,7 @@ via_pmu_interrupt(int irq, void *arg)
 		}
 		if (intr & CB1_INT) {
 			adb_int_pending = 1;
-			pmu_irq_stats[0]++;
+			pmu_irq_stats[11]++;
 		}
 		if (intr & SR_INT) {
 			req = pmu_sr_intr();
@@ -1746,7 +1750,7 @@ gpio1_interrupt(int irq, void *arg)
 			disable_irq_nosync(gpio_irq);
 			gpio_irq_enabled = 0;
 		}
-		pmu_irq_stats[1]++;
+		pmu_irq_stats[12]++;
 		adb_int_pending = 1;
 		spin_unlock_irqrestore(&pmu_lock, flags);
 		via_pmu_interrupt(0, NULL);
-- 
2.16.4

