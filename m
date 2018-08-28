Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0145A208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xfYSEXgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0145A208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeH2BCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47782 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeH2BCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=J0VdibBmrXSeqAQMa1qNkktcA6keB0VuwzCYmlrsnxY=; b=xfYSEXgkgFos
        rkqC8SBxN50w4s3GHQcihu2V4YgOSS1rlKDO2i9BGXgrh9W1j/s1DKwPTjB6zJ/5dom/fsOkHCrbw
        HpAm0e+Z/1UbEn76TLHUYzCmYEQ6sQ7kd/8b/rlRcjUeeBEQlXBCumN6OVo+T6jZEs4rqtO64qGNu
        r5cVU=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE1-0007ll-1G; Tue, 28 Aug 2018 21:08:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1AD74440079; Tue, 28 Aug 2018 21:54:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Add locking to debugfs regulator_summary" to the regulator tree
In-Reply-To: 
Message-Id: <20180828205454.1AD74440079@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:54:54 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Add locking to debugfs regulator_summary

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

From 7e4d9683d6a716533f5c5026795b7b1ebdbcb2ed Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Thu, 16 Aug 2018 13:28:03 -0700
Subject: [PATCH] regulator: core: Add locking to debugfs regulator_summary

Most functions that access the rdev lock the rdev mutex before looking
at data.  ...but not the code that implements the debugfs
regulator_summary.  It probably should though, so let's do it.

Note: this fixes no known issues.  The problem was found only by code
inspection.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 51 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index df55cf8f09f0..f686f2311317 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3475,21 +3475,23 @@ int regulator_set_current_limit(struct regulator *regulator,
 }
 EXPORT_SYMBOL_GPL(regulator_set_current_limit);
 
+static int _regulator_get_current_limit_unlocked(struct regulator_dev *rdev)
+{
+	/* sanity check */
+	if (!rdev->desc->ops->get_current_limit)
+		return -EINVAL;
+
+	return rdev->desc->ops->get_current_limit(rdev);
+}
+
 static int _regulator_get_current_limit(struct regulator_dev *rdev)
 {
 	int ret;
 
 	regulator_lock(rdev);
-
-	/* sanity check */
-	if (!rdev->desc->ops->get_current_limit) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = rdev->desc->ops->get_current_limit(rdev);
-out:
+	ret = _regulator_get_current_limit_unlocked(rdev);
 	regulator_unlock(rdev);
+
 	return ret;
 }
 
@@ -3554,21 +3556,23 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 }
 EXPORT_SYMBOL_GPL(regulator_set_mode);
 
+static unsigned int _regulator_get_mode_unlocked(struct regulator_dev *rdev)
+{
+	/* sanity check */
+	if (!rdev->desc->ops->get_mode)
+		return -EINVAL;
+
+	return rdev->desc->ops->get_mode(rdev);
+}
+
 static unsigned int _regulator_get_mode(struct regulator_dev *rdev)
 {
 	int ret;
 
 	regulator_lock(rdev);
-
-	/* sanity check */
-	if (!rdev->desc->ops->get_mode) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = rdev->desc->ops->get_mode(rdev);
-out:
+	ret = _regulator_get_mode_unlocked(rdev);
 	regulator_unlock(rdev);
+
 	return ret;
 }
 
@@ -4675,18 +4679,23 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 	struct regulation_constraints *c;
 	struct regulator *consumer;
 	struct summary_data summary_data;
+	unsigned int opmode;
 
 	if (!rdev)
 		return;
 
+	regulator_lock_nested(rdev, level);
+
+	opmode = _regulator_get_mode_unlocked(rdev);
 	seq_printf(s, "%*s%-*s %3d %4d %6d %7s ",
 		   level * 3 + 1, "",
 		   30 - level * 3, rdev_get_name(rdev),
 		   rdev->use_count, rdev->open_count, rdev->bypass_count,
-		   regulator_opmode_to_str(_regulator_get_mode(rdev)));
+		   regulator_opmode_to_str(opmode));
 
 	seq_printf(s, "%5dmV ", _regulator_get_voltage(rdev) / 1000);
-	seq_printf(s, "%5dmA ", _regulator_get_current_limit(rdev) / 1000);
+	seq_printf(s, "%5dmA ",
+		   _regulator_get_current_limit_unlocked(rdev) / 1000);
 
 	c = rdev->constraints;
 	if (c) {
@@ -4733,6 +4742,8 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 	class_for_each_device(&regulator_class, NULL, &summary_data,
 			      regulator_summary_show_children);
+
+	regulator_unlock(rdev);
 }
 
 static int regulator_summary_show_roots(struct device *dev, void *data)
-- 
2.18.0

