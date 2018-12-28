Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A995AC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0672148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeL1Giv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 01:38:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbeL1Git (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 01:38:49 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B130931B40F1A;
        Fri, 28 Dec 2018 14:38:46 +0800 (CST)
Received: from SIA1000080854.huawei.com (10.180.101.187) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Fri, 28 Dec 2018 14:38:42 +0800
From:   h00249924 <hutenghui@huawei.com>
To:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <liyuequan@hisilicon.com>, <cash.qianli@hisilicon.com>,
        <huangli295@hisilicon.com>, <hantanglei@huawei.com>,
        <wangyoulin1@hisilicon.com>, <ninggaoyu@hisilicon.com>,
        <hanxiaolong3@hisilicon.com>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/3] dmaengine: Extend the k3dma driver binding
Date:   Fri, 28 Dec 2018 14:36:22 +0800
Message-ID: <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.101.187]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Extend the k3dma driver binding to support hisi-asp hardware variants.

Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/dma/k3dma.txt | 33 ++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 4945aea..cd21b82 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -3,7 +3,9 @@
 See dma.txt first
 
 Required properties:
-- compatible: Should be "hisilicon,k3-dma-1.0"
+- compatible: Must be one of
+-		"hisilicon,k3-dma-1.0"
+-		"hisilicon,hisi-pcm-asp-dma-1.0"
 - reg: Should contain DMA registers location and length.
 - interrupts: Should contain one interrupt shared by all channel
 - #dma-cells: see dma.txt, should be 1, para number
@@ -43,3 +45,32 @@ For example, i2c0 read channel request line is 18, while write channel use 19
 			dma-names = "rx", "tx";
 		};
 
+
+
+
+Controller:
+		asp_dmac: asp_dmac@E804B000 {
+			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
+			reg = <0x0 0xe804b000 0x0 0x1000>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			dma-requests = <32>;
+			dma-min-chan = <0>;
+			dma-used-chans = <0xFFFE>;
+			dma-share;
+			interrupts = <0 216 4>;
+			interrupt-names = "asp_dma_irq";
+			status = "ok";
+		};
+
+Client:
+		i2s2: hisi_i2s {
+			compatible = "hisilicon,hisi-i2s";
+			reg = <0x0 0xe804f800 0x0 0x400>,
+				<0x0 0xe804e000 0x0 0x400>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
+			dmas = <&asp_dmac 18 &asp_dmac 19>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+		};
-- 
1.9.1

