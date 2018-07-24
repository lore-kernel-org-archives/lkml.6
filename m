Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1096C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0EC20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0EC20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbeGXGcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:32:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:44216 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbeGXGcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:32:15 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6O55JLL028169;
        Tue, 24 Jul 2018 00:05:36 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/5] fsi: Prevent multiple concurrent rescans
Date:   Tue, 24 Jul 2018 15:05:19 +1000
Message-Id: <20180724050519.31920-6-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724050519.31920-1-benh@kernel.crashing.org>
References: <20180724050519.31920-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus scanning process isn't terribly good at parallel attempts
at rescanning the same bus. Let's have a per-master mutex protecting
the scanning process.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-core.c   | 16 ++++++++++++++--
 drivers/fsi/fsi-master.h |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index dea5bd48acc5..2c31563fdcae 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1203,8 +1203,14 @@ static void fsi_master_unscan(struct fsi_master *master)
 
 int fsi_master_rescan(struct fsi_master *master)
 {
+	int rc;
+
+	mutex_lock(&master->scan_lock);
 	fsi_master_unscan(master);
-	return fsi_master_scan(master);
+	rc = fsi_master_scan(master);
+	mutex_unlock(&master->scan_lock);
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(fsi_master_rescan);
 
@@ -1240,6 +1246,7 @@ int fsi_master_register(struct fsi_master *master)
 	int rc;
 	struct device_node *np;
 
+	mutex_init(&master->scan_lock);
 	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
 	dev_set_name(&master->dev, "fsi%d", master->idx);
 
@@ -1264,8 +1271,11 @@ int fsi_master_register(struct fsi_master *master)
 	}
 
 	np = dev_of_node(&master->dev);
-	if (!of_property_read_bool(np, "no-scan-on-init"))
+	if (!of_property_read_bool(np, "no-scan-on-init")) {
+		mutex_lock(&master->scan_lock);
 		fsi_master_scan(master);
+		mutex_unlock(&master->scan_lock);
+	}
 
 	return 0;
 }
@@ -1278,7 +1288,9 @@ void fsi_master_unregister(struct fsi_master *master)
 		master->idx = -1;
 	}
 
+	mutex_lock(&master->scan_lock);
 	fsi_master_unscan(master);
+	mutex_unlock(&master->scan_lock);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(fsi_master_unregister);
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index f653f75da7be..040a7d4cf717 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -18,6 +18,7 @@
 #define DRIVERS_FSI_MASTER_H
 
 #include <linux/device.h>
+#include <linux/mutex.h>
 
 /* Various protocol delays */
 #define	FSI_ECHO_DELAY_CLOCKS	16	/* Number clocks for echo delay */
@@ -59,6 +60,7 @@ struct fsi_master {
 	int		idx;
 	int		n_links;
 	int		flags;
+	struct mutex	scan_lock;
 	int		(*read)(struct fsi_master *, int link, uint8_t id,
 				uint32_t addr, void *val, size_t size);
 	int		(*write)(struct fsi_master *, int link, uint8_t id,
-- 
2.17.1

