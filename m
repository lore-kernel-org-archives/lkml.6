Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeFDUcC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:32:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35017 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeFDUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:30:44 -0400
X-Google-Smtp-Source: ADUXVKKAcetqUnwWUigZYrwGdWLIQIs/mPThNbteVrW0/GCBWnJhmv5B/BbjrWXOk/sJJSgSQflTkA==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/4] remoteproc: qcom: mdt_loader: Make the firmware authentication optional
Date: Mon,  4 Jun 2018 13:30:35 -0700
Message-Id: <20180604203038.14080-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604203038.14080-1-bjorn.andersson@linaro.org>
References: <20180604203038.14080-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

qcom_mdt_load function loads the mdt type firmware and
initialises the secure memory as well. Make the initialisation only
when requested by the caller, so that the function can be used
by self-authenticating remoteproc as well.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since RFC:
- None

 drivers/soc/qcom/mdt_loader.c       | 87 ++++++++++++++++++++---------
 include/linux/soc/qcom/mdt_loader.h |  4 ++
 2 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index dc09d7ac905f..1c488024c698 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -74,23 +74,10 @@ ssize_t qcom_mdt_get_size(const struct firmware *fw)
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_get_size);
 
-/**
- * qcom_mdt_load() - load the firmware which header is loaded as fw
- * @dev:	device handle to associate resources with
- * @fw:		firmware object for the mdt file
- * @firmware:	name of the firmware, for construction of segment file names
- * @pas_id:	PAS identifier
- * @mem_region:	allocated memory region to load firmware into
- * @mem_phys:	physical address of allocated memory region
- * @mem_size:	size of the allocated memory region
- * @reloc_base:	adjusted physical address after relocation
- *
- * Returns 0 on success, negative errno otherwise.
- */
-int qcom_mdt_load(struct device *dev, const struct firmware *fw,
-		  const char *firmware, int pas_id, void *mem_region,
-		  phys_addr_t mem_phys, size_t mem_size,
-		  phys_addr_t *reloc_base)
+static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
+			   const char *firmware, int pas_id, void *mem_region,
+			   phys_addr_t mem_phys, size_t mem_size,
+			   phys_addr_t *reloc_base, bool pas_init)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr *phdr;
@@ -121,10 +108,12 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw_name)
 		return -ENOMEM;
 
-	ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);
-	if (ret) {
-		dev_err(dev, "invalid firmware metadata\n");
-		goto out;
+	if (pas_init) {
+		ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);
+		if (ret) {
+			dev_err(dev, "invalid firmware metadata\n");
+			goto out;
+		}
 	}
 
 	for (i = 0; i < ehdr->e_phnum; i++) {
@@ -144,10 +133,13 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	}
 
 	if (relocate) {
-		ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
-		if (ret) {
-			dev_err(dev, "unable to setup relocation\n");
-			goto out;
+		if (pas_init) {
+			ret = qcom_scm_pas_mem_setup(pas_id, mem_phys,
+						     max_addr - min_addr);
+			if (ret) {
+				dev_err(dev, "unable to setup relocation\n");
+				goto out;
+			}
 		}
 
 		/*
@@ -202,7 +194,52 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 	return ret;
 }
+
+/**
+ * qcom_mdt_load() - load the firmware which header is loaded as fw
+ * @dev:	device handle to associate resources with
+ * @fw:		firmware object for the mdt file
+ * @firmware:	name of the firmware, for construction of segment file names
+ * @pas_id:	PAS identifier
+ * @mem_region:	allocated memory region to load firmware into
+ * @mem_phys:	physical address of allocated memory region
+ * @mem_size:	size of the allocated memory region
+ * @reloc_base:	adjusted physical address after relocation
+ *
+ * Returns 0 on success, negative errno otherwise.
+ */
+int qcom_mdt_load(struct device *dev, const struct firmware *fw,
+		  const char *firmware, int pas_id, void *mem_region,
+		  phys_addr_t mem_phys, size_t mem_size,
+		  phys_addr_t *reloc_base)
+{
+	return __qcom_mdt_load(dev, fw, firmware, pas_id, mem_region, mem_phys,
+			       mem_size, reloc_base, true);
+}
 EXPORT_SYMBOL_GPL(qcom_mdt_load);
 
+/**
+ * qcom_mdt_load_no_init() - load the firmware which header is loaded as fw
+ * @dev:	device handle to associate resources with
+ * @fw:		firmware object for the mdt file
+ * @firmware:	name of the firmware, for construction of segment file names
+ * @pas_id:	PAS identifier
+ * @mem_region:	allocated memory region to load firmware into
+ * @mem_phys:	physical address of allocated memory region
+ * @mem_size:	size of the allocated memory region
+ * @reloc_base:	adjusted physical address after relocation
+ *
+ * Returns 0 on success, negative errno otherwise.
+ */
+int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
+			  const char *firmware, int pas_id,
+			  void *mem_region, phys_addr_t mem_phys,
+			  size_t mem_size, phys_addr_t *reloc_base)
+{
+	return __qcom_mdt_load(dev, fw, firmware, pas_id, mem_region, mem_phys,
+			       mem_size, reloc_base, false);
+}
+EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
+
 MODULE_DESCRIPTION("Firmware parser for Qualcomm MDT format");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
index 5b98bbdabc25..944b06aefb0f 100644
--- a/include/linux/soc/qcom/mdt_loader.h
+++ b/include/linux/soc/qcom/mdt_loader.h
@@ -17,4 +17,8 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		  phys_addr_t mem_phys, size_t mem_size,
 		  phys_addr_t *reloc_base);
 
+int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
+			  const char *fw_name, int pas_id, void *mem_region,
+			  phys_addr_t mem_phys, size_t mem_size,
+			  phys_addr_t *reloc_base);
 #endif
-- 
2.17.0
