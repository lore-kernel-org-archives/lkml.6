Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeESNM7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 09:12:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56955 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeESNM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 09:12:58 -0400
Date: Sat, 19 May 2018 06:12:49 -0700
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-2773397171ac4b6e794ba0b3e34c06cbaf29897a@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, douly.fnst@cn.fujitsu.com
Reply-To: douly.fnst@cn.fujitsu.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20180511080956.6316-1-douly.fnst@cn.fujitsu.com>
References: <20180511080956.6316-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/vector: Merge allocate_vector() into
 assign_vector_locked()
Git-Commit-ID: 2773397171ac4b6e794ba0b3e34c06cbaf29897a
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

Commit-ID:  2773397171ac4b6e794ba0b3e34c06cbaf29897a
Gitweb:     https://git.kernel.org/tip/2773397171ac4b6e794ba0b3e34c06cbaf29897a
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Fri, 11 May 2018 16:09:56 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 15:09:11 +0200

x86/vector: Merge allocate_vector() into assign_vector_locked()

assign_vector_locked() calls allocate_vector() to get a real vector for an
IRQ. If the current target CPU is online and in the new requested affinity
mask, allocate_vector() will return 0 and nothing should be done. But,
assign_vector_locked() calls apic_update_irq_cfg() even in that case which
is pointless.

allocate_vector() is not called from anything else, so the functions can be
merged and in case of no change the apic_update_irq_cfg() can be avoided.

[ tglx: Massaged changelog ]

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180511080956.6316-1-douly.fnst@cn.fujitsu.com

---
 arch/x86/kernel/apic/vector.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bb6f7a2148d7..a75de0792942 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -218,7 +218,8 @@ static int reserve_irq_vector(struct irq_data *irqd)
 	return 0;
 }
 
-static int allocate_vector(struct irq_data *irqd, const struct cpumask *dest)
+static int
+assign_vector_locked(struct irq_data *irqd, const struct cpumask *dest)
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	bool resvd = apicd->has_reserved;
@@ -236,22 +237,12 @@ static int allocate_vector(struct irq_data *irqd, const struct cpumask *dest)
 		return 0;
 
 	vector = irq_matrix_alloc(vector_matrix, dest, resvd, &cpu);
-	if (vector > 0)
-		apic_update_vector(irqd, vector, cpu);
 	trace_vector_alloc(irqd->irq, vector, resvd, vector);
-	return vector;
-}
-
-static int assign_vector_locked(struct irq_data *irqd,
-				const struct cpumask *dest)
-{
-	struct apic_chip_data *apicd = apic_chip_data(irqd);
-	int vector = allocate_vector(irqd, dest);
-
 	if (vector < 0)
 		return vector;
+	apic_update_vector(irqd, vector, cpu);
+	apic_update_irq_cfg(irqd, vector, cpu);
 
-	apic_update_irq_cfg(irqd, apicd->vector, apicd->cpu);
 	return 0;
 }
 
