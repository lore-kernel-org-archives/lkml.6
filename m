Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeBALAy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:00:54 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42784 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeBALAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:00:51 -0500
X-Google-Smtp-Source: AH8x2254hnUBhB4NH/HMGPnnRlb3YMnpH/a3JBypU5Q7fso9SQhAySr1/fDpkpw6p5UHxsXKbe+1oQ==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: matthias.bgg@gmail.com
Cc: mars.cheng@mediatek.com, weiyi.lu@mediatek.com, ulf.hansson@linaro.org,
        kevin-cw.chen@mediatek.com, sean.wang@mediatek.com,
        geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] soc: mediatek: Handle return of of_match_device function
Date: Thu,  1 Feb 2018 16:30:22 +0530
Message-Id: <1517482822-28758-1-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In scpsys_probe function, return value of of_match_device function which
returns null is dereferenced without checking. Therefore, add a check for
potential null dereference.

Detected by CoverityScan, CID#1424087 "Dereference null return value"

Fixes: commit 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 435ce5e..6e7f196 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -981,6 +981,9 @@ static int scpsys_probe(struct platform_device *pdev)
 	int i, ret;
 
 	match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
+	if (!match)
+		return -EINVAL;
+
 	soc = (const struct scp_soc_data *)match->data;
 
 	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
-- 
2.7.4
