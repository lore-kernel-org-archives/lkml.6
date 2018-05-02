Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeEBBKi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:10:38 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40212 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeEBBKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:31 -0400
X-Google-Smtp-Source: AB8JxZqepSkTj+8T+TXBon5KnEzicdqmQJDcNJooaI4LXgwX/wLsid5JgRGNSIu5Gj4xTsd+R2uZRw==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] soc: qcom: smem: always ignore partitions with 0 offset or size
Date: Tue,  1 May 2018 20:10:10 -0500
Message-Id: <20180502011019.22812-4-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qcom_smem_enumerate_partitions(), any partition table entry
having a zero offset or size field is ignored.  Move those checks
earlier in the loop, because there's no sense in examining the
host fields for those entries.

Add the same checks in qcom_smem_set_global_partition(), so the
scan for the global partition skips over these invalid entries.
This allows a later check for zero size or offset once the global
entry is found to be eliminated.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index d8008bf480a4..83ba549cfea0 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -742,9 +742,13 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 
 	for (i = 0; i < le32_to_cpu(ptable->num_entries); i++) {
 		entry = &ptable->entry[i];
+		if (!le32_to_cpu(entry->offset))
+			continue;
+		if (!le32_to_cpu(entry->size))
+			continue;
+
 		host0 = le16_to_cpu(entry->host0);
 		host1 = le16_to_cpu(entry->host1);
-
 		if (host0 == SMEM_GLOBAL_HOST && host0 == host1) {
 			found = true;
 			break;
@@ -756,11 +760,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	if (!le32_to_cpu(entry->offset) || !le32_to_cpu(entry->size)) {
-		dev_err(smem->dev, "Invalid entry for global partition\n");
-		return -EINVAL;
-	}
-
 	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
 	host0 = le16_to_cpu(header->host0);
 	host1 = le16_to_cpu(header->host1);
@@ -809,18 +808,16 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 
 	for (i = 0; i < le32_to_cpu(ptable->num_entries); i++) {
 		entry = &ptable->entry[i];
+		if (!le32_to_cpu(entry->offset))
+			continue;
+		if (!le32_to_cpu(entry->size))
+			continue;
+
 		host0 = le16_to_cpu(entry->host0);
 		host1 = le16_to_cpu(entry->host1);
-
 		if (host0 != local_host && host1 != local_host)
 			continue;
 
-		if (!le32_to_cpu(entry->offset))
-			continue;
-
-		if (!le32_to_cpu(entry->size))
-			continue;
-
 		if (host0 == local_host)
 			remote_host = host1;
 		else
-- 
2.14.1
