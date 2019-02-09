Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBCDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2741920869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="RsdTMO7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBIEjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:39:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43459 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBIEjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 23:39:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so2614095pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 20:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6eWteoO5+iSWVFhMx+sefIbG224Q6c2m9104t5OMn2g=;
        b=RsdTMO7RLN9VJ8he1cj7h1kU1lwPANOX/t0CutF0oa2wHgthhlCK+Xwrfc8v2//n+b
         750N12g78e9H3mTSnoIH6AuL614b8beInIViJ7oyrW1kP7RhmrL5NRt9rCR9dJvbaPnj
         40Lxn7XvpDgQVOdL6IN9cIfuc4bxjY4cRNtfLThiDb0B7+AxGPPgzGdwcLtBzhgCL8o/
         SoAfbaTlKz5tql0/53yoaa39F8LadT5AEHI2/XTZzrE8ZkbBfDztG+Sh+cQCZadAFLfB
         SgCO7KSU9VuwVaya4mr5fMpoceaFA0I/dOZb0Z7rF6g1Rb0zxdr46ju7wq9AwrTU6UUz
         ls3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6eWteoO5+iSWVFhMx+sefIbG224Q6c2m9104t5OMn2g=;
        b=mYuGZ8Ct9NxZtiguES+QdXd8rnshlplkI58FAPzx4i9v3PcG2uxjgTQ+QT+oGGIPrM
         VGOy3yqcfwyjZWDwjuUt3tnD0zcZZVuIcONcQkZd+DTGiOH/5IuxTty2IlbO/6dEoG6I
         zZmEgXskcVcz2G7c/JxLIC2WJB4N6MVG1ZQuw/2VXDIDA7UiyipRzMxabvnxQ4rDCZwn
         oEuZ2V/sO9cPozxFvgM2kgGGZCx1/q8AmYH3L/6V1YC7vEQCzMe8+fqNan1o+4g54u5p
         HKAZh9nNLX2EBxcdcMaTOhhj+NKAhAN4bo8eh1pZLnBAaCaUZaTGIVwedqPpAHHc93IK
         Wskw==
X-Gm-Message-State: AHQUAuYXPM3WL8Zg3I47ZYaHVf5rD/nKXaIAW82BYUhsFJURz1KYrMQu
        zNzYRVWi9E7pcTn/QlrIWQP+TA==
X-Google-Smtp-Source: AHgI3IbDpShoExpfG/No5pd2KuaIWUOOYZE0e9GDVBNguPGpkYTfVRJmQU/0fpUHbyMfI7mKwec7Cw==
X-Received: by 2002:a63:ea42:: with SMTP id l2mr9738259pgk.213.1549687190264;
        Fri, 08 Feb 2019 20:39:50 -0800 (PST)
Received: from localhost.localdomain (36-239-237-75.dynamic-ip.hinet.net. [36.239.237.75])
        by smtp.gmail.com with ESMTPSA id e123sm4018274pgc.58.2019.02.08.20.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 20:39:49 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pascal Paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: stpmic1: Remove regul_id and *regmap from struct stpmic1_regulator
Date:   Sat,  9 Feb 2019 12:39:35 +0800
Message-Id: <20190209043935.24637-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the context with *rdev available, there is no problem to get regulator
id and *regmap, so no need to store them in struct stpmic1_regulator.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/stpmic1_regulator.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 963e67fa9ca6..dd5c8fb1ff86 100644
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
@@ -477,7 +473,7 @@ static int stpmic1_set_icc(struct regulator_dev *rdev)
 	struct stpmic1_regulator *regul = rdev_get_drvdata(rdev);
 
 	/* enable switch off in case of over current */
-	return regmap_update_bits(regul->regmap, regul->cfg->icc_reg,
+	return regmap_update_bits(rdev->regmap, regul->cfg->icc_reg,
 				  regul->cfg->icc_mask, regul->cfg->icc_mask);
 }
 
@@ -505,7 +501,7 @@ static int stpmic1_regulator_init(struct platform_device *pdev,
 
 	/* set mask reset */
 	if (regul->mask_reset && regul->cfg->mask_reset_reg != 0) {
-		ret = regmap_update_bits(regul->regmap,
+		ret = regmap_update_bits(rdev->regmap,
 					 regul->cfg->mask_reset_reg,
 					 regul->cfg->mask_reset_mask,
 					 regul->cfg->mask_reset_mask);
@@ -584,10 +580,8 @@ regulator_dev *stpmic1_regulator_register(struct platform_device *pdev, int id,
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

