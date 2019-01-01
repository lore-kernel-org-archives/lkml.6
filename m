Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9346FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587A3208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfAAD4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 22:56:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:58726 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726686AbfAAD4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 22:56:35 -0500
X-UUID: 6fa21e6881ed41d7abee99e30e565062-20190101
X-UUID: 6fa21e6881ed41d7abee99e30e565062-20190101
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1793865324; Tue, 01 Jan 2019 11:56:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 11:56:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 11:56:24 +0800
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
Subject: [PATCH v5 01/20] dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
Date:   Tue, 1 Jan 2019 11:55:33 +0800
Message-ID: <1546314952-15990-2-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D295BE183B2D07F988ADC0DF8F959D171B7EF49423C2E614D5697319B88ACFD82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds decriptions for mt8183 IOMMU and SMI.

mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
uses ARM Short-Descriptor translation table format.

The mt8183 M4U-SMI HW diagram is as below:

                          EMI
                           |
                          M4U
                           |
                       ----------
                       |        |
                   gals0-rx   gals1-rx
                       |        |
                       |        |
                   gals0-tx   gals1-tx
                       |        |
                      ------------
                       SMI Common
                      ------------
                           |
  +-----+-----+--------+-----+-----+-------+-------+
  |     |     |        |     |     |       |       |
  |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
  |     |     |        |     |     |       |       |
  |     |     |        |     |     |       |       |
  |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
  |     |     |        |     |     |       |       |
larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
disp  vdec   img     cam    venc   img    cam

All the connections are HW fixed, SW can NOT adjust it.

Compared with mt8173, we add a GALS(Global Async Local Sync) module
between SMI-common and M4U, and additional GALS between larb2/3/5/6
and SMI-common. GALS can help synchronize for the modules in different
clock frequency, it can be seen as a "asynchronous fifo".

GALS can only help transfer the command/data while it doesn't have
the configuring register, thus it has the special "smi" clock and it
doesn't have the "apb" clock. From the diagram above, we add "gals0"
and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.

From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
Control Unit) is connected with smi-common directly, we can take them
as "larb2", "larb3" and "larb7", and their register spaces are
different with the normal larb.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  15 ++-
 .../memory-controllers/mediatek,smi-common.txt     |  11 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   3 +
 include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++++++++++++++++++++
 4 files changed, 153 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index 6922db5..6e758996 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -36,6 +36,10 @@ each local arbiter.
 like display, video decode, and camera. And there are different ports
 in each larb. Take a example, There are many ports like MC, PP, VLD in the
 video decode local arbiter, all these ports are according to the video HW.
+  In some SoCs, there may be a GALS(Global Async Local Sync) module between
+smi-common and m4u, and additional GALS module between smi-larb and
+smi-common. GALS can been seen as a "asynchronous fifo" which could help
+synchronize for the modules in different clock frequency.
 
 Required properties:
 - compatible : must be one of the following string:
@@ -44,18 +48,23 @@ Required properties:
 	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
 						     generation one m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
+	"mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
 - reg : m4u register base and size.
 - interrupts : the interrupt of m4u.
 - clocks : must contain one entry for each clock-names.
-- clock-names : must be "bclk", It is the block clock of m4u.
+- clock-names : Only 1 optional clock:
+  - "bclk": the block clock of m4u.
+  Note that m4u use the EMI clock which always has been enabled before kernel
+  if there is no this "bclk".
 - mediatek,larbs : List of phandle to the local arbiters in the current Socs.
 	Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
 	according to the local arbiter index, like larb0, larb1, larb2...
 - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
 	Specifies the mtk_m4u_id as defined in
 	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
-	dt-binding/memory/mt2712-larb-port.h for mt2712, and
-	dt-binding/memory/mt8173-larb-port.h for mt8173.
+	dt-binding/memory/mt2712-larb-port.h for mt2712,
+	dt-binding/memory/mt8173-larb-port.h for mt8173, and
+	dt-binding/memory/mt8183-larb-port.h for mt8183.
 
 Example:
 	iommu: iommu@10205000 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index e937ddd..8d3240a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -2,9 +2,10 @@ SMI (Smart Multimedia Interface) Common
 
 The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
 
-Mediatek SMI have two generations of HW architecture, mt2712 and mt8173 use
-the second generation of SMI HW while mt2701 uses the first generation HW of
-SMI.
+Mediatek SMI have two generations of HW architecture, here is the list
+which generation the Socs use:
+generation 1: mt2701 and mt7623.
+generation 2: mt2712, mt8173 and mt8183.
 
 There's slight differences between the two SMI, for generation 2, the
 register which control the iommu port is at each larb's register base. But
@@ -19,6 +20,7 @@ Required properties:
 	"mediatek,mt2712-smi-common"
 	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
 	"mediatek,mt8173-smi-common"
+	"mediatek,mt8183-smi-common"
 - reg : the register and size of the SMI block.
 - power-domains : a phandle to the power domain of this local arbiter.
 - clocks : Must contain an entry for each entry in clock-names.
@@ -30,6 +32,9 @@ Required properties:
 	    They may be the same if both source clocks are the same.
   - "async" : asynchronous clock, it help transform the smi clock into the emi
 	      clock domain, this clock is only needed by generation 1 smi HW.
+  and these 2 option clocks for generation 2 smi HW:
+  - "gals0": the path0 clock of GALS(Global Async Local Sync).
+  - "gals1": the path1 clock of GALS(Global Async Local Sync).
 
 Example:
 	smi_common: smi@14022000 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
index 94eddca..69266c9 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
@@ -8,6 +8,7 @@ Required properties:
 		"mediatek,mt2712-smi-larb"
 		"mediatek,mt7623-smi-larb", "mediatek,mt2701-smi-larb"
 		"mediatek,mt8173-smi-larb"
+		"mediatek,mt8183-smi-larb"
 - reg : the register and size of this local arbiter.
 - mediatek,smi : a phandle to the smi_common node.
 - power-domains : a phandle to the power domain of this local arbiter.
@@ -16,6 +17,8 @@ Required properties:
   - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
 	    the register.
   - "smi" : It's the clock for transfer data and command.
+  and this optional clock name:
+  - "gals": the clock for gals(Global Async Local Sync).
 
 Required property for mt2701, mt2712 and mt7623:
 - mediatek,larb-id :the hardware id of this larb.
diff --git a/include/dt-bindings/memory/mt8183-larb-port.h b/include/dt-bindings/memory/mt8183-larb-port.h
new file mode 100644
index 0000000..2c579f3
--- /dev/null
+++ b/include/dt-bindings/memory/mt8183-larb-port.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ */
+#ifndef __DTS_IOMMU_PORT_MT8183_H
+#define __DTS_IOMMU_PORT_MT8183_H
+
+#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+#define M4U_LARB3_ID			3
+#define M4U_LARB4_ID			4
+#define M4U_LARB5_ID			5
+#define M4U_LARB6_ID			6
+#define M4U_LARB7_ID			7
+
+/* larb0 */
+#define	M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define	M4U_PORT_DISP_2L_OVL0_LARB0     MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define	M4U_PORT_DISP_2L_OVL1_LARB0     MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define	M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define	M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define	M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define	M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define	M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 7)
+#define	M4U_PORT_MDP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 8)
+#define	M4U_PORT_DISP_FAKE0		MTK_M4U_ID(M4U_LARB0_ID, 9)
+
+/* larb1 */
+#define	M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define	M4U_PORT_HW_VDEC_PP_EXT         MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define	M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define	M4U_PORT_HW_VDEC_AVC_MV_EXT     MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define	M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define	M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define	M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB1_ID, 6)
+
+/* larb2 VPU0 */
+#define	M4U_PORT_IMG_IPUO		MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define	M4U_PORT_IMG_IPU3O		MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define	M4U_PORT_IMG_IPUI		MTK_M4U_ID(M4U_LARB2_ID, 2)
+
+/* larb3 VPU1 */
+#define	M4U_PORT_CAM_IPUO		MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define	M4U_PORT_CAM_IPU2O		MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define	M4U_PORT_CAM_IPU3O		MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define	M4U_PORT_CAM_IPUI		MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define	M4U_PORT_CAM_IPU2I		MTK_M4U_ID(M4U_LARB3_ID, 4)
+
+/* larb4 */
+#define	M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB4_ID, 0)
+#define	M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB4_ID, 1)
+#define	M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB4_ID, 2)
+#define	M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB4_ID, 3)
+#define	M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB4_ID, 4)
+#define	M4U_PORT_JPGENC_RDMA		MTK_M4U_ID(M4U_LARB4_ID, 5)
+#define	M4U_PORT_JPGENC_BSDMA		MTK_M4U_ID(M4U_LARB4_ID, 6)
+#define	M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB4_ID, 7)
+#define	M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB4_ID, 8)
+#define	M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB4_ID, 9)
+#define	M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB4_ID, 10)
+
+/* larb5 */
+#define	M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB5_ID, 0)
+#define	M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB5_ID, 1)
+#define	M4U_PORT_CAM_IMG3O		MTK_M4U_ID(M4U_LARB5_ID, 2)
+#define	M4U_PORT_CAM_VIPI		MTK_M4U_ID(M4U_LARB5_ID, 3)
+#define	M4U_PORT_CAM_LCEI		MTK_M4U_ID(M4U_LARB5_ID, 4)
+#define	M4U_PORT_CAM_SMXI		MTK_M4U_ID(M4U_LARB5_ID, 5)
+#define	M4U_PORT_CAM_SMXO		MTK_M4U_ID(M4U_LARB5_ID, 6)
+#define	M4U_PORT_CAM_WPE0_RDMA1		MTK_M4U_ID(M4U_LARB5_ID, 7)
+#define	M4U_PORT_CAM_WPE0_RDMA0		MTK_M4U_ID(M4U_LARB5_ID, 8)
+#define	M4U_PORT_CAM_WPE0_WDMA		MTK_M4U_ID(M4U_LARB5_ID, 9)
+#define	M4U_PORT_CAM_FDVT_RP		MTK_M4U_ID(M4U_LARB5_ID, 10)
+#define	M4U_PORT_CAM_FDVT_WR		MTK_M4U_ID(M4U_LARB5_ID, 11)
+#define	M4U_PORT_CAM_FDVT_RB		MTK_M4U_ID(M4U_LARB5_ID, 12)
+#define	M4U_PORT_CAM_WPE1_RDMA0		MTK_M4U_ID(M4U_LARB5_ID, 13)
+#define	M4U_PORT_CAM_WPE1_RDMA1		MTK_M4U_ID(M4U_LARB5_ID, 14)
+#define	M4U_PORT_CAM_WPE1_WDMA		MTK_M4U_ID(M4U_LARB5_ID, 15)
+#define	M4U_PORT_CAM_DPE_RDMA		MTK_M4U_ID(M4U_LARB5_ID, 16)
+#define	M4U_PORT_CAM_DPE_WDMA		MTK_M4U_ID(M4U_LARB5_ID, 17)
+#define	M4U_PORT_CAM_MFB_RDMA0		MTK_M4U_ID(M4U_LARB5_ID, 18)
+#define	M4U_PORT_CAM_MFB_RDMA1		MTK_M4U_ID(M4U_LARB5_ID, 19)
+#define	M4U_PORT_CAM_MFB_WDMA		MTK_M4U_ID(M4U_LARB5_ID, 20)
+#define	M4U_PORT_CAM_RSC_RDMA0		MTK_M4U_ID(M4U_LARB5_ID, 21)
+#define	M4U_PORT_CAM_RSC_WDMA		MTK_M4U_ID(M4U_LARB5_ID, 22)
+#define	M4U_PORT_CAM_OWE_RDMA		MTK_M4U_ID(M4U_LARB5_ID, 23)
+#define	M4U_PORT_CAM_OWE_WDMA		MTK_M4U_ID(M4U_LARB5_ID, 24)
+
+/* larb6 */
+#define	M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB6_ID, 0)
+#define	M4U_PORT_CAM_RRZO		MTK_M4U_ID(M4U_LARB6_ID, 1)
+#define	M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB6_ID, 2)
+#define	M4U_PORT_CAM_AFO		MTK_M4U_ID(M4U_LARB6_ID, 3)
+#define	M4U_PORT_CAM_LSCI0		MTK_M4U_ID(M4U_LARB6_ID, 4)
+#define	M4U_PORT_CAM_LSCI1		MTK_M4U_ID(M4U_LARB6_ID, 5)
+#define	M4U_PORT_CAM_PDO		MTK_M4U_ID(M4U_LARB6_ID, 6)
+#define	M4U_PORT_CAM_BPCI		MTK_M4U_ID(M4U_LARB6_ID, 7)
+#define	M4U_PORT_CAM_LCSO		MTK_M4U_ID(M4U_LARB6_ID, 8)
+#define	M4U_PORT_CAM_CAM_RSSO_A		MTK_M4U_ID(M4U_LARB6_ID, 9)
+#define	M4U_PORT_CAM_UFEO		MTK_M4U_ID(M4U_LARB6_ID, 10)
+#define	M4U_PORT_CAM_SOCO		MTK_M4U_ID(M4U_LARB6_ID, 11)
+#define	M4U_PORT_CAM_SOC1		MTK_M4U_ID(M4U_LARB6_ID, 12)
+#define	M4U_PORT_CAM_SOC2		MTK_M4U_ID(M4U_LARB6_ID, 13)
+#define	M4U_PORT_CAM_CCUI		MTK_M4U_ID(M4U_LARB6_ID, 14)
+#define	M4U_PORT_CAM_CCUO		MTK_M4U_ID(M4U_LARB6_ID, 15)
+#define	M4U_PORT_CAM_RAWI_A		MTK_M4U_ID(M4U_LARB6_ID, 16)
+#define	M4U_PORT_CAM_CCUG		MTK_M4U_ID(M4U_LARB6_ID, 17)
+#define	M4U_PORT_CAM_PSO		MTK_M4U_ID(M4U_LARB6_ID, 18)
+#define	M4U_PORT_CAM_AFO_1		MTK_M4U_ID(M4U_LARB6_ID, 19)
+#define	M4U_PORT_CAM_LSCI_2		MTK_M4U_ID(M4U_LARB6_ID, 20)
+#define	M4U_PORT_CAM_PDI		MTK_M4U_ID(M4U_LARB6_ID, 21)
+#define	M4U_PORT_CAM_FLKO		MTK_M4U_ID(M4U_LARB6_ID, 22)
+#define	M4U_PORT_CAM_LMVO		MTK_M4U_ID(M4U_LARB6_ID, 23)
+#define	M4U_PORT_CAM_UFGO		MTK_M4U_ID(M4U_LARB6_ID, 24)
+#define	M4U_PORT_CAM_SPARE		MTK_M4U_ID(M4U_LARB6_ID, 25)
+#define	M4U_PORT_CAM_SPARE_2		MTK_M4U_ID(M4U_LARB6_ID, 26)
+#define	M4U_PORT_CAM_SPARE_3		MTK_M4U_ID(M4U_LARB6_ID, 27)
+#define	M4U_PORT_CAM_SPARE_4		MTK_M4U_ID(M4U_LARB6_ID, 28)
+#define	M4U_PORT_CAM_SPARE_5		MTK_M4U_ID(M4U_LARB6_ID, 29)
+#define	M4U_PORT_CAM_SPARE_6		MTK_M4U_ID(M4U_LARB6_ID, 30)
+
+/* CCU */
+#define	M4U_PORT_CCU0			MTK_M4U_ID(M4U_LARB7_ID, 0)
+#define	M4U_PORT_CCU1			MTK_M4U_ID(M4U_LARB7_ID, 1)
+
+#endif
-- 
1.9.1

