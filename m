Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeEBBMl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:12:41 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44286 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeEBBKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:33 -0400
X-Google-Smtp-Source: AB8JxZqBT8Xmn7E1n3PWDfJiNvL7NVst5wDfYByeOKlew6qGD98YojKP/dxMIkcLSrZVOaPZsxFWYw==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] soc: qcom: smem: verify both host ids in partition header
Date: Tue,  1 May 2018 20:10:12 -0500
Message-Id: <20180502011019.22812-6-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global partition is indicated by having both host values in its
table of contents entry equal SMEM_GLOBAL_HOST=0xfffe.

In qcom_smem_set_global_partition(), we check whether the header
structure at the beginning of the partition contains that host
value, but the check only verifies *one* of them.  Change the check
so the partition header must have SMEM_GLOBAL_HOST for *both* its
host fields.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 5d3ed510e54b..6931602d9a9e 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -769,7 +769,7 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	if (host0 != SMEM_GLOBAL_HOST && host1 != SMEM_GLOBAL_HOST) {
+	if (host0 != SMEM_GLOBAL_HOST || host1 != SMEM_GLOBAL_HOST) {
 		dev_err(smem->dev, "Global partition hosts are invalid\n");
 		return -EINVAL;
 	}
-- 
2.14.1
