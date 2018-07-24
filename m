Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C06C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3C520881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3C520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbeGXJXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:23:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11920 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388605AbeGXJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:22:46 -0400
X-UUID: 05f564d25aaf43b79acd3c3ebc0d0ad1-20180724
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 497752321; Tue, 24 Jul 2018 16:17:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 24 Jul 2018 16:17:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 24 Jul 2018 16:17:21 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v1 10/15] drm/mediatek: add drm_device in RDMA for mamory mode to reaquest buffer
Date:   Tue, 24 Jul 2018 16:17:10 +0800
Message-ID: <1532420235-22268-11-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If RDMA want to request gem buffer, it need to save the drm device.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 49edbae50167..8d41f5cd485b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -72,6 +72,7 @@ struct mtk_disp_rdma {
 	struct mtk_ddp_comp		ddp_comp;
 	struct drm_crtc			*crtc;
 	const struct mtk_disp_rdma_data	*data;
+	struct drm_device *drm_dev;
 	bool rdma_memory_mode;
 };
 
@@ -240,6 +241,7 @@ static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
 {
 	struct mtk_disp_rdma *priv = dev_get_drvdata(dev);
 	struct mtk_ddp_comp *comp = &priv->ddp_comp;
+	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
 	struct drm_device *drm_dev = data;
 	int ret;
 
@@ -250,6 +252,7 @@ static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	rdma->drm_dev = drm_dev;
 
 	comp->comp_mode = &priv->rdma_memory_mode;
 
-- 
2.12.5

