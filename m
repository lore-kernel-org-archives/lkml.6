Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7880C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FBA204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBGWi2AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FBA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbeKDXLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbeKDXJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7649E20869;
        Sun,  4 Nov 2018 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339664;
        bh=oJPa4pRWIlFB1DJzGXIWXUMv3BqcPaxbvVPmMsvgLQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBGWi2ARgBEmyQfbIc/Ye3YamnHIJS0qBAKrx7+g2aD+Jraikid3Hg89pFXN5nU2P
         7+qZ7OApioyFS8KmHfS8lR7a0kQtRlAYhM31ajDvPT6DsRiNsBRECXl0s1zK97bKRt
         A6TdkkP1GA/UMyUBO13YK2LClMPbJGsdyHSsOYOU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 05/15] watchdog: lantiq: update register names to better match spec
Date:   Sun,  4 Nov 2018 08:54:07 -0500
Message-Id: <20181104135417.88671-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135417.88671-1-sashal@kernel.org>
References: <20181104135417.88671-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hauke Mehrtens <hauke@hauke-m.de>

[ Upstream commit 1f59f8aff98f200af7a6882184add7b85f5da741 ]

Some of the names of the bits were confusing to me.
Now the bits share the same prefix as the register they are set on.

The LTQ_WDT_CR_PWL register (bits 26:25) is the pre warning limit and it
does not turn anything on. It has 4 possible divers 1/2, 1/4, 1/8 and
1/16, this drivers only uses 1/16.
The LTQ_WDT_CR_CLKDIV register bits(25:24) is only configuring a clock
divers and do not turn any thing on too, all possible values are valid
dividers.
Using the LTQ_WDT_SR prefix is also wrong these bits are used in the
LTQ_WDT_CR registers, SR is the status register which is read only.

This uses GENMASK where it is a mask and it uses shifts when a value is
written to some bits.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/lantiq_wdt.c | 36 ++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 582f2fa1b8d9..6ab14bd9c1e4 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/bitops.h>
 #include <linux/watchdog.h>
 #include <linux/of_platform.h>
 #include <linux/uaccess.h>
@@ -28,18 +29,19 @@
  * essentially the following two magic passwords need to be written to allow
  * IO access to the WDT core
  */
-#define LTQ_WDT_PW1		0x00BE0000
-#define LTQ_WDT_PW2		0x00DC0000
+#define LTQ_WDT_CR_PW1		0x00BE0000
+#define LTQ_WDT_CR_PW2		0x00DC0000
+
+#define LTQ_WDT_CR		0x0		/* watchdog control register */
+#define  LTQ_WDT_CR_GEN		BIT(31)		/* enable bit */
+/* Pre-warning limit set to 1/16 of max WDT period */
+#define  LTQ_WDT_CR_PWL		(0x3 << 26)
+/* set clock divider to 0x40000 */
+#define  LTQ_WDT_CR_CLKDIV	(0x3 << 24)
+#define  LTQ_WDT_CR_PW_MASK	GENMASK(23, 16)	/* Password field */
+#define  LTQ_WDT_CR_MAX_TIMEOUT	((1 << 16) - 1)	/* The reload field is 16 bit */
 
-#define LTQ_WDT_CR		0x0	/* watchdog control register */
-#define LTQ_WDT_SR		0x8	/* watchdog status register */
-
-#define LTQ_WDT_SR_EN		(0x1 << 31)	/* enable bit */
-#define LTQ_WDT_SR_PWD		(0x3 << 26)	/* turn on power */
-#define LTQ_WDT_SR_CLKDIV	(0x3 << 24)	/* turn on clock and set */
-						/* divider to 0x40000 */
 #define LTQ_WDT_DIVIDER		0x40000
-#define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
@@ -56,26 +58,26 @@ ltq_wdt_enable(void)
 {
 	unsigned long int timeout = ltq_wdt_timeout *
 			(ltq_io_region_clk_rate / LTQ_WDT_DIVIDER) + 0x1000;
-	if (timeout > LTQ_MAX_TIMEOUT)
-		timeout = LTQ_MAX_TIMEOUT;
+	if (timeout > LTQ_WDT_CR_MAX_TIMEOUT)
+		timeout = LTQ_WDT_CR_MAX_TIMEOUT;
 
 	/* write the first password magic */
-	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
 	/* write the second magic plus the configuration and new timeout */
-	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV |
-		LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
+	ltq_w32(LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV |
+		LTQ_WDT_CR_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
 }
 
 static void
 ltq_wdt_disable(void)
 {
 	/* write the first password magic */
-	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
 	/*
 	 * write the second password magic with no config
 	 * this turns the watchdog off
 	 */
-	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
+	ltq_w32(LTQ_WDT_CR_PW2, ltq_wdt_membase + LTQ_WDT_CR);
 }
 
 static ssize_t
-- 
2.17.1

