Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4819060555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeFFNdW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:33:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52999 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFFNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:32:00 -0400
Date: Wed, 6 Jun 2018 06:31:25 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a33a5d2d16cb84bea8d5f5510f3a41aa48b5c467@git.kernel.org>
Cc: tariqt@mellanox.com, bp@alien8.de, mingo@kernel.org,
        liu.song.a23@gmail.com, jroedel@suse.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, songliubraving@fb.com,
        0x7f454c46@gmail.com, mike.travis@hpe.com, hpa@zytor.com,
        peterz@infradead.org
Reply-To: mingo@kernel.org, jroedel@suse.de, liu.song.a23@gmail.com,
          bp@alien8.de, tariqt@mellanox.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, 0x7f454c46@gmail.com, songliubraving@fb.com,
          peterz@infradead.org, hpa@zytor.com, mike.travis@hpe.com
In-Reply-To: <20180604162224.386544292@linutronix.de>
References: <20180604162224.386544292@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] genirq/generic_pending: Do not lose pending
 affinity update
Git-Commit-ID: a33a5d2d16cb84bea8d5f5510f3a41aa48b5c467
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

Commit-ID:  a33a5d2d16cb84bea8d5f5510f3a41aa48b5c467
Gitweb:     https://git.kernel.org/tip/a33a5d2d16cb84bea8d5f5510f3a41aa48b5c467
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 4 Jun 2018 17:33:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 15:18:19 +0200

genirq/generic_pending: Do not lose pending affinity update

The generic pending interrupt mechanism moves interrupts from the interrupt
handler on the original target CPU to the new destination CPU. This is
required for x86 and ia64 due to the way the interrupt delivery and
acknowledge works if the interrupts are not remapped.

However that update can fail for various reasons. Some of them are valid
reasons to discard the pending update, but the case, when the previous move
has not been fully cleaned up is not a legit reason to fail.

Check the return value of irq_do_set_affinity() for -EBUSY, which indicates
a pending cleanup, and rearm the pending move in the irq dexcriptor so it's
tried again when the next interrupt arrives.

Fixes: 996c591227d9 ("x86/irq: Plug vector cleanup race")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Song Liu <songliubraving@fb.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <liu.song.a23@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tariq Toukan <tariqt@mellanox.com>
Link: https://lkml.kernel.org/r/20180604162224.386544292@linutronix.de

---
 kernel/irq/migration.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 86ae0eb80b53..8b8cecd18cce 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -38,17 +38,18 @@ bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear)
 void irq_move_masked_irq(struct irq_data *idata)
 {
 	struct irq_desc *desc = irq_data_to_desc(idata);
-	struct irq_chip *chip = desc->irq_data.chip;
+	struct irq_data *data = &desc->irq_data;
+	struct irq_chip *chip = data->chip;
 
-	if (likely(!irqd_is_setaffinity_pending(&desc->irq_data)))
+	if (likely(!irqd_is_setaffinity_pending(data)))
 		return;
 
-	irqd_clr_move_pending(&desc->irq_data);
+	irqd_clr_move_pending(data);
 
 	/*
 	 * Paranoia: cpu-local interrupts shouldn't be calling in here anyway.
 	 */
-	if (irqd_is_per_cpu(&desc->irq_data)) {
+	if (irqd_is_per_cpu(data)) {
 		WARN_ON(1);
 		return;
 	}
@@ -73,9 +74,20 @@ void irq_move_masked_irq(struct irq_data *idata)
 	 * For correct operation this depends on the caller
 	 * masking the irqs.
 	 */
-	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids)
-		irq_do_set_affinity(&desc->irq_data, desc->pending_mask, false);
-
+	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids) {
+		int ret;
+
+		ret = irq_do_set_affinity(data, desc->pending_mask, false);
+		/*
+		 * If the there is a cleanup pending in the underlying
+		 * vector management, reschedule the move for the next
+		 * interrupt. Leave desc->pending_mask intact.
+		 */
+		if (ret == -EBUSY) {
+			irqd_set_move_pending(data);
+			return;
+		}
+	}
 	cpumask_clear(desc->pending_mask);
 }
 
