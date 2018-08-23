Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708B1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34280208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34280208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbeHWMaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:30:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55642 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:30:08 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F1F5ACA0;
        Thu, 23 Aug 2018 09:01:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 223/324] drm/armada: fix irq handling
Date:   Thu, 23 Aug 2018 09:54:49 +0200
Message-Id: <20180823075007.321005497@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 92298c1cd8e8a6b56322b602ad72b54e6237631d ]

Add the missing locks to the IRQ enable/disable paths, and fix a comment
in the interrupt handler: reading the ISR clears down the status bits,
but does not reset the interrupt so it can signal again.  That seems to
require a write.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/armada/armada_crtc.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -519,8 +519,9 @@ static irqreturn_t armada_drm_irq(int ir
 	u32 v, stat = readl_relaxed(dcrtc->base + LCD_SPU_IRQ_ISR);
 
 	/*
-	 * This is rediculous - rather than writing bits to clear, we
-	 * have to set the actual status register value.  This is racy.
+	 * Reading the ISR appears to clear bits provided CLEAN_SPU_IRQ_ISR
+	 * is set.  Writing has some other effect to acknowledge the IRQ -
+	 * without this, we only get a single IRQ.
 	 */
 	writel_relaxed(0, dcrtc->base + LCD_SPU_IRQ_ISR);
 
@@ -1116,16 +1117,22 @@ armada_drm_crtc_set_property(struct drm_
 static int armada_drm_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	unsigned long flags;
 
+	spin_lock_irqsave(&dcrtc->irq_lock, flags);
 	armada_drm_crtc_enable_irq(dcrtc, VSYNC_IRQ_ENA);
+	spin_unlock_irqrestore(&dcrtc->irq_lock, flags);
 	return 0;
 }
 
 static void armada_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	unsigned long flags;
 
+	spin_lock_irqsave(&dcrtc->irq_lock, flags);
 	armada_drm_crtc_disable_irq(dcrtc, VSYNC_IRQ_ENA);
+	spin_unlock_irqrestore(&dcrtc->irq_lock, flags);
 }
 
 static const struct drm_crtc_funcs armada_crtc_funcs = {
@@ -1415,6 +1422,7 @@ static int armada_drm_crtc_create(struct
 		       CFG_PDWN64x66, dcrtc->base + LCD_SPU_SRAM_PARA1);
 	writel_relaxed(0x2032ff81, dcrtc->base + LCD_SPU_DMA_CTRL1);
 	writel_relaxed(dcrtc->irq_ena, dcrtc->base + LCD_SPU_IRQ_ENA);
+	readl_relaxed(dcrtc->base + LCD_SPU_IRQ_ISR);
 	writel_relaxed(0, dcrtc->base + LCD_SPU_IRQ_ISR);
 
 	ret = devm_request_irq(dev, irq, armada_drm_irq, 0, "armada_drm_crtc",


