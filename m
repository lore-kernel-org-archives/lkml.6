Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75623C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280AF20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="aJ3rGtpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280AF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeGZICA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:02:00 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:40311 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbeGZICA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:02:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 36C4713F10AA3;
        Thu, 26 Jul 2018 14:49:55 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8L0M31VXV11I; Thu, 26 Jul 2018 14:49:53 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id D8C0513F10A9D;
        Thu, 26 Jul 2018 14:49:52 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai D8C0513F10A9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1532587792;
        bh=9ncMXsNDtn2OVUN0nxtTUS8bQ7wSv8wIMBnkQsgkcSg=;
        h=From:To:Subject:Date:Message-Id;
        b=aJ3rGtpxTDSNnfB3jKZ1BrhLTXQXRdro/yHOWmaMXRcMqyhc8EIoMF9VyTQAyOrEh
         OUDBgJjz4FhqRPLIUKeyO3QhSyKwWI1GnwrrXpil3OJ2J0ao4IAa3Cd9yATgCZl3k0
         Z+uC/KXioeaiwBkb3YuQDFfrSoypsDNiuMcgvx9s=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ofndkpl4iUqi; Thu, 26 Jul 2018 14:49:52 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 4BF6113F10A9A;
        Thu, 26 Jul 2018 14:49:52 +0800 (CST)
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     vkoul@kernel.org
Cc:     corbet@lwn.net, dan.j.williams@intel.com, robh@kernel.org,
        linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashutosh.dixit@intel.com,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH v2 1/2] dmaengine: add a new helper dmaenginem_async_device_register
Date:   Thu, 26 Jul 2018 14:45:53 +0800
Message-Id: <20180726064554.24975-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the dmaenginem_async_device_register for DMA code.
Use the Devres to call the release for the DMA engine driver.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
v1 --> v2:
    change the name to dmaenginem_async_device_register().
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/dma/dmaengine.c               | 35 +++++++++++++++++++++++++++
 include/linux/dmaengine.h             |  1 +
 3 files changed, 37 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index a3e8bceb5f19..15720cd17958 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -240,6 +240,7 @@ CLOCK
   devm_of_clk_add_hw_provider()
 
 DMA
+  dmaenginem_async_device_register()
   dmam_alloc_coherent()
   dmam_alloc_attrs()
   dmam_declare_coherent_memory()
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 84ac38dbdb65..fa6fdc5f2a04 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1135,6 +1135,41 @@ void dma_async_device_unregister(struct dma_device *device)
 }
 EXPORT_SYMBOL(dma_async_device_unregister);
 
+static void dmam_device_release(struct device *dev, void *res)
+{
+	struct dma_device *device;
+
+	device = *(struct dma_device **)res;
+	dma_async_device_unregister(device);
+}
+
+/**
+ * dmaenginem_async_device_register - registers DMA devices found
+ * @device: &dma_device
+ *
+ * The operation is managed and will be undone on driver detach.
+ */
+int dmaenginem_async_device_register(struct dma_device *device)
+{
+	void *p;
+	int ret;
+
+	p = devres_alloc(dmam_device_release, sizeof(void *), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	ret = dma_async_device_register(device);
+	if (!ret) {
+		*(struct dma_device **)p = device;
+		devres_add(device->dev, p);
+	} else {
+		devres_free(p);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(dmaenginem_async_device_register);
+
 struct dmaengine_unmap_pool {
 	struct kmem_cache *cache;
 	const char *name;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c8c3a7a93802..d49ec5c31944 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1406,6 +1406,7 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
 /* --- DMA device --- */
 
 int dma_async_device_register(struct dma_device *device);
+int dmaenginem_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
-- 
2.17.1

