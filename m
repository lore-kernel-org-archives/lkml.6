Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D71C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B097B21873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220485;
	bh=EhSwc8YZXpNLa457hu+6PsYYq1FYt0pMKcWYUIlYCSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RDdqjoAH0gmsxufMZAUiIgdj1V7NgkrCn8D/5B3X3NHESLeM4q07hmyOgUoxkmx3B
	 uyahRMh167EDfMtvCNYtvG5bKJ6Ukt9u49cqYj79DCxtZOwxVAcPgBHPUGwAUSWIbc
	 4VHMuKvbKt21XeD7RDodHk/BR4ODPmGNXc5alw4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfBZWee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfBZWed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:34:33 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BB5218A1;
        Tue, 26 Feb 2019 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551220471;
        bh=EhSwc8YZXpNLa457hu+6PsYYq1FYt0pMKcWYUIlYCSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jI+lGYBgVD+nUUzZMkqIsZXvF/TmO56M6kLugzmh06R6b5le6QM2oabRAunMnkJKh
         zGZ0+tP/ZumBp3raKeqZtnC9V0mGt3a9r6/2/0CwGjGmPcJphER2R2YE3xVXzZvAqf
         2tQjuZnEwxjM4BvMI5zxxiepgAHsp2LDUWG1w+KE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 2/8] clk: core: clarify the check for runtime PM
Date:   Tue, 26 Feb 2019 14:34:23 -0800
Message-Id: <20190226223429.193873-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226223429.193873-1-sboyd@kernel.org>
References: <20190226223429.193873-1-sboyd@kernel.org>
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
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
[sboyd@kernel.org: Change to a boolean flag]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fef937ea44f4..d46e8b9b9c9f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -57,6 +57,7 @@ struct clk_core {
 	struct clk_core		*new_child;
 	unsigned long		flags;
 	bool			orphan;
+	bool			rpm_enabled;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned int		protect_count;
@@ -92,9 +93,9 @@ struct clk {
 /***           runtime pm          ***/
 static int clk_pm_runtime_get(struct clk_core *core)
 {
-	int ret = 0;
+	int ret;
 
-	if (!core->dev)
+	if (!core->rpm_enabled)
 		return 0;
 
 	ret = pm_runtime_get_sync(core->dev);
@@ -103,7 +104,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
 
 static void clk_pm_runtime_put(struct clk_core *core)
 {
-	if (!core->dev)
+	if (!core->rpm_enabled)
 		return;
 
 	pm_runtime_put_sync(core->dev);
@@ -223,7 +224,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	 * taking enable spinlock, but the below check is needed if one tries
 	 * to call it from other places.
 	 */
-	if (core->dev) {
+	if (core->rpm_enabled) {
 		pm_runtime_get_noresume(core->dev);
 		if (!pm_runtime_active(core->dev)) {
 			ret = false;
@@ -233,7 +234,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 
 	ret = core->ops->is_enabled(core->hw);
 done:
-	if (core->dev)
+	if (core->rpm_enabled)
 		pm_runtime_put(core->dev);
 
 	return ret;
@@ -3341,7 +3342,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
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

