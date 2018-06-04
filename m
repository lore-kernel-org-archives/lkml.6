Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeFDQ2s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:28:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40707 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeFDQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:27:44 -0400
Message-Id: <20180604162224.908136099@linutronix.de>
User-Agent: quilt/0.65
Date: Mon, 04 Jun 2018 17:34:00 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>
Subject: [patch 8/8] x86/apic/vector: Print APIC control bits in debugfs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-apic-vector--Print-APIC-control-bits-in-debugfs.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the debugability of the vector management by adding the state bits
to the debugfs output.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/vector.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -588,8 +588,7 @@ static int x86_vector_alloc_irqs(struct
 static void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
 				  struct irq_data *irqd, int ind)
 {
-	unsigned int cpu, vector, prev_cpu, prev_vector;
-	struct apic_chip_data *apicd;
+	struct apic_chip_data apicd;
 	unsigned long flags;
 	int irq;
 
@@ -605,24 +604,26 @@ static void x86_vector_debug_show(struct
 		return;
 	}
 
-	apicd = irqd->chip_data;
-	if (!apicd) {
+	if (!irqd->chip_data) {
 		seq_printf(m, "%*sVector: Not assigned\n", ind, "");
 		return;
 	}
 
 	raw_spin_lock_irqsave(&vector_lock, flags);
-	cpu = apicd->cpu;
-	vector = apicd->vector;
-	prev_cpu = apicd->prev_cpu;
-	prev_vector = apicd->prev_vector;
+	memcpy(&apicd, irqd->chip_data, sizeof(apicd));
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
-	seq_printf(m, "%*sVector: %5u\n", ind, "", vector);
-	seq_printf(m, "%*sTarget: %5u\n", ind, "", cpu);
-	if (prev_vector) {
-		seq_printf(m, "%*sPrevious vector: %5u\n", ind, "", prev_vector);
-		seq_printf(m, "%*sPrevious target: %5u\n", ind, "", prev_cpu);
+
+	seq_printf(m, "%*sVector: %5u\n", ind, "", apicd.vector);
+	seq_printf(m, "%*sTarget: %5u\n", ind, "", apicd.cpu);
+	if (apicd.prev_vector) {
+		seq_printf(m, "%*sPrevious vector: %5u\n", ind, "", apicd.prev_vector);
+		seq_printf(m, "%*sPrevious target: %5u\n", ind, "", apicd.prev_cpu);
 	}
+	seq_printf(m, "%*smove_in_progress: %u\n", ind, "", apicd.move_in_progress ? 1 : 0);
+	seq_printf(m, "%*sis_managed:       %u\n", ind, "", apicd.is_managed ? 1 : 0);
+	seq_printf(m, "%*scan_reserve:      %u\n", ind, "", apicd.can_reserve ? 1 : 0);
+	seq_printf(m, "%*shas_reserved:     %u\n", ind, "", apicd.has_reserved ? 1 : 0);
+	seq_printf(m, "%*scleanup_pending:  %u\n", ind, "", !hlist_unhashed(&apicd.clist));
 }
 #endif
 
