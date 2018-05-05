Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEETMW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 15:12:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50326 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbeEETMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 15:12:21 -0400
From: Andrew Lunn <andrew@lunn.ch>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, andrew.smirnov@gmail.com,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC] drivers: nvmem: Export nvmem_add_cells()
Date: Sat,  5 May 2018 21:11:47 +0200
Message-Id: <1525547507-1428-1-git-send-email-andrew@lunn.ch>
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

This is an RFC.

I have an intel platform with an AT24 EEPROM. I want to make use of
nvmem, but don't have device tree to be able to specify cells. I have
an x86 platform driver which does:

struct nvmem_cell_info nameplate_cells[] = {
       {
               .name = "checksum",
               .offset = 2,
               .bytes = 1,
       },
       {
               .name = "part_number",
               .offset = 11,
               .bytes = 11,
       },
};

       err = nvmem_add_cells(nvmem, nameplate_cells,
                             ARRAY_SIZE(nameplate_cells));
       if (err) {
               dev_err(dev, "Error adding cells to nameplate nvmem device\n");
               return;
       }

       cell = nvmem_cell_get(NULL, "checksum");


drivers/nvmem/core.c           | 15 ++++++++-------
 include/linux/nvmem-provider.h | 11 +++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b05aa8e81303..d1bd43874439 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -353,18 +353,18 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
 	return 0;
 }
 
-static int nvmem_add_cells(struct nvmem_device *nvmem,
-			   const struct nvmem_config *cfg)
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
@@ -380,7 +380,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 		nvmem_cell_add(cells[i]);
 	}
 
-	nvmem->ncells = cfg->ncells;
+	nvmem->ncells = ncells;
 	/* remove tmp array */
 	kfree(cells);
 
@@ -393,6 +393,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 
 	return rval;
 }
+EXPORT_SYMBOL_GPL(nvmem_add_cells);
 
 /*
  * nvmem_setup_compat() - Create an additional binary entry in
@@ -509,7 +510,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
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
