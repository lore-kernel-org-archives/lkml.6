Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E6AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98BD20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Rb/vvnOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98BD20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeKSXeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:34:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49746 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbeKSXd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PVHCJEjTDneJi5GZKepzo6ZLbFfVOSyds3wAGKexYj4=; b=Rb/vvnOsZtzI
        FMlRG7zBzX3NrdRYcMxBKSQCXLKoWk3ybSeeg2BkEqR8SsFqfxqddORfUzBznDKDCwVn5uY1NCnd5
        17BKhdK3RhK+yBiLb2VpVZVBlak37hAvGMkqFHDrR1TI6nCMb9AL0/QreBRPDds9DnuILuvO7hwD5
        3caN8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gOjJn-0000AB-0O; Mon, 19 Nov 2018 13:10:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B83C71125031; Mon, 19 Nov 2018 13:10:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Properly handle case where supply is the couple" to the regulator tree
In-Reply-To: 
Message-Id: <20181119131022.B83C71125031@debutante.sirena.org.uk>
Date:   Mon, 19 Nov 2018 13:10:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Properly handle case where supply is the couple

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

From 089e2cc2e1861ad13a56811aa538419989346089 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Mon, 19 Nov 2018 00:56:18 +0300
Subject: [PATCH] regulator: core: Properly handle case where supply is the
 couple

Check whether supply regulator is the couple to avoid infinite recursion
during of locking.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 47ccd35c7965..e46e53aa43db 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -233,6 +233,21 @@ void regulator_unlock(struct regulator_dev *rdev)
 	mutex_unlock(&regulator_nesting_mutex);
 }
 
+static bool regulator_supply_is_couple(struct regulator_dev *rdev)
+{
+	struct regulator_dev *c_rdev;
+	int i;
+
+	for (i = 1; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+
+		if (rdev->supply->rdev == c_rdev)
+			return true;
+	}
+
+	return false;
+}
+
 static void regulator_unlock_recursive(struct regulator_dev *rdev,
 				       unsigned int n_coupled)
 {
@@ -245,7 +260,7 @@ static void regulator_unlock_recursive(struct regulator_dev *rdev,
 		if (!c_rdev)
 			continue;
 
-		if (c_rdev->supply)
+		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev))
 			regulator_unlock_recursive(
 					c_rdev->supply->rdev,
 					c_rdev->coupling_desc.n_coupled);
@@ -283,7 +298,7 @@ static int regulator_lock_recursive(struct regulator_dev *rdev,
 			*old_contended_rdev = NULL;
 		}
 
-		if (c_rdev->supply) {
+		if (c_rdev->supply && !regulator_supply_is_couple(c_rdev)) {
 			err = regulator_lock_recursive(c_rdev->supply->rdev,
 						       new_contended_rdev,
 						       old_contended_rdev,
-- 
2.19.0.rc2

