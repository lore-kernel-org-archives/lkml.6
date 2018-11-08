Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A90ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2202086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="itu9acpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2202086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeKIBzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:55:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46180 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeKIBzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4RnQwMrRU/eQtgPaDJIzigLxXGFEDIUqgZqI9+V0OHg=; b=itu9acpb7yAL
        O3wZkpl0IEqkJVPyj2BOg6edlirtiOyY9+QsA7sPR1wRu/Org+lJP38qwDSP3nGGZkEMUxXVlIOYO
        WRZ0PFGX5G+7vJwJaiew/dLzHyX1GqZqtXg3rLvZ8xZBS1e/Wdsn6SED/d7zTFssAcQ1GAvVra+KA
        z1SlQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKn14-0000CZ-3P; Thu, 08 Nov 2018 16:18:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C884E1124D9E; Thu,  8 Nov 2018 16:18:45 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Mutually resolve regulators coupling" to the regulator tree
In-Reply-To: 
Message-Id: <20181108161845.C884E1124D9E@debutante.sirena.org.uk>
Date:   Thu,  8 Nov 2018 16:18:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Mutually resolve regulators coupling

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

From f9503385b1877ac34514cd5ea7683eee61c4bec3 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 5 Oct 2018 18:36:30 +0300
Subject: [PATCH] regulator: core: Mutually resolve regulators coupling

If registered regulator found a couple, then the couple can find the
registered regulator too and hence coupling can be mutually resolved
at the registration time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 54 +++++++++++++---------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5105eaaf3cef..925df9e6f1e3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4439,7 +4439,7 @@ static int regulator_register_resolve_supply(struct device *dev, void *data)
 	return 0;
 }
 
-static int regulator_fill_coupling_array(struct regulator_dev *rdev)
+static void regulator_resolve_coupling(struct regulator_dev *rdev)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	int n_coupled = c_desc->n_coupled;
@@ -4453,33 +4453,21 @@ static int regulator_fill_coupling_array(struct regulator_dev *rdev)
 
 		c_rdev = of_parse_coupled_regulator(rdev, i - 1);
 
-		if (c_rdev) {
-			c_desc->coupled_rdevs[i] = c_rdev;
-			c_desc->n_resolved++;
-		}
-	}
-
-	if (rdev->coupling_desc.n_resolved < n_coupled)
-		return -1;
-	else
-		return 0;
-}
+		if (!c_rdev)
+			continue;
 
-static int regulator_register_fill_coupling_array(struct device *dev,
-						  void *data)
-{
-	struct regulator_dev *rdev = dev_to_rdev(dev);
+		regulator_lock(c_rdev);
 
-	if (!IS_ENABLED(CONFIG_OF))
-		return 0;
+		c_desc->coupled_rdevs[i] = c_rdev;
+		c_desc->n_resolved++;
 
-	if (regulator_fill_coupling_array(rdev))
-		rdev_dbg(rdev, "unable to resolve coupling\n");
+		regulator_unlock(c_rdev);
 
-	return 0;
+		regulator_resolve_coupling(c_rdev);
+	}
 }
 
-static int regulator_resolve_coupling(struct regulator_dev *rdev)
+static int regulator_init_coupling(struct regulator_dev *rdev)
 {
 	int n_phandles;
 
@@ -4519,13 +4507,6 @@ static int regulator_resolve_coupling(struct regulator_dev *rdev)
 	if (!of_check_coupling_data(rdev))
 		return -EPERM;
 
-	/*
-	 * After everything has been checked, try to fill rdevs array
-	 * with pointers to regulators parsed from device tree. If some
-	 * regulators are not registered yet, retry in late init call
-	 */
-	regulator_fill_coupling_array(rdev);
-
 	return 0;
 }
 
@@ -4662,11 +4643,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto wash;
 
-	mutex_lock(&regulator_list_mutex);
-	ret = regulator_resolve_coupling(rdev);
-	mutex_unlock(&regulator_list_mutex);
-
-	if (ret != 0)
+	ret = regulator_init_coupling(rdev);
+	if (ret < 0)
 		goto wash;
 
 	/* add consumers devices */
@@ -4700,6 +4678,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	rdev_init_debugfs(rdev);
 
+	/* try to resolve regulators coupling since a new one was registered */
+	mutex_lock(&regulator_list_mutex);
+	regulator_resolve_coupling(rdev);
+	mutex_unlock(&regulator_list_mutex);
+
 	/* try to resolve regulators supply since a new one was registered */
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_register_resolve_supply);
@@ -5155,9 +5138,6 @@ static int __init regulator_init_complete(void)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_late_cleanup);
 
-	class_for_each_device(&regulator_class, NULL, NULL,
-			      regulator_register_fill_coupling_array);
-
 	return 0;
 }
 late_initcall_sync(regulator_init_complete);
-- 
2.19.0.rc2

