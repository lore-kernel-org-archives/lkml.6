Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AE7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB982075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfAAEws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 23:52:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35546 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728425AbfAAEwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 23:52:47 -0500
X-UUID: 926d049c97d5449cac60646be8db4107-20190101
X-UUID: 926d049c97d5449cac60646be8db4107-20190101
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 345160631; Tue, 01 Jan 2019 12:52:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 12:52:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 12:52:40 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Subject: [PATCH 08/13] media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
Date:   Tue, 1 Jan 2019 12:51:11 +0800
Message-ID: <1546318276-18993-9-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU has already added the device_link between the consumer
and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
the smi-larb's pm_runtime_get_sync also be called automatically.

CC: Tiffany Lin <tiffany.lin@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  | 19 -----------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  3 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  1 -
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 38 ----------------------
 4 files changed, 61 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
index 79ca03a..90e1641 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
@@ -16,7 +16,6 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_vcodec_dec_pm.h"
 #include "mtk_vcodec_util.h"
@@ -24,7 +23,6 @@
 
 int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
 {
-	struct device_node *node;
 	struct platform_device *pdev;
 	struct mtk_vcodec_pm *pm;
 	int ret = 0;
@@ -32,18 +30,7 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
 	pdev = mtkdev->plat_dev;
 	pm = &mtkdev->pm;
 	pm->mtkdev = mtkdev;
-	node = of_parse_phandle(pdev->dev.of_node, "mediatek,larb", 0);
-	if (!node) {
-		mtk_v4l2_err("of_parse_phandle mediatek,larb fail!");
-		return -1;
-	}
 
-	pdev = of_find_device_by_node(node);
-	if (WARN_ON(!pdev)) {
-		of_node_put(node);
-		return -1;
-	}
-	pm->larbvdec = &pdev->dev;
 	pdev = mtkdev->plat_dev;
 	pm->dev = &pdev->dev;
 
@@ -181,16 +168,10 @@ void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
 	ret = clk_set_parent(pm->vdec_sel, pm->vdecpll);
 	if (ret)
 		mtk_v4l2_err("clk_set_parent vdec_sel vdecpll fail %d", ret);
-
-	ret = mtk_smi_larb_get(pm->larbvdec);
-	if (ret)
-		mtk_v4l2_err("mtk_smi_larb_get larbvdec fail %d", ret);
-
 }
 
 void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
 {
-	mtk_smi_larb_put(pm->larbvdec);
 	clk_disable_unprepare(pm->vdec_sel);
 	clk_disable_unprepare(pm->vdecpll);
 	clk_disable_unprepare(pm->univpll_d2);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index 3cffb38..2696e14 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -191,9 +191,6 @@ struct mtk_vcodec_pm {
 	struct clk	*venc_sel;
 	struct clk	*univpll1_d2;
 	struct clk	*venc_lt_sel;
-	struct device	*larbvdec;
-	struct device	*larbvenc;
-	struct device	*larbvenclt;
 	struct device	*dev;
 	struct mtk_vcodec_dev	*mtkdev;
 };
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 54631ad..7401619 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -16,7 +16,6 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 3e73e9d..a3abd3d 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -16,7 +16,6 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_util.h"
@@ -25,7 +24,6 @@
 
 int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 {
-	struct device_node *node;
 	struct platform_device *pdev;
 	struct device *dev;
 	struct mtk_vcodec_pm *pm;
@@ -38,31 +36,6 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 	pm->dev = &pdev->dev;
 	dev = &pdev->dev;
 
-	node = of_parse_phandle(dev->of_node, "mediatek,larb", 0);
-	if (!node) {
-		mtk_v4l2_err("no mediatek,larb found");
-		return -1;
-	}
-	pdev = of_find_device_by_node(node);
-	if (!pdev) {
-		mtk_v4l2_err("no mediatek,larb device found");
-		return -1;
-	}
-	pm->larbvenc = &pdev->dev;
-
-	node = of_parse_phandle(dev->of_node, "mediatek,larb", 1);
-	if (!node) {
-		mtk_v4l2_err("no mediatek,larb found");
-		return -1;
-	}
-
-	pdev = of_find_device_by_node(node);
-	if (!pdev) {
-		mtk_v4l2_err("no mediatek,larb device found");
-		return -1;
-	}
-
-	pm->larbvenclt = &pdev->dev;
 	pdev = mtkdev->plat_dev;
 	pm->dev = &pdev->dev;
 
@@ -117,21 +90,10 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 	ret = clk_set_parent(pm->venc_lt_sel, pm->univpll1_d2);
 	if (ret)
 		mtk_v4l2_err("clk_set_parent fail %d", ret);
-
-	ret = mtk_smi_larb_get(pm->larbvenc);
-	if (ret)
-		mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
-
-	ret = mtk_smi_larb_get(pm->larbvenclt);
-	if (ret)
-		mtk_v4l2_err("mtk_smi_larb_get larb4 fail %d", ret);
-
 }
 
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
 {
-	mtk_smi_larb_put(pm->larbvenc);
-	mtk_smi_larb_put(pm->larbvenclt);
 	clk_disable_unprepare(pm->venc_lt_sel);
 	clk_disable_unprepare(pm->venc_sel);
 }
-- 
1.9.1

