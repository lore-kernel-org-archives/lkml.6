Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F2C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF5220645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF5220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeLMMeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:34:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47211 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbeLMMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:34:19 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gXQBv-0005iT-Hb; Thu, 13 Dec 2018 13:34:11 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] reset: socfpga: declare socfpga_reset_init in a header file
Date:   Thu, 13 Dec 2018 13:33:58 +0100
Message-Id: <20181213123358.24391-3-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213123358.24391-1-p.zabel@pengutronix.de>
References: <20181213123358.24391-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid declaring extern functions in c files. To make sure function
definition and usage don't get out of sync, declare socfpga_reset_init
in a common header.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-socfpga/socfpga.c | 3 +--
 drivers/reset/reset-socfpga.c   | 2 +-
 include/linux/reset/socfpga.h   | 7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/reset/socfpga.h

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index cc64576c102b..685272fa9eb6 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -19,6 +19,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/reboot.h>
+#include <linux/reset/socfpga.h>
 
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
@@ -32,8 +33,6 @@ void __iomem *rst_manager_base_addr;
 void __iomem *sdr_ctl_base_addr;
 unsigned long socfpga_cpu1start_addr;
 
-extern void __init socfpga_reset_init(void);
-
 void __init socfpga_sysmgr_init(void)
 {
 	struct device_node *np;
diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index 318cfc51c441..96953992c2bb 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -11,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
+#include <linux/reset/socfpga.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -18,7 +19,6 @@
 #include "reset-simple.h"
 
 #define SOCFPGA_NR_BANKS	8
-void __init socfpga_reset_init(void);
 
 static int a10_reset_init(struct device_node *np)
 {
diff --git a/include/linux/reset/socfpga.h b/include/linux/reset/socfpga.h
new file mode 100644
index 000000000000..b11a2047c342
--- /dev/null
+++ b/include/linux/reset/socfpga.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_RESET_SOCFPGA_H__
+#define __LINUX_RESET_SOCFPGA_H__
+
+void __init socfpga_reset_init(void);
+
+#endif /* __LINUX_RESET_SOCFPGA_H__ */
-- 
2.19.1

