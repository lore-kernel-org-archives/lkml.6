Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734F720854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KLZWzsJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734F720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeKQFMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:12:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39261 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeKQFMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:12:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so7134611pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 10:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O/I1k539tqwRKsWEthqNKRxgRw6UGeJxi9txfRXZzPs=;
        b=KLZWzsJhlfTV/XtDJEEamvmNiM8nLyXeEta/AJD2tDgdv+WurGGNVZuvZe18Jho4KC
         v6Q3QOBZhO8bzJGTqkFzQ0NYhuB7nNqPDjDwcLg2rCP90f8FzF6V4hqz2BgpFijfuvlU
         oN4NsVm4d9FqcOK72WlLquPVnxjX2t5/VYnGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O/I1k539tqwRKsWEthqNKRxgRw6UGeJxi9txfRXZzPs=;
        b=KBTiXGQWO7uU10MCV1x/t5bB+gx1+ZjaVnz024paMs7C6uBRTAUq9gfrMZCeVAJciU
         +kWqkNOG02cjPamPOMyw1mEsTUS8vmjK8dJNgYpzY5R2xZrf7a6OHAhCoPWe8W1fJbM2
         GxeBbTzIFckFPnLn0XLej0NVmtl6ZRIZYleIjYuSR2rJ91ffCpdvs40KSofZ3EJoLMJS
         2QvfPBMsuniQMAjBxaRkxrV9VABIkRf0T9tptoG0RCqOOqDDCtnfvSSleTQrc8yxe85w
         A7FKlcdF+6cwNiyA+zLKPpKy1FqzDGiK9E7FJKmSGvjaIt5K7bBFIE+8ifjTbWuJmxoZ
         yOsQ==
X-Gm-Message-State: AGRZ1gLOkkZcpdhStrntpngSNUOFckNB/t1HL11NDcBdxtWJzI8+y9jF
        wjBeo6Vsr++Kjdr71dKuroHX5w==
X-Google-Smtp-Source: AJdET5c5jsenlqjOYFDIn7rMKqqrkp8pjbYQ5O05azogL1kYAUz70A/3ueQ5e7DYLQP49vZMyEREOA==
X-Received: by 2002:a63:2f07:: with SMTP id v7mr10351558pgv.368.1542394743165;
        Fri, 16 Nov 2018 10:59:03 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id n13-v6sm44514473pfk.19.2018.11.16.10.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 10:59:02 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] pinctrl: msm: Add sleep pinctrl state transitions
Date:   Fri, 16 Nov 2018 10:58:53 -0800
Message-Id: <20181116185853.128207-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PM suspend callbacks to the msm core driver that select the
sleep and default pinctrl states. Then wire those callbacks up
in the sdm845 driver, for those boards that may have GPIO hogs
that need to change state during suspend.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v2:
 - Moved dev_pm_ops structure to pinctrl-msm [Bjorn]

 drivers/pinctrl/qcom/pinctrl-msm.c    | 19 +++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.h    |  2 ++
 drivers/pinctrl/qcom/pinctrl-sdm845.c |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7c7d083e2c0dc..87cbebe217fd2 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1072,6 +1072,25 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
 		}
 }
 
+static int msm_pinctrl_suspend(struct device *dev)
+{
+	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
+
+	return pinctrl_force_sleep(pctrl->pctrl);
+}
+
+static int msm_pinctrl_resume(struct device *dev)
+{
+	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
+
+	return pinctrl_force_default(pctrl->pctrl);
+}
+
+SIMPLE_DEV_PM_OPS(msm_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
+		  msm_pinctrl_resume);
+
+EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
+
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data)
 {
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 29172fdf5882c..c12048e54a6f0 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -123,6 +123,8 @@ struct msm_pinctrl_soc_data {
 	unsigned int ntiles;
 };
 
+extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
+
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data);
 int msm_pinctrl_remove(struct platform_device *pdev);
diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 2ab7a88857579..c97f20fca5fd3 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -1300,6 +1300,7 @@ static const struct of_device_id sdm845_pinctrl_of_match[] = {
 static struct platform_driver sdm845_pinctrl_driver = {
 	.driver = {
 		.name = "sdm845-pinctrl",
+		.pm = &msm_pinctrl_dev_pm_ops,
 		.of_match_table = sdm845_pinctrl_of_match,
 	},
 	.probe = sdm845_pinctrl_probe,
-- 
2.16.4

