Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6407C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FABD20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FABD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438955AbeKWIDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:03:35 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40144 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbeKWIDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:03:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7760120DB0; Thu, 22 Nov 2018 22:22:22 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id C531D207A8;
        Thu, 22 Nov 2018 22:22:21 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/2] clk: core: clarify the check for runtime PM
Date:   Thu, 22 Nov 2018 22:22:11 +0100
Message-Id: <20181122212212.16039-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122212212.16039-1-miquel.raynal@bootlin.com>
References: <20181122212212.16039-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the core->dev entry is populated only if runtime PM is
enabled. Doing so prevents accessing the device structure in any
case.

Keep the same logic but instead of using the presence of core->dev as
the only condition, also check the status of
pm_runtime_enabled(). Then, we can set the core->dev pointer at any
time as long as a device structure is available.

This change will help supporting device links in the clock subsystem.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..b799347c5fd6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -97,7 +97,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
 {
 	int ret = 0;
 
-	if (!core->dev)
+	if (!core->dev || !pm_runtime_enabled(core->dev))
 		return 0;
 
 	ret = pm_runtime_get_sync(core->dev);
@@ -106,7 +106,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
 
 static void clk_pm_runtime_put(struct clk_core *core)
 {
-	if (!core->dev)
+	if (!core->dev || !pm_runtime_enabled(core->dev))
 		return;
 
 	pm_runtime_put_sync(core->dev);
@@ -226,7 +226,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	 * taking enable spinlock, but the below check is needed if one tries
 	 * to call it from other places.
 	 */
-	if (core->dev) {
+	if (core->dev && pm_runtime_enabled(core->dev)) {
 		pm_runtime_get_noresume(core->dev);
 		if (!pm_runtime_active(core->dev)) {
 			ret = false;
@@ -236,7 +236,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 
 	ret = core->ops->is_enabled(core->hw);
 done:
-	if (core->dev)
+	if (core->dev && pm_runtime_enabled(core->dev))
 		pm_runtime_put(core->dev);
 
 	return ret;
@@ -3272,8 +3272,7 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	}
 	core->ops = hw->init->ops;
 
-	if (dev && pm_runtime_enabled(dev))
-		core->dev = dev;
+	core->dev = dev;
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
 	core->hw = hw;
-- 
2.19.1

