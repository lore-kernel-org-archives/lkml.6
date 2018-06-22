Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4CAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763BE241CD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763BE241CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeFVM1V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:27:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44827 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeFVM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:27:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCR39d066765
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:27:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCR3ZI066762;
        Fri, 22 Jun 2018 05:27:03 -0700
Date:   Fri, 22 Jun 2018 05:27:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-83559b47cdc4d396fc1187a13b527d01b55e0fe6@git.kernel.org>
Cc:     mingo@kernel.org, jason@lakedaemon.net, sumit.garg@linaro.org,
        yangyingliang@huawei.com, tglx@linutronix.de, marc.zyngier@arm.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          alexandre.belloni@bootlin.com, marc.zyngier@arm.com,
          tglx@linutronix.de, yangyingliang@huawei.com,
          sumit.garg@linaro.org, mingo@kernel.org, jason@lakedaemon.net
In-Reply-To: <20180622095254.5906-6-marc.zyngier@arm.com>
References: <20180622095254.5906-6-marc.zyngier@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/gic-v3-its: Only emit SYNC if targetting a
 valid collection
Git-Commit-ID: 83559b47cdc4d396fc1187a13b527d01b55e0fe6
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

Commit-ID:  83559b47cdc4d396fc1187a13b527d01b55e0fe6
Gitweb:     https://git.kernel.org/tip/83559b47cdc4d396fc1187a13b527d01b55e0fe6
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Fri, 22 Jun 2018 10:52:52 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:22:01 +0200

irqchip/gic-v3-its: Only emit SYNC if targetting a valid collection

It is possible, under obscure circumstances, to convince the ITS driver to
emit a SYNC operation that targets a collection that is not bound to any
redistributor (and the target_address field is zero) because the
corresponding CPU has not been seen yet (the system has been booted with
max_cpus="something small").

If the ITS is using the linear CPU number as the target, this is not a big
deal, as we just end-up issuing a SYNC to CPU0. But if the ITS requires the
physical address of the redistributor (with GITS_TYPER.PTA==1), we end-up
asking the ITS to write to the physical address zero, which is not exactly
a good idea (there has been report of the ITS locking up). This should of
course never happen, but hey, this is SW...

In order to avoid the above disaster, let's track which collections have
been actually initialized, and let's not generate a SYNC if the collection
hasn't been properly bound to a redistributor.  Take this opportunity to
spit our a warning, in the hope that someone may report the issue if it
arrises again.

Reported-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Link: https://lkml.kernel.org/r/20180622095254.5906-6-marc.zyngier@arm.com

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
 
