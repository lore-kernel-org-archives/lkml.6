Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4508121738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547062503;
	bh=ZQiXtrC+SDj1EXLl34L+G8grM5G9YdMHOAWpB4+LU+k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=syzXQF2vfzErmx+DkriLQB1Qt/UQQJWLVXnOLN2ET0orJB9f/ORg4MvomiMXskf4n
	 QOkkZohITStwobTl55d8DkVSHLEcdIuluW9YGb/kT9gZvebsIY+w4dfW8A6BxloVq6
	 ZOMoRfHCWhiOinao/dRBui3xjOetI1/HPrlmdRro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfAITfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:35:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53898 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfAITfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZG3P4sdz2HMQ2KVRvQg9xRVPmf497whzJyZHINpBDas=; b=wT80z84O9j9k
        VZxEkbUc8cu0vmm01C1LHpOXm1jOaa5EoMHCmKR4FBUsXV/s7O1ll7r60kv7ITj2NhxyWQr5JgHYx
        uInZHQNCctwZgFO5Lj5kS8zjV+5LL4PLTBiLzkCZ+MugccSdY01yPsiEKWbK0F0RlahYgcJLwfCnZ
        khoJ8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghJcx-00010o-Er; Wed, 09 Jan 2019 19:34:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 185B71127528; Wed,  9 Jan 2019 19:34:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: provide rdev_get_regmap()" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190109193459.185B71127528@debutante.sirena.org.uk>
Date:   Wed,  9 Jan 2019 19:34:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: provide rdev_get_regmap()

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

From 03c87b95ac04c2a34045641b25dded6e3e889556 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 9 Jan 2019 18:44:00 +0100
Subject: [PATCH] regulator: provide rdev_get_regmap()

Provide a helper allowing to access regulator's regmap.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c         | 6 ++++++
 include/linux/regulator/driver.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3f9d81b6e763..430a73dea487 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5251,6 +5251,12 @@ struct device *rdev_get_dev(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(rdev_get_dev);
 
+struct regmap *rdev_get_regmap(struct regulator_dev *rdev)
+{
+	return rdev->regmap;
+}
+EXPORT_SYMBOL_GPL(rdev_get_regmap);
+
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data)
 {
 	return reg_init_data->driver_data;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 389bcaf7900f..795b38a06b6c 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -503,6 +503,7 @@ int regulator_notifier_call_chain(struct regulator_dev *rdev,
 
 void *rdev_get_drvdata(struct regulator_dev *rdev);
 struct device *rdev_get_dev(struct regulator_dev *rdev);
+struct regmap *rdev_get_regmap(struct regulator_dev *rdev);
 int rdev_get_id(struct regulator_dev *rdev);
 
 int regulator_mode_to_status(unsigned int);
-- 
2.20.1

