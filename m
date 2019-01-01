Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938BAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C7B21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfAAD6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 22:58:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:10847 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726686AbfAAD6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 22:58:17 -0500
X-UUID: 6e23c38c6c35491799d0ab1a90c20da0-20190101
X-UUID: 6e23c38c6c35491799d0ab1a90c20da0-20190101
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1085665192; Tue, 01 Jan 2019 11:58:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 11:58:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 11:58:09 +0800
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
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v5 09/20] iommu/mediatek: Refine protect memory definition
Date:   Tue, 1 Jan 2019 11:55:41 +0800
Message-ID: <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The protect memory setting is a little different in the different SoCs.
In the register REG_MMU_CTRL_REG(0x110), the TF_PROT(translation fault
protect) shift bit is normally 4 while it shift 5 bits only in the
mt8173. This patch delete the complex MACRO and use a common if-else
instead.

Also, use "F_MMU_TF_PROT_TO_PROGRAM_ADDR" instead of the hard code(2)
which means the M4U will output the dirty data to the programmed
address that we allocated dynamically when translation fault occurs.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
@Nicalos, I don't put it in the plat_data since only the previous mt8173
shift 5. As I know, the latest SoC always use the new setting like mt2712
and mt8183. Thus, I think it is unnecessary to put it in plat_data and
let all the latest SoC set it. Hence, I still keep "== mt8173" for this
like the reg REG_MMU_CTRL_REG.
---
 drivers/iommu/mtk_iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index eca1536..35a1263 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -53,11 +53,7 @@
 
 #define REG_MMU_CTRL_REG			0x110
 #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
-#define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
-	((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
-/* It's named by F_MMU_TF_PROT_SEL in mt2712. */
-#define F_MMU_TF_PROTECT_SEL(prot, data) \
-	(((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
+#define F_MMU_TF_PROT_TO_PROGRAM_ADDR		2
 
 #define REG_MMU_IVRP_PADDR			0x114
 
@@ -521,9 +517,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		return ret;
 	}
 
-	regval = F_MMU_TF_PROTECT_SEL(2, data);
 	if (data->plat_data->m4u_plat == M4U_MT8173)
-		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
+		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
+			  (F_MMU_TF_PROT_TO_PROGRAM_ADDR << 5);
+	else
+		regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR << 4;
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
 	regval = F_L2_MULIT_HIT_EN |
-- 
1.9.1

