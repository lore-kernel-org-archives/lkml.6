Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F53C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D95420831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D95420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJ2Ay1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:54:27 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:35934 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJ2Ay1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:54:27 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id t49Q1y0053XaVaC0149Q5Z; Sun, 28 Oct 2018 17:09:24 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gGncy-0001jr-1c; Sun, 28 Oct 2018 17:09:24 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gGncy-0006Pp-0D; Sun, 28 Oct 2018 17:09:24 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] regulator: bd718x7: Remove double indirection for bd718xx_pmic_inits.rdatas
Date:   Sun, 28 Oct 2018 17:09:22 +0100
Message-Id: <20181028160922.24618-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1:

    drivers/regulator/bd718x7-regulator.c: In function ‘bd718xx_probe’:
    drivers/regulator/bd718x7-regulator.c:1020: warning: initialization from incompatible pointer type
    drivers/regulator/bd718x7-regulator.c:1024: warning: initialization from incompatible pointer type

Apparently this old compiler can't handle the obscure double
indirection.

However, there is no need for a double indirection.  Just store a
pointer to the array instead, like other drivers tend to do.

Fixes: 494edd266b945f36 ("regulator/mfd: Support ROHM BD71847 power management IC")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 drivers/regulator/bd718x7-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 3a47e0372e77c812..fff5bc4faa2c99aa 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1007,7 +1007,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 };
 
 struct bd718xx_pmic_inits {
-	const struct bd718xx_regulator_data (*r_datas)[];
+	const struct bd718xx_regulator_data *r_datas;
 	unsigned int r_amount;
 };
 
@@ -1017,11 +1017,11 @@ static int bd718xx_probe(struct platform_device *pdev)
 	struct regulator_config config = { 0 };
 	struct bd718xx_pmic_inits pmic_regulators[] = {
 		[BD718XX_TYPE_BD71837] = {
-			.r_datas = &bd71837_regulators,
+			.r_datas = bd71837_regulators,
 			.r_amount = ARRAY_SIZE(bd71837_regulators),
 		},
 		[BD718XX_TYPE_BD71847] = {
-			.r_datas = &bd71847_regulators,
+			.r_datas = bd71847_regulators,
 			.r_amount = ARRAY_SIZE(bd71847_regulators),
 		},
 	};
@@ -1059,7 +1059,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 		struct regulator_dev *rdev;
 		const struct bd718xx_regulator_data *r;
 
-		r = &(*pmic_regulators[mfd->chip_type].r_datas)[i];
+		r = &pmic_regulators[mfd->chip_type].r_datas[i];
 		desc = &r->desc;
 
 		config.dev = pdev->dev.parent;
-- 
2.17.1

