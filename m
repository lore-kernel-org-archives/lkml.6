Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D118C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42F8218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="vzb3dwP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfAZPWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:22:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41826 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:22:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so6033695pfi.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 07:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7eXUfBkVw2EZvMUdOGDzkqelR5/zwCEZQVjbx6FKH2s=;
        b=vzb3dwP0vIEArZRUTnYLnSp1J0KM7oKV65elXbix1aszO9Kn8mS1SvWdfx3CCl3Q8n
         ZkF36TjFejYpZcsmVxASwmANEXMs0q806yJgn9lF2m+KAr89VYIYZJSSwPVs64CvKvOK
         lx0m+ukwhHcF4vO1yqEO/0P9ruVgI+iO4NiOtNMYeVDdCyhMUN728Vs/WLQf1wLqMbnm
         4I0F99Cs29T6nljxe07uwKUwyTZZEkvU9M8Re2j/ZbQkX7inyHe+SdcDhpNnhBr6NVxq
         tmlwXOHgej5NiBfDvG0DccjZ9BaIyvyMxnB7LxjeYZ3+aRev6BVJ0zjIwyuo1kmI04vh
         3pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7eXUfBkVw2EZvMUdOGDzkqelR5/zwCEZQVjbx6FKH2s=;
        b=XBfZmzynGjJVO5hdAzQaaO2uH9HwS235w3XYce8fMWys+sntVH0AJtH+m6Qo89EvGY
         glOh7UqGDofFpm2oYU3KcJio+CF3W64NvAWi7Nj2jGgsF0y66shPXrwmPLkXAs9etza7
         FYwRQXxeA1/9aTHFLK6Q7VpoGA/Qi2J7e+z9n8TVbeWsz3WExhZm12IhpphojOPEfhEi
         wWgtmqf01PgRJ+dsUTmg5GLlklp7l5iWlFMim39QI4HfA2DupxR7rEVFQ/SiotTqPF7l
         jA5+OT7LunQpToabaleg1fiMPI9Bvs+UyBSAd21B9HXKD965e6+XUWE9pcDeGb9vGI3e
         tQWQ==
X-Gm-Message-State: AJcUukftuJW868pgsxrl91PtIZviAjCtJHgjju7Ecdpn80fc4teYVL/I
        ckj0ej+8KMPv875yF400XF2TJA==
X-Google-Smtp-Source: ALg8bN6BKem8FWYjroqisCnxxCefuTzXO+o4v5NoS3oTzLdzsHHnAhGi+Oj8tmFeEG6w5SEJV+EMIA==
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr13825187pgd.446.1548516166086;
        Sat, 26 Jan 2019 07:22:46 -0800 (PST)
Received: from localhost.localdomain (36-239-222-123.dynamic-ip.hinet.net. [36.239.222.123])
        by smtp.gmail.com with ESMTPSA id g28sm46024849pfd.100.2019.01.26.07.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 07:22:44 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     S Twiss <stwiss.opensource@diasemi.com>,
        Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: da9062: Check return value of devm_regmap_field_alloc calls
Date:   Sat, 26 Jan 2019 23:22:33 +0800
Message-Id: <20190126152234.3091-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since devm_regmap_field_alloc can fail, add error checking for it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9062-regulator.c | 29 +++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 34a70d9dc450..d06e9600fa18 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1029,31 +1029,50 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 		regl->desc.type = REGULATOR_VOLTAGE;
 		regl->desc.owner = THIS_MODULE;
 
-		if (regl->info->mode.reg)
+		if (regl->info->mode.reg) {
 			regl->mode = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->mode);
-		if (regl->info->suspend.reg)
+			if (IS_ERR(regl->mode))
+				return PTR_ERR(regl->mode);
+		}
+
+		if (regl->info->suspend.reg) {
 			regl->suspend = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->suspend);
-		if (regl->info->sleep.reg)
+			if (IS_ERR(regl->suspend))
+				return PTR_ERR(regl->suspend);
+		}
+
+		if (regl->info->sleep.reg) {
 			regl->sleep = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->sleep);
-		if (regl->info->suspend_sleep.reg)
+			if (IS_ERR(regl->sleep))
+				return PTR_ERR(regl->sleep);
+		}
+
+		if (regl->info->suspend_sleep.reg) {
 			regl->suspend_sleep = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->suspend_sleep);
-		if (regl->info->ilimit.reg)
+			if (IS_ERR(regl->suspend_sleep))
+				return PTR_ERR(regl->suspend_sleep);
+		}
+
+		if (regl->info->ilimit.reg) {
 			regl->ilimit = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->ilimit);
+			if (IS_ERR(regl->ilimit))
+				return PTR_ERR(regl->ilimit);
+		}
 
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
-- 
2.17.1

