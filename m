Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06327C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6222502D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6222502D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755722AbeFXPiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:38:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755337AbeFXPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:38:21 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A8DA2C;
        Sun, 24 Jun 2018 15:38:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Tariq Toukan <tariqt@mellanox.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 4.16 55/64] genirq/migration: Avoid out of line call if pending is not set
Date:   Sun, 24 Jun 2018 23:22:36 +0800
Message-Id: <20180624142747.087440944@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit d340ebd696f921d3ad01b8c0c29dd38f2ad2bf3e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/irq.h    |    7 ++++++-
 kernel/irq/migration.c |    5 +----
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -556,7 +556,12 @@ extern int irq_affinity_online_cpu(unsig
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
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -91,7 +91,7 @@ void irq_move_masked_irq(struct irq_data
 	cpumask_clear(desc->pending_mask);
 }
 
-void irq_move_irq(struct irq_data *idata)
+void __irq_move_irq(struct irq_data *idata)
 {
 	bool masked;
 
@@ -102,9 +102,6 @@ void irq_move_irq(struct irq_data *idata
 	 */
 	idata = irq_desc_get_irq_data(irq_data_to_desc(idata));
 
-	if (likely(!irqd_is_setaffinity_pending(idata)))
-		return;
-
 	if (unlikely(irqd_irq_disabled(idata)))
 		return;
 


