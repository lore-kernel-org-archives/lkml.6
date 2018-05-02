Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeEBBLy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:11:54 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40990 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeEBBKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:37 -0400
X-Google-Smtp-Source: AB8JxZrqLY/qBBAxkc24FzexBU1NRy3DZDJFEp+FpdF83ZZdV1MUvoo6YKbttxo+xSxpr24O7NBfBg==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] soc: qcom: smem: verify partition offset_free_uncached
Date: Tue,  1 May 2018 20:10:16 -0500
Message-Id: <20180502011019.22812-10-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add verification in qcom_smem_partition_header() that the
offset_free_uncached field in a partition's header structure does
not exceed the partition's size.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index f1e6e4609ccb..7ef415c4d62e 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -755,6 +755,12 @@ qcom_smem_partition_header(struct qcom_smem *smem,
 		return NULL;
 	}
 
+	if (le32_to_cpu(header->offset_free_uncached) > size) {
+		dev_err(smem->dev, "bad partition free uncached (%u > %u)\n",
+			le32_to_cpu(header->offset_free_uncached), size);
+		return NULL;
+	}
+
 	return header;
 }
 
@@ -763,7 +769,7 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	struct smem_partition_header *header;
 	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
-	u32 host0, host1, size;
+	u32 host0, host1;
 	bool found = false;
 	int i;
 
@@ -803,13 +809,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	size = le32_to_cpu(header->offset_free_uncached);
-	if (size > le32_to_cpu(header->size)) {
-		dev_err(smem->dev,
-			"Global partition has invalid free pointer\n");
-		return -EINVAL;
-	}
-
 	smem->global_partition = header;
 	smem->global_cacheline = le32_to_cpu(entry->cacheline);
 
@@ -871,12 +870,6 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		if (le32_to_cpu(header->offset_free_uncached) > le32_to_cpu(header->size)) {
-			dev_err(smem->dev,
-				"Partition %d has invalid free pointer\n", i);
-			return -EINVAL;
-		}
-
 		smem->partitions[remote_host] = header;
 		smem->cacheline[remote_host] = le32_to_cpu(entry->cacheline);
 	}
-- 
2.14.1
