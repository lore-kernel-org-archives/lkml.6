Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7848C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6371320C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQ/xRaZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6371320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeIYPKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:10:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39939 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeIYPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:10:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so18832118wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n7P2OSw8y61wcHZXfde/sCT0rh4Lfv8tdnBhTgzGYnU=;
        b=LQ/xRaZnZ/dByBF9rTFaqMOVQLxUFJsdsQuNwcwYXVMOiE7ZzLbROcZKTmIbOpZ7TN
         AFsSF6M724qkJoYhG7DpaOM+diUc+jLwuKIRT6vYf8jSkGcQ/mOc6zEjdMH5c8j2Kgyd
         bpbUEU+Zci6i7DYhWpNqC+AEv/rWss5sWztRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n7P2OSw8y61wcHZXfde/sCT0rh4Lfv8tdnBhTgzGYnU=;
        b=BQtPjeQhGOXfJJqAQntUKdHJs4XuhKEZpsN06GWCpeotV3CnoJ5Eumevgi+GFzdICX
         CVoZco/Bw4AFBODQ4J44qN54Egy585HeSBtpXEaoucfsKPRjSjOh4jbDtNul9huE1+Si
         khB6epgWXFE/zJjcDHCz5fWq9dw8pPHpnsIx8WmFDotY+QvK1Hk07gV8oRzHkxsfAQBg
         cRAzN4LIGnlxKr6oTaSVXcrQZRi4vjFApd9SuW/WmX4mH4zlqgj4XOl3p/FAI+glvT5B
         GmHpfZQ4zojlMJ2yd2yfzdPFeLFtlPhm6IhEPFWG4zqSBI+fgQIVvhioHXlh1RUY43kd
         1mlw==
X-Gm-Message-State: ABuFfojAF6xfRSSwXvyxmOlNvnSv++TvN+Ly433/ar7+lI7S+1stdNJS
        MB4n/CTDPLmHPoK7GVi8NII7k2Hhyq0=
X-Google-Smtp-Source: ACcGV60mDHOmUD35l0uF2lPStiIueUCz2vCAOHzvHOURJmTuNlK5tExCmgR/b9nxFZ4CxpzhMHhgbg==
X-Received: by 2002:adf:8425:: with SMTP id 34-v6mr12377wrf.153.1537866239922;
        Tue, 25 Sep 2018 02:03:59 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:03:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 04/14] thermal/drivers/hisi: Factor out the probe functions
Date:   Tue, 25 Sep 2018 11:03:02 +0200
Message-Id: <1537866192-12320-5-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hi6220 and the hi3660 probe functions are doing almost the same
operations, they can share 90% of their code.

Factor out the probe functions by moving the common code in the common
probe function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 567fde6..7287818 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -391,16 +391,8 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 {
 	struct platform_device *pdev = data->pdev;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->regs)) {
-		dev_err(dev, "failed to get io address\n");
-		return PTR_ERR(data->regs);
-	}
-
 	data->clk = devm_clk_get(dev, "thermal_clk");
 	if (IS_ERR(data->clk)) {
 		ret = PTR_ERR(data->clk);
@@ -409,10 +401,6 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 		return ret;
 	}
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
-
 	data->sensor.id = HI6220_DEFAULT_SENSOR;
 
 	return 0;
@@ -420,21 +408,6 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 
 static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 {
-	struct platform_device *pdev = data->pdev;
-	struct device *dev = &pdev->dev;
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->regs)) {
-		dev_err(dev, "failed to get io address\n");
-		return PTR_ERR(data->regs);
-	}
-
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
-
 	data->sensor.id = HI3660_DEFAULT_SENSOR;
 
 	return 0;
@@ -553,6 +526,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
 	struct device *dev = &pdev->dev;
+	struct resource *res;
 	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -564,6 +538,17 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	data->sensor.data = data;
 	data->ops = of_device_get_match_data(dev);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->regs)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0)
+		return data->irq;
+
 	ret = data->ops->probe(data);
 	if (ret)
 		return ret;
-- 
2.7.4

