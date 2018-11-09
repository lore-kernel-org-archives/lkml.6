Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B09CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2378C20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2378C20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeKJFjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:39:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54582 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbeKJFjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:39:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 84B18224CA; Fri,  9 Nov 2018 20:57:03 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5CE5220714;
        Fri,  9 Nov 2018 20:57:03 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     UNGLinuxDriver@microchip.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] power: reset: ocelot: switch the SI to boot mode
Date:   Fri,  9 Nov 2018 20:57:00 +0100
Message-Id: <20181109195700.28321-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the SI to boot mode so on a warm reboot, the SI is able to access
the flash.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/power/reset/ocelot-reset.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
index 5a13a5cc8188..419952c61fd0 100644
--- a/drivers/power/reset/ocelot-reset.c
+++ b/drivers/power/reset/ocelot-reset.c
@@ -26,6 +26,13 @@ struct ocelot_reset_context {
 
 #define SOFT_CHIP_RST BIT(0)
 
+#define ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
+#define IF_SI_OWNER_MASK			GENMASK(1, 0)
+#define IF_SI_OWNER_SISL			0
+#define IF_SI_OWNER_SIBM			1
+#define IF_SI_OWNER_SIMC			2
+#define IF_SI_OWNER_OFFSET			4
+
 static int ocelot_restart_handle(struct notifier_block *this,
 				 unsigned long mode, void *cmd)
 {
@@ -37,6 +44,11 @@ static int ocelot_restart_handle(struct notifier_block *this,
 	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_RESET,
 			   CORE_RST_PROTECT, 0);
 
+	/* Make the SI back to boot mode */
+	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL,
+			   IF_SI_OWNER_MASK << IF_SI_OWNER_OFFSET,
+			   IF_SI_OWNER_SIBM << IF_SI_OWNER_OFFSET);
+
 	writel(SOFT_CHIP_RST, ctx->base);
 
 	pr_emerg("Unable to restart system\n");
-- 
2.19.1

