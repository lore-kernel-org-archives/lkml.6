Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E95AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D5322360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Dg5ZI6Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D5322360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbeKNKkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:40:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35428 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeKNKjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=koKHZHVkpUws1QEnAmJ3qb65OYHjUgL5OI7TZ5freqQ=; b=Dg5ZI6LdBigE
        ybkgK0vd1MOeTdg2jfkHOf7VSCSjdgrGF/R/p5nwLll13teYg+yMqCh/TP9QWGZarMkC1+qwTU4XZ
        ssGZ6uvxNGRP/18Edbswy/+Y95Pvy4DBO3CfX7Nizkq+swbfxzrKFY5OVw0MoE6mGtfIdtzoz8xWK
        ZgydI=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMjCw-0002pQ-V0; Wed, 14 Nov 2018 00:39:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 12B22440079; Wed, 14 Nov 2018 00:38:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd718x7: Change next state after poweroff to ready" to the regulator tree
In-Reply-To: 
Message-Id: <20181114003859.12B22440079@finisterre.ee.mobilebroadband>
Date:   Wed, 14 Nov 2018 00:38:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd718x7: Change next state after poweroff to ready

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

From e770b18bbbaecebfb37389b45bf82974a17488d7 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Wed, 7 Nov 2018 15:41:26 +0200
Subject: [PATCH] regulator: bd718x7: Change next state after poweroff to ready

BD71837 and BD71847 have a HW functionality which leave power
rails OFF after powerof state:
- if they have been controlled by SW.
- if state transition from poweroff is done to SNVS

BD71837 can after reset transition from power-off to SNVS or
READY state depending on reset reason. By default only wathcdog
reset changes state from poweroff to ready. Change PMIC
configuration to always transition to READY in order to avoid
crucial power rails being OFF after reset.

If SNVS is required the crucial power rails should not be
controlled by SW - eg corresponding regulator control register
should have SEL bit kept zero. Currently the driver assumes all
regulators to be controlled by SW so it sets all SEL bits to 1.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd718x7-regulator.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 512c936ae021..e63581651d69 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1054,6 +1054,29 @@ static int bd718xx_probe(struct platform_device *pdev)
 			BD718XX_REG_REGLOCK);
 	}
 
+	/* At poweroff transition PMIC HW disables EN bit for regulators but
+	 * leaves SEL bit untouched. So if state transition from POWEROFF
+	 * is done to SNVS - then all power rails controlled by SW (having
+	 * SEL bit set) stay disabled as EN is cleared. This may result boot
+	 * failure if any crucial systems are powered by these rails.
+	 *
+	 * Change the next stage from poweroff to be READY instead of SNVS
+	 * for all reset types because OTP loading at READY will clear SEL
+	 * bit allowing HW defaults for power rails to be used
+	 */
+	err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
+				 BD718XX_ON_REQ_POWEROFF_MASK |
+				 BD718XX_SWRESET_POWEROFF_MASK |
+				 BD718XX_WDOG_POWEROFF_MASK |
+				 BD718XX_KEY_L_POWEROFF_MASK,
+				 BD718XX_POWOFF_TO_RDY);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to change reset target\n");
+		goto err;
+	} else {
+		dev_dbg(&pdev->dev, "Changed all resets from SVNS to READY\n");
+	}
+
 	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
 
 		const struct regulator_desc *desc;
-- 
2.19.1

