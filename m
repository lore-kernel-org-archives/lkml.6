Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52348601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeFFNfV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:35:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFFNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:35:19 -0400
Date: Wed, 6 Jun 2018 06:34:50 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a07771ac6a78860777a9da5d9bc38830ec993fe7@git.kernel.org>
Cc: mike.travis@hpe.com, 0x7f454c46@gmail.com, peterz@infradead.org,
        songliubraving@fb.com, tariqt@mellanox.com, jroedel@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, mingo@kernel.org, liu.song.a23@gmail.com
Reply-To: songliubraving@fb.com, tariqt@mellanox.com, peterz@infradead.org,
          0x7f454c46@gmail.com, mike.travis@hpe.com,
          liu.song.a23@gmail.com, mingo@kernel.org, hpa@zytor.com,
          jroedel@suse.de, linux-kernel@vger.kernel.org, bp@alien8.de,
          tglx@linutronix.de
In-Reply-To: <20180604162224.908136099@linutronix.de>
References: <20180604162224.908136099@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic/vector: Print APIC control bits in
 debugfs
Git-Commit-ID: a07771ac6a78860777a9da5d9bc38830ec993fe7
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

Commit-ID:  a07771ac6a78860777a9da5d9bc38830ec993fe7
Gitweb:     https://git.kernel.org/tip/a07771ac6a78860777a9da5d9bc38830ec993fe7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 4 Jun 2018 17:34:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 15:18:22 +0200

x86/apic/vector: Print APIC control bits in debugfs

Extend the debugability of the vector management by adding the state bits
to the debugfs output.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Song Liu <songliubraving@fb.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <liu.song.a23@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tariq Toukan <tariqt@mellanox.com>
Link: https://lkml.kernel.org/r/20180604162224.908136099@linutronix.de

---
 arch/x86/kernel/apic/vector.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index b708f597eee3..35aaee4fc028 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -588,8 +588,7 @@ error:
 static void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
 				  struct irq_data *irqd, int ind)
 {
-	unsigned int cpu, vector, prev_cpu, prev_vector;
-	struct apic_chip_data *apicd;
+	struct apic_chip_data apicd;
 	unsigned long flags;
 	int irq;
 
@@ -605,24 +604,26 @@ static void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
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
 
