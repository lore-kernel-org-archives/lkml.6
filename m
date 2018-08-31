Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDACC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F342083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F342083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeHaQli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:41:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48453 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaQlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:41:37 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fvid1-0006iQ-1y; Fri, 31 Aug 2018 14:34:19 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] regulator: da9063: fix DT probing with constraints
Date:   Fri, 31 Aug 2018 14:34:02 +0200
Message-Id: <20180831123402.9494-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.18.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
reordered the da9063_regulator_info[] array, but not the DA9063_ID_*
regulator ids and not the da9063_matches[] array, because ids are used
as indices in the array initializer. This mismatch between regulator id
and da9063_regulator_info[] array index causes the driver probe to fail
because constraints from DT are not applied to the correct regulator:

  da9063 0-0058: Device detected (chip-ID: 0x61, var-ID: 0x50)
  DA9063_BMEM: Bringing 900000uV into 3300000-3300000uV
  DA9063_LDO9: Bringing 3300000uV into 2500000-2500000uV
  DA9063_LDO1: Bringing 900000uV into 3300000-3300000uV
  DA9063_LDO1: failed to apply 3300000-3300000uV constraint(-22)

This patch reorders the DA9063_ID_* as apparently intended, and with
them the entries in the da90630_matches[] array.

Fixes: 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/da9063/pdata.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
index 8a125701ef7b..50bed4f89c1a 100644
--- a/include/linux/mfd/da9063/pdata.h
+++ b/include/linux/mfd/da9063/pdata.h
@@ -21,7 +21,7 @@
 /*
  * Regulator configuration
  */
-/* DA9063 regulator IDs */
+/* DA9063 and DA9063L regulator IDs */
 enum {
 	/* BUCKs */
 	DA9063_ID_BCORE1,
@@ -37,18 +37,20 @@ enum {
 	DA9063_ID_BMEM_BIO_MERGED,
 	/* When two BUCKs are merged, they cannot be reused separately */
 
-	/* LDOs */
+	/* LDOs on both DA9063 and DA9063L */
+	DA9063_ID_LDO3,
+	DA9063_ID_LDO7,
+	DA9063_ID_LDO8,
+	DA9063_ID_LDO9,
+	DA9063_ID_LDO11,
+
+	/* DA9063-only LDOs */
 	DA9063_ID_LDO1,
 	DA9063_ID_LDO2,
-	DA9063_ID_LDO3,
 	DA9063_ID_LDO4,
 	DA9063_ID_LDO5,
 	DA9063_ID_LDO6,
-	DA9063_ID_LDO7,
-	DA9063_ID_LDO8,
-	DA9063_ID_LDO9,
 	DA9063_ID_LDO10,
-	DA9063_ID_LDO11,
 };
 
 /* Regulators platform data */
-- 
2.18.0

