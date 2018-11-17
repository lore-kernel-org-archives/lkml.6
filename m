Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DF4C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418892086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418892086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbeKQMwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:52:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21247 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729714AbeKQMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:52:10 -0500
X-UUID: fa391111206f4861a82d1358d6c383d4-20181117
X-UUID: fa391111206f4861a82d1358d6c383d4-20181117
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1968481091; Sat, 17 Nov 2018 10:37:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 17 Nov 2018 10:37:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 17 Nov 2018 10:37:00 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v3 03/15] memory: mtk-smi: Use a general config_port interface
Date:   Sat, 17 Nov 2018 10:35:30 +0800
Message-ID: <1542422142-30688-4-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D016561B32725CC421D6A2A756D2EF2D94AF1319A457EAF092E01F5FA825F0162000:8
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
the normal larb. Hence, we add a "larb_special_mask" for these special
larbs.

This is also a prepare patch for adding mt8183 SMI support.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 8f2d152..e37e54b 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -53,6 +53,7 @@ struct mtk_smi_larb_gen {
 	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *);
+	unsigned int larb_special_mask; /* The special larbs mask. */
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
+	if (BIT(larb->larbid) & larb->larb_gen->larb_special_mask)
 		return;
 
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
@@ -261,7 +258,8 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
 	.need_larbid = true,
-	.config_port = mtk_smi_larb_config_port_mt2712,
+	.config_port = mtk_smi_larb_config_port_gen2_general,
+	.larb_special_mask = BIT(8) | BIT(9), /* bdpsys */
 };
 
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
-- 
1.9.1

