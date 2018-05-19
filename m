Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeESUKs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 16:10:48 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37645 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752322AbeESUKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 16:10:46 -0400
From: Andrew Lunn <andrew@lunn.ch>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] drivers: nvmem: Add u16 and u8 accessors
Date: Sat, 19 May 2018 22:10:14 +0200
Message-Id: <1526760614-15508-1-git-send-email-andrew@lunn.ch>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvmem core exports and accessor for getting a u32 from a cell.
Add similar accessors for u16 and u8.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/nvmem/core.c           | 74 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h | 14 +++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b1c95ef78544..61fd5810f805 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1216,6 +1216,80 @@ int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
 
+/**
+ * nvmem_cell_read_u16() - Read a cell value as an u16
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: Name of nvmem cell to read.
+ * @val: pointer to output value.
+ *
+ * Return: 0 on success or negative errno.
+ */
+int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, cell_id);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR(buf)) {
+		nvmem_cell_put(cell);
+		return PTR_ERR(buf);
+	}
+	if (len != sizeof(*val)) {
+		kfree(buf);
+		nvmem_cell_put(cell);
+		return -EINVAL;
+	}
+	memcpy(val, buf, sizeof(*val));
+
+	kfree(buf);
+	nvmem_cell_put(cell);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
+
+/**
+ * nvmem_cell_read_u8() - Read a cell value as an u8
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: Name of nvmem cell to read.
+ * @val: pointer to output value.
+ *
+ * Return: 0 on success or negative errno.
+ */
+int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, cell_id);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR(buf)) {
+		nvmem_cell_put(cell);
+		return PTR_ERR(buf);
+	}
+	if (len != sizeof(*val)) {
+		kfree(buf);
+		nvmem_cell_put(cell);
+		return -EINVAL;
+	}
+	memcpy(val, buf, sizeof(*val));
+
+	kfree(buf);
+	nvmem_cell_put(cell);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_read_u8);
+
 /**
  * nvmem_device_cell_read() - Read a given nvmem device and cell
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 4e85447f7860..927d964a6358 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -39,6 +39,8 @@ void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
+int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
+int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
 
 /* direct nvmem device read/write interface */
 struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
@@ -95,6 +97,18 @@ static inline int nvmem_cell_read_u32(struct device *dev,
 	return -ENOSYS;
 }
 
+static inline int nvmem_cell_read_u16(struct device *dev,
+				      const char *cell_id, u16 *val)
+{
+	return -ENOSYS;
+}
+
+static inline int nvmem_cell_read_u8(struct device *dev,
+				     const char *cell_id, u8 *val)
+{
+	return -ENOSYS;
+}
+
 static inline struct nvmem_device *nvmem_device_get(struct device *dev,
 						    const char *name)
 {
-- 
2.17.0
