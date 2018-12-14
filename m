Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EB4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F42206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="cbtNFfQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbeLNUyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:54:14 -0500
Received: from plaes.org ([188.166.43.21]:47226 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbeLNUyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:54:13 -0500
Received: from localhost (85.253.152.156.cable.starman.ee [85.253.152.156])
        by plaes.org (Postfix) with ESMTPSA id C4BC340673;
        Fri, 14 Dec 2018 20:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544820851; bh=WXVd6MN1CaPvZ6RjtN5Jd1UpIipSyBs++cIK4VDQ6KQ=;
        h=From:To:Cc:Subject:Date:From;
        b=cbtNFfQ5jjqYNH6nJ4pJxuK6xTFH3rS4ACBOU/L29WODRFWF3dbyJI9SZdcYSTaRV
         0fzodvXExkOGuYO7Cm9FhqVLhr/iAc4TssZV0Tw+Kw5FxFLuMW4bRcLb8bA1Owjvnt
         ZdV0IS+SwKvWB4UaTft5MMT7AupjiQqEcCfRhnl02GMbzpcamtdYzAguWEWsVQR6sG
         oxd06Jgd7MFtS8H4B8WTTKOWk+Dey58p7RTnfAGXIghXEhubeR/L1scgEbsdjNwyCe
         2MP9V3rwdYomJIB+hUi6vtbh7h5slDg4O71SWR2dOHk0iLVkh+rUUMYVbOk1G2866p
         EYP40lWTN9fqg==
From:   Priit Laes <plaes@plaes.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH] regulator: axp20x: fix set_ramp_delay for AXP209/dcdc2
Date:   Fri, 14 Dec 2018 22:54:07 +0200
Message-Id: <20181214205407.31695-1-plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial commit of set_ramp_delay feature was missing an assignment which
should have populated slew_rate table for dcdc2 regulator. Add it.

Fixes: d29f54df8b16 ("regulator: axp20x: add support for set_ramp_delay for AXP209")

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/regulator/axp20x-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index e8a895b81c90..48af859fd053 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -378,6 +378,7 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 	switch (axp20x->variant) {
 	case AXP209_ID:
 		if (desc->id == AXP20X_DCDC2) {
+			slew_rates = axp209_dcdc2_ldo3_slew_rates;
 			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
 			reg = AXP20X_DCDC2_LDO3_V_RAMP;
 			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
-- 
2.11.0

