Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3CBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C8120659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Rb4ORm8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C8120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeK0EQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:16:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48402 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeK0EQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EARQYgnozo85tHMZRDTwCcgCBiCQX/rDMHhyAFuC2Qc=; b=Rb4ORm8u/FRt
        vMu0VKdzxFZbOR2NXd1Myl2zsEnkPIap0tEz+9TNoePR06HI1SWZcGdhAbO/O2YdiwnHgGfig5Apu
        nkdmnUKKbTBzPZ8OfZK5XY/tgavBRnDfMJVwCcKch5J4lpaoB+1c70RtCUO5OQG2943oeVH+7rkU7
        wGMvo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRKZO-0005U1-7s; Mon, 26 Nov 2018 17:21:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EBEEE112519F; Mon, 26 Nov 2018 17:21:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Priit Laes <plaes@plaes.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: enable power when setting up constraints" to the regulator tree
In-Reply-To: 
Message-Id: <20181126172113.EBEEE112519F@debutante.sirena.org.uk>
Date:   Mon, 26 Nov 2018 17:21:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: enable power when setting up constraints

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

From 2bb1666369339f69f227ad060c250afde94d5c69 Mon Sep 17 00:00:00 2001
From: Olliver Schinagl <oliver@schinagl.nl>
Date: Mon, 26 Nov 2018 17:27:44 +0200
Subject: [PATCH] regulator: core: enable power when setting up constraints

When a regulator is marked as always on, it is enabled early on, when
checking and setting up constraints. It makes the assumption that the
bootloader properly initialized the regulator, and just in case enables
the regulator anyway.

Some constraints however currently get missed, such as the soft-start
and ramp-delay. This causes the regulator to be enabled, without the
soft-start and ramp-delay being applied, which in turn can cause
high-currents or other start-up problems.

By moving the always-enabled constraints later in the constraints check,
we can at least ensure all constraints for the regulator are followed.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b528aede..6e146102fd93 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1158,17 +1158,6 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
-	/* If the constraints say the regulator should be on at this point
-	 * and we have control then make sure it is enabled.
-	 */
-	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
-		ret = _regulator_do_enable(rdev);
-		if (ret < 0 && ret != -EINVAL) {
-			rdev_err(rdev, "failed to enable\n");
-			return ret;
-		}
-	}
-
 	if ((rdev->constraints->ramp_delay || rdev->constraints->ramp_disable)
 		&& ops->set_ramp_delay) {
 		ret = ops->set_ramp_delay(rdev, rdev->constraints->ramp_delay);
@@ -1214,6 +1203,17 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
+	/* If the constraints say the regulator should be on at this point
+	 * and we have control then make sure it is enabled.
+	 */
+	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		ret = _regulator_do_enable(rdev);
+		if (ret < 0 && ret != -EINVAL) {
+			rdev_err(rdev, "failed to enable\n");
+			return ret;
+		}
+	}
+
 	print_constraints(rdev);
 	return 0;
 }
-- 
2.19.0.rc2

