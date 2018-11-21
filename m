Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BC3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472FF214DE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Rhs4F3Dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472FF214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbeKVAFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:05:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60000 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbeKVAFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hwCaOpkVJpY7QqfFdxeEwXVxJRI8H1PYgyv8O0XdmBs=; b=Rhs4F3DhzcKy
        lAY2t5Rvm3ZiPAjY4ecwtUgHP3HuGERQZAx5f2Zao53dYiDc+0LqCZGubDn6mRJr2WN1z1rLfBWqZ
        NPKULpRs3tuDF0UI76hdOHl8z1vWrK0vhUN/lNHlUwv6OT7NAjjVrkkmIOHYbVFsZt2rQIoqGvxIV
        lhoko=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gPSaY-0003Zx-Mb; Wed, 21 Nov 2018 13:30:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5D9C411250AE; Wed, 21 Nov 2018 13:30:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Avoid propagating to supplies when possible" to the regulator tree
In-Reply-To: 
Message-Id: <20181121133042.5D9C411250AE@debutante.sirena.org.uk>
Date:   Wed, 21 Nov 2018 13:30:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Avoid propagating to supplies when possible

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

From 488c008a7b7c88b0989ab165f9d0d89ee0777add Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Tue, 20 Nov 2018 09:52:54 -0800
Subject: [PATCH] regulator: core: Avoid propagating to supplies when possible

When we called regulator_enable() on a regulator we'd end up
propagating that call all the way up the chain every time.  This is a
bit of a waste of time.  A child regulator already refcounts its own
enables so it should avoid passing on to its parent unless the
refcount transitioned between 0 and 1.

Historically this hasn't been a huge problem since we skipped dealing
with enable for always-on regulators.  In a previous patch, however,
we removed the always-on optimization.  On one system, the debugfs
regulator_summary was now showing a "use_count" of 33 for a top-level
regulator.

Let's implement this optimization.  This turns out to be fairly
trivial with the recent reorganization of the regulator core.

NOTE: as part of this patch I'll make "always-on" regulators start
with a use count of 1.  This keeps the counts clean when recursively
resolving regulators.

ALSO NOTE: this commit also contains somewhat of a bug fix to
regulator_force_disable().  It was incorrectly looping over
"rdev->open_count" when it should have been looping over use_count.
We have to touch that code anyway (since we should no longer loop at
all), so we'll fix it together in one patch.  Also: since this comes
after commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for
regulators locking") we can now move to use _regulator_disable() for
our supply and keep it in the lock.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 26a0c523ed86..03a03763457c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1822,6 +1822,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			rdev->supply = NULL;
 			return ret;
 		}
+		rdev->use_count = 1;
 	}
 
 	return 0;
@@ -2491,7 +2492,7 @@ static int _regulator_enable(struct regulator *regulator)
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
-	if (rdev->supply) {
+	if (rdev->use_count == 0 && rdev->supply) {
 		ret = _regulator_enable(rdev->supply);
 		if (ret < 0)
 			return ret;
@@ -2539,7 +2540,7 @@ static int _regulator_enable(struct regulator *regulator)
 	_regulator_handle_consumer_disable(regulator);
 
 err_disable_supply:
-	if (rdev->supply)
+	if (rdev->use_count == 0 && rdev->supply)
 		_regulator_disable(rdev->supply);
 
 	return ret;
@@ -2648,7 +2649,7 @@ static int _regulator_disable(struct regulator *regulator)
 	if (ret == 0 && rdev->coupling_desc.n_coupled > 1)
 		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 
-	if (ret == 0 && rdev->supply)
+	if (ret == 0 && rdev->use_count == 0 && rdev->supply)
 		ret = _regulator_disable(rdev->supply);
 
 	return ret;
@@ -2733,11 +2734,10 @@ int regulator_force_disable(struct regulator *regulator)
 		ret = drms_uA_update(rdev);
 	}
 
-	regulator_unlock_dependent(rdev, &ww_ctx);
+	if (rdev->use_count != 0 && rdev->supply)
+		_regulator_disable(rdev->supply);
 
-	if (rdev->supply)
-		while (rdev->open_count--)
-			regulator_disable(rdev->supply);
+	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	return ret;
 }
-- 
2.19.0.rc2

