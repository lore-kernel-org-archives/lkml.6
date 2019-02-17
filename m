Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D27C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAECD21900
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfBQJJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:09:30 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46050 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727680AbfBQJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:09:28 -0500
X-UUID: 83494a69ade54e2aa538aafa1d61b5bc-20190217
X-UUID: 83494a69ade54e2aa538aafa1d61b5bc-20190217
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 181692658; Sun, 17 Feb 2019 17:09:23 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 17:09:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 17:09:21 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 19/22] iommu/mediatek: Add shutdown callback
Date:   Sun, 17 Feb 2019 17:04:57 +0800
Message-ID: <1550394300-17420-20-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only improve the shutdown flow. The shutdown callback will
mute the M4U HW when the system shutdown.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/iommu/mtk_iommu.c    | 6 ++++++
 drivers/iommu/mtk_iommu_v1.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b02854c..8742841 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -702,6 +702,11 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void mtk_iommu_shutdown(struct platform_device *pdev)
+{
+	mtk_iommu_remove(pdev);
+}
+
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -783,6 +788,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
 	.remove	= mtk_iommu_remove,
+	.shutdown = mtk_iommu_shutdown,
 	.driver	= {
 		.name = "mtk-iommu",
 		.of_match_table = of_match_ptr(mtk_iommu_of_ids),
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 4f15043..dd84eea 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -660,6 +660,11 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void mtk_iommu_shutdown(struct platform_device *pdev)
+{
+	mtk_iommu_remove(pdev);
+}
+
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -697,6 +702,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
 	.remove	= mtk_iommu_remove,
+	.shutdown = mtk_iommu_shutdown,
 	.driver	= {
 		.name = "mtk-iommu-v1",
 		.of_match_table = mtk_iommu_of_ids,
-- 
1.9.1

