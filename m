Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeDELxa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:53:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37837 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeDELx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:53:29 -0400
X-Google-Smtp-Source: AIpwx48FUVWGk9QCS3n/+8ZjXZeC/6JDbKJLGZTRC7g0/pUX0lY4nDeFpouXCUnEf8rwnnvyn9MqqQ==
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] kernel/irq/proc: /proc/interrupts irq-off latency reduction
Date: Thu,  5 Apr 2018 21:53:13 +1000
Message-Id: <20180405115313.29821-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading /proc/interrupts shows up as a latency source of several
hundred microseconds on a 2 socket 176 thread system, because it
iterates twice over all CPUs under an irq lock pulling in remote
cachelines, doing lots of seq_printf, etc.

On a 16 socket system with higher latencies to remote cachelines,
latencies around 10ms would be seen here. irqbalanced periodically
reads this file, and the latency spikes are noticed on smaller
systems. Also the file is unprivileged, so it's important to reduce
this latency.

Avoid holding the lock while iterating over CPUs to get their stats.
The desc should be protected with irq_lock_sparse().

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/irq/proc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index e8f374971e37..bbc4004b74bc 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -544,17 +544,22 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc)
 		goto outsparse;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
 	for_each_online_cpu(j)
 		any_count |= kstat_irqs_cpu(i, j);
+
 	action = desc->action;
-	if ((!action || irq_desc_is_chained(desc)) && !any_count)
-		goto out;
+	if (!any_count) {
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		if (!action || irq_desc_is_chained(desc))
+			goto out;
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+	}
 
 	seq_printf(p, "%*d: ", prec, i);
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
 
+	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
 		if (desc->irq_data.chip->irq_print_chip)
 			desc->irq_data.chip->irq_print_chip(&desc->irq_data, p);
-- 
2.16.3
