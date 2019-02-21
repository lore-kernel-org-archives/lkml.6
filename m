Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3493AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F003720818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="sdLe5Ces"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfBUQ2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:28:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37698 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:28:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id q3so7038706pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=fsXbxFn1053YWraWQi+gYikoNqyvp3tdWnPT3zClaqk=;
        b=sdLe5CesQ9owobXpWOPfLZl3QBk0L3TooAJQVi0U0YivnJbPWZh4tRfrDCGn6hQcn3
         Rvrk9KsLgo+a1MEHjfd80DmkKuZEupP3Qk656dIPBHxKnhmcnO1Ln0SI+u/8rav8/Y4Q
         72cdLfs2zphbQ6lMr0BD6aI5iHMLV8ijgmTBsysawCcBbhNLz3C5J4ZWBtwYWQ72b4lO
         pv+iOT9UpWt7vJpuXSPb00U7xajSt3zBamnarPyes8ZzXdswZvXIpaNpUT7NSynxGPcW
         oITuVEGFBLtxu2PzKVlPg9Rf715DeBzivGg8GRMZWnZbsnnGlUN4wi52u5mrD1g5Gwtf
         epoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fsXbxFn1053YWraWQi+gYikoNqyvp3tdWnPT3zClaqk=;
        b=NQ4q0/aVWa8bZGzPOhodsh60JRI7EBZQaLJKOklmkvFP2kg4ivhCEM2iIu175XK3+K
         bBEr4TJs8Pws9LFudZctKkRqKbl1aH8cD1my3s9psCrxO0FGXcYlaOFoNCIOEGc9nhA7
         8SuhYWz7eb97M3ux6bmBUZOjfVcHXEvlIe50VbPt5XgRCBov1CdY9PEZst/mxSmIidFJ
         AcEjiofrmQqCdvGSy6Kb31OJmkw4HSqxfeNJeb/x8wi7QLCRX5NoxCvBM2RdzIyvs2FZ
         bGMXsVzR92r7wS4egMDi5zbNaZrSbDAPvKDNq1yBIvnyMpN2lO4rre2zhXEd/T0+pZdj
         1oRQ==
X-Gm-Message-State: AHQUAubc4cEWxLgiqj/TXncLznRra9QjInYJwKIVeeDv1XsEEL/ylpZg
        doVlUG2b5RPGNQoifYUAgsJGwA==
X-Google-Smtp-Source: AHgI3IbZUUjJQv1uQ4ITCQ1rRYKa5VPYuqg4wArA5uWomMmrxNDPH18Nh/RAkVmNly4s+mRXSaVJ+g==
X-Received: by 2002:a17:902:76c7:: with SMTP id j7mr10661504plt.121.1550766521372;
        Thu, 21 Feb 2019 08:28:41 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id x23sm51926582pfe.0.2019.02.21.08.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 08:28:40 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Henry Chen <henryc.chen@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mt6311: Use linear instead of linear range for mt6311_buck_ops
Date:   Fri, 22 Feb 2019 00:28:31 +0800
Message-Id: <20190221162831.11693-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code already set .min_uV and .uV_step fields and it actually can
use regulator_list_voltage_linear.
So remove buck_volt_range and use regulator_list_voltage_linear instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6311-regulator.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index 0495716fd35f..01d69f43d2b0 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -38,13 +38,9 @@ static const struct regmap_config mt6311_regmap_config = {
 #define MT6311_MAX_UV		1393750
 #define MT6311_STEP_UV		6250
 
-static const struct regulator_linear_range buck_volt_range[] = {
-	REGULATOR_LINEAR_RANGE(MT6311_MIN_UV, 0, 0x7f, MT6311_STEP_UV),
-};
-
 static const struct regulator_ops mt6311_buck_ops = {
-	.list_voltage = regulator_list_voltage_linear_range,
-	.map_voltage = regulator_map_voltage_linear_range,
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
@@ -71,8 +67,6 @@ static const struct regulator_ops mt6311_ldo_ops = {
 	.min_uV = MT6311_MIN_UV,\
 	.uV_step = MT6311_STEP_UV,\
 	.owner = THIS_MODULE,\
-	.linear_ranges = buck_volt_range, \
-	.n_linear_ranges = ARRAY_SIZE(buck_volt_range), \
 	.enable_reg = MT6311_VDVFS11_CON9,\
 	.enable_mask = MT6311_PMIC_VDVFS11_EN_MASK,\
 	.vsel_reg = MT6311_VDVFS11_CON12,\
-- 
2.17.1

