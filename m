Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753090AbeDJW0R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 18:26:17 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37308 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbeDJW0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:26:12 -0400
X-Google-Smtp-Source: AIpwx4+Y54vX/U1iEoRXbGWQ3Imz2NloPOx0lqvp7RLEbo6s7SItHz+7wbFsHXy3BLS3YUYvG4AhVA==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] soc: qcom: smem: check sooner in qcom_smem_set_global_partition()
Date: Tue, 10 Apr 2018 17:25:42 -0500
Message-Id: <20180410222542.29474-7-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180410222542.29474-1-elder@linaro.org>
References: <20180410222542.29474-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no sense in scanning the partition table again if we know
the global partition has already been discovered.  Check for a
non-null global_partition pointer in qcom_smem_set_global_partition()
immediately.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 6e42599b70d4..7d9a43da5084 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -364,6 +364,11 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 	end = phdr_to_last_uncached_entry(phdr);
 	cached = phdr_to_last_cached_entry(phdr);
 
+	if (smem->global_partition) {
+		dev_err(smem->dev, "Already found the global partition\n");
+		return -EINVAL;
+	}
+
 	while (hdr < end) {
 		if (hdr->canary != SMEM_PRIVATE_CANARY)
 			goto bad_canary;
@@ -729,11 +734,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	if (smem->global_partition) {
-		dev_err(smem->dev, "Already found the global partition\n");
-		return -EINVAL;
-	}
-
 	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
 	host0 = le16_to_cpu(header->host0);
 	host1 = le16_to_cpu(header->host1);
-- 
2.14.1
