Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C13860767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeFFNex (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:34:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbeFFNew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:34:52 -0400
Date: Wed, 6 Jun 2018 06:34:20 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-12f47073a40f6aa75119d8f5df4077b7f334cced@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, songliubraving@fb.com,
        0x7f454c46@gmail.com, hpa@zytor.com, jroedel@suse.de,
        tariqt@mellanox.com, mike.travis@hpe.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, liu.song.a23@gmail.com
Reply-To: hpa@zytor.com, mike.travis@hpe.com, tariqt@mellanox.com,
          jroedel@suse.de, linux-kernel@vger.kernel.org,
          0x7f454c46@gmail.com, songliubraving@fb.com, bp@alien8.de,
          mingo@kernel.org, peterz@infradead.org, liu.song.a23@gmail.com,
          tglx@linutronix.de
In-Reply-To: <20180604162224.819273597@linutronix.de>
References: <20180604162224.819273597@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] genirq/affinity: Defer affinity setting if irq
 chip is busy
Git-Commit-ID: 12f47073a40f6aa75119d8f5df4077b7f334cced
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

Commit-ID:  12f47073a40f6aa75119d8f5df4077b7f334cced
Gitweb:     https://git.kernel.org/tip/12f47073a40f6aa75119d8f5df4077b7f334cced
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 4 Jun 2018 17:33:59 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 15:18:22 +0200

genirq/affinity: Defer affinity setting if irq chip is busy

The case that interrupt affinity setting fails with -EBUSY can be handled
in the kernel completely by using the already available generic pending
infrastructure.

If a irq_chip::set_affinity() fails with -EBUSY, handle it like the
interrupts for which irq_chip::set_affinity() can only be invoked from
interrupt context. Copy the new affinity mask to irq_desc::pending_mask and
set the affinity pending bit. The next raised interrupt for the affected
irq will check the pending bit and try to set the new affinity from the
handler. This avoids that -EBUSY is returned when an affinity change is
requested from user space and the previous change has not been cleaned
up. The new affinity will take effect when the next interrupt is raised
from the device.

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
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
Link: https://lkml.kernel.org/r/20180604162224.819273597@linutronix.de

---
 kernel/irq/manage.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e3336d904f64..facfecfc543c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -204,6 +204,39 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	return ret;
 }
 
+#ifdef CONFIG_GENERIC_PENDING_IRQ
+static inline int irq_set_affinity_pending(struct irq_data *data,
+					   const struct cpumask *dest)
+{
+	struct irq_desc *desc = irq_data_to_desc(data);
+
+	irqd_set_move_pending(data);
+	irq_copy_pending(desc, dest);
+	return 0;
+}
+#else
+static inline int irq_set_affinity_pending(struct irq_data *data,
+					   const struct cpumask *dest)
+{
+	return -EBUSY;
+}
+#endif
+
+static int irq_try_set_affinity(struct irq_data *data,
+				const struct cpumask *dest, bool force)
+{
+	int ret = irq_do_set_affinity(data, dest, force);
+
+	/*
+	 * In case that the underlying vector management is busy and the
+	 * architecture supports the generic pending mechanism then utilize
+	 * this to avoid returning an error to user space.
+	 */
+	if (ret == -EBUSY && !force)
+		ret = irq_set_affinity_pending(data, dest);
+	return ret;
+}
+
 int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 			    bool force)
 {
@@ -214,8 +247,8 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	if (irq_can_move_pcntxt(data)) {
-		ret = irq_do_set_affinity(data, mask, force);
+	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
+		ret = irq_try_set_affinity(data, mask, force);
 	} else {
 		irqd_set_move_pending(data);
 		irq_copy_pending(desc, mask);
