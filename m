Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8650AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4045A20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VSeuobp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4045A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeHaTvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:51:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60646 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHaTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OTvCuW+pDd487NXQ+3lKvOx2mLmHKI17YIgc1srsgDk=; b=VSeuobp5zuZz
        rPdVufrc8T9hBCppZHZsn9ayske2mp0r9shNyw05EV+LQiQfTd3KbE3GXaOHG/FB1sOOiU0Pz9jLV
        xhVYHKHOBzFuR0wuiiqHJWP00r3B8BsOtHoEp19W2LTe/E30he0Z2eS92dITe2JTCej8w8nd/aX0y
        uMjyQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fvlZg-0003y4-Ga; Fri, 31 Aug 2018 15:43:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4360E11226FE; Fri, 31 Aug 2018 16:43:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9063: fix DT probing with constraints" to the regulator tree
In-Reply-To: 
Message-Id: <20180831154304.4360E11226FE@debutante.sirena.org.uk>
Date:   Fri, 31 Aug 2018 16:43:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: fix DT probing with constraints

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

From ef394f3fbecbe61d69450ad8cf0fa8f713c8ce8f Mon Sep 17 00:00:00 2001
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 31 Aug 2018 14:34:02 +0200
Subject: [PATCH] regulator: da9063: fix DT probing with constraints

Commit 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
reordered the da9063_regulator_info[] array, but not the DA9063_ID_*
regulator ids and not the da9063_matches[] array, because ids are used
as indices in the array initializer. This mismatch between regulator id
and da9063_regulator_info[] array index causes the driver probe to fail
because constraints from DT are not applied to the correct regulator:

  da9063 0-0058: Device detected (chip-ID: 0x61, var-ID: 0x50)
  DA9063_BMEM: Bringing 900000uV into 3300000-3300000uV
  DA9063_LDO9: Bringing 3300000uV into 2500000-2500000uV
  DA9063_LDO1: Bringing 900000uV into 3300000-3300000uV
  DA9063_LDO1: failed to apply 3300000-3300000uV constraint(-22)

This patch reorders the DA9063_ID_* as apparently intended, and with
them the entries in the da90630_matches[] array.

Fixes: 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/mfd/da9063/pdata.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
index 8a125701ef7b..50bed4f89c1a 100644
--- a/include/linux/mfd/da9063/pdata.h
+++ b/include/linux/mfd/da9063/pdata.h
@@ -21,7 +21,7 @@
 /*
  * Regulator configuration
  */
-/* DA9063 regulator IDs */
+/* DA9063 and DA9063L regulator IDs */
 enum {
 	/* BUCKs */
 	DA9063_ID_BCORE1,
@@ -37,18 +37,20 @@ enum {
 	DA9063_ID_BMEM_BIO_MERGED,
 	/* When two BUCKs are merged, they cannot be reused separately */
 
-	/* LDOs */
+	/* LDOs on both DA9063 and DA9063L */
+	DA9063_ID_LDO3,
+	DA9063_ID_LDO7,
+	DA9063_ID_LDO8,
+	DA9063_ID_LDO9,
+	DA9063_ID_LDO11,
+
+	/* DA9063-only LDOs */
 	DA9063_ID_LDO1,
 	DA9063_ID_LDO2,
-	DA9063_ID_LDO3,
 	DA9063_ID_LDO4,
 	DA9063_ID_LDO5,
 	DA9063_ID_LDO6,
-	DA9063_ID_LDO7,
-	DA9063_ID_LDO8,
-	DA9063_ID_LDO9,
 	DA9063_ID_LDO10,
-	DA9063_ID_LDO11,
 };
 
 /* Regulators platform data */
-- 
2.19.0.rc1

