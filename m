Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEPCsA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:48:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13994 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751855AbeEPCr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:47:59 -0400
X-UUID: a0d9f4f5fbb94fb4b662a8f332753be9-20180516
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <honghui.zhang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v3] dt-bindings: mediatek: Add binding for mt2712 IOMMU and SMI
Date: Wed, 16 May 2018 10:47:27 +0800
Message-ID: <1526438847-25124-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds decriptions for mt2712 IOMMU and SMI.

In order to balance the bandwidth, mt2712 has two M4Us, two
smi-commons, 10 smi-larbs. and mt2712 is also MTK IOMMU gen2 which
uses ARM Short-Descriptor translation table format.

The mt2712 M4U-SMI HW diagram is as below:

                            EMI
                             |
              ------------------------------------
              |                                  |
             M4U0                              M4U1
              |                                  |
         smi-common0                        smi-common1
              |                                  |
  -------------------------       --------------------------------
  |     |     |     |     |       |         |        |     |     |
  |     |     |     |     |       |         |        |     |     |
larb0 larb1 larb2 larb3 larb6    larb4    larb5    larb7 larb8 larb9
disp0 vdec  cam   venc   jpg  mdp1/disp1 mdp2/disp2 mdp3 vdo/nr tvd

All the connections are HW fixed, SW can NOT adjust it.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
The mt2712 iommu code has already merged in v4.14, but the dt-binding
patch looks lost. Resend it as v3.

v3:
Add a new ECO port(DISP_RDMA2) in larb0/port7.

v2:
https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023848.html

v1:
https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023665.html
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |   6 +-
 .../memory-controllers/mediatek,smi-common.txt     |   6 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   5 +-
 include/dt-bindings/memory/mt2712-larb-port.h      | 103 +++++++++++++++++++++
 4 files changed, 114 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index 53c20ca..df5db73 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -40,6 +40,7 @@ video decode local arbiter, all these ports are according to the video HW.
 Required properties:
 - compatible : must be one of the following string:
 	"mediatek,mt2701-m4u" for mt2701 which uses generation one m4u HW.
+	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
 - reg : m4u register base and size.
 - interrupts : the interrupt of m4u.
@@ -50,8 +51,9 @@ Required properties:
 	according to the local arbiter index, like larb0, larb1, larb2...
 - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
 	Specifies the mtk_m4u_id as defined in
-	dt-binding/memory/mt2701-larb-port.h for mt2701 and
-	dt-binding/memory/mt8173-larb-port.h for mt8173
+	dt-binding/memory/mt2701-larb-port.h for mt2701,
+	dt-binding/memory/mt2712-larb-port.h for mt2712, and
+	dt-binding/memory/mt8173-larb-port.h for mt8173.
 
 Example:
 	iommu: iommu@10205000 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index aa614b2..615abdd 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -2,8 +2,9 @@ SMI (Smart Multimedia Interface) Common
 
 The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
 
-Mediatek SMI have two generations of HW architecture, mt8173 uses the second
-generation of SMI HW while mt2701 uses the first generation HW of SMI.
+Mediatek SMI have two generations of HW architecture, mt2712 and mt8173 use
+the second generation of SMI HW while mt2701 uses the first generation HW of
+SMI.
 
 There's slight differences between the two SMI, for generation 2, the
 register which control the iommu port is at each larb's register base. But
@@ -15,6 +16,7 @@ not needed for SMI generation 2.
 Required properties:
 - compatible : must be one of :
 	"mediatek,mt2701-smi-common"
+	"mediatek,mt2712-smi-common"
 	"mediatek,mt8173-smi-common"
 - reg : the register and size of the SMI block.
 - power-domains : a phandle to the power domain of this local arbiter.
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
index ddf46b8..083155c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
@@ -4,8 +4,9 @@ The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
 
 Required properties:
 - compatible : must be one of :
-		"mediatek,mt8173-smi-larb"
 		"mediatek,mt2701-smi-larb"
+		"mediatek,mt2712-smi-larb"
+		"mediatek,mt8173-smi-larb"
 - reg : the register and size of this local arbiter.
 - mediatek,smi : a phandle to the smi_common node.
 - power-domains : a phandle to the power domain of this local arbiter.
@@ -15,7 +16,7 @@ Required properties:
 	    the register.
   - "smi" : It's the clock for transfer data and command.
 
-Required property for mt2701:
+Required property for mt2701 and mt2712:
 - mediatek,larb-id :the hardware id of this larb.
 
 Example:
diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h
new file mode 100644
index 0000000..47660a8
--- /dev/null
+++ b/include/dt-bindings/memory/mt2712-larb-port.h
@@ -0,0 +1,103 @@
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __DTS_IOMMU_PORT_MT2712_H
+#define __DTS_IOMMU_PORT_MT2712_H
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
+#define M4U_LARB8_ID			8
+#define M4U_LARB9_ID			9
+
+/* larb0 */
+#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_OD_R		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_DISP_OD_W		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_MDP_WDMA		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_DISP_RDMA2		MTK_M4U_ID(M4U_LARB0_ID, 7)
+
+/* larb1 */
+#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_HW_VDEC_UFO_EXT	MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_HW_VDEC_VLD2_EXT	MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB1_ID, 8)
+#define M4U_PORT_HW_VDEC_TILE		MTK_M4U_ID(M4U_LARB1_ID, 9)
+#define M4U_PORT_HW_IMG_RESZ_EXT	MTK_M4U_ID(M4U_LARB1_ID, 10)
+
+/* larb2 */
+#define M4U_PORT_CAM_DMA0		MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_CAM_DMA1		MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_CAM_DMA2		MTK_M4U_ID(M4U_LARB2_ID, 2)
+
+/* larb3 */
+#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB3_ID, 4)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 5)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 6)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 7)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 8)
+
+/* larb4 */
+#define M4U_PORT_DISP_OVL1		MTK_M4U_ID(M4U_LARB4_ID, 0)
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB4_ID, 1)
+#define M4U_PORT_DISP_WDMA1		MTK_M4U_ID(M4U_LARB4_ID, 2)
+#define M4U_PORT_DISP_OD1_R		MTK_M4U_ID(M4U_LARB4_ID, 3)
+#define M4U_PORT_DISP_OD1_W		MTK_M4U_ID(M4U_LARB4_ID, 4)
+#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB4_ID, 5)
+#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(M4U_LARB4_ID, 6)
+
+/* larb5 */
+#define M4U_PORT_DISP_OVL2		MTK_M4U_ID(M4U_LARB5_ID, 0)
+#define M4U_PORT_DISP_WDMA2		MTK_M4U_ID(M4U_LARB5_ID, 1)
+#define M4U_PORT_MDP_RDMA2		MTK_M4U_ID(M4U_LARB5_ID, 2)
+#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB5_ID, 3)
+
+/* larb6 */
+#define M4U_PORT_JPGDEC_WDMA_0		MTK_M4U_ID(M4U_LARB6_ID, 0)
+#define M4U_PORT_JPGDEC_WDMA_1		MTK_M4U_ID(M4U_LARB6_ID, 1)
+#define M4U_PORT_JPGDEC_BSDMA_0		MTK_M4U_ID(M4U_LARB6_ID, 2)
+#define M4U_PORT_JPGDEC_BSDMA_1		MTK_M4U_ID(M4U_LARB6_ID, 3)
+
+/* larb7 */
+#define M4U_PORT_MDP_RDMA3		MTK_M4U_ID(M4U_LARB7_ID, 0)
+#define M4U_PORT_MDP_WROT2		MTK_M4U_ID(M4U_LARB7_ID, 1)
+
+/* larb8 */
+#define M4U_PORT_VDO			MTK_M4U_ID(M4U_LARB8_ID, 0)
+#define M4U_PORT_NR			MTK_M4U_ID(M4U_LARB8_ID, 1)
+#define M4U_PORT_WR_CHANNEL0		MTK_M4U_ID(M4U_LARB8_ID, 2)
+
+/* larb9 */
+#define M4U_PORT_TVD			MTK_M4U_ID(M4U_LARB9_ID, 0)
+#define M4U_PORT_WR_CHANNEL1		MTK_M4U_ID(M4U_LARB9_ID, 1)
+
+#endif
-- 
1.9.1
