Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37457C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28DD20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="GL3J1QqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28DD20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeGYHDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:03:01 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:54187 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeGYHDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:03:01 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jul 2018 03:02:57 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id A703813DD7058;
        Wed, 25 Jul 2018 13:50:43 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bO7Uxzy5EBRM; Wed, 25 Jul 2018 13:50:43 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id E987913DD7057;
        Wed, 25 Jul 2018 13:50:42 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai E987913DD7057
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1532497843;
        bh=I7qxXPMh0Ztmk69OPZfQOO+RfUlKhwCtU08BPafJrQw=;
        h=From:To:Subject:Date:Message-Id;
        b=GL3J1QqO29bHG4BwTmPtA86NlLIH5PESJSPnlIEK8k3WyaICArBN0blYYoChIYdeP
         1utk4/xII8R+wI8TahPPzZz8u2FIqeYLVS0jOneK8N55fiGSqTd95tR7+g3KspswNh
         TfMLbk6u2k9BwxMQ1Bgi+Vb2WD8GSizl/OC5FUqs=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id snZ_IPtrycN9; Wed, 25 Jul 2018 13:50:42 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 5645613DD7052;
        Wed, 25 Jul 2018 13:50:42 +0800 (CST)
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     vkoul@kernel.org
Cc:     corbet@lwn.net, dan.j.williams@intel.com, robh@kernel.org,
        linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] dmaengine: add a new helper dmam_async_device_register
Date:   Wed, 25 Jul 2018 13:46:45 +0800
Message-Id: <20180725054645.9723-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the dmam_async_device_register for DMA code.
Use the Devres to call the release for the DMA engine driver.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/dma/dmaengine.c               | 35 +++++++++++++++++++++++++++
 include/linux/dmaengine.h             |  1 +
 3 files changed, 37 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index a3e8bceb5f19..26c6de621446 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -240,6 +240,7 @@ CLOCK
   devm_of_clk_add_hw_provider()
 
 DMA
+  dmam_async_device_register()
   dmam_alloc_coherent()
   dmam_alloc_attrs()
   dmam_declare_coherent_memory()
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 84ac38dbdb65..2477af0bdfc7 100644
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
+ * dmam_async_device_register - registers DMA devices found
+ * @device: &dma_device
+ *
+ * The operation is managed and will be undone on driver detach.
+ */
+int dmam_async_device_register(struct dma_device *device)
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
+EXPORT_SYMBOL(dmam_async_device_register);
+
 struct dmaengine_unmap_pool {
 	struct kmem_cache *cache;
 	const char *name;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c8c3a7a93802..b98bced0b98e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1406,6 +1406,7 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
 /* --- DMA device --- */
 
 int dma_async_device_register(struct dma_device *device);
+int dmam_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
-- 
2.17.1

