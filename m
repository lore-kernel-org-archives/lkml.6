Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A7AC282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DAA2192B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549732464;
	bh=YUVvyFlWkHsaX3LHViOmkCsw4Y92yWA3dkANhsvpFjc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WkMo/k5+ntemXe/ZY1u0+Py1XRYen/xTCw5mTmWRBcz0Yf4Q78JcbJYXQgBABdp4W
	 iaQHY6cjExobiMd6uDaxA/KG5SXqDe22DgLtrc3vxq916v/HiBPUXr9A8G1QPBSSYg
	 7PQSFXsWa9G0Vz64LU0vb5UIkhj/KmJR06mxUD+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfBIROX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:14:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfBIROX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:14:23 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52B321919;
        Sat,  9 Feb 2019 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549732462;
        bh=YUVvyFlWkHsaX3LHViOmkCsw4Y92yWA3dkANhsvpFjc=;
        h=From:To:Cc:Subject:Date:From;
        b=V8ZUreuylpyuJu+u0f9NnY9C2DzjbHneSFgBpzQQ7ih9uwoS480Nj4OICv4UWBrMu
         YBQAP+/D9Pj89Nu4x3fvXEIEhUeCK7kgpBQbqXTqb8S/BXHmjwBJskpIFV4wtBGMP4
         RXpT5rqQQUP/wLi74DKTfcjPS3qFsKogf2qyNqQ4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] regulator: s2mps11: Fix steps for buck7, buck8 and LDO35
Date:   Sat,  9 Feb 2019 18:14:14 +0100
Message-Id: <20190209171414.28125-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LDO35 uses 25 mV step, not 50 mV.  Bucks 7 and 8 use 12.5 mV step
instead of 6.25 mV.  Wrong step caused over-voltage (LDO35) or
under-voltage (buck7 and 8) if regulators were used (e.g. on Exynos5420
Arndale Octa board).

Cc: <stable@vger.kernel.org>
Fixes: cb74685ecb39 ("regulator: s2mps11: Add samsung s2mps11 regulator driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/s2mps11.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index ee4a23ab0663..134c62db36c5 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -362,7 +362,7 @@ static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_ldo(32, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(33, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(34, STEP_50_MV),
-	regulator_desc_s2mps11_ldo(35, STEP_50_MV),
+	regulator_desc_s2mps11_ldo(35, STEP_25_MV),
 	regulator_desc_s2mps11_ldo(36, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(37, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(38, STEP_50_MV),
@@ -372,8 +372,8 @@ static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_buck1_4(4),
 	regulator_desc_s2mps11_buck5,
 	regulator_desc_s2mps11_buck67810(6, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck67810(7, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck67810(8, MIN_600_MV, STEP_6_25_MV),
+	regulator_desc_s2mps11_buck67810(7, MIN_600_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(8, MIN_600_MV, STEP_12_5_MV),
 	regulator_desc_s2mps11_buck9,
 	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV),
 };
-- 
2.17.1

