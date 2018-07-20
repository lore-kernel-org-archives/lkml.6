Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8CDECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C4A20856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C4A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbeGTRbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:31:09 -0400
Received: from smtprz14.163.net ([106.3.154.247]:1339 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732826AbeGTRbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:31:09 -0400
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 5E8571C80DC0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 23:52:31 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 4EF7D1001293
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 23:52:31 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JovWPpNZc2f4 for <linux-kernel@vger.kernel.org>;
        Fri, 20 Jul 2018 23:52:30 +0800 (CST)
Received: from localhost (unknown [110.184.155.205])
        by antispam1.tom.com (Postfix) with ESMTPA id 013F01001225;
        Fri, 20 Jul 2018 23:52:29 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     robh+dt@kernel.org
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] of: irq: Add a helper function for irq_of_parse_and_map
Date:   Fri, 20 Jul 2018 23:52:21 +0800
Message-Id: <1532101941-13130-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a resource managed irq_of_parse_and_map function.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/of/irq.c       | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/of_irq.h |  7 +++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 02ad93a..947fe41 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -45,6 +45,44 @@ unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
 }
 EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 
+static void devm_irq_dispose_mapping(struct device *dev, void *res)
+{
+	irq_dispose_mapping(*(unsigned int *)res);
+}
+
+/**
+ * devm_irq_of_parse_and_map - Resource-managed irq_of_parse_and_map
+ * @dev: Device whose interrupt is to be mapped
+ * @index: Index of the interrupt to map
+ *
+ * Managed irq_of_parse_and_map. Irq mapping created by this function is
+ * automatically disposed on driver detach.
+ *
+ * RETURNS:
+ * Returns a linux irq number on success, 0 on failure.
+ */
+unsigned int devm_irq_of_parse_and_map(struct device *dev, int index)
+{
+	struct device_node *np = dev->of_node;
+	unsigned int *dr = NULL;
+	unsigned int rc = 0;
+
+	dr = devres_alloc(devm_irq_dispose_mapping, sizeof(unsigned int),
+			  GFP_KERNEL);
+	if (!dr)
+		return 0;
+
+	rc = irq_of_parse_and_map(np, index);
+	if (rc > 0) {
+		*dr = rc;
+		devres_add(dev, dr);
+	} else
+		devres_free(dr);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(devm_irq_of_parse_and_map);
+
 /**
  * of_irq_find_parent - Given a device node, find its interrupt parent node
  * @child: pointer to device node
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 1214cab..1ac26ff 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -55,6 +55,7 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
 						       u32 rid);
 extern void of_msi_configure(struct device *dev, struct device_node *np);
 u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
+extern unsigned int devm_irq_of_parse_and_map(struct device *dev, int index);
 #else
 static inline int of_irq_count(struct device_node *dev)
 {
@@ -97,6 +98,12 @@ static inline u32 of_msi_map_rid(struct device *dev,
 {
 	return rid_in;
 }
+
+static inline unsigned int devm_irq_of_parse_and_map(struct device *dev,
+						     int index)
+{
+	return 0;
+}
 #endif
 
 #if defined(CONFIG_OF_IRQ) || defined(CONFIG_SPARC)
-- 
1.9.1

