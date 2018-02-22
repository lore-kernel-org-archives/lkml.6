Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeBVLXu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:23:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbeBVLXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:23:47 -0500
Message-Id: <20180222112317.009379968@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 22 Feb 2018 12:08:07 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yuriy Vostrikov <delamonpansie@gmail.com>
Subject: [patch 3/3] x
References: <20180222110804.587011608@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=x.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -855,10 +855,14 @@ irq_thread_check_affinity(struct irq_des
 	 * This code is triggered unconditionally. Check the affinity
 	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
 	 */
-	if (cpumask_available(desc->irq_common_data.affinity))
-		cpumask_copy(mask, desc->irq_common_data.affinity);
-	else
+	if (cpumask_available(desc->irq_common_data.affinity)) {
+		const struct cpumask *m;
+
+		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
+		cpumask_copy(mask, m);
+	} else {
 		valid = false;
+	}
 	raw_spin_unlock_irq(&desc->lock);
 
 	if (valid)
