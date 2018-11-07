Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41597C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A71420827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IepAuI2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A71420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeKHAb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:31:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40220 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKHAb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FhYOWeXTPN3rKw/TRtfoZ1HT5XTN3j2Jq+SpJrsZtpM=; b=IepAuI2AsRzd
        t3nszoxflyIbp2JIQvhZR5R0n68XqbTUMrwoSTrZiqX2sixw6U6TV3B0m+b6Pw0DxlrapQwdpxn5j
        o1VXEXioywm2XP2Q+RtG9fGvT6qkZ/mRSArSfFYrMnkwoI4rC1UDlkLISGbZTrgjZsRHzkIuDsp3i
        g1ALU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKPKQ-0006b0-MG; Wed, 07 Nov 2018 15:01:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 657B71124E14; Wed,  7 Nov 2018 15:01:10 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd718x7: Remove double indirection for bd718xx_pmic_inits.rdatas" to the regulator tree
In-Reply-To: 
Message-Id: <20181107150110.657B71124E14@debutante.sirena.org.uk>
Date:   Wed,  7 Nov 2018 15:01:10 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd718x7: Remove double indirection for bd718xx_pmic_inits.rdatas

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

From de226ebda96cafa981b9c0fef56888931668b671 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 28 Oct 2018 17:09:22 +0100
Subject: [PATCH] regulator: bd718x7: Remove double indirection for
 bd718xx_pmic_inits.rdatas
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With gcc 4.1:

    drivers/regulator/bd718x7-regulator.c: In function ‘bd718xx_probe’:
    drivers/regulator/bd718x7-regulator.c:1020: warning: initialization from incompatible pointer type
    drivers/regulator/bd718x7-regulator.c:1024: warning: initialization from incompatible pointer type

Apparently this old compiler can't handle the obscure double
indirection.

However, there is no need for a double indirection.  Just store a
pointer to the array instead, like other drivers tend to do.

Fixes: 494edd266b945f36 ("regulator/mfd: Support ROHM BD71847 power management IC")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd718x7-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 3a47e0372e77..fff5bc4faa2c 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1007,7 +1007,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 };
 
 struct bd718xx_pmic_inits {
-	const struct bd718xx_regulator_data (*r_datas)[];
+	const struct bd718xx_regulator_data *r_datas;
 	unsigned int r_amount;
 };
 
@@ -1017,11 +1017,11 @@ static int bd718xx_probe(struct platform_device *pdev)
 	struct regulator_config config = { 0 };
 	struct bd718xx_pmic_inits pmic_regulators[] = {
 		[BD718XX_TYPE_BD71837] = {
-			.r_datas = &bd71837_regulators,
+			.r_datas = bd71837_regulators,
 			.r_amount = ARRAY_SIZE(bd71837_regulators),
 		},
 		[BD718XX_TYPE_BD71847] = {
-			.r_datas = &bd71847_regulators,
+			.r_datas = bd71847_regulators,
 			.r_amount = ARRAY_SIZE(bd71847_regulators),
 		},
 	};
@@ -1059,7 +1059,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 		struct regulator_dev *rdev;
 		const struct bd718xx_regulator_data *r;
 
-		r = &(*pmic_regulators[mfd->chip_type].r_datas)[i];
+		r = &pmic_regulators[mfd->chip_type].r_datas[i];
 		desc = &r->desc;
 
 		config.dev = pdev->dev.parent;
-- 
2.19.0.rc2

