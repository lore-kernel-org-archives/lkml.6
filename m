Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9073C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4B72229F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="opyH5pbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfBOBnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:43:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39881 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfBOBnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:43:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so4112615pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 17:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Mgfw1KWUPlniv7NflFnZpe0ndDew1LjIM9jvi7/mQvc=;
        b=opyH5pbhYp7xcnjqR/lrwxAI7itc/lgPTiRo3DnPspZ98AytMkd3/gHhTfpOPjyvxS
         0VuFg1VrHgFI3F3WFdZjEKtK24mgeqXlgjZCcH0lE4TqGcrx6Ksj4uHn/dDZqbPfHG59
         NugjX45TJ3I3VvcOmtl2+uOaAQ0DE/EjHYDvsx7HKxy8vK+yYhnXTj49ojPppd7dTndx
         3mSgw19HTJjNNDRhxv/42Jxn3XmVjzlmXV0GkUjrF6wZnpncrZ+bhDnqq1IKX/3Cl7i7
         jINSrcDB/RplOVtAU61L2BTlWbf22dwviL7RhDIsKRWAQ4btrlGDb0EPMKHr0AT3D/GA
         1qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mgfw1KWUPlniv7NflFnZpe0ndDew1LjIM9jvi7/mQvc=;
        b=jU+Xz8kNVM0jK1rrweYVZRe/qLyGf9Fe9TyrD6vqOkHAN5TUhAaf1Ohk2jt0pbFz5i
         JwzZh6WQLnQVW7ryt1xV+ZUm96FiWke8m8typU8G7VDr6lN0AncuOLkg7rfibh+0ZgO4
         F+WBaXgUjOu4xuMFPQkohQVnImO0+8qzjZUGadgu99YYe7CvlnQpltpN2gho437/y8zo
         t5SrmrzXaTxlnI/s8ETv7anZ8KoBUoY2V9Cdk70UqakfQYqmCxfNzopu4UpSkTydamDm
         +JvWwlW+Yaoy7UflOO23fSBgsdey/V42+ShZTWzRftuOwvT2IzlkEfa1ERyPgeraRN90
         YWbA==
X-Gm-Message-State: AHQUAuZc3TTFpjgRmiMo5CljbRt1kXwzFRpV1gfXnqYhdBferx8hrohy
        kDSZkWUpsvv7kIoeNV9pZlQMiSinuV0=
X-Google-Smtp-Source: AHgI3IbJ/9pTV+S/X83CUQPfYNVWcQ9EKe/lhpyT1xPsuONpI1SiO1s6tEawxo/l+IKzmM81jCcvzg==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr7423031plq.84.1550194981695;
        Thu, 14 Feb 2019 17:43:01 -0800 (PST)
Received: from localhost.localdomain (36-239-208-250.dynamic-ip.hinet.net. [36.239.208.250])
        by smtp.gmail.com with ESMTPSA id w65sm4737996pfb.23.2019.02.14.17.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 17:43:01 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     James Ban <James.Ban.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: pv88060: Fix .ops for PV88060_SW
Date:   Fri, 15 Feb 2019 09:42:49 +0800
Message-Id: <20190215014249.24558-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no vsel_reg/vsel_mask settings for PV88060_ID_SWx, so don't use
pv88060_ldo_ops for PV88060_SW. The PV88060_ID_SWx is fixed voltage,
set .fixed_uV instead of .min_uV then regulator core will automatically
support get_voltage and list_voltage.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi James,
I don't have this h/w, please help to review and test this patch.
Thanks,
Axel
 drivers/regulator/pv88060-regulator.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index a9446056435f..d5dab9bef378 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -184,6 +184,12 @@ static const struct regulator_ops pv88060_ldo_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 };
 
+static const struct regulator_ops pv88060_sw_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
 #define PV88060_BUCK(chip, regl_name, min, step, max, limits_array) \
 {\
 	.desc	=	{\
@@ -237,9 +243,8 @@ static const struct regulator_ops pv88060_ldo_ops = {
 		.regulators_node = of_match_ptr("regulators"),\
 		.type = REGULATOR_VOLTAGE,\
 		.owner = THIS_MODULE,\
-		.ops = &pv88060_ldo_ops,\
-		.min_uV = max,\
-		.uV_step = 0,\
+		.ops = &pv88060_sw_ops,\
+		.fixed_uV = max,\
 		.n_voltages = 1,\
 		.enable_reg = PV88060_REG_##regl_name##_CONF,\
 		.enable_mask = PV88060_SW_EN,\
-- 
2.17.1

