Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7757C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9112170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9112170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeHCFFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:05:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37586 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727532AbeHCFFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:05:38 -0400
X-UUID: 11b4f0b076134762b1141e85e09a1d9f-20180803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1687820583; Fri, 03 Aug 2018 11:11:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 11:11:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 11:11:14 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v2 11/15] drm/mediatek: add callback function to return OVL layer number
Date:   Fri, 3 Aug 2018 11:11:04 +0800
Message-ID: <1533265868-28110-12-git-send-email-stu.hsieh@mediatek.com>
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

This patch add callback function to return OVL layer number

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 978782a77629..a42cfa057f42 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -58,6 +58,7 @@
 struct mtk_disp_ovl_data {
 	unsigned int addr;
 	bool fmt_rgb565_is_0;
+	unsigned int layer_nr;
 };
 
 /**
@@ -132,6 +133,13 @@ static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
 	writel(0x0, comp->regs + DISP_REG_OVL_RST);
 }
 
+static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
+{
+	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
+
+	return ovl->data->layer_nr;
+}
+
 static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
 {
 	unsigned int reg;
@@ -221,6 +229,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_ovl_funcs = {
 	.stop = mtk_ovl_stop,
 	.enable_vblank = mtk_ovl_enable_vblank,
 	.disable_vblank = mtk_ovl_disable_vblank,
+	.layer_nr = mtk_ovl_layer_nr,
 	.layer_on = mtk_ovl_layer_on,
 	.layer_off = mtk_ovl_layer_off,
 	.layer_config = mtk_ovl_layer_config,
@@ -319,6 +328,7 @@ static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
 static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
 	.addr = DISP_REG_OVL_ADDR_MT8173,
 	.fmt_rgb565_is_0 = true,
+	.layer_nr = 4,
 };
 
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
-- 
2.12.5.2.gbdf23ab

