Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17986C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15122509F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15122509F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeFXPqJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:46:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60408 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeFXPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:46:05 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 213BB49F;
        Sun, 24 Jun 2018 15:46:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH 4.17 57/70] genirq/generic_pending: Do not lose pending affinity update
Date:   Sun, 24 Jun 2018 23:22:49 +0800
Message-Id: <20180624142744.015048976@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit a33a5d2d16cb84bea8d5f5510f3a41aa48b5c467 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/migration.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -38,17 +38,18 @@ bool irq_fixup_move_pending(struct irq_d
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
@@ -73,9 +74,20 @@ void irq_move_masked_irq(struct irq_data
 	 * For correct operation this depends on the caller
 	 * masking the irqs.
 	 */
-	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids)
-		irq_do_set_affinity(&desc->irq_data, desc->pending_mask, false);
+	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids) {
+		int ret;
 
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
 


