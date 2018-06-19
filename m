Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31575C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE352083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE352083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965149AbeFSHZR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:25:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36003 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755663AbeFSHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:25:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5J7P2iZ3005728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 00:25:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5J7P2563005725;
        Tue, 19 Jun 2018 00:25:02 -0700
Date:   Tue, 19 Jun 2018 00:25:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eric Dumazet <tipbot@zytor.com>
Message-ID: <tip-4a5f4d2f891bcff7285b5f7490ed5a7a5d516049@git.kernel.org>
Cc:     jdorfman@google.com, hpa@zytor.com, edumazet@google.com,
        eric.dumazet@gmail.com, mingo@kernel.org, willemb@google.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: eric.dumazet@gmail.com, edumazet@google.com, hpa@zytor.com,
          jdorfman@google.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, willemb@google.com, mingo@kernel.org
In-Reply-To: <20180618125612.155057-1-edumazet@google.com>
References: <20180618125612.155057-1-edumazet@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Use rcu in kstat_irqs_usr()
Git-Commit-ID: 4a5f4d2f891bcff7285b5f7490ed5a7a5d516049
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4a5f4d2f891bcff7285b5f7490ed5a7a5d516049
Gitweb:     https://git.kernel.org/tip/4a5f4d2f891bcff7285b5f7490ed5a7a5d516049
Author:     Eric Dumazet <edumazet@google.com>
AuthorDate: Mon, 18 Jun 2018 05:56:12 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 19 Jun 2018 09:19:40 +0200

genirq: Use rcu in kstat_irqs_usr()

Jeremy Dorfman identified mutex contention when multiple threads
parse /proc/stat concurrently.

Since commit 425a5072dcd1 ("genirq: Free irq_desc with rcu"),
kstat_irqs_usr() can be switched to rcu locking, which removes this mutex
contention.

show_interrupts() case will be handled in a separate patch.

Reported-by: Jeremy Dorfman <jdorfman@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>
Link: https://lkml.kernel.org/r/20180618125612.155057-1-edumazet@google.com

---
 kernel/irq/irqdesc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index afc7f902d74a..578d0e5f1b5b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -443,6 +443,7 @@ static void free_desc(unsigned int irq)
 	 * We free the descriptor, masks and stat fields via RCU. That
 	 * allows demultiplex interrupts to do rcu based management of
 	 * the child interrupts.
+	 * This also allows us to use rcu in kstat_irqs_usr().
 	 */
 	call_rcu(&desc->rcu, delayed_free_desc);
 }
@@ -928,17 +929,17 @@ unsigned int kstat_irqs(unsigned int irq)
  * kstat_irqs_usr - Get the statistics for an interrupt
  * @irq:	The interrupt number
  *
- * Returns the sum of interrupt counts on all cpus since boot for
- * @irq. Contrary to kstat_irqs() this can be called from any
- * preemptible context. It's protected against concurrent removal of
- * an interrupt descriptor when sparse irqs are enabled.
+ * Returns the sum of interrupt counts on all cpus since boot for @irq.
+ * Contrary to kstat_irqs() this can be called from any context.
+ * It uses rcu since a concurrent removal of an interrupt descriptor is
+ * observing an rcu grace period before delayed_free_desc()/irq_kobj_release().
  */
 unsigned int kstat_irqs_usr(unsigned int irq)
 {
 	unsigned int sum;
 
-	irq_lock_sparse();
+	rcu_read_lock();
 	sum = kstat_irqs(irq);
-	irq_unlock_sparse();
+	rcu_read_unlock();
 	return sum;
 }
