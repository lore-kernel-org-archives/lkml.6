Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeBVVLA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:11:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46871 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeBVVK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:10:59 -0500
Date: Thu, 22 Feb 2018 13:09:49 -0800
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-651ca2c00405a2ae3870cc0b4f15a182eb6fbe26@git.kernel.org>
Cc: delamonpansie@gmail.com, rdunlap@infradead.org, peterz@infradead.org,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: delamonpansie@gmail.com, rdunlap@infradead.org, peterz@infradead.org,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
In-Reply-To: <20180222112316.849980972@linutronix.de>
References: <20180222112316.849980972@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] genirq/matrix: Handle CPU offlining proper
Git-Commit-ID: 651ca2c00405a2ae3870cc0b4f15a182eb6fbe26
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

Commit-ID:  651ca2c00405a2ae3870cc0b4f15a182eb6fbe26
Gitweb:     https://git.kernel.org/tip/651ca2c00405a2ae3870cc0b4f15a182eb6fbe26
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 22 Feb 2018 12:08:05 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 22 Feb 2018 22:05:43 +0100

genirq/matrix: Handle CPU offlining proper

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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180222112316.849980972@linutronix.de

---
 kernel/irq/matrix.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 5187dfe..4c57704 100644
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
@@ -81,9 +82,11 @@ void irq_matrix_online(struct irq_matrix *m)
 
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
@@ -370,14 +373,16 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
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
