Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCC6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F572077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ESqpBdf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F572077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeICUse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:48:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbeICUsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Su9PGjLLF+1b0Pjtq2B9fgEremfcJ1OHBLBSfhqBU6o=; b=ESqpBdf1omCP
        kr1HP8h5AmFdj1lDPl30av3xcaaK3sK5RkriOnOyGCFXh4glapd2SlcImkTxph1H9p9/q1THppUoV
        eTi1W+fv3ANFuGX/6erxhINlLm7rnaIyKqCJwivJGosnWOzmEMhEGys/Hemv/CdTg1gUsPhZvMFL8
        4pG5k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwrhR-0000Ss-TZ; Mon, 03 Sep 2018 16:27:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A219011227AE; Mon,  3 Sep 2018 17:27:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: Fix 'do-nothing' value for regulators without suspend state" to the regulator tree
In-Reply-To: 
Message-Id: <20180903162737.A219011227AE@debutante.sirena.org.uk>
Date:   Mon,  3 Sep 2018 17:27:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Fix 'do-nothing' value for regulators without suspend state

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 3edd79cf5a44b12dbb13bc320f5788aed6562b36 Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Mon, 3 Sep 2018 16:49:37 +0200
Subject: [PATCH] regulator: Fix 'do-nothing' value for regulators without
 suspend state

Some regulators don't have all states defined and in such cases regulator
core should not assume anything. However in current implementation
of of_get_regulation_constraints() DO_NOTHING_IN_SUSPEND enable value was
set only for regulators which had suspend node defined, otherwise the
default 0 value was used, what means DISABLE_IN_SUSPEND. This lead to
broken system suspend/resume on boards, which had simple regulator
constraints definition (without suspend state nodes).

To avoid further mismatches between the default and uninitialized values
of the suspend enabled/disabled states, change the values of the them,
so default '0' means DO_NOTHING_IN_SUSPEND.

Fixes: 72069f9957a1: regulator: leave one item to record whether regulator is enabled
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/regulator/core.c          | 2 +-
 drivers/regulator/of_regulator.c  | 2 --
 include/linux/regulator/machine.h | 6 +++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bb1324f93143..90215f57270f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3161,7 +3161,7 @@ static inline int regulator_suspend_toggle(struct regulator_dev *rdev,
 	if (!rstate->changeable)
 		return -EPERM;
 
-	rstate->enabled = en;
+	rstate->enabled = (en) ? ENABLE_IN_SUSPEND : DISABLE_IN_SUSPEND;
 
 	return 0;
 }
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 638f17d4c848..210fc20f7de7 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -213,8 +213,6 @@ static void of_get_regulation_constraints(struct device_node *np,
 		else if (of_property_read_bool(suspend_np,
 					"regulator-off-in-suspend"))
 			suspend_state->enabled = DISABLE_IN_SUSPEND;
-		else
-			suspend_state->enabled = DO_NOTHING_IN_SUSPEND;
 
 		if (!of_property_read_u32(np, "regulator-suspend-min-microvolt",
 					  &pval))
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 3468703d663a..a459a5e973a7 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -48,9 +48,9 @@ struct regulator;
  * DISABLE_IN_SUSPEND	- turn off regulator in suspend states
  * ENABLE_IN_SUSPEND	- keep regulator on in suspend states
  */
-#define DO_NOTHING_IN_SUSPEND	(-1)
-#define DISABLE_IN_SUSPEND	0
-#define ENABLE_IN_SUSPEND	1
+#define DO_NOTHING_IN_SUSPEND	0
+#define DISABLE_IN_SUSPEND	1
+#define ENABLE_IN_SUSPEND	2
 
 /* Regulator active discharge flags */
 enum regulator_active_discharge {
-- 
2.19.0.rc1

