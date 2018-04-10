Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeDJXm1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:42:27 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42431 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeDJW0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:26:11 -0400
X-Google-Smtp-Source: AIpwx4/OPRi5UrsC0XYPB8oM2LqZR9fhke4u4fUhxyKKOym8MoTyf0AjqP1U+8BUWYjVShuhyCU5AA==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] soc: qcom: smem: fix qcom_smem_set_global_partition()
Date: Tue, 10 Apr 2018 17:25:41 -0500
Message-Id: <20180410222542.29474-6-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180410222542.29474-1-elder@linaro.org>
References: <20180410222542.29474-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is at least one entry in the partition table, but no global
entry, the qcom_smem_set_global_partition() should return an error
just like it does if there are no partition table entries.

It turns out the function still returns an error in this case, but
it waits to do so until it has mistakenly treated the last entry in
the table as if it were the global entry found.

Fix the function to return immediately if no global entry is found
in the table.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 0ed263055988..6e42599b70d4 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -698,9 +698,10 @@ static u32 qcom_smem_get_item_count(struct qcom_smem *smem)
 static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 {
 	struct smem_partition_header *header;
-	struct smem_ptable_entry *entry = NULL;
+	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
 	u32 host0, host1, size;
+	bool found = false;
 	int i;
 
 	ptable = qcom_smem_get_ptable(smem);
@@ -712,11 +713,13 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		host0 = le16_to_cpu(entry->host0);
 		host1 = le16_to_cpu(entry->host1);
 
-		if (host0 == SMEM_GLOBAL_HOST && host0 == host1)
+		if (host0 == SMEM_GLOBAL_HOST && host0 == host1) {
+			found = true;
 			break;
+		}
 	}
 
-	if (!entry) {
+	if (!found) {
 		dev_err(smem->dev, "Missing entry for global partition\n");
 		return -EINVAL;
 	}
-- 
2.14.1
