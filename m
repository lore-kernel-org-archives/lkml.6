Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeBVVLS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:11:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeBVVLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:11:17 -0500
Date: Thu, 22 Feb 2018 13:10:17 -0800
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f60606c4ce402963dc552c62910ffa7080b4a628@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, rdunlap@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        delamonpansie@gmail.com
Reply-To: delamonpansie@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, rdunlap@infradead.org,
        tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20180222112316.930791749@linutronix.de>
References: <20180222112316.930791749@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic/vector: Handle vector release on CPU
 unplug correctly
Git-Commit-ID: f60606c4ce402963dc552c62910ffa7080b4a628
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

Commit-ID:  f60606c4ce402963dc552c62910ffa7080b4a628
Gitweb:     https://git.kernel.org/tip/f60606c4ce402963dc552c62910ffa7080b4a628
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 22 Feb 2018 12:08:06 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 22 Feb 2018 22:05:44 +0100

x86/apic/vector: Handle vector release on CPU unplug correctly

When a irq vector is replaced, then the previous vector is normally
released when the first interrupt happens on the new vector. If the target
CPU of the previous vector is already offline when the new vector is
installed, then the previous vector is silently discarded, which leads to
accounting issues causing suspend failures and other problems.

Adjust the logic so that the previous vector is freed in the underlying
matrix allocator to ensure that the accounting stays correct.

Fixes: 69cde0004a4b ("x86/vector: Use matrix allocator for vector assignment")
Reported-by: Yuriy Vostrikov <delamonpansie@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Yuriy Vostrikov <delamonpansie@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180222112316.930791749@linutronix.de

---
 arch/x86/kernel/apic/vector.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3cc471b..a82ea2e 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -134,21 +134,40 @@ static void apic_update_vector(struct irq_data *irqd, unsigned int newvec,
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	struct irq_desc *desc = irq_data_to_desc(irqd);
+	bool managed = irqd_affinity_is_managed(irqd);
 
 	lockdep_assert_held(&vector_lock);
 
 	trace_vector_update(irqd->irq, newvec, newcpu, apicd->vector,
 			    apicd->cpu);
 
-	/* Setup the vector move, if required  */
-	if (apicd->vector && cpu_online(apicd->cpu)) {
+	/*
+	 * If there is no vector associated or if the associated vector is
+	 * the shutdown vector, which is associated to make PCI/MSI
+	 * shutdown mode work, then there is nothing to release. Clear out
+	 * prev_vector for this and the offlined target case.
+	 */
+	apicd->prev_vector = 0;
+	if (!apic->vector || apicd->vector == MANAGED_IRQ_SHUTDOWN_VECTOR)
+		goto setnew;
+	/*
+	 * If the target CPU of the previous vector is online, then mark
+	 * the vector as move in progress and store it for cleanup when the
+	 * first interrupt on the new vector arrives. If the target CPU is
+	 * offline then the regular release mechanism via the cleanup
+	 * vector is not possible and the vector can be immediately freed
+	 * in the underlying matrix allocator.
+	 */
+	if (cpu_online(apicd->cpu)) {
 		apicd->move_in_progress = true;
 		apicd->prev_vector = apicd->vector;
 		apicd->prev_cpu = apicd->cpu;
 	} else {
-		apicd->prev_vector = 0;
+		irq_matrix_free(vector_matrix, apicd->cpu, apicd->vector,
+				managed);
 	}
 
+setnew:
 	apicd->vector = newvec;
 	apicd->cpu = newcpu;
 	BUG_ON(!IS_ERR_OR_NULL(per_cpu(vector_irq, newcpu)[newvec]));
