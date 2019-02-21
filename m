Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ED5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E372C20836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550776405;
	bh=IK2SoKeoaYJYd44LrdbovK8DvUmFVXleIYERXyU8KDQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=llr7k8OlDZ3OS0DISCU1x6VVY0IexjWJSIO+6zGCz/n+sPZspTt1WUQ6MWxp2mWHf
	 bWKHubMmt+OxhcYiOy20fnnxA4Lgf0TlH8B8EXYwmiEDZjqfASmgTwoS4vQXc+8Ow4
	 FCL3OP08FSaH4LxF3+eIRiGY1hVvWYXJRCT510AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfBUTNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:13:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38164 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfBUTNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1bNFILHZPnKluK4Pa3hEdoxanOGy6NvHMjtW+iRGedM=; b=obe0+9MlgbOC
        D7clzwjivc/JEiXpCvfNpZFu926Rzq2LG0rb+uXZXOgTl7h8AZQ2LpslEOfmQAhby85eaQ/xSf93E
        JS5tYTYXlvboCCRuw3qnFYKeor68SwLwR4FX/aMW0RQNCyeVu9vSG+6gKUShZeWduI53fcghPMi//
        1UjZA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwtmZ-0005xQ-I8; Thu, 21 Feb 2019 19:13:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B9F0511227D7; Thu, 21 Feb 2019 19:13:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Log forbidden DRMS operation" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190221191318.B9F0511227D7@debutante.sirena.org.uk>
Date:   Thu, 21 Feb 2019 19:13:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Log forbidden DRMS operation

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

From 74a569ee4c452e2a1c997f034837ddae500734ca Mon Sep 17 00:00:00 2001
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Date: Thu, 21 Feb 2019 12:55:22 +0100
Subject: [PATCH] regulator: core: Log forbidden DRMS operation

When REGULATOR_CHANGE_DRMS is not set, drms_uA_update is a no-op.
It used to print a debug message, which was dropped in commit
8a34e979f684 ("regulator: refactor valid_ops_mask checking code")

Let's bring the debug message back, because it helps find missing
regulator-allow-set-load properties.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9cf09666616f..68473d0cc57e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -918,8 +918,10 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	 * first check to see if we can set modes at all, otherwise just
 	 * tell the consumer everything is OK.
 	 */
-	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS))
+	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS)) {
+		rdev_dbg(rdev, "DRMS operation not allowed\n");
 		return 0;
+	}
 
 	if (!rdev->desc->ops->get_optimum_mode &&
 	    !rdev->desc->ops->set_load)
-- 
2.20.1

