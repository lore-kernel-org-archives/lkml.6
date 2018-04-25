Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754661AbeDYPSr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:18:47 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44583 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeDYPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:18:45 -0400
X-Google-Smtp-Source: AIpwx49VCF8BIUxd/5L4MAsoJwWDQwvaNJ6C1dGEH0GwfQtXvmveUNayE74LX0NZMs8gKJ+vJ9VkbQ==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: smem: introduce qcom_smem_virt_to_phys()
Date: Wed, 25 Apr 2018 10:18:20 -0500
Message-Id: <20180425151820.25595-1-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create function qcom_smem_virt_to_phys(), which returns the physical
address corresponding to a given SMEM item's virtual address.  This
feature is required for a driver that will soon be out for review.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c       | 27 +++++++++++++++++++++++++++
 include/linux/soc/qcom/smem.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7d9a43da5084..70b2ee80d6bd 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -655,6 +655,33 @@ int qcom_smem_get_free_space(unsigned host)
 }
 EXPORT_SYMBOL(qcom_smem_get_free_space);
 
+/**
+ * qcom_smem_virt_to_phys() - return the physical address associated
+ * with an smem item pointer (previously returned by qcom_smem_get()
+ * @p:	the virtual address to convert
+ *
+ * Returns 0 if the pointer provided is not within any smem region.
+ */
+phys_addr_t qcom_smem_virt_to_phys(void *p)
+{
+	unsigned i;
+
+	for (i = 0; i < __smem->num_regions; i++) {
+		struct smem_region *region = &__smem->regions[i];
+
+		if (p < region->virt_base)
+			continue;
+		if (p < region->virt_base + region->size) {
+			u64 offset = p - region->virt_base;
+
+			return (phys_addr_t)region->aux_base + offset;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_smem_virt_to_phys);
+
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
 	struct smem_header *header;
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index c1657ed27b30..86e1b358688a 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -9,4 +9,6 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
 
 int qcom_smem_get_free_space(unsigned host);
 
+phys_addr_t qcom_smem_virt_to_phys(void *p);
+
 #endif
-- 
2.14.1
