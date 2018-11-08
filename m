Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7E2ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EBE2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="i079Mw7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EBE2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeKIByx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:54:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45926 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeKIByw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hLTwyf08YcVX71C/1yx26V1Kuph6S5skr4q3g8pOwPI=; b=i079Mw7Yiszw
        sRACitS+6E7jH7geSbLmZeWFl0YGo1mzyryaBgbdk9yZU8Ms31G7oC9TbNY81Fx+BCmpTOQCXmd9L
        ChN8AiIv44zCPZ5jNnZw9U58BO0V0SzIs8kSWpb40wgT9dt5lDA6xsDQlqV2FUA/dfdLW4NGJH55+
        cG418=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKn0v-0000C5-Uf; Thu, 08 Nov 2018 16:18:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AD2191124D9E; Thu,  8 Nov 2018 16:18:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Add new max_uV_step constraint" to the regulator tree
In-Reply-To: 
Message-Id: <20181108161837.AD2191124D9E@debutante.sirena.org.uk>
Date:   Thu,  8 Nov 2018 16:18:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Add new max_uV_step constraint

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

From 34c7aa1a08e2e28964ccfeff57480697f8ea8056 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 5 Oct 2018 18:36:35 +0300
Subject: [PATCH] regulator: core: Add new max_uV_step constraint

On NVIDIA Tegra30 there is a requirement for regulator "A" to have voltage
higher than voltage of regulator "B" by N microvolts, the N value changes
depending on the voltage of regulator "B". This is similar to min-spread
between voltages of regulators, the difference is that the spread value
isn't fixed. This means that extra carefulness is required for regulator
"A" to drop its voltage without violating the requirement, hence its
voltage should be changed in steps so that its couple "B" could follow
(there is also max-spread requirement).

Add new "max_uV_step" constraint that breaks voltage change into several
steps, each step is limited by the max_uV_step value.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c          | 41 +++++++++++++++++++++++++++++++
 drivers/regulator/of_regulator.c  |  4 +++
 include/linux/regulator/machine.h |  3 +++
 3 files changed, 48 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 089e8ad8ef57..ba03bdf3716f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3191,6 +3191,36 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
+static int regulator_limit_voltage_step(struct regulator_dev *rdev,
+					int *current_uV, int *min_uV)
+{
+	struct regulation_constraints *constraints = rdev->constraints;
+
+	/* Limit voltage change only if necessary */
+	if (!constraints->max_uV_step || !_regulator_is_enabled(rdev))
+		return 1;
+
+	if (*current_uV < 0) {
+		*current_uV = _regulator_get_voltage(rdev);
+
+		if (*current_uV < 0)
+			return *current_uV;
+	}
+
+	if (abs(*current_uV - *min_uV) <= constraints->max_uV_step)
+		return 1;
+
+	/* Clamp target voltage within the given step */
+	if (*current_uV < *min_uV)
+		*min_uV = min(*current_uV + constraints->max_uV_step,
+			      *min_uV);
+	else
+		*min_uV = max(*current_uV - constraints->max_uV_step,
+			      *min_uV);
+
+	return 0;
+}
+
 static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 					 int *current_uV,
 					 int *min_uV, int *max_uV,
@@ -3302,6 +3332,17 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	desired_min_uV = possible_uV;
 
 finish:
+	/* Apply max_uV_step constraint if necessary */
+	if (state == PM_SUSPEND_ON) {
+		ret = regulator_limit_voltage_step(rdev, current_uV,
+						   &desired_min_uV);
+		if (ret < 0)
+			return ret;
+
+		if (ret == 0)
+			done = false;
+	}
+
 	/* Set current_uV if wasn't done earlier in the code and if necessary */
 	if (n_coupled > 1 && *current_uV == -1) {
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c4223b3e0dff..a732f09d207b 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -170,6 +170,10 @@ static void of_get_regulation_constraints(struct device_node *np,
 				  &pval))
 		constraints->max_spread = pval;
 
+	if (!of_property_read_u32(np, "regulator-max-step-microvolt",
+				  &pval))
+		constraints->max_uV_step = pval;
+
 	constraints->over_current_protection = of_property_read_bool(np,
 					"regulator-over-current-protection");
 
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index a459a5e973a7..1d34a70ffda2 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -158,6 +158,9 @@ struct regulation_constraints {
 	/* used for coupled regulators */
 	int max_spread;
 
+	/* used for changing voltage in steps */
+	int max_uV_step;
+
 	/* valid regulator operating modes for this machine */
 	unsigned int valid_modes_mask;
 
-- 
2.19.0.rc2

