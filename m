Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeEBBLO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:11:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55629 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeEBBKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:38 -0400
X-Google-Smtp-Source: AB8JxZrYhqlzI2J1HcIQ+iN2FKS9G11vWY+96dU6H+zgkqc6Buzev5GDrMtv8dhv1u0JI4LG4J7Y/g==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] soc: qcom: smem: small change in global entry loop
Date: Tue,  1 May 2018 20:10:17 -0500
Message-Id: <20180502011019.22812-11-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the logic in the loop that finds that global host entry in
the partition table not require the host0 and host1 local variables.
The next patch will remove them.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7ef415c4d62e..54c504e41508 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -784,9 +784,10 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		if (!le32_to_cpu(entry->size))
 			continue;
 
-		host0 = le16_to_cpu(entry->host0);
-		host1 = le16_to_cpu(entry->host1);
-		if (host0 == SMEM_GLOBAL_HOST && host0 == host1) {
+		if (le16_to_cpu(entry->host0) != SMEM_GLOBAL_HOST)
+			continue;
+
+		if (le16_to_cpu(entry->host1) == SMEM_GLOBAL_HOST) {
 			found = true;
 			break;
 		}
-- 
2.14.1
