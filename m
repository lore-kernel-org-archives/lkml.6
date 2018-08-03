Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB30AC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90082216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90082216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeHCFFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:05:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13583 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727182AbeHCFFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:05:36 -0400
X-UUID: 06669314419a45fb854741bfd7f93bc9-20180803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1511857809; Fri, 03 Aug 2018 11:11:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 11:11:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 11:11:13 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v2 10/15] drm/mediatek: add function to get layer number for component
Date:   Fri, 3 Aug 2018 11:11:03 +0800
Message-ID: <1533265868-28110-11-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add function to get layer number for component

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index a1988ce15141..8377e4f9ce3d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -78,6 +78,7 @@ struct mtk_ddp_comp_funcs {
 	void (*stop)(struct mtk_ddp_comp *comp);
 	void (*enable_vblank)(struct mtk_ddp_comp *comp, struct drm_crtc *crtc);
 	void (*disable_vblank)(struct mtk_ddp_comp *comp);
+	unsigned int (*layer_nr)(struct mtk_ddp_comp *comp);
 	void (*layer_on)(struct mtk_ddp_comp *comp, unsigned int idx);
 	void (*layer_off)(struct mtk_ddp_comp *comp, unsigned int idx);
 	void (*layer_config)(struct mtk_ddp_comp *comp, unsigned int idx,
@@ -129,6 +130,12 @@ static inline void mtk_ddp_comp_disable_vblank(struct mtk_ddp_comp *comp)
 		comp->funcs->disable_vblank(comp);
 }
 
+static inline unsigned int mtk_ddp_comp_layer_nr(struct mtk_ddp_comp *comp)
+{
+	if (comp->funcs && comp->funcs->layer_nr)
+		return comp->funcs->layer_nr(comp);
+}
+
 static inline void mtk_ddp_comp_layer_on(struct mtk_ddp_comp *comp,
 					 unsigned int idx)
 {
-- 
2.12.5.2.gbdf23ab

