Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDFCC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835BD241DB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835BD241DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeFVMa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:30:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeFVMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:30:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCUldJ067521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:30:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCUlEA067518;
        Fri, 22 Jun 2018 05:30:47 -0700
Date:   Fri, 22 Jun 2018 05:30:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eric Dumazet <tipbot@zytor.com>
Message-ID: <tip-74bdf7815dfb3805a37b0bba615814063a227bf5@git.kernel.org>
Cc:     mingo@kernel.org, edumazet@google.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com, hpa@zytor.com
Reply-To: edumazet@google.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          eric.dumazet@gmail.com
In-Reply-To: <20180620150332.163320-1-edumazet@google.com>
References: <20180620150332.163320-1-edumazet@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Speedup show_interrupts()
Git-Commit-ID: 74bdf7815dfb3805a37b0bba615814063a227bf5
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

Commit-ID:  74bdf7815dfb3805a37b0bba615814063a227bf5
Gitweb:     https://git.kernel.org/tip/74bdf7815dfb3805a37b0bba615814063a227bf5
Author:     Eric Dumazet <edumazet@google.com>
AuthorDate: Wed, 20 Jun 2018 08:03:32 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:22:58 +0200

genirq: Speedup show_interrupts()

Since commit 425a5072dcd1 ("genirq: Free irq_desc with rcu"),
show_interrupts() can be switched to rcu locking, which removes possible
contention on sparse_irq_lock.

The per_cpu count scan and print can be done without holding desc spinlock.

And there is no need to call kstat_irqs_cpu() and abuse irq_to_desc() while
holding rcu read lock, since desc and desc->kstat_irqs wont disappear or
change.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Link: https://lkml.kernel.org/r/20180620150332.163320-1-edumazet@google.com

---
 kernel/irq/proc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 37eda10f5c36..da9addb8d655 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -475,22 +475,24 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 	}
 
-	irq_lock_sparse();
+	rcu_read_lock();
 	desc = irq_to_desc(i);
 	if (!desc)
 		goto outsparse;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	for_each_online_cpu(j)
-		any_count |= kstat_irqs_cpu(i, j);
-	action = desc->action;
-	if ((!action || irq_desc_is_chained(desc)) && !any_count)
-		goto out;
+	if (desc->kstat_irqs)
+		for_each_online_cpu(j)
+			any_count |= *per_cpu_ptr(desc->kstat_irqs, j);
+
+	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
+		goto outsparse;
 
 	seq_printf(p, "%*d: ", prec, i);
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
+		seq_printf(p, "%10u ", desc->kstat_irqs ?
+					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
 
+	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
 		if (desc->irq_data.chip->irq_print_chip)
 			desc->irq_data.chip->irq_print_chip(&desc->irq_data, p);
@@ -511,6 +513,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (desc->name)
 		seq_printf(p, "-%-8s", desc->name);
 
+	action = desc->action;
 	if (action) {
 		seq_printf(p, "  %s", action->name);
 		while ((action = action->next) != NULL)
@@ -518,10 +521,9 @@ int show_interrupts(struct seq_file *p, void *v)
 	}
 
 	seq_putc(p, '\n');
-out:
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 outsparse:
-	irq_unlock_sparse();
+	rcu_read_unlock();
 	return 0;
 }
 #endif
