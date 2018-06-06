Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C56A160767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeFFNcp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:32:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeFFNcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:32:43 -0400
Date: Wed, 6 Jun 2018 06:31:54 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-d340ebd696f921d3ad01b8c0c29dd38f2ad2bf3e@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        tglx@linutronix.de, mike.travis@hpe.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, mingo@kernel.org, liu.song.a23@gmail.com,
        0x7f454c46@gmail.com, jroedel@suse.de, tariqt@mellanox.com
Reply-To: 0x7f454c46@gmail.com, mingo@kernel.org, liu.song.a23@gmail.com,
          peterz@infradead.org, tariqt@mellanox.com, jroedel@suse.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          bp@alien8.de, douly.fnst@cn.fujitsu.com, mike.travis@hpe.com
In-Reply-To: <20180604162224.471925894@linutronix.de>
References: <20180604162224.471925894@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] genirq/migration: Avoid out of line call if
 pending is not set
Git-Commit-ID: d340ebd696f921d3ad01b8c0c29dd38f2ad2bf3e
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

Commit-ID:  d340ebd696f921d3ad01b8c0c29dd38f2ad2bf3e
Gitweb:     https://git.kernel.org/tip/d340ebd696f921d3ad01b8c0c29dd38f2ad2bf3e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 6 Jun 2018 14:46:59 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 15:18:20 +0200

genirq/migration: Avoid out of line call if pending is not set

The upcoming fix for the -EBUSY return from affinity settings requires to
use the irq_move_irq() functionality even on irq remapped interrupts. To
avoid the out of line call, move the check for the pending bit into an
inline helper.

Preparatory change for the real fix. No functional change.

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <liu.song.a23@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tariq Toukan <tariqt@mellanox.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Link: https://lkml.kernel.org/r/20180604162224.471925894@linutronix.de

---
 include/linux/irq.h    | 7 ++++++-
 kernel/irq/migration.c | 5 +----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 65916a305f3d..4e66378f290b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -551,7 +551,12 @@ extern int irq_affinity_online_cpu(unsigned int cpu);
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
-void irq_move_irq(struct irq_data *data);
+void __irq_move_irq(struct irq_data *data);
+static inline void irq_move_irq(struct irq_data *data)
+{
+	if (unlikely(irqd_is_setaffinity_pending(data)))
+		__irq_move_irq(data);
+}
 void irq_move_masked_irq(struct irq_data *data);
 void irq_force_complete_move(struct irq_desc *desc);
 #else
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 8b8cecd18cce..def48589ea48 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -91,7 +91,7 @@ void irq_move_masked_irq(struct irq_data *idata)
 	cpumask_clear(desc->pending_mask);
 }
 
-void irq_move_irq(struct irq_data *idata)
+void __irq_move_irq(struct irq_data *idata)
 {
 	bool masked;
 
@@ -102,9 +102,6 @@ void irq_move_irq(struct irq_data *idata)
 	 */
 	idata = irq_desc_get_irq_data(irq_data_to_desc(idata));
 
-	if (likely(!irqd_is_setaffinity_pending(idata)))
-		return;
-
 	if (unlikely(irqd_irq_disabled(idata)))
 		return;
 
