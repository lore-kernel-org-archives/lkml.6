Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeEBBK5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:10:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34795 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeEBBKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:40 -0400
X-Google-Smtp-Source: AB8JxZp6fqaPQqql8E8E9oGeuzME5U8cuhSXYHMyDZssp+HwQXjHWnaZCIkODynhqftOUEcg4UEHMA==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] soc: qcom: smem: a few last cleanups
Date: Tue,  1 May 2018 20:10:19 -0500
Message-Id: <20180502011019.22812-13-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains several small cleanups:
  - In qcom_smem_enumerate_partitions(), change the "local_host"
    argument to have 16 bit unsigned type
  - Also in qcom_smem_enumerate_partitions(), change the type of
    the "host0" and "host1" local variables to be u16
  - Fix error messages reporting host ids to use the right format
    specifier
  - Shorten the error messages as well, to fit on one line
  - Add a compile-time check to ensure the local host value passed
    to qcom_smem_enumerate_partitions() is in range

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7383a0e1b468..0d7f369c3f7a 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -819,14 +819,14 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	return 0;
 }
 
-static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
-					  unsigned int local_host)
+static int
+qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 {
 	struct smem_partition_header *header;
 	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
 	unsigned int remote_host;
-	u32 host0, host1;
+	u16 host0, host1;
 	int i;
 
 	ptable = qcom_smem_get_ptable(smem);
@@ -850,16 +850,12 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			continue;
 
 		if (remote_host >= SMEM_HOST_COUNT) {
-			dev_err(smem->dev,
-				"Invalid remote host %d\n",
-				remote_host);
+			dev_err(smem->dev, "bad host %hu\n", remote_host);
 			return -EINVAL;
 		}
 
 		if (smem->partitions[remote_host]) {
-			dev_err(smem->dev,
-				"Already found a partition for host %d\n",
-				remote_host);
+			dev_err(smem->dev, "duplicate host %hu\n", remote_host);
 			return -EINVAL;
 		}
 
@@ -956,6 +952,7 @@ static int qcom_smem_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(SMEM_HOST_APPS >= SMEM_HOST_COUNT);
 	ret = qcom_smem_enumerate_partitions(smem, SMEM_HOST_APPS);
 	if (ret < 0 && ret != -ENOENT)
 		return ret;
-- 
2.14.1
