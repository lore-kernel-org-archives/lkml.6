Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7464C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A126025562
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A126025562
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032195AbeGAQmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:42:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031809AbeGAQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:42:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9FD55A73;
        Sun,  1 Jul 2018 16:42:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.17 111/220] clk:aspeed: Fix reset bits for PCI/VGA and PECI
Date:   Sun,  1 Jul 2018 18:22:15 +0200
Message-Id: <20180701160913.007992346@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

commit e76e56823a318ca580be4cfc5a6a9269bc70abea upstream.

This commit fixes incorrect setting of reset bits for PCI/VGA and
PECI modules.

1. Reset bit for PCI/VGA is 8.
2. PECI reset bit is missing so added bit 10 as its reset bit.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/clk-aspeed.c                 |    4 ++--
 include/dt-bindings/clock/aspeed-clock.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -88,7 +88,7 @@ static const struct aspeed_gate_data asp
 	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
 	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
 	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
-	[ASPEED_CLK_GATE_BCLK] =	{  4, 10, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
+	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
 	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	0 }, /* DAC */
 	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
 	[ASPEED_CLK_GATE_USBPORT2CLK] =	{  7,  3, "usb-port2-gate",	NULL,	0 }, /* USB2.0 Host port 2 */
@@ -297,7 +297,7 @@ static const u8 aspeed_resets[] = {
 	[ASPEED_RESET_JTAG_MASTER] = 22,
 	[ASPEED_RESET_MIC]	= 18,
 	[ASPEED_RESET_PWM]	=  9,
-	[ASPEED_RESET_PCIVGA]	=  8,
+	[ASPEED_RESET_PECI]	= 10,
 	[ASPEED_RESET_I2C]	=  2,
 	[ASPEED_RESET_AHB]	=  1,
 };
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -45,7 +45,7 @@
 #define ASPEED_RESET_JTAG_MASTER	3
 #define ASPEED_RESET_MIC		4
 #define ASPEED_RESET_PWM		5
-#define ASPEED_RESET_PCIVGA		6
+#define ASPEED_RESET_PECI		6
 #define ASPEED_RESET_I2C		7
 #define ASPEED_RESET_AHB		8
 


