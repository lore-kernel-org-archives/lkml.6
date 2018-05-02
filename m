Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeEBBKm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:10:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36624 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeEBBKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:32 -0400
X-Google-Smtp-Source: AB8JxZoaRFaT2dD4QIX3l+wsde09VqagCqZCvWcN6yvQGqgNjtc2uMYf6Qb4zf1Tvx7PE0NNOAf03A==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] soc: qcom: smem: small refactor in qcom_smem_enumerate_partitions()
Date: Tue,  1 May 2018 20:10:11 -0500
Message-Id: <20180502011019.22812-5-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine the code that checks whether a partition table entry is
associated with the local host with the assignment of the remote
host id value.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 83ba549cfea0..5d3ed510e54b 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -815,13 +815,12 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 
 		host0 = le16_to_cpu(entry->host0);
 		host1 = le16_to_cpu(entry->host1);
-		if (host0 != local_host && host1 != local_host)
-			continue;
-
 		if (host0 == local_host)
 			remote_host = host1;
-		else
+		else if (host1 == local_host)
 			remote_host = host0;
+		else
+			continue;
 
 		if (remote_host >= SMEM_HOST_COUNT) {
 			dev_err(smem->dev,
-- 
2.14.1
