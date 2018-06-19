Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283CAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E4D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E4D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757462AbeFSV2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:28:01 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:50662 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757354AbeFSV14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:27:56 -0400
Received: from localhost.localdomain (pD95EF733.dip0.t-ipconnect.de [217.94.247.51])
        by mail.bugwerft.de (Postfix) with ESMTPSA id D03D828A290;
        Tue, 19 Jun 2018 21:24:50 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH RFC 3/4] w1: core: provide helper to look up w1 slaves through devicetree nodes
Date:   Tue, 19 Jun 2018 23:27:43 +0200
Message-Id: <20180619212744.794-4-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619212744.794-1-daniel@zonque.org>
References: <20180619212744.794-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a helper called w1_of_get_slave() that allows users to refer
to w1 slave devices through phandles in devicetree nodes.

The implementation walks all master devices and all their slaves in order to
find the right slave device.

The API is stubbed out for !CONFIG_OF.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/w1/w1.c    | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/w1.h | 11 +++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index dc73d8c08438..693aa9be2cd9 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1185,6 +1185,43 @@ int w1_process(void *data)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+struct w1_slave *w1_of_get_slave(struct device_node *np,
+				 const char *name, int index)
+{
+	struct device_node *slave_node;
+	struct w1_master *master;
+	struct w1_slave *sl;
+	bool found = false;
+
+	slave_node = of_parse_phandle(np, name, index);
+	if (!slave_node)
+		return NULL;
+
+	mutex_lock(&w1_mlock);
+	list_for_each_entry(master, &w1_masters, w1_master_entry) {
+		mutex_lock(&master->list_mutex);
+		list_for_each_entry(sl, &master->slist, w1_slave_entry) {
+			if (sl->dev.of_node == slave_node) {
+				found = true;
+				break;
+			}
+		}
+		mutex_unlock(&master->list_mutex);
+
+		if (found)
+			break;
+	}
+	mutex_unlock(&w1_mlock);
+
+	if (!found)
+		return NULL;
+
+	return sl;
+}
+EXPORT_SYMBOL_GPL(w1_of_get_slave);
+#endif /* CONFIG_OF */
+
 static int __init w1_init(void)
 {
 	int retval;
diff --git a/include/linux/w1.h b/include/linux/w1.h
index 3111585c371f..c44dffe782f0 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -322,6 +322,17 @@ static inline struct w1_master* dev_to_w1_master(struct device *dev)
 	return container_of(dev, struct w1_master, dev);
 }
 
+#ifdef CONFIG_OF
+struct w1_slave *w1_of_get_slave(struct device_node *np,
+				 const char *name, int index);
+#else
+static inline struct w1_slave *w1_of_get_slave(struct device_node *np,
+					       const char *name, int index)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 #endif /* __KERNEL__ */
 
 #endif /* __LINUX_W1_H */
-- 
2.17.1

