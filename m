Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeEBBMA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:12:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42386 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEBBKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:36 -0400
X-Google-Smtp-Source: AB8JxZo5rUAciIbBztdkuB1GVOcrzYrsvJwmOXy9hgSMJkjmeGzwWwYANxW8SrDsLZWAwDmSmmHYDA==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] soc: qcom: smem: verify partition header size
Date: Tue,  1 May 2018 20:10:15 -0500
Message-Id: <20180502011019.22812-9-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add verification in qcom_smem_partition_header() that the size in a
partition's header structure matches the size in its partition table
entry.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index d52a282f7338..f1e6e4609ccb 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -737,6 +737,7 @@ qcom_smem_partition_header(struct qcom_smem *smem,
 		struct smem_ptable_entry *entry)
 {
 	struct smem_partition_header *header;
+	u32 size;
 
 	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
 
@@ -747,6 +748,13 @@ qcom_smem_partition_header(struct qcom_smem *smem,
 		return NULL;
 	}
 
+	size = le32_to_cpu(header->size);
+	if (size != le32_to_cpu(entry->size)) {
+		dev_err(smem->dev, "bad partition size (%u != %u)\n",
+			size, le32_to_cpu(entry->size));
+		return NULL;
+	}
+
 	return header;
 }
 
@@ -795,11 +803,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	if (le32_to_cpu(header->size) != le32_to_cpu(entry->size)) {
-		dev_err(smem->dev, "Global partition has invalid size\n");
-		return -EINVAL;
-	}
-
 	size = le32_to_cpu(header->offset_free_uncached);
 	if (size > le32_to_cpu(header->size)) {
 		dev_err(smem->dev,
@@ -868,12 +871,6 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		if (le32_to_cpu(header->size) != le32_to_cpu(entry->size)) {
-			dev_err(smem->dev,
-				"Partition %d has invalid size\n", i);
-			return -EINVAL;
-		}
-
 		if (le32_to_cpu(header->offset_free_uncached) > le32_to_cpu(header->size)) {
 			dev_err(smem->dev,
 				"Partition %d has invalid free pointer\n", i);
-- 
2.14.1
