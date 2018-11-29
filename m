Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B712C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0421205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0421205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbeK2UBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:01:04 -0500
Received: from inva021.nxp.com ([92.121.34.21]:56264 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeK2UBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:01:04 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 86ECB2000F8;
        Thu, 29 Nov 2018 09:56:22 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 225B020008A;
        Thu, 29 Nov 2018 09:56:21 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E7267402D9;
        Thu, 29 Nov 2018 16:56:18 +0800 (SGT)
From:   ying.zhang22455@nxp.com
To:     linux-kernel@vger.kernel.org
Cc:     Zhang Ying-22455 <ying.zhang22455@nxp.com>
Subject: [PATCH] armv8: GPIO: enable port input and interrupt
Date:   Thu, 29 Nov 2018 16:51:50 +0800
Message-Id: <20181129085150.8602-1-ying.zhang22455@nxp.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

The GPIO Input Buffer Enable register is used to control the input
enable of each individual GPIO port. When an individual GPIO port’s
direction is set to input (GPIO_GPDIR[DRn=0]), the associated input
enable must be set (GPIOxGPIE[IEn]=1) to propagate the port value to
the GPIO Data Register.

This patch enable port input and interrupt.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 drivers/gpio/gpio-mpc8xxx.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 793518a..f97cd23 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -362,9 +362,10 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	if (!mpc8xxx_gc->irq)
 		return 0;
 
-	/* ack and mask all irqs */
+	/* ack and enable irqs */
 	gc->write_reg(mpc8xxx_gc->regs + GPIO_IER, 0xffffffff);
-	gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR, 0);
+	gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR, 0xffffffff);
+	gc->write_reg(mpc8xxx_gc->regs + GPIO_ICR2, 0xffffffff);
 
 	irq_set_chained_handler_and_data(mpc8xxx_gc->irqn,
 					 mpc8xxx_gpio_irq_cascade, mpc8xxx_gc);
-- 
1.7.1

