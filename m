Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC9CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2442087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="v2wRyF4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2442087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeH2BCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47888 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeH2BCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6uB11fIjJAwX7yreMB2AsAJ/bdBVIdEZXjO3SQiq6e4=; b=v2wRyF4E6HsP
        cr4dQcaDHRmxIMOkNSG7Lcer12snHDrK0MiBDc0W6heLDCbO+xFI1MFdtdVUKLEzZri+1Besy7CMA
        +PgZd+hRkFrywQelQGssm1LQ+rrTkdHwuwFlbOZUIZAVD40ajh0glBlG0HCJqGYCE244o44ILOkCj
        PuZmo=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE1-0007lv-F1; Tue, 28 Aug 2018 21:08:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5782344007F; Tue, 28 Aug 2018 21:55:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: regmap helpers - support overlapping linear ranges" to the regulator tree
In-Reply-To: 
Message-Id: <20180828205501.5782344007F@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:55:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: regmap helpers - support overlapping linear ranges

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

From e7d80b6b848b4b5f83d3fbee9fd042d036ede9c6 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Wed, 22 Aug 2018 12:53:27 +0300
Subject: [PATCH] regulator: regmap helpers - support overlapping linear ranges

Don't give up voltage mapping if first range with suitable min/max uV
does not provide the wanted voltage.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/helpers.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 2ae7c3ac5940..ef09021dc46e 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -321,17 +321,18 @@ int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
 
 		ret += range->min_sel;
 
-		break;
+		/*
+		 * Map back into a voltage to verify we're still in bounds.
+		 * If we are not, then continue checking rest of the ranges.
+		 */
+		voltage = rdev->desc->ops->list_voltage(rdev, ret);
+		if (voltage >= min_uV && voltage <= max_uV)
+			break;
 	}
 
 	if (i == rdev->desc->n_linear_ranges)
 		return -EINVAL;
 
-	/* Map back into a voltage to verify we're still in bounds */
-	voltage = rdev->desc->ops->list_voltage(rdev, ret);
-	if (voltage < min_uV || voltage > max_uV)
-		return -EINVAL;
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_map_voltage_linear_range);
-- 
2.18.0

