Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ED2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F80520855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ojpKu2DS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ojpKu2DS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfAQJQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:16:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfAQJQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:16:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E020A60851; Thu, 17 Jan 2019 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547716577;
        bh=8T+x0tKb6M4sdkHsZm/gSK6UzAOkiObL3LBGb2D36zo=;
        h=From:To:Cc:Subject:Date:From;
        b=ojpKu2DSmIPp8JlIj0/kwjGCC3mZVLI5aARjtpkpxigcfX0bF4oNAiG/tbJSxYCk2
         M/iLDJwk6nwoHlGGazWBHpBe8lDQcimUayQgiT6ZHmHi1g+B1uQ5YgrS1J6wX47q7Z
         zHiSDVN+WmMbyfYQkbUQVib4H02I8zJXyhYhwhKY=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 294596075A;
        Thu, 17 Jan 2019 09:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547716577;
        bh=8T+x0tKb6M4sdkHsZm/gSK6UzAOkiObL3LBGb2D36zo=;
        h=From:To:Cc:Subject:Date:From;
        b=ojpKu2DSmIPp8JlIj0/kwjGCC3mZVLI5aARjtpkpxigcfX0bF4oNAiG/tbJSxYCk2
         M/iLDJwk6nwoHlGGazWBHpBe8lDQcimUayQgiT6ZHmHi1g+B1uQ5YgrS1J6wX47q7Z
         zHiSDVN+WmMbyfYQkbUQVib4H02I8zJXyhYhwhKY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 294596075A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] watchdog: qcom: Add suspend/resume support
Date:   Thu, 17 Jan 2019 14:45:55 +0530
Message-Id: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the support for qcom watchdog suspend and resume
when entering and exiting deep sleep states. Otherwise
having watchdog active after suspend would result in unwanted
crashes/resets if resume happens after a long time.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/watchdog/qcom-wdt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 780971318810..4f58185e89eb 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -245,6 +245,30 @@ static int qcom_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int qcom_wdt_suspend(struct device *dev)
+{
+	struct qcom_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		qcom_wdt_stop(&wdt->wdd);
+
+	return 0;
+}
+
+static int qcom_wdt_resume(struct device *dev)
+{
+	struct qcom_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		qcom_wdt_start(&wdt->wdd);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(qcom_wdt_pm_ops, qcom_wdt_suspend, qcom_wdt_resume);
+
 static const struct of_device_id qcom_wdt_of_table[] = {
 	{ .compatible = "qcom,kpss-timer", .data = reg_offset_data_apcs_tmr },
 	{ .compatible = "qcom,scss-timer", .data = reg_offset_data_apcs_tmr },
@@ -259,6 +283,7 @@ static struct platform_driver qcom_watchdog_driver = {
 	.driver	= {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= qcom_wdt_of_table,
+		.pm		= &qcom_wdt_pm_ops,
 	},
 };
 module_platform_driver(qcom_watchdog_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

