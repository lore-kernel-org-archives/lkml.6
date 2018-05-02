Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeEBBMC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:12:02 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37753 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeEBBKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:35 -0400
X-Google-Smtp-Source: AB8JxZqz6qW57jKhVjdppIcEbvhv8SD40PkSRtZg7fq4zq+h7H0cf+WbmZ9Xt7JbEeajKqRZ6OIOHg==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] soc: qcom: smem: introduce qcom_smem_partition_header()
Date: Tue,  1 May 2018 20:10:14 -0500
Message-Id: <20180502011019.22812-8-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new function qcom_smem_partition_header() to encapsulate
validating the header information found in a partition.  This will
be built up over a few commits to make it more obvious how the
common function is replacing duplicated code elsewhere.  Initially
it just verifies the header has the right magic number.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 9e20c6b1b4c2..d52a282f7338 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -727,6 +727,29 @@ static u32 qcom_smem_get_item_count(struct qcom_smem *smem)
 	return le16_to_cpu(info->num_items);
 }
 
+/*
+ * Validate the partition header for a partition whose partition
+ * table entry is supplied.  Returns a pointer to its header if
+ * valid, or a null pointer otherwise.
+ */
+static struct smem_partition_header *
+qcom_smem_partition_header(struct qcom_smem *smem,
+		struct smem_ptable_entry *entry)
+{
+	struct smem_partition_header *header;
+
+	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
+
+	if (memcmp(header->magic, SMEM_PART_MAGIC, sizeof(header->magic))) {
+		dev_err(smem->dev, "bad partition magic %02x %02x %02x %02x\n",
+			header->magic[0], header->magic[1],
+			header->magic[2], header->magic[3]);
+		return NULL;
+	}
+
+	return header;
+}
+
 static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 {
 	struct smem_partition_header *header;
@@ -760,15 +783,13 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
+	header = qcom_smem_partition_header(smem, entry);
+	if (!header)
+		return -EINVAL;
+
 	host0 = le16_to_cpu(header->host0);
 	host1 = le16_to_cpu(header->host1);
 
-	if (memcmp(header->magic, SMEM_PART_MAGIC, sizeof(header->magic))) {
-		dev_err(smem->dev, "Global partition has invalid magic\n");
-		return -EINVAL;
-	}
-
 	if (host0 != SMEM_GLOBAL_HOST || host1 != SMEM_GLOBAL_HOST) {
 		dev_err(smem->dev, "Global partition hosts are invalid\n");
 		return -EINVAL;
@@ -836,13 +857,9 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
-		if (memcmp(header->magic, SMEM_PART_MAGIC,
-			    sizeof(header->magic))) {
-			dev_err(smem->dev,
-				"Partition %d has invalid magic\n", i);
+		header = qcom_smem_partition_header(smem, entry);
+		if (!header)
 			return -EINVAL;
-		}
 
 		if (host0 != le16_to_cpu(header->host0) ||
 				host1 != le16_to_cpu(header->host1)) {
-- 
2.14.1
