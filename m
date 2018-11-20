Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE24C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B10E206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RZKFGtyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B10E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbeKUDkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:40:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbeKUDkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hg8gBcn1dml9Di/gaFGKpCyTQDxzv59Uq4nMZNXOqc8=; b=RZKFGtyvxq3J
        6h23Ce6qydtURskvBXG2/7P/L+Hofj4c+D6hxpUgqDDviNP/6Q6hIptKalvRXCVoImMRYQ0nQraDu
        4nT1svjCuOwkI6drQc2F/ym9dQPsKt+QdlAZi309Kn2p0kkbluMizR2fn0nQUCVyGQ4E5DwLlSU16
        PNa2k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP9Xi-0001qT-3K; Tue, 20 Nov 2018 17:10:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B0B7F1124DC2; Tue, 20 Nov 2018 17:10:29 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Don't double-disable supplies in regulator_disable_deferred()" to the regulator tree
In-Reply-To: 
Message-Id: <20181120171029.B0B7F1124DC2@debutante.sirena.org.uk>
Date:   Tue, 20 Nov 2018 17:10:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Don't double-disable supplies in regulator_disable_deferred()

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

From 8ff00ba79283e691ae294a158879237179c683eb Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 19 Nov 2018 16:26:50 -0800
Subject: [PATCH] regulator: core: Don't double-disable supplies in
 regulator_disable_deferred()

In the commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for
regulators locking") disabling of the supply was moved into
_regulator_disable().  That means regulator_disable_work() shouldn't
be disabling since that double-disables the supply.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f937a33e5f02..cfc2b8f6453b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2670,16 +2670,6 @@ static void regulator_disable_work(struct work_struct *work)
 		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 
 	regulator_unlock_dependent(rdev, &ww_ctx);
-
-	if (rdev->supply) {
-		for (i = 0; i < count; i++) {
-			ret = regulator_disable(rdev->supply);
-			if (ret != 0) {
-				rdev_err(rdev,
-					 "Supply disable failed: %d\n", ret);
-			}
-		}
-	}
 }
 
 /**
-- 
2.19.0.rc2

