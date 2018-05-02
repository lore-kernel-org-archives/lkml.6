Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeEBBMh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:12:37 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34650 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeEBBKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:34 -0400
X-Google-Smtp-Source: AB8JxZoshUMe1RacY61GEkOlUvzPWaXwhsyV41fxFAHWaAyObxVelrX17iEGnEhO/JOi75rIyrHTQQ==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] soc: qcom: smem: require order of host ids to match
Date: Tue,  1 May 2018 20:10:13 -0500
Message-Id: <20180502011019.22812-7-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qcom_smem_enumerate_partitions(), we find all partitions that
have a given local host id in either its host0 or its host1 field
in the partition table entry.  We then verify that the header
structure at the start of each partition also contains the same two
host ids as is found in the table of contents.

There is no requirement that the order of the two host ids be the
same in the table of contents and in the partition header.

This patch changes that, requiring host0 to in the partition table
entry to equal host0 in the partition header structure (and similar
for the host1 values).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 6931602d9a9e..9e20c6b1b4c2 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -837,9 +837,6 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 		}
 
 		header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
-		host0 = le16_to_cpu(header->host0);
-		host1 = le16_to_cpu(header->host1);
-
 		if (memcmp(header->magic, SMEM_PART_MAGIC,
 			    sizeof(header->magic))) {
 			dev_err(smem->dev,
@@ -847,15 +844,10 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		if (host0 != local_host && host1 != local_host) {
+		if (host0 != le16_to_cpu(header->host0) ||
+				host1 != le16_to_cpu(header->host1)) {
 			dev_err(smem->dev,
-				"Partition %d hosts are invalid\n", i);
-			return -EINVAL;
-		}
-
-		if (host0 != remote_host && host1 != remote_host) {
-			dev_err(smem->dev,
-				"Partition %d hosts are invalid\n", i);
+				"Partition %d hosts don't match\n", i);
 			return -EINVAL;
 		}
 
-- 
2.14.1
