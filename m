Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91729C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 04:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5057221783
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 04:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="tuO2PPmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfALEao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 23:30:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41864 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfALEao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 23:30:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so7155337pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 20:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bb5NiRdRTYhaDDRi0q2AS3eLwfu1G9cPUm5EDh5CnKI=;
        b=tuO2PPmGwViToQ8TwYLGb7iQOBKHNW5JRDZMIZO+wd8TtAl0CKfPjqwsbIoOdfWmPM
         4h3AtMy0PjhXBEkkgSqZJguevjstHf9KXRbjEKQ4WcbPpL2nZAz4lhZRw0QewrHl7jgn
         5EG2i1t/JLm1P0UGCBMcR+sKY3y0fb01qFm0DDWWYUWiXd6fZge3QQsxTimJqG4rZgyB
         PqJy4ztoQs2DdgoKR1R5BnwJ1+CJr7J45gw75KFvYvtxyPjxTW7/33/h6aHclLQUpa/m
         3j7Gvby2uOgbhwjUTtTw3I7AnuZ9JcPbcBXVyuKH9KUuHX9jwpOoO0kjQRCz5J49DoAo
         vnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bb5NiRdRTYhaDDRi0q2AS3eLwfu1G9cPUm5EDh5CnKI=;
        b=MTaq7Leou6uhtS8IXUE6jP5jLDMK5qxNjtvMiumfrg5z9dnd4t4HvkYLcxjCufWo5k
         cAeQToFGU0EOjKgFUrKFZLyv/62E5EPmgTg5dkedf5a8FMcPsB+o4qrvFnwRI9tvP1cx
         ufzGhBikDS9SU4/D2C9c7NSrD3/B9WauQ3W2MhKJqs1JD+WF6DsT3pKbpTSIghA2AaUH
         bdpAudCKrCBDFsQo6/f3uKMTiu4WhFxfoNBy5LVZCw99dmxaH8HQ04/IIcbfTJztbDua
         oREx3b1+omQgJRBdJjRStP4F3gtbE3nhA2xQy/4NZrLtc9CUxXQhPQo6Ko+clQXdXQ5u
         TkOQ==
X-Gm-Message-State: AJcUukf3Eqnf0HdA1gXGKRVWF1xPiNRZXDR+KWf5VHw7JCoGdGGsNckS
        9jKSwu8G5Mil8MYB0VMQnlQR/Q==
X-Google-Smtp-Source: ALg8bN750qGkXi//LATu9UeTSQ1t+8KEiRS/igAFBU/ifkWM514TdQhXTo7z+ihlJ6KNz+x98QcaOw==
X-Received: by 2002:a62:3888:: with SMTP id f130mr16880767pfa.132.1547267442435;
        Fri, 11 Jan 2019 20:30:42 -0800 (PST)
Received: from localhost.localdomain (36-239-240-185.dynamic-ip.hinet.net. [36.239.240.185])
        by smtp.gmail.com with ESMTPSA id j9sm102403389pfi.86.2019.01.11.20.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 20:30:41 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: pwm: No need to make a copy of regulator_ops per instance
Date:   Sat, 12 Jan 2019 12:30:13 +0800
Message-Id: <20190112043013.15017-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having instance specific copy of desc is enough to support multiple
instance of pwm regulator.
The regulator_ops is never changed so no need to copy it per instance, make
pwm_regulator_voltage_table_ops and pwm_regulator_voltage_continuous_ops
const to ensure they won't be changed.
The pwm_regulator_desc is a template to be copied so also make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pwm-regulator.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index a2fd140eff81..3f53f9134b32 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -40,9 +40,6 @@ struct pwm_regulator_data {
 	/* regulator descriptor */
 	struct regulator_desc desc;
 
-	/* Regulator ops */
-	struct regulator_ops ops;
-
 	int state;
 
 	/* Enable GPIO */
@@ -231,7 +228,7 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 	return 0;
 }
 
-static struct regulator_ops pwm_regulator_voltage_table_ops = {
+static const struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.set_voltage_sel = pwm_regulator_set_voltage_sel,
 	.get_voltage_sel = pwm_regulator_get_voltage_sel,
 	.list_voltage    = pwm_regulator_list_voltage,
@@ -241,7 +238,7 @@ static struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.is_enabled      = pwm_regulator_is_enabled,
 };
 
-static struct regulator_ops pwm_regulator_voltage_continuous_ops = {
+static const struct regulator_ops pwm_regulator_voltage_continuous_ops = {
 	.get_voltage = pwm_regulator_get_voltage,
 	.set_voltage = pwm_regulator_set_voltage,
 	.enable          = pwm_regulator_enable,
@@ -249,7 +246,7 @@ static struct regulator_ops pwm_regulator_voltage_continuous_ops = {
 	.is_enabled      = pwm_regulator_is_enabled,
 };
 
-static struct regulator_desc pwm_regulator_desc = {
+static const struct regulator_desc pwm_regulator_desc = {
 	.name		= "pwm-regulator",
 	.type		= REGULATOR_VOLTAGE,
 	.owner		= THIS_MODULE,
@@ -287,9 +284,7 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 
 	drvdata->state			= -EINVAL;
 	drvdata->duty_cycle_table	= duty_cycle_table;
-	memcpy(&drvdata->ops, &pwm_regulator_voltage_table_ops,
-	       sizeof(drvdata->ops));
-	drvdata->desc.ops = &drvdata->ops;
+	drvdata->desc.ops = &pwm_regulator_voltage_table_ops;
 	drvdata->desc.n_voltages	= length / sizeof(*duty_cycle_table);
 
 	return 0;
@@ -301,9 +296,7 @@ static int pwm_regulator_init_continuous(struct platform_device *pdev,
 	u32 dutycycle_range[2] = { 0, 100 };
 	u32 dutycycle_unit = 100;
 
-	memcpy(&drvdata->ops, &pwm_regulator_voltage_continuous_ops,
-	       sizeof(drvdata->ops));
-	drvdata->desc.ops = &drvdata->ops;
+	drvdata->desc.ops = &pwm_regulator_voltage_continuous_ops;
 	drvdata->desc.continuous_voltage_range = true;
 
 	of_property_read_u32_array(pdev->dev.of_node,
-- 
2.17.1

