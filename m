Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3850C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E25320693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E25320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757465AbeFSV2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:28:25 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:50674 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966934AbeFSV15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:27:57 -0400
Received: from localhost.localdomain (pD95EF733.dip0.t-ipconnect.de [217.94.247.51])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 2BFF628A295;
        Tue, 19 Jun 2018 21:24:51 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH RFC 4/4] w1: ds2760: add devicetree matching glue
Date:   Tue, 19 Jun 2018 23:27:44 +0200
Message-Id: <20180619212744.794-5-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619212744.794-1-daniel@zonque.org>
References: <20180619212744.794-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an id table for ds2760 so it can be matched by the core.

Also, refrain from allocating the platform device for the supply driver at
runtime when the device was matched via DT, because in this case, supply
devices are also probed with device tree nodes, so they will always be
present.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/w1/slaves/w1_ds2760.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2760.c b/drivers/w1/slaves/w1_ds2760.c
index 26168abfb8b8..a737a96204ed 100644
--- a/drivers/w1/slaves/w1_ds2760.c
+++ b/drivers/w1/slaves/w1_ds2760.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/idr.h>
 #include <linux/gfp.h>
+#include <linux/of.h>
 
 #include <linux/w1.h>
 
@@ -131,6 +132,9 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 	int ret;
 	struct platform_device *pdev;
 
+	if (sl->dev.of_node)
+		return 0;
+
 	pdev = platform_device_alloc("ds2760-battery", PLATFORM_DEVID_AUTO);
 	if (!pdev)
 		return -ENOMEM;
@@ -154,9 +158,17 @@ static void w1_ds2760_remove_slave(struct w1_slave *sl)
 {
 	struct platform_device *pdev = dev_get_drvdata(&sl->dev);
 
-	platform_device_unregister(pdev);
+	if (!sl->dev.of_node)
+		platform_device_unregister(pdev);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id w1_ds2760_of_ids[] = {
+	{ .compatible = "maxim,w1-ds2760" },
+	{}
+};
+#endif
+
 static struct w1_family_ops w1_ds2760_fops = {
 	.add_slave    = w1_ds2760_add_slave,
 	.remove_slave = w1_ds2760_remove_slave,
@@ -166,6 +178,7 @@ static struct w1_family_ops w1_ds2760_fops = {
 static struct w1_family w1_ds2760_family = {
 	.fid = W1_FAMILY_DS2760,
 	.fops = &w1_ds2760_fops,
+	.of_match_table = of_match_ptr(w1_ds2760_of_ids),
 };
 module_w1_family(w1_ds2760_family);
 
-- 
2.17.1

