Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeDJXnI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:43:08 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54123 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752988AbeDJW0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:26:09 -0400
X-Google-Smtp-Source: AIpwx4/iJUfJBn7ACpQYZv6FyRphpbEISg+PpXjW7lavrzipJcHwNRTp+CIw2y76AqbL+iIhJf1ZqQ==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] soc: qcom: smem: byte swap values properly
Date: Tue, 10 Apr 2018 17:25:39 -0500
Message-Id: <20180410222542.29474-4-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180410222542.29474-1-elder@linaro.org>
References: <20180410222542.29474-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two places report an error when a partition header is found to
not contain the right canary value.  The error messages do not
properly byte swap the host ids.  Fix this, and adjust the format
specificier to match the 16-bit unsigned data type.

Move the error handling for a bad canary value to the end of
qcom_smem_alloc_private().  This avoids some long lines, and
reduces the distraction of handling this unexpected problem.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 3102aa94aec2..82f0908b90e1 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -365,13 +365,8 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 	cached = phdr_to_last_cached_entry(phdr);
 
 	while (hdr < end) {
-		if (hdr->canary != SMEM_PRIVATE_CANARY) {
-			dev_err(smem->dev,
-				"Found invalid canary in hosts %d:%d partition\n",
-				phdr->host0, phdr->host1);
-			return -EINVAL;
-		}
-
+		if (hdr->canary != SMEM_PRIVATE_CANARY)
+			goto bad_canary;
 		if (le16_to_cpu(hdr->item) == item)
 			return -EEXIST;
 
@@ -400,6 +395,11 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 	le32_add_cpu(&phdr->offset_free_uncached, alloc_size);
 
 	return 0;
+bad_canary:
+	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
+		le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
+
+	return -EINVAL;
 }
 
 static int qcom_smem_alloc_global(struct qcom_smem *smem,
@@ -563,8 +563,8 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 	return ERR_PTR(-ENOENT);
 
 invalid_canary:
-	dev_err(smem->dev, "Found invalid canary in hosts %d:%d partition\n",
-			phdr->host0, phdr->host1);
+	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
+			le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
 
 	return ERR_PTR(-EINVAL);
 }
-- 
2.14.1
