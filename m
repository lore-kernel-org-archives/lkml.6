Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeEBBLL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:11:11 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55628 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeEBBKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:39 -0400
X-Google-Smtp-Source: AB8JxZorXSddS93FoJJTGGDTdbq/J30HAjb4zyU6yySXoq35mHyJwnkVBQZkXQij3CeLsuC/ARXx/A==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] soc: qcom: smem: verify partition host ids match
Date: Tue,  1 May 2018 20:10:18 -0500
Message-Id: <20180502011019.22812-12-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add verification in qcom_smem_partition_header() that the host ids
found in a partition's header structure match those in its partition
table entry.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 54c504e41508..7383a0e1b468 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -734,7 +734,7 @@ static u32 qcom_smem_get_item_count(struct qcom_smem *smem)
  */
 static struct smem_partition_header *
 qcom_smem_partition_header(struct qcom_smem *smem,
-		struct smem_ptable_entry *entry)
+		struct smem_ptable_entry *entry, u16 host0, u16 host1)
 {
 	struct smem_partition_header *header;
 	u32 size;
@@ -748,6 +748,17 @@ qcom_smem_partition_header(struct qcom_smem *smem,
 		return NULL;
 	}
 
+	if (host0 != le16_to_cpu(header->host0)) {
+		dev_err(smem->dev, "bad host0 (%hu != %hu)\n",
+				host0, le16_to_cpu(header->host0));
+		return NULL;
+	}
+	if (host1 != le16_to_cpu(header->host1)) {
+		dev_err(smem->dev, "bad host1 (%hu != %hu)\n",
+				host1, le16_to_cpu(header->host1));
+		return NULL;
+	}
+
 	size = le32_to_cpu(header->size);
 	if (size != le32_to_cpu(entry->size)) {
 		dev_err(smem->dev, "bad partition size (%u != %u)\n",
@@ -769,7 +780,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	struct smem_partition_header *header;
 	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
-	u32 host0, host1;
 	bool found = false;
 	int i;
 
@@ -798,18 +808,11 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	header = qcom_smem_partition_header(smem, entry);
+	header = qcom_smem_partition_header(smem, entry,
+				SMEM_GLOBAL_HOST, SMEM_GLOBAL_HOST);
 	if (!header)
 		return -EINVAL;
 
-	host0 = le16_to_cpu(header->host0);
-	host1 = le16_to_cpu(header->host1);
-
-	if (host0 != SMEM_GLOBAL_HOST || host1 != SMEM_GLOBAL_HOST) {
-		dev_err(smem->dev, "Global partition hosts are invalid\n");
-		return -EINVAL;
-	}
-
 	smem->global_partition = header;
 	smem->global_cacheline = le32_to_cpu(entry->cacheline);
 
@@ -860,17 +863,10 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		header = qcom_smem_partition_header(smem, entry);
+		header = qcom_smem_partition_header(smem, entry, host0, host1);
 		if (!header)
 			return -EINVAL;
 
-		if (host0 != le16_to_cpu(header->host0) ||
-				host1 != le16_to_cpu(header->host1)) {
-			dev_err(smem->dev,
-				"Partition %d hosts don't match\n", i);
-			return -EINVAL;
-		}
-
 		smem->partitions[remote_host] = header;
 		smem->cacheline[remote_host] = le32_to_cpu(entry->cacheline);
 	}
-- 
2.14.1
