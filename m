Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A165C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4855D217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545241723;
	bh=XiXUvIeyPSPLiGhcEuGiDEiFG79hdmo92d0IgA0s6Y4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FmYAfTVDfrd2As9bZ7GtxqdUU+9114/LQr/UWSqo8hhv0MR6IaORRHeJJuKN+4DkN
	 Lox70fT5sf5sztKAxoHZXGw9TQnAK7dxh1QCWmRBmzCWtQ929W9EuXZzARH++bPoBV
	 bxPm0fgKxWqVJuE+CEHdqg0eGxt6rluZwoY/wDyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeLSRsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:48:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41696 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbeLSRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rULM5IQbzd6+byID8wFrGyhPJoZM2SxJw3bFd0TQTDA=; b=C89phaZs4HPl
        MFUuGLU5b68gpRRgUzaSgnt6oR62WAKVtAYOlODIFjqsqOHiGJVnwmXIXmeuKSiD3IuBPh3/b63gD
        VwdykSSx2msR2Y+CjxqzhSvrj2gqkMFmBK3JgnWBHXcpu3mdqWy6AqU6HVBCeFERXNVNYToj8byWF
        hKP4A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZfxT-00056k-PB; Wed, 19 Dec 2018 17:48:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6929711259E9; Wed, 19 Dec 2018 17:48:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "drivers/regulator: fix a missing check of return value" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181219174835.6929711259E9@debutante.sirena.org.uk>
Date:   Wed, 19 Dec 2018 17:48:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   drivers/regulator: fix a missing check of return value

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

From 966e927bf8cc6a44f8b72582a1d6d3ffc73b12ad Mon Sep 17 00:00:00 2001
From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 18 Dec 2018 23:04:13 -0600
Subject: [PATCH] drivers/regulator: fix a missing check of return value

If palmas_smps_read() fails, we should not use the read data in "reg"
which may contain random value. The fix inserts a check for the return
value of palmas_smps_read(): If it fails, we return the error code
upstream and stop using "reg".

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/palmas-regulator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index bb5ab7d78895..c2cc392a27d4 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -443,13 +443,16 @@ static int palmas_ldo_write(struct palmas *palmas, unsigned int reg,
 static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
 {
 	int id = rdev_get_id(dev);
+	int ret;
 	struct palmas_pmic *pmic = rdev_get_drvdata(dev);
 	struct palmas_pmic_driver_data *ddata = pmic->palmas->pmic_ddata;
 	struct palmas_regs_info *rinfo = &ddata->palmas_regs_info[id];
 	unsigned int reg;
 	bool rail_enable = true;
 
-	palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
+	ret = palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
+	if (ret)
+		return ret;
 
 	reg &= ~PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
 
-- 
2.19.0.rc2

