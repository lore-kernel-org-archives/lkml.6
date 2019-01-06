Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45633C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E7620859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfAFT2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:28:52 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:31704 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFT2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:28:51 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:143e:fcd5:beb7:2140])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 0AFDD13F8B7;
        Sun,  6 Jan 2019 20:28:42 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 3/8] nvmem: Add nvmem_cell_get_optional and devm_nvmem_cell_get_optional
Date:   Sun,  6 Jan 2019 20:28:15 +0100
Message-Id: <20190106192820.12558-4-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106192820.12558-1-albeu@free.fr>
References: <20190106192820.12558-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper functions to make the driver code simpler when a cell is
optional. Using these functions just return NULL when the cell doesn't
exists or if nvmem is disabled.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/nvmem/core.c           | 48 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h | 16 ++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f8c43da6f2ca..8e1b52559467 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1083,6 +1083,30 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
+/**
+ * nvmem_cell_get_optional() - Get an optional nvmem cell of device from
+ * a given id.
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: nvmem cell name to get.
+ *
+ * Return: Will be NULL if no cell with the given name is defined,
+ * an ERR_PTR() on error or a valid pointer to a struct nvmem_cell.
+ * The nvmem_cell will be freed by the nvmem_cell_put().
+ */
+struct nvmem_cell *nvmem_cell_get_optional(struct device *dev,
+					   const char *cell_id)
+{
+	struct nvmem_cell *cell;
+
+	cell = nvmem_cell_get(dev, cell_id);
+	if (IS_ERR(cell) && PTR_ERR(cell) == -ENOENT)
+		return NULL;
+
+	return cell;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_get_optional);
+
 static void devm_nvmem_cell_release(struct device *dev, void *res)
 {
 	nvmem_cell_put(*(struct nvmem_cell **)res);
@@ -1118,6 +1142,30 @@ struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_cell_get);
 
+/**
+ * devm_nvmem_cell_get() - Get an optional nvmem cell of device from
+ * a given id.
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @id: nvmem cell name id to get.
+ *
+ * Return: Will be NULL if the cell doesn't exists, an ERR_PTR() on
+ * error or a valid pointer to a struct nvmem_cell.  The nvmem_cell
+ * will be freed by the automatically once the device is freed.
+ */
+struct nvmem_cell *devm_nvmem_cell_get_optional(struct device *dev,
+						const char *cell_id)
+{
+	struct nvmem_cell *cell;
+
+	cell = devm_nvmem_cell_get(dev, cell_id);
+	if (IS_ERR(cell) && PTR_ERR(cell) == -ENOENT)
+		return NULL;
+
+	return cell;
+}
+EXPORT_SYMBOL_GPL(devm_nvmem_cell_get_optional);
+
 static int devm_nvmem_cell_match(struct device *dev, void *res, void *data)
 {
 	struct nvmem_cell **c = res;
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 312bfa5efd80..8d7bf21a9adc 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -56,7 +56,11 @@ enum {
 
 /* Cell based interface */
 struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
+struct nvmem_cell *nvmem_cell_get_optional(struct device *dev,
+					   const char *id);
 struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
+struct nvmem_cell *devm_nvmem_cell_get_optional(struct device *dev,
+						const char *id);
 void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
@@ -96,12 +100,24 @@ static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct nvmem_cell *nvmem_cell_get_optional(struct device *dev,
+							 const char *id)
+{
+	return NULL;
+}
+
 static inline struct nvmem_cell *devm_nvmem_cell_get(struct device *dev,
 						     const char *id)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct nvmem_cell *
+devm_nvmem_cell_get_optional(struct device *dev, const char *id)
+{
+	return NULL;
+}
+
 static inline void devm_nvmem_cell_put(struct device *dev,
 				       struct nvmem_cell *cell)
 {
-- 
2.19.1

