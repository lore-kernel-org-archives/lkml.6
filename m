Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeEBBNI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:13:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44284 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEBBKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:30 -0400
X-Google-Smtp-Source: AB8JxZomTstYDyQSATDz/Q0YfaCoRdhpkZ8UzhKDYs3BdN0+PD81puxP0SgmpP3ggJVky5j8w6Fv+Q==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] soc: qcom: smem: initialize region struct only when successful
Date: Tue,  1 May 2018 20:10:09 -0500
Message-Id: <20180502011019.22812-3-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502011019.22812-1-elder@linaro.org>
References: <20180502011019.22812-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hold off initializing anything for the array entry representing a
memory region in qcom_smem_map_memory() until we know we've
successfully mapped it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c46bb43c0f3d..d8008bf480a4 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -887,6 +887,7 @@ static int qcom_smem_map_memory(struct qcom_smem *smem, struct device *dev,
 {
 	struct device_node *np;
 	struct resource r;
+	resource_size_t size;
 	int ret;
 
 	np = of_parse_phandle(dev->of_node, name, 0);
@@ -899,12 +900,13 @@ static int qcom_smem_map_memory(struct qcom_smem *smem, struct device *dev,
 	of_node_put(np);
 	if (ret)
 		return ret;
+	size = resource_size(&r);
 
-	smem->regions[i].aux_base = (u32)r.start;
-	smem->regions[i].size = resource_size(&r);
-	smem->regions[i].virt_base = devm_ioremap_wc(dev, r.start, resource_size(&r));
+	smem->regions[i].virt_base = devm_ioremap_wc(dev, r.start, size);
 	if (!smem->regions[i].virt_base)
 		return -ENOMEM;
+	smem->regions[i].aux_base = (u32)r.start;
+	smem->regions[i].size = size;
 
 	return 0;
 }
-- 
2.14.1
