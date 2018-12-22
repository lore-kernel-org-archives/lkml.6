Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A4FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B34C21908
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391773AbeLVSbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:31:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390029AbeLVSbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:31:00 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gafQ0-0003CD-IB; Sat, 22 Dec 2018 11:26:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] regulator: axp20x: check rdev is null before dereferencing it
Date:   Sat, 22 Dec 2018 11:26:08 +0000
Message-Id: <20181222112608.30681-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently rdev is dereferenced when assigning desc before rdev is null
checked, hence there is a potential null pointer dereference on rdev.
Fix this by null checking rdev first.

Detected by CoverityScan, CID#1476031 ("Dereference before null check")

Fixes: 77e3e3b165db ("regulator: axp20x: add software based soft_start for AXP209 LDO3")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/axp20x-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 48af859fd053..eaa7a487924c 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -436,11 +436,13 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
 {
 	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
-	const struct regulator_desc *desc = rdev->desc;
+	const struct regulator_desc *desc;
 
 	if (!rdev)
 		return -EINVAL;
 
+	desc = rdev->desc;
+
 	switch (axp20x->variant) {
 	case AXP209_ID:
 		if ((desc->id == AXP20X_LDO3) &&
-- 
2.19.1

