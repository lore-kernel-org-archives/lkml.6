Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbeEHWfP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:35:15 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52830 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932133AbeEHWfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:35:14 -0400
From: Andrew Lunn <andrew@lunn.ch>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2] drivers: nvmem: Export nvmem_add_cells()
Date: Wed,  9 May 2018 00:34:50 +0200
Message-Id: <1525818890-28873-1-git-send-email-andrew@lunn.ch>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all platforms use device tree. It is useful to be able to add
cells to a NVMEM device from code. Export nvmem_add_cells() so making
this possible.

This required changing the parameters a bit, so that just the cells
and the number of cells are passed, not the whole nvmem config
structure.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2: Add documentation for nvmem_add_cells()
---
 drivers/nvmem/core.c           | 24 +++++++++++++++++-------
 include/linux/nvmem-provider.h | 11 +++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b05aa8e81303..b1c95ef78544 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -353,18 +353,27 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
 	return 0;
 }
 
-static int nvmem_add_cells(struct nvmem_device *nvmem,
-			   const struct nvmem_config *cfg)
+/**
+ * nvmem_add_cells() - Add cell information to an nvmem device
+ *
+ * @nvmem: nvmem device to add cells to.
+ * @info: nvmem cell info to add to the device
+ * @ncells: number of cells in info
+ *
+ * Return: 0 or negative error code on failure.
+ */
+int nvmem_add_cells(struct nvmem_device *nvmem,
+		    const struct nvmem_cell_info *info,
+		    int ncells)
 {
 	struct nvmem_cell **cells;
-	const struct nvmem_cell_info *info = cfg->cells;
 	int i, rval;
 
-	cells = kcalloc(cfg->ncells, sizeof(*cells), GFP_KERNEL);
+	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
 	if (!cells)
 		return -ENOMEM;
 
-	for (i = 0; i < cfg->ncells; i++) {
+	for (i = 0; i < ncells; i++) {
 		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
 		if (!cells[i]) {
 			rval = -ENOMEM;
@@ -380,7 +389,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 		nvmem_cell_add(cells[i]);
 	}
 
-	nvmem->ncells = cfg->ncells;
+	nvmem->ncells = ncells;
 	/* remove tmp array */
 	kfree(cells);
 
@@ -393,6 +402,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 
 	return rval;
 }
+EXPORT_SYMBOL_GPL(nvmem_add_cells);
 
 /*
  * nvmem_setup_compat() - Create an additional binary entry in
@@ -509,7 +519,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	if (config->cells)
-		nvmem_add_cells(nvmem, config);
+		nvmem_add_cells(nvmem, config->cells, config->ncells);
 
 	return nvmem;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index f89598bc4e1c..24def6ad09bb 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -77,6 +77,9 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
 
+int nvmem_add_cells(struct nvmem_device *nvmem,
+		    const struct nvmem_cell_info *info,
+		    int ncells);
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -99,6 +102,14 @@ static inline int
 devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
 	return nvmem_unregister(nvmem);
+
+}
+
+static inline int nvmem_add_cells(struct nvmem_device *nvmem,
+				  const struct nvmem_cell_info *info,
+				  int ncells)
+{
+	return -ENOSYS;
 }
 
 #endif /* CONFIG_NVMEM */
-- 
2.17.0
