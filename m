Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25501ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F1E20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="oP3SHTSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F1E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeGUL76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 07:59:58 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41598 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbeGUL76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 07:59:58 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v3 01/18] doc: dt-bindings: jz4780-dma: Update bindings to reflect driver changes
Date:   Sat, 21 Jul 2018 13:06:26 +0200
Message-Id: <20180721110643.19624-2-paul@crapouillou.net>
In-Reply-To: <20180721110643.19624-1-paul@crapouillou.net>
References: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171256; bh=NI6gMHkrQ4N2cLl51YaYvZ27t2JNmQZvj+Ey5pY5pTA=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oP3SHTSKO5p6H9XBnB2qxvN/bZGCuYZxOvMzkBU3rBGHfPwm7KOFMrmiEmosZFw0PwTrhVpkkliC2DysnJ9cD1W3laXD58T3+6BRH2mD+/nRjQk3M6duxF8+y6KRlr4oO8pjuhEYOgzpC+GTfr6HXHPHOvTKI9XAqIBP86KUKkQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is now compatible with four SoCs: JZ4780, JZ4770, JZ4725B and
JZ4740.

Besides, it now expects the devicetree to supply a second memory
resource. This resource is mandatory on the newly supported SoCs.
For the JZ4780, new devicetree code must also provide it, although the
driver is still compatible with older devicetree binaries.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 Documentation/devicetree/bindings/dma/jz4780-dma.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

 v2: New patch in this series; regroups the changes made to the
 jz4780-dma.txt doc file in the previous version of the patchset.

 v3: Updated example to comply with devicetree specification

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index f25feee62b15..14f33305e194 100644
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
 - interrupt-parent: Should be the phandle of the interrupt controller that
 - clocks: Should contain a clock specifier for the JZ4780 PDMA clock.
@@ -20,9 +25,10 @@ Optional properties:
 
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

