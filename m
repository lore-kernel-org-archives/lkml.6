Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4B7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F84206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="kazx7G2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfADOnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:43:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33849 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfADOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:43:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so17607913pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=NAFDSV7lZrWkw6m4YWVFTqPnVjm/t+XGcu7X9nTvAN8=;
        b=kazx7G2GguQUH3CtFycwV+qRgUlzoXKukPHkpFDEP7+gpwgfPxlu0L4Dr4UPzQIh7k
         VcL36jPq1i3in7NuJJSnR0OfnZF/i76u9KAedQkzKnIML2VcaqY30OrM33UzxvFkcDFk
         WsF86ZIIXEnVkNHQRJ2C7H5BU7iSSqT81r+ay918fc2V/wj90d6YbhIIeUTC8yKuBXca
         wUNgCf5uPBkyxk8EV9wng2BDuNDNWG8XFUVfVc9M+wCJyVTuhiLhzCEeggAMDwwHAtKN
         +tRaiLSeC/lnzqw2ODB2qVZ2MUL+mqv+Tnfu9NoimYMbqHT4js858ua2Iw2czNuRW/Vt
         FovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NAFDSV7lZrWkw6m4YWVFTqPnVjm/t+XGcu7X9nTvAN8=;
        b=X/Po1Hf+h9W14WHhl7wjH0pxJPBYKk/koezxkS0oSHxNlm8G7ijVUwdL2MkCRDmh1R
         v3dlB+eNrAJ4LqjLxB5P4MK3AYmE2lqoC1hKGScEcbd74uhkcPjV0bgRYu0S9heWEasI
         k40qpGLj++Xbk1CTlifOUfnbZ9h6H9bgzJBYC76awI0g1wl4tNcpN5nKsjgOumx37e9M
         p0Ln3v198Q+k854WwsUx6kjBiOg1sRNryNIGGe38e+TUjTQgn57UcCeIZ4TXef4x0A7Z
         GJ0nbWxiAHZmX58VfAcmQSW2ZN09T6PCGr71BvqQMGq+S3dXOTmbrv56ZI1DlKNSDEd5
         kJzw==
X-Gm-Message-State: AJcUukcccrKbL4cPrmKg/x2afyQ+DV9UmmxRKQo0F5erqpyttsqORPwu
        KGr31iZZyg4vKroh+7JnN5QEBQ==
X-Google-Smtp-Source: ALg8bN74sMieNXYqcsEhdQ4U636CfiKzbCAfDCrRKrhvJYM7sf9MfPTMnTBoEyg60rAW0n/t5Dvfag==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr1888229pgn.205.1546612991691;
        Fri, 04 Jan 2019 06:43:11 -0800 (PST)
Received: from localhost.localdomain (36-239-217-174.dynamic-ip.hinet.net. [36.239.217.174])
        by smtp.gmail.com with ESMTPSA id x19sm101548523pfk.14.2019.01.04.06.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 06:43:10 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Wenyou Yang <wenyou.yang@atmel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: act8945a: Use rdev_get_id() to access id of regulator
Date:   Fri,  4 Jan 2019 22:42:36 +0800
Message-Id: <20190104144236.15658-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rdev_get_id() instead of directly access rdev->desc->id.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/act8945a-regulator.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 603db77723b6..caa61d306a69 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -87,7 +87,8 @@ static const struct regulator_linear_range act8945a_voltage_ranges[] = {
 static int act8945a_set_suspend_state(struct regulator_dev *rdev, bool enable)
 {
 	struct regmap *regmap = rdev->regmap;
-	int id = rdev->desc->id, reg, val;
+	int id = rdev_get_id(rdev);
+	int reg, val;
 
 	switch (id) {
 	case ACT8945A_ID_DCDC1:
@@ -159,7 +160,7 @@ static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
 	struct regmap *regmap = rdev->regmap;
-	int id = rdev->desc->id;
+	int id = rdev_get_id(rdev);
 	int reg, ret, val = 0;
 
 	switch (id) {
@@ -190,11 +191,11 @@ static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 
 	switch (mode) {
 	case REGULATOR_MODE_STANDBY:
-		if (rdev->desc->id > ACT8945A_ID_DCDC3)
+		if (id > ACT8945A_ID_DCDC3)
 			val = BIT(5);
 		break;
 	case REGULATOR_MODE_NORMAL:
-		if (rdev->desc->id <= ACT8945A_ID_DCDC3)
+		if (id <= ACT8945A_ID_DCDC3)
 			val = BIT(5);
 		break;
 	default:
@@ -213,7 +214,7 @@ static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 static unsigned int act8945a_get_mode(struct regulator_dev *rdev)
 {
 	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
-	int id = rdev->desc->id;
+	int id = rdev_get_id(rdev);
 
 	if (id < ACT8945A_ID_DCDC1 || id >= ACT8945A_ID_MAX)
 		return -EINVAL;
-- 
2.17.1

