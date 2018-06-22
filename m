Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5EAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E9523FCE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E9523FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754534AbeFVJxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:53:39 -0400
Received: from foss.arm.com ([217.140.101.70]:60840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754562AbeFVJxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:53:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985AD1596;
        Fri, 22 Jun 2018 02:53:09 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671203F819;
        Fri, 22 Jun 2018 02:53:08 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 5/7] irqchip/gic-v3-its: Only emit SYNC if targetting a valid collection
Date:   Fri, 22 Jun 2018 10:52:52 +0100
Message-Id: <20180622095254.5906-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622095254.5906-1-marc.zyngier@arm.com>
References: <20180622095254.5906-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible, under obscure circumstances, to convince the ITS
driver to emit a SYNC operation that targets a collection that is
not bound to any redistributor (and the target_address field is
zero) because the corresponding CPU has not been seen yet (the
system has been booted with max_cpus="something small").

If the ITS is using the linear CPU number as the target, this is
not a big deal, as we just end-up issuing a SYNC to CPU0. But if
the ITS requires the physical address of the redistributor (with
GITS_TYPER.PTA==1), we end-up asking the ITS to write to the
physical address zero, which is not exactly a good idea (there
has been report of the ITS locking up). This should of course
never happen, but hey, this is SW...

In order to avoid the above disaster, let's track which collections
have been actually initialized, and let's not generate a SYNC
if the collection hasn't been properly bound to a redistributor.
We take this opportunity to spit our a warning, in the hope that
someone may report the issue if it arrises again.

Reported-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cae53937feeb..fcfc96f8e0de 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -182,6 +182,14 @@ static struct its_collection *dev_event_to_col(struct its_device *its_dev,
 	return its->collections + its_dev->event_map.col_map[event];
 }
 
+static struct its_collection *valid_col(struct its_collection *col)
+{
+	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(0, 15)))
+		return NULL;
+
+	return col;
+}
+
 /*
  * ITS command descriptors - parameters to be encoded in a command
  * block.
@@ -439,7 +447,7 @@ static struct its_collection *its_build_mapti_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_movi_cmd(struct its_node *its,
@@ -458,7 +466,7 @@ static struct its_collection *its_build_movi_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_discard_cmd(struct its_node *its,
@@ -476,7 +484,7 @@ static struct its_collection *its_build_discard_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_inv_cmd(struct its_node *its,
@@ -494,7 +502,7 @@ static struct its_collection *its_build_inv_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_int_cmd(struct its_node *its,
@@ -512,7 +520,7 @@ static struct its_collection *its_build_int_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_clear_cmd(struct its_node *its,
@@ -530,7 +538,7 @@ static struct its_collection *its_build_clear_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_invall_cmd(struct its_node *its,
@@ -1824,11 +1832,16 @@ static int its_alloc_tables(struct its_node *its)
 
 static int its_alloc_collections(struct its_node *its)
 {
+	int i;
+
 	its->collections = kcalloc(nr_cpu_ids, sizeof(*its->collections),
 				   GFP_KERNEL);
 	if (!its->collections)
 		return -ENOMEM;
 
+	for (i = 0; i < nr_cpu_ids; i++)
+		its->collections[i].target_address = ~0ULL;
+
 	return 0;
 }
 
-- 
2.17.1

