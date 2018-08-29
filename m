Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A92C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8A1205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ZBOYPnnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8A1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH3Bb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:31:56 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52204 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeH3Bbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:31:55 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 01/18] dt-bindings: jz4780-dma: Update bindings to reflect driver changes
Date:   Wed, 29 Aug 2018 23:32:43 +0200
Message-Id: <20180829213300.22829-2-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578386; bh=7/nF5ptTjLMFMBSK3el5ZN3TxvQ3NZOE4K7lOOvvJcw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZBOYPnnVlLW4Xp7VX0wUKJO1B9Si1wloj0ki23wtiDRdXsv9VJCn8LNPTDvSzhvwTkGFsJnvon/KZFAKJU5lpXI2Qxh7A/R2mWUK52FD+2bGlc9Lv4yG/0GTyHJwfuTeWbtw6OXuTUJt8aH91Yq6hW3xAp+yv//lp190CQQeGLE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver now expects the devicetree to supply a second memory
resource. This resource is mandatory on the newly supported SoCs.
For the JZ4780, new devicetree code must also provide it, although the
driver is still compatible with older devicetree binaries.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
     v2: New patch in this series; regroups the changes made to the
     jz4780-dma.txt doc file in the previous version of the patchset.
    
     v3: Updated example to comply with devicetree specification
    
     v4: Removed driver-specific comment in commit message
    
     v5: Remove 'doc' in patch title

 Documentation/devicetree/bindings/dma/jz4780-dma.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index 03e9cf7b42e0..636fcb26b164 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -2,8 +2,13 @@
 
 Required properties:
 
-- compatible: Should be "ingenic,jz4780-dma"
-- reg: Should contain the DMA controller registers location and length.
+- compatible: Should be one of:
+  * ingenic,jz4740-dma
+  * ingenic,jz4725b-dma
+  * ingenic,jz4770-dma
+  * ingenic,jz4780-dma
+- reg: Should contain the DMA channel registers location and length, followed
+  by the DMA controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the DMA controller.
 - clocks: Should contain a clock specifier for the JZ4780 PDMA clock.
 - #dma-cells: Must be <2>. Number of integer cells in the dmas property of
@@ -19,9 +24,10 @@ Optional properties:
 
 Example:
 
-dma: dma@13420000 {
+dma: dma-controller@13420000 {
 	compatible = "ingenic,jz4780-dma";
-	reg = <0x13420000 0x10000>;
+	reg = <0x13420000 0x400
+	       0x13421000 0x40>;
 
 	interrupt-parent = <&intc>;
 	interrupts = <10>;
-- 
2.11.0

