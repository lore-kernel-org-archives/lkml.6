Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A457C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3BA2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548742263;
	bh=Z848HCBtnzeyslpUOhB1zGR5r1IbxympifhvWGT6J3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=09+2LhnvccpDLkcUHE2bTk9vWrYj6hTPPqwHfxDkoFW4Yenb11Bh2k98K5kiZQ6l6
	 1+3eSbLh0I3du/+yK+LX4NEDYf4DYY0bYi+4suzm6hD/tzQ4s/b+kJy1Bg8/hJ/W+p
	 GIz7kzL2OsmXYYiWaMDIviSpL7k6pciO14vRpitI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfA2GLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfA2GKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:10:24 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9120E21841;
        Tue, 29 Jan 2019 06:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548742223;
        bh=Z848HCBtnzeyslpUOhB1zGR5r1IbxympifhvWGT6J3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+Jo7mWUqfz1ur1wEqNpUO+8yeyp2rRAvnsgH9ICjO599S1Hyz+Mw16aIXCWFpYI6
         Z4f9BckDZfClGF0Lls2HaCYLOSzWbIWVBzQfUSCG4JeHbPwkou36Ck6fwLm1gqOix7
         4Fq6H11JRg0KwEziBjZu7VOl+CZwN15sTo+HBhCU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 3/9] clk: core: clarify the check for runtime PM
Date:   Mon, 28 Jan 2019 22:10:15 -0800
Message-Id: <20190129061021.94775-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129061021.94775-1-sboyd@kernel.org>
References: <20190129061021.94775-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Currently, the core->dev entry is populated only if runtime PM is
enabled. Doing so prevents accessing the device structure in any
case.

Keep the same logic but instead of using the presence of core->dev as
the only condition, also check the status of
pm_runtime_enabled(). Then, we can set the core->dev pointer at any
time as long as a device structure is available.

This change will help supporting device links in the clock subsystem.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
[sboyd@kernel.org: Change to a boolean flag]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5d82cf25bb29..01cdb9ae03fa 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -60,6 +60,7 @@ struct clk_core {
 	struct clk_core		*new_child;
 	unsigned long		flags;
 	bool			orphan;
+	bool			rpm_enabled;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned int		protect_count;
@@ -95,9 +96,9 @@ struct clk {
 /***           runtime pm          ***/
 static int clk_pm_runtime_get(struct clk_core *core)
 {
-	int ret = 0;
+	int ret;
 
-	if (!core->dev)
+	if (!core->rpm_enabled)
 		return 0;
 
 	ret = pm_runtime_get_sync(core->dev);
@@ -106,7 +107,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
 
 static void clk_pm_runtime_put(struct clk_core *core)
 {
-	if (!core->dev)
+	if (!core->rpm_enabled)
 		return;
 
 	pm_runtime_put_sync(core->dev);
@@ -226,7 +227,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	 * taking enable spinlock, but the below check is needed if one tries
 	 * to call it from other places.
 	 */
-	if (core->dev) {
+	if (core->rpm_enabled) {
 		pm_runtime_get_noresume(core->dev);
 		if (!pm_runtime_active(core->dev)) {
 			ret = false;
@@ -236,7 +237,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 
 	ret = core->ops->is_enabled(core->hw);
 done:
-	if (core->dev)
+	if (core->rpm_enabled)
 		pm_runtime_put(core->dev);
 
 	return ret;
@@ -3391,7 +3392,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	core->ops = hw->init->ops;
 
 	if (dev && pm_runtime_enabled(dev))
-		core->dev = dev;
+		core->rpm_enabled = true;
+	core->dev = dev;
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
 	core->hw = hw;
-- 
Sent by a computer through tubes

