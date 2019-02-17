Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BE5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDA021A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfBQJHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:07:09 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55450 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbfBQJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:07:08 -0500
X-UUID: 8e550376c8ae42c1849d5847e9d01d07-20190217
X-UUID: 8e550376c8ae42c1849d5847e9d01d07-20190217
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1591928431; Sun, 17 Feb 2019 17:07:00 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 17:06:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 17:06:51 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        "Will Deacon" <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 03/22] memory: mtk-smi: Use a general config_port interface
Date:   Sun, 17 Feb 2019 17:04:41 +0800
Message-ID: <1550394300-17420-4-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D92796D9E122B8D3BBA5A18BAAC1D8F89FB6142A4E174207C62064ADCB3797C22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config_port of mt2712 and mt8183 are the same. Use a general
config_port interface instead.

In addition, in mt2712, larb8 and larb9 are the bdpsys larbs which
are not the normal larb, their register space are different from the
normal one. thus, we can not call the general config_port. In mt8183,
IPU0/1 and CCU connect with smi-common directly, they also are not
the normal larb. Hence, we add a "larb_direct_to_common_mask" for these
larbs which connect to smi-commmon directly.

This is also a preparing patch for adding mt8183 SMI support.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/memory/mtk-smi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 8f2d152..9fd6b3d 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -53,6 +53,7 @@ struct mtk_smi_larb_gen {
 	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *);
+	unsigned int larb_direct_to_common_mask;
 };
 
 struct mtk_smi {
@@ -176,17 +177,13 @@ void mtk_smi_larb_put(struct device *larbdev)
 	return -ENODEV;
 }
 
-static void mtk_smi_larb_config_port_mt2712(struct device *dev)
+static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 	u32 reg;
 	int i;
 
-	/*
-	 * larb 8/9 is the bdpsys larb, the iommu_en is enabled defaultly.
-	 * Don't need to set it again.
-	 */
-	if (larb->larbid == 8 || larb->larbid == 9)
+	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
 		return;
 
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
@@ -261,7 +258,8 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
 	.need_larbid = true,
-	.config_port = mtk_smi_larb_config_port_mt2712,
+	.config_port                = mtk_smi_larb_config_port_gen2_general,
+	.larb_direct_to_common_mask = BIT(8) | BIT(9),      /* bdpsys */
 };
 
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
-- 
1.9.1

