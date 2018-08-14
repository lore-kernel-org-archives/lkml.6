Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BABC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1417D21709
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1417D21709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbeHNSpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:45:35 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:55684 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731882AbeHNSpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:45:34 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 05DD0CD5B;
        Tue, 14 Aug 2018 18:57:49 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH] media: camss: Use managed memory allocations
Date:   Tue, 14 Aug 2018 18:57:35 +0300
Message-Id: <1534262255-32270-1-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use managed memory allocations for structs which are used until
the driver is removed.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-ispif.c |  4 ++--
 drivers/media/platform/qcom/camss/camss.c       | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index 7f26902..ca7b091 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -1076,8 +1076,8 @@ int msm_ispif_subdev_init(struct ispif_device *ispif,
 	else
 		return -EINVAL;
 
-	ispif->line = kcalloc(ispif->line_num, sizeof(*ispif->line),
-			      GFP_KERNEL);
+	ispif->line = devm_kcalloc(dev, ispif->line_num, sizeof(*ispif->line),
+				   GFP_KERNEL);
 	if (!ispif->line)
 		return -ENOMEM;
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index dcc0c30..3304f7a 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -848,17 +848,18 @@ static int camss_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	camss->csiphy = kcalloc(camss->csiphy_num, sizeof(*camss->csiphy),
-				GFP_KERNEL);
+	camss->csiphy = devm_kcalloc(dev, camss->csiphy_num,
+				     sizeof(*camss->csiphy), GFP_KERNEL);
 	if (!camss->csiphy)
 		return -ENOMEM;
 
-	camss->csid = kcalloc(camss->csid_num, sizeof(*camss->csid),
-			      GFP_KERNEL);
+	camss->csid = devm_kcalloc(dev, camss->csid_num, sizeof(*camss->csid),
+				   GFP_KERNEL);
 	if (!camss->csid)
 		return -ENOMEM;
 
-	camss->vfe = kcalloc(camss->vfe_num, sizeof(*camss->vfe), GFP_KERNEL);
+	camss->vfe = devm_kcalloc(dev, camss->vfe_num, sizeof(*camss->vfe),
+				  GFP_KERNEL);
 	if (!camss->vfe)
 		return -ENOMEM;
 
-- 
2.7.4

