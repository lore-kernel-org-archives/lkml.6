Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E3CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B042B21917
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549552978;
	bh=QI75GPkU4E3XDC3jl4R+eJQ+MBFz9zI1wjbotFZbN54=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=uFUAOxZdKI4AbmK2uPtrlLxDHMMPFXBLqAfZvPVvQvaHk3lKodi0Ng5AxXOV4KMf+
	 UahKuHwLkZMaU2X13kYOesL5Ue5h5T017LoPXPVvs9V9uWMGuhNMz2pWcQoJA2zOVZ
	 b9n1uynPzZwKykRBdApkq5+7PoFv2yOae8j6rq3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfBGPW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:22:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44130 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfBGPWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CeUZUG+he5nZRgLpZPozqc+PmoCQ4AjCgtJK3TA5Tw8=; b=xx5fxIKkWrnH
        gDjlSH3EU7ml2omPRT9e3eGZxWd6w68NT6ZfStPjtb0tiGb2fDJgHY3xeavBtYvLiVONQ3ZbSrS1Z
        tH/nOtoCsmkBKwA7Yqq+a1mtbf+REgqllRQJYWKQIE1SU9rPdX6sfBp56IVdkQMFAtdaD9w/+gjLy
        Vc37E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grlVp-0006P9-VC; Thu, 07 Feb 2019 15:22:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8D4131127EF9; Thu,  7 Feb 2019 15:22:49 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lochnagar: Fix n_voltages setting for VDDCORE" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190207152249.8D4131127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 15:22:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lochnagar: Fix n_voltages setting for VDDCORE

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

From 9df3bb319c449c6723c2c2a1c78db45301fd8669 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 29 Jan 2019 11:01:56 +0800
Subject: [PATCH] regulator: lochnagar: Fix n_voltages setting for VDDCORE

With current n_voltages setting, regulator_list_voltage will return
-EINVAL when selector >=57. The highest selector is 0x41, so the
n_voltages should be 0x41+1, i.e. 66.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lochnagar-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 818d20410518..47f5663e99c8 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -194,7 +194,7 @@ static const struct regulator_desc lochnagar_regulators[] = {
 		.name = "VDDCORE",
 		.supply_name = "SYSVDD",
 		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 57,
+		.n_voltages = 66,
 		.ops = &lochnagar_vddcore_ops,
 
 		.id = LOCHNAGAR_VDDCORE,
-- 
2.20.1

