Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135DDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81BE222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB6jQM0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbfBMPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:05:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51861 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBMPFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:05:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so2847690wmj.1;
        Wed, 13 Feb 2019 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SKvnZE8FRNSDrOi2i7LIYAhX4r86ogk967jOuzBNxJ8=;
        b=ZB6jQM0BV+40kIie7WHvQcTe4kxy+1PHRNwAb0StxGRm6J6jAylTx7ASPg/OjKdSHA
         1GQZ1qb7u0cz3zQTt8fhos29G/vLKQ1P/LKBq7xFr1qIEjpN9M4t5CV5L84g8A/jn7D0
         trzyphRGSCWSoXzIYYfQ5moiRK2W7LUkwOG0uyBwY46FkyE0RapIQh2t9fibtk6NcoD+
         sC1FM8/0ILtosBed363QhikfMTH535RFM6cXmedD45J0YbZ5MqSNh9sgPN5fEyjc2KFM
         MZOfcLMi+xlWOi+CinczIR8wRcwbjCTqixSB8mPGkYZqF4UocZ9sdIZygpWgPO0kNJxx
         08SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SKvnZE8FRNSDrOi2i7LIYAhX4r86ogk967jOuzBNxJ8=;
        b=Wab1ZDf7nySpgWQwpR492BmEnAB6eV9DV+21kLNJ/sAeJNYOt5qTBJ9qfcHqreKMI6
         FeX8LZchZMjwtWVqOW2Qd54KLHgYVxXR6Be3M27igqNr5By6dumefZtSPbomsy0W0VKi
         HxHsM+10ZHPj47Ae3HvVCQefc3QwjatDGXZlbn44fhEasZkq4BXQu6vAgfo7Bn3GahT/
         iNMVpW+CxsoA0b6r0dTcl+7Oo0iw6HOgnQM+OMrUGEyHcF/mDB4mHdrvf8Tbw3wLtiav
         UeoiPNvklmrNKOY2X2DVIIAPyagd43EE2qeeenNi/UzBrJLmen1qEEPFUzqMnu08WEq4
         h8Cg==
X-Gm-Message-State: AHQUAubt21UiMHvXmmnWslYfY0LoA2a4BaEAb+/Zy6VlwUzbEyS/HySy
        dVzfIn22fTsHMfqHpa90DB8raRg0chQ=
X-Google-Smtp-Source: AHgI3IZid6tlDJ1m6bmRdnxpqkRAtYjkJ/5kbzuuhA8XqiyRHHxzds6vY7UgpnQZ7k9CtMdNunF4DQ==
X-Received: by 2002:a1c:8088:: with SMTP id b130mr663511wmd.96.1550070313917;
        Wed, 13 Feb 2019 07:05:13 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id f187sm7533959wma.4.2019.02.13.07.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 07:05:13 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2 1/3] pwm: hibvt: Use individual struct per of-data.
Date:   Wed, 13 Feb 2019 16:05:06 +0100
Message-Id: <20190213150508.11499-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split pwm-soc array in one struct per soc and point to the
corresponding on in of-data.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 27c107e78d59..ffc803818c3c 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -49,15 +49,19 @@ struct hibvt_pwm_chip {
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
+	const struct hibvt_pwm_soc *soc;
 };
 
 struct hibvt_pwm_soc {
 	u32 num_pwms;
 };
 
-static const struct hibvt_pwm_soc pwm_soc[2] = {
-	{ .num_pwms = 4 },
-	{ .num_pwms = 8 },
+static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
+	.num_pwms = 4,
+};
+
+static const struct hibvt_pwm_soc hi3519v100_soc_info = {
+	.num_pwms = 8,
 };
 
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
@@ -198,6 +202,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.npwm = soc->num_pwms;
 	pwm_chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm_chip->chip.of_pwm_n_cells = 3;
+	pwm_chip->soc = soc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm_chip->base = devm_ioremap_resource(&pdev->dev, res);
@@ -250,8 +255,10 @@ static int hibvt_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hibvt_pwm_of_match[] = {
-	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[0] },
-	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[1] },
+	{ .compatible = "hisilicon,hi3516cv300-pwm",
+	  .data = &hi3516cv300_soc_info },
+	{ .compatible = "hisilicon,hi3519v100-pwm",
+	  .data = &hi3519v100_soc_info },
 	{  }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
-- 
2.17.1

