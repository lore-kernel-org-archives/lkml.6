Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BB9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DFD20836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550776400;
	bh=EGffwYyWoq4wqIC1Z0lOFE82UbgYs+lFVmuxXXLfRBM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bn8sAwd4Y8UxbmrZ62YO8uGXHYq7yDYP9txVDlYeyGiA3s4tnswl6Vpq9pDfKghLt
	 bnkECG9ZkNxuBCA6G1NhSMnl86gmOdZFUfM2DxWI7g+ROw0CNRL7RYrflyKBhBO+Vb
	 7CyYOX+VLATq9JuIhtePDV34XqNDm9y04zVD4PVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBUTNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:13:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38046 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfBUTNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PBnSzdP+tUBbA/omfgFHybI4sow7LlrUabA/v5NToCU=; b=ObIr/ojXQX4e
        SN+jXNlct67stJLtZN+KWmBIu2nqTHE/rg2gKztvvC3oJL5tURBbEpZdGCqAKbrbytAdTshV9dr+7
        rBRQ7yR49wTCOX9hjRAFFknQyjE3FMTCisZmTnNqUU2WiILX3y+X9168yZXbedIlMinPvRJR1Pg+G
        BPcsY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwtmU-0005xJ-La; Thu, 21 Feb 2019 19:13:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B6FDC1122744; Thu, 21 Feb 2019 19:13:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: s5m8767: Simplify s5m8767_set_voltage_time_sel implementation" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190221191313.B6FDC1122744@debutante.sirena.org.uk>
Date:   Thu, 21 Feb 2019 19:13:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s5m8767: Simplify s5m8767_set_voltage_time_sel implementation

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

From bf1fc259e8a40b9eb059a161db0d6d3d6b8c94e4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 21 Feb 2019 21:17:22 +0800
Subject: [PATCH] regulator: s5m8767: Simplify s5m8767_set_voltage_time_sel
 implementation

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s5m8767.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 5b0e1fe6723f..bb9d1a083299 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -339,13 +339,9 @@ static int s5m8767_set_voltage_time_sel(struct regulator_dev *rdev,
 					     unsigned int new_sel)
 {
 	struct s5m8767_info *s5m8767 = rdev_get_drvdata(rdev);
-	const struct sec_voltage_desc *desc;
-	int reg_id = rdev_get_id(rdev);
-
-	desc = reg_voltage_map[reg_id];
 
 	if ((old_sel < new_sel) && s5m8767->ramp_delay)
-		return DIV_ROUND_UP(desc->step * (new_sel - old_sel),
+		return DIV_ROUND_UP(rdev->desc->uV_step * (new_sel - old_sel),
 					s5m8767->ramp_delay * 1000);
 	return 0;
 }
-- 
2.20.1

