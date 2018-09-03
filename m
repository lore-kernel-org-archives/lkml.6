Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB60EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8876C20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="o2/QbgRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8876C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeICUsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:48:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44582 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeICUsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qxswO6P7SlpEoam5zw5HNTMzFANv0kLdseJFUHJWdVw=; b=o2/QbgRn0Xgf
        RVntJwtnibhu9f0rgBAmuHuzFMDpMzIpAv16RqQp+1FWh4MG+fVl3Wro4D7XD0DXMVcM2LgovIpyy
        uc5LQSx4e7TkhWBt+bnIJcMs1LvIewuSmxEpwhDOBzffpVy37psIcdXbACXEW0scr5IOmiHe+fPhK
        9g3CQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwrhQ-0000Sn-2Q; Mon, 03 Sep 2018 16:27:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C782111227AE; Mon,  3 Sep 2018 17:27:35 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Fix useless O^2 complexity in suspend/resume" to the regulator tree
In-Reply-To: 
Message-Id: <20180903162735.C782111227AE@debutante.sirena.org.uk>
Date:   Mon,  3 Sep 2018 17:27:35 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Fix useless O^2 complexity in suspend/resume

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

From cd7e36ab7222af85597517bafd66013cbc8f9877 Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Mon, 3 Sep 2018 16:49:36 +0200
Subject: [PATCH] regulator: Fix useless O^2 complexity in suspend/resume

regulator_pm_ops with regulator_suspend and regulator_resume functions are
assigned to every regulator device registered in the system, so there is no
need to iterate over all again in them. Replace class_for_each_device()
construction with direct operation on the rdev embedded in the given
regulator device. This saves a lots of useless operations in suspend and
resume paths.

Fixes: f7efad10b5c4: regulator: add PM suspend and resume hooks
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f686f2311317..a147871af09b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4464,19 +4464,6 @@ void regulator_unregister(struct regulator_dev *rdev)
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
 #ifdef CONFIG_SUSPEND
-static int _regulator_suspend(struct device *dev, void *data)
-{
-	struct regulator_dev *rdev = dev_to_rdev(dev);
-	suspend_state_t *state = data;
-	int ret;
-
-	regulator_lock(rdev);
-	ret = suspend_set_state(rdev, *state);
-	regulator_unlock(rdev);
-
-	return ret;
-}
-
 /**
  * regulator_suspend - prepare regulators for system wide suspend
  * @state: system suspend state
@@ -4485,20 +4472,25 @@ static int _regulator_suspend(struct device *dev, void *data)
  */
 static int regulator_suspend(struct device *dev)
 {
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 	suspend_state_t state = pm_suspend_target_state;
+	int ret;
+
+	regulator_lock(rdev);
+	ret = suspend_set_state(rdev, state);
+	regulator_unlock(rdev);
 
-	return class_for_each_device(&regulator_class, NULL, &state,
-				     _regulator_suspend);
+	return ret;
 }
 
-static int _regulator_resume(struct device *dev, void *data)
+static int regulator_resume(struct device *dev)
 {
-	int ret = 0;
+	suspend_state_t state = pm_suspend_target_state;
 	struct regulator_dev *rdev = dev_to_rdev(dev);
-	suspend_state_t *state = data;
 	struct regulator_state *rstate;
+	int ret = 0;
 
-	rstate = regulator_get_suspend_state(rdev, *state);
+	rstate = regulator_get_suspend_state(rdev, state);
 	if (rstate == NULL)
 		return 0;
 
@@ -4513,15 +4505,6 @@ static int _regulator_resume(struct device *dev, void *data)
 
 	return ret;
 }
-
-static int regulator_resume(struct device *dev)
-{
-	suspend_state_t state = pm_suspend_target_state;
-
-	return class_for_each_device(&regulator_class, NULL, &state,
-				     _regulator_resume);
-}
-
 #else /* !CONFIG_SUSPEND */
 
 #define regulator_suspend	NULL
-- 
2.19.0.rc1

