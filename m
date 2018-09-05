Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0455AC4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E1B20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E1B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeIERAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeIEQ6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:58:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05A8520870;
        Wed,  5 Sep 2018 12:28:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fxWvE-0002Ao-1s; Wed, 05 Sep 2018 08:28:36 -0400
Message-Id: <20180905122835.952828400@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Sep 2018 08:28:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 10/22] irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t
References: <20180905122754.443196118@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit c7a3334c762a9b1dd2e39cb2ded00ce66e8a06d1 ]

The its_lock lock is held while a new device is added to the list and
during setup while the CPU is booted. Even on -RT the CPU-bootup is
performed with disabled interrupts.

Make its_lock a raw_spin_lock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2ea39a83737f..e8217ebe8c1e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -148,7 +148,7 @@ static struct {
 } vpe_proxy;
 
 static LIST_HEAD(its_nodes);
-static DEFINE_SPINLOCK(its_lock);
+static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
 static struct irq_domain *its_parent;
 
@@ -1850,7 +1850,7 @@ static void its_cpu_init_collection(void)
 	struct its_node *its;
 	int cpu;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	cpu = smp_processor_id();
 
 	list_for_each_entry(its, &its_nodes, entry) {
@@ -1892,7 +1892,7 @@ static void its_cpu_init_collection(void)
 		its_send_invall(its, &its->collections[cpu]);
 	}
 
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 }
 
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
@@ -3041,9 +3041,9 @@ static int __init its_probe_one(struct resource *res,
 	if (err)
 		goto out_free_tables;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 
 	return 0;
 
-- 
2.18.0


