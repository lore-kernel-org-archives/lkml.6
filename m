Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932122AbeBVLYY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:24:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753698AbeBVLXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:23:45 -0500
Message-Id: <20180222112316.849980972@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 22 Feb 2018 12:08:05 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yuriy Vostrikov <delamonpansie@gmail.com>, stable@vger.kernel.org
Subject: [patch 1/3] genirq/matrix: Handle CPU offlining proper
References: <20180222110804.587011608@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=genirq-matrix--Handle-CPU-offlining-proper.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At CPU hotunplug the corresponding per cpu matrix allocator is shut down and
the allocated interrupt bits are discarded under the assumption that all
allocated bits have been either migrated away or shut down through the
managed interrupts mechanism.

This is not true because interrupts which are not started up might have a
vector allocated on the outgoing CPU. When the interrupt is started up
later or completely shutdown and freed then the allocated vector is handed
back, triggering warnings or causing accounting issues which result in
suspend failures and other issues.

Change the CPU hotplug mechanism of the matrix allocator so that the
remaining allocations at unplug time are preserved and global accounting at
hotplug is correctly readjusted to take the dormant vectors into account.

Fixes: 2f75d9e1c905 ("genirq: Implement bitmap matrix allocator")
Reported-by: Yuriy Vostrikov <delamonpansie@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Yuriy Vostrikov <delamonpansie@gmail.com>
Cc: stable@vger.kernel.org
---
 kernel/irq/matrix.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -16,6 +16,7 @@ struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
 	unsigned int		managed;
+	bool			initialized;
 	bool			online;
 	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
 	unsigned long		managed_map[IRQ_MATRIX_SIZE];
@@ -81,9 +82,11 @@ void irq_matrix_online(struct irq_matrix
 
 	BUG_ON(cm->online);
 
-	bitmap_zero(cm->alloc_map, m->matrix_bits);
-	cm->available = m->alloc_size - (cm->managed + m->systembits_inalloc);
-	cm->allocated = 0;
+	if (!cm->initialized) {
+		cm->available = m->alloc_size;
+		cm->available -= cm->managed + m->systembits_inalloc;
+		cm->initialized = true;
+	}
 	m->global_available += cm->available;
 	cm->online = true;
 	m->online_maps++;
@@ -370,14 +373,16 @@ void irq_matrix_free(struct irq_matrix *
 	if (WARN_ON_ONCE(bit < m->alloc_start || bit >= m->alloc_end))
 		return;
 
-	if (cm->online) {
-		clear_bit(bit, cm->alloc_map);
-		cm->allocated--;
+	clear_bit(bit, cm->alloc_map);
+	cm->allocated--;
+
+	if (cm->online)
 		m->total_allocated--;
-		if (!managed) {
-			cm->available++;
+
+	if (!managed) {
+		cm->available++;
+		if (cm->online)
 			m->global_available++;
-		}
 	}
 	trace_irq_matrix_free(bit, cpu, m, cm);
 }
