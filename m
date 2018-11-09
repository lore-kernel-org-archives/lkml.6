Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A62C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A240F20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHQKhLB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A240F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeKJILk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:11:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36874 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbeKJILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:11:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id u13-v6so1545198pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=deR2DBQY1z1RlhRjU/vwUxZxbWnUFD1ztEzC9UHYdaw=;
        b=mHQKhLB0jweDp3nEPUKUWvftJymlgE+58bcdhthWb+RnQKggsADsN9XOhKRZK00nF5
         6v1QBlHR2PCj8s7ZReZADrXk2JMW1UqqRUqcU0m4bCZfziHAam6gY+qQ4EWTESp5AT7O
         1Ab+q3y35nPd422/nPzC229AiCYbDj/kBUI1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=deR2DBQY1z1RlhRjU/vwUxZxbWnUFD1ztEzC9UHYdaw=;
        b=Da43Hd4BMxKv4MKnv6I4mAf9jWodd7P2vum2QMVNG6dTYzIQInCUO7oRhQdlz0he+s
         vTWSgOM7JLRu8XRwjYl4uyIPFkf5+3N0sIRdmk2zOD9tNhCrUXTH/GGOgQYU5B5Zknsz
         WkIFrrF6IyPjEI1AWaXDFUVOensKuMglm7cZ/D6BNZDqD6/0/CjcK4dIbispJIUVzJBr
         BDAPIp0EmhmhaOep4C4SpqHDc5cTHqeTYWDnw2BXoElcS/Dq3OWIX8iVcb/iAKZ1OnTz
         FRLwKXokwAt4jWDeg6vovWp9GNLnZVW+rqsIzzuYJ2dg8ndq+y73hx/B3CcXqCLg5wGA
         T3TQ==
X-Gm-Message-State: AGRZ1gJ9NgpCIPgqSqL8+VVevUOy+QnNNtDMYl40VadHzbISXcAt8p3f
        Fn2eSWN5zawSHHeQxj+LbkkdYg==
X-Google-Smtp-Source: AJdET5cBuQY5XuyXvhktTS2gRRmtrMKU/a8lxZeyhXHR3G8CKN60ZBaMD3OzpLgH8wHp5HXOVlqBxw==
X-Received: by 2002:a65:5a8e:: with SMTP id c14mr9014921pgt.137.1541802543043;
        Fri, 09 Nov 2018 14:29:03 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id o7-v6sm11581274pfb.23.2018.11.09.14.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 14:29:02 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] pinctrl: msm: Add sleep pinctrl state transitions
Date:   Fri,  9 Nov 2018 14:28:35 -0800
Message-Id: <20181109222835.60607-1-evgreen@chromium.org>
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
---

 drivers/pinctrl/qcom/pinctrl-msm.c    | 16 ++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.h    |  2 ++
 drivers/pinctrl/qcom/pinctrl-sdm845.c |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7c7d083e2c0dc..d505d0a50f0a5 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1072,6 +1072,22 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
 		}
 }
 
+int msm_pinctrl_suspend(struct device *dev)
+{
+	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
+
+	return pinctrl_force_sleep(pctrl->pctrl);
+}
+EXPORT_SYMBOL(msm_pinctrl_suspend);
+
+int msm_pinctrl_resume(struct device *dev)
+{
+	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
+
+	return pinctrl_force_default(pctrl->pctrl);
+}
+EXPORT_SYMBOL(msm_pinctrl_resume);
+
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data)
 {
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 29172fdf5882c..e163ca600ecd3 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -123,6 +123,8 @@ struct msm_pinctrl_soc_data {
 	unsigned int ntiles;
 };
 
+int msm_pinctrl_suspend(struct device *dev);
+int msm_pinctrl_resume(struct device *dev);
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data);
 int msm_pinctrl_remove(struct platform_device *pdev);
diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 2ab7a88857579..a3ac9cbeabad1 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -1287,6 +1287,9 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
 	.ngpios = 150,
 };
 
+static SIMPLE_DEV_PM_OPS(sdm845_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
+			 msm_pinctrl_resume);
+
 static int sdm845_pinctrl_probe(struct platform_device *pdev)
 {
 	return msm_pinctrl_probe(pdev, &sdm845_pinctrl);
@@ -1300,6 +1303,7 @@ static const struct of_device_id sdm845_pinctrl_of_match[] = {
 static struct platform_driver sdm845_pinctrl_driver = {
 	.driver = {
 		.name = "sdm845-pinctrl",
+		.pm = &sdm845_pinctrl_dev_pm_ops,
 		.of_match_table = sdm845_pinctrl_of_match,
 	},
 	.probe = sdm845_pinctrl_probe,
-- 
2.16.4

