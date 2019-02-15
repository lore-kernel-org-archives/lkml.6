Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CC620675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404134AbfBOJqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:46:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59366 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390166AbfBOJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:45:59 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gua4B-0001Ey-4t; Fri, 15 Feb 2019 09:45:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V3] regulator: axp20x: remove a redundant null check on rdev
Date:   Fri, 15 Feb 2019 09:45:54 +0000
Message-Id: <20190215094554.28593-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently rdev is dereferenced when assigning desc before rdev is null
checked, this is leading to static analysis warnings.  However, rdev
can never be null, so the null check is redundant and can be removed.

Detected by CoverityScan, CID#1476031 ("Dereference before null check")

Fixes: 77e3e3b165db ("regulator: axp20x: add software based soft_start for AXP209 LDO3")
Signed-off-by: Colin Ian King <colin.king@canonical.com>

--

V2: Fix 2nd occurrance of this thinko
V3: Remove null check, Dan Carpenter noted that rdev can never be null.
---
 drivers/regulator/axp20x-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 6d081c8321a1..db1750df579d 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -372,9 +372,6 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 	const int *slew_rates;
 	int rate_count = 0;
 
-	if (!rdev)
-		return -EINVAL;
-
 	desc = rdev->desc;
 
 	switch (axp20x->variant) {
-- 
2.20.1

