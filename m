Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3298E222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="B6qo55az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393694AbfBNCAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:00:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43504 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbfBNCAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:00:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id q17so2181801pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mgKAbwo+LQ2sRyR8egkeWKdkh6qN/Sv6pvFQueF4UnU=;
        b=B6qo55azgkktz8JK+NwL54/d15BpIrBNpK1sjlM/t6bxnWU2qYVdApZmbPfM0oUmZG
         +taFmdSVA/8FdgplRYVVLA1uGFuiwu/JYXz49jbYF82kH4jhVitV/DsIawnifnYgf90U
         pw/aszZ3pJaGjS1ywPb1knQ2NpVHxyYBhaI+GcSH5vxzEMFfjpj8X7YX6cNRPc8xJAsI
         4SUnq4h4mmPnNYCnwEyfJn6lqVFlKzLxZS2asFfbKS/T7obLrUsW5WjFrS3sWDlRA17b
         0mY4FxNoqJsFspFNLgAU5vdgTGYjbqTlAYPYSxxGK8cvF4o7qyFweu8Bks6evzmcA3oo
         hPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mgKAbwo+LQ2sRyR8egkeWKdkh6qN/Sv6pvFQueF4UnU=;
        b=jWmOd0pV3+3LGudcLJK9QY7dJd5iB9cQ0/qWFBIkmXC42lI2SZNwUKvWbyIrMUxoGy
         qJjzTyhTQBmPrilwc97LQAT/GpLCSa0RVj2l4JvQmylpB0ySrvuIPI0PdvYSXfvEbu8J
         rOcfUtAJ1nzqsx2TQJbIxymopqvWL0Dtw49Aya4QHud+MLtXvPQAt3TzI4cvYmvHbsY5
         N1ic7NL3N2O286zxioSih+tFVNyw9/cCY2q/rj3STg9AEVRLQ4BOe8IDBEnX4LfvjHmH
         TxRdm5pOoTnjKtWSUyStGrNdmpzIc1/6c9iCJ4DBvgadjubF7Qxo8sr/XDgj7E/5wBu4
         HR1A==
X-Gm-Message-State: AHQUAuYq3scqhwAh2akQS1fxj+Ce/uIjsDhXK9RlWLt89drOT+g7A3qb
        PmxD17bU/YOYdMkbNSw79TDLuw8EoWo=
X-Google-Smtp-Source: AHgI3IbNBEc//K8X2ziAkmR3pLtuHpyfuVb0cIM5JgzGOJoC8bZYURzIcmWvYiI7wG2RZat4nXqSmw==
X-Received: by 2002:a62:964d:: with SMTP id c74mr1350878pfe.213.1550109611429;
        Wed, 13 Feb 2019 18:00:11 -0800 (PST)
Received: from localhost.localdomain (36-239-208-250.dynamic-ip.hinet.net. [36.239.208.250])
        by smtp.gmail.com with ESMTPSA id i24sm759863pgg.14.2019.02.13.18.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:00:10 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pascal Paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] regulator: stpmic1: Remove regul_id and *regmap from struct stpmic1_regulator
Date:   Thu, 14 Feb 2019 09:59:56 +0800
Message-Id: <20190214015956.30589-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the context with *rdev available, regulator core provides
rdev_get_id()/rdev_get_regmap() APIs to get regulator id and *regmap.
So no need to store them in struct stpmic1_regulator.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: Use rdev_get_regmap rather than directly access rdev->regmap
BTW, The regul_id is not used in this driver.
 drivers/regulator/stpmic1_regulator.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 963e67fa9ca6..d456fb5d4044 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -30,20 +30,16 @@ struct stpmic1_regulator_cfg {
 
 /**
  * stpmic1 regulator data: this structure is used as driver data
- * @regul_id: regulator id
  * @reg_node: DT node of regulator (unused on non-DT platforms)
  * @cfg: stpmic specific regulator description
  * @mask_reset: mask_reset bit value
  * @irq_curlim: current limit interrupt number
- * @regmap: point to parent regmap structure
  */
 struct stpmic1_regulator {
-	unsigned int regul_id;
 	struct device_node *reg_node;
 	const struct stpmic1_regulator_cfg *cfg;
 	u8 mask_reset;
 	int irq_curlim;
-	struct regmap *regmap;
 };
 
 static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode);
@@ -475,9 +471,10 @@ static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode)
 static int stpmic1_set_icc(struct regulator_dev *rdev)
 {
 	struct stpmic1_regulator *regul = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
 
 	/* enable switch off in case of over current */
-	return regmap_update_bits(regul->regmap, regul->cfg->icc_reg,
+	return regmap_update_bits(regmap, regul->cfg->icc_reg,
 				  regul->cfg->icc_mask, regul->cfg->icc_mask);
 }
 
@@ -501,11 +498,12 @@ static int stpmic1_regulator_init(struct platform_device *pdev,
 				  struct regulator_dev *rdev)
 {
 	struct stpmic1_regulator *regul = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	int ret = 0;
 
 	/* set mask reset */
 	if (regul->mask_reset && regul->cfg->mask_reset_reg != 0) {
-		ret = regmap_update_bits(regul->regmap,
+		ret = regmap_update_bits(regmap,
 					 regul->cfg->mask_reset_reg,
 					 regul->cfg->mask_reset_mask,
 					 regul->cfg->mask_reset_mask);
@@ -584,10 +582,8 @@ regulator_dev *stpmic1_regulator_register(struct platform_device *pdev, int id,
 	config.regmap = pmic_dev->regmap;
 	config.driver_data = regul;
 
-	regul->regul_id = id;
 	regul->reg_node = config.of_node;
 	regul->cfg = &stpmic1_regulator_cfgs[id];
-	regul->regmap = pmic_dev->regmap;
 
 	rdev = devm_regulator_register(&pdev->dev, &regul->cfg->desc, &config);
 	if (IS_ERR(rdev)) {
-- 
2.17.1

