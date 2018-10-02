Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AECFC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C71E206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C71E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbeJBURj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbeJBURi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:38 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 257FAB2F;
        Tue,  2 Oct 2018 13:34:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.14 096/137] usb: musb: dsps: do not disable CPPI41 irq in driver teardown
Date:   Tue,  2 Oct 2018 06:24:57 -0700
Message-Id: <20181002132505.213201823@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Liu <b-liu@ti.com>

commit 783f3b4e9ec50491c21746e7e05ec6c39c21f563 upstream.

TI AM335x CPPI 4.1 module uses a single register bit for CPPI interrupts
in both musb controllers. So disabling the CPPI irq in one musb driver
breaks the other musb module.

Since musb is already disabled before tearing down dma controller in
musb_remove(), it is safe to not disable CPPI irq in
musb_dma_controller_destroy().

Fixes: 255348289f71 ("usb: musb: dsps: Manage CPPI 4.1 DMA interrupt in DSPS")
Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_dsps.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -684,16 +684,6 @@ dsps_dma_controller_create(struct musb *
 	return controller;
 }
 
-static void dsps_dma_controller_destroy(struct dma_controller *c)
-{
-	struct musb *musb = c->musb;
-	struct dsps_glue *glue = dev_get_drvdata(musb->controller->parent);
-	void __iomem *usbss_base = glue->usbss_base;
-
-	musb_writel(usbss_base, USBSS_IRQ_CLEARR, USBSS_IRQ_PD_COMP);
-	cppi41_dma_controller_destroy(c);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static void dsps_dma_controller_suspend(struct dsps_glue *glue)
 {
@@ -723,7 +713,7 @@ static struct musb_platform_ops dsps_ops
 
 #ifdef CONFIG_USB_TI_CPPI41_DMA
 	.dma_init	= dsps_dma_controller_create,
-	.dma_exit	= dsps_dma_controller_destroy,
+	.dma_exit	= cppi41_dma_controller_destroy,
 #endif
 	.enable		= dsps_musb_enable,
 	.disable	= dsps_musb_disable,


