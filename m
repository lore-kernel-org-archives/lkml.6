Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC30ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E6E20856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E6E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbeGRQUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:20:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58821 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbeGRQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:20:45 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ffoaj-0000sh-7B; Wed, 18 Jul 2018 17:42:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t
Date:   Wed, 18 Jul 2018 17:42:04 +0200
Message-Id: <20180718154205.13704-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718154205.13704-1-bigeasy@linutronix.de>
References: <20180718154205.13704-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The its_lock lock is held while a new device is added to the list and
during setup while the CPU is booted. Even on -RT the CPU-bootup is
performed with disabled interrupts.

Make its_lock a raw_spin_lock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-=
its.c
index d7842d312d3e..a616043d25ee 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -160,7 +160,7 @@ static struct {
 } vpe_proxy;
=20
 static LIST_HEAD(its_nodes);
-static DEFINE_SPINLOCK(its_lock);
+static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
 static struct irq_domain *its_parent;
=20
@@ -1997,12 +1997,12 @@ static void its_cpu_init_collections(void)
 {
 	struct its_node *its;
=20
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
=20
 	list_for_each_entry(its, &its_nodes, entry)
 		its_cpu_init_collection(its);
=20
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 }
=20
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
@@ -3070,7 +3070,7 @@ static int its_save_disable(void)
 	struct its_node *its;
 	int err =3D 0;
=20
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	list_for_each_entry(its, &its_nodes, entry) {
 		void __iomem *base;
=20
@@ -3102,7 +3102,7 @@ static int its_save_disable(void)
 			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
 		}
 	}
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
=20
 	return err;
 }
@@ -3112,7 +3112,7 @@ static void its_restore_enable(void)
 	struct its_node *its;
 	int ret;
=20
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	list_for_each_entry(its, &its_nodes, entry) {
 		void __iomem *base;
 		int i;
@@ -3164,7 +3164,7 @@ static void its_restore_enable(void)
 		    GITS_TYPER_HCC(gic_read_typer(base + GITS_TYPER)))
 			its_cpu_init_collection(its);
 	}
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 }
=20
 static struct syscore_ops its_syscore_ops =3D {
@@ -3398,9 +3398,9 @@ static int __init its_probe_one(struct resource *res,
 	if (err)
 		goto out_free_tables;
=20
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
=20
 	return 0;
=20
--=20
2.18.0

