Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB30DC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A5220833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A5220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeILLGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:06:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33518 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725881AbeILLGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:06:07 -0400
X-UUID: f235e538202b4d4288a316f88d459fd8-20180912
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 959829480; Wed, 12 Sep 2018 14:03:00 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 12 Sep 2018 14:02:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 12 Sep 2018 14:02:55 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v1 1/1] drm/mediatek: add function to match the connector and crtc
Date:   Wed, 12 Sep 2018 14:02:50 +0800
Message-ID: <1536732170-30046-2-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536732170-30046-1-git-send-email-stu.hsieh@mediatek.com>
References: <1536732170-30046-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 24DD10C6BBEE98A34316FF5EC742783176C4298690238399664AB9431FDFF5B62000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add function to match the connector and crtc

Because the connector set the possible_crtc to match the crtc.

This function would search the connector in every ddp path and
return the corresponding value for possible_crtc.

Change-Id: Id51de53b95039f8174462d483eb9bfee31b3b93b
Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 41 +++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index ff974d82a4a6..1f734b806a00 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -245,6 +245,22 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
 };
 
+static bool mtk_drm_find_comp_in_ddp(struct mtk_ddp_comp ddp_comp,
+				     const enum mtk_ddp_comp_id *path,
+				     unsigned int path_len)
+{
+	int i;
+
+	if (!path)
+		return false;
+
+	for (i = 0; i < path_len; i++)
+		if (ddp_comp.id == path[i])
+			return true;
+
+	return false;
+}
+
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type)
 {
@@ -260,6 +276,31 @@ int mtk_ddp_comp_get_id(struct device_node *node,
 	return -EINVAL;
 }
 
+unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
+						struct mtk_ddp_comp ddp_comp)
+{
+	struct mtk_drm_private *private = drm->dev_private;
+	unsigned int ret;
+
+	if (mtk_drm_find_comp_in_ddp(ddp_comp, private->data->main_path,
+				     private->data->main_len) == true) {
+		ret = BIT(0);
+	} else if (mtk_drm_find_comp_in_ddp(ddp_comp,
+					    private->data->ext_path,
+					    private->data->ext_len) == true) {
+		ret = BIT(1);
+	} else if (mtk_drm_find_comp_in_ddp(ddp_comp,
+					    private->data->third_path,
+					    private->data->third_len) == true) {
+		ret = BIT(2);
+	} else {
+		DRM_INFO("Failed to find comp in ddp table\n");
+		ret = 0;
+	}
+
+	return ret;
+}
+
 int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 		      struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id comp_id,
 		      const struct mtk_ddp_comp_funcs *funcs)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 8399229e6ad2..f882e69088b8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -166,6 +166,8 @@ static inline void mtk_ddp_gamma_set(struct mtk_ddp_comp *comp,
 		comp->funcs->gamma_set(comp, state);
 }
 
+unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
+						struct mtk_ddp_comp ddp_comp);
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type);
 int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
-- 
2.12.5.2.gbdf23ab

