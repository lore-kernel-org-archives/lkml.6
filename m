Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826B520C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uo7P3B0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826B520C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbeGQKow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:44:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36156 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbeGQKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:44:52 -0400
Received: by mail-pf0-f196.google.com with SMTP id d14-v6so289113pfo.3;
        Tue, 17 Jul 2018 03:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WfH3ZgLhwu+xoTXF70X3gUOpVc+l6Mcncfd0VLq0bAo=;
        b=uo7P3B0QPXB5GcijvE7nYC3gflJCrrInRSHZCAKM0D5IpD25KWJIrQqGVygpoUr/pX
         GEUFP/NiV2N6iUImXs2X0S7blnKTbbn2l2APeWSB3pphfaTeWVEa7trAV9IWNTMeqgPF
         oOMgiw1sG+detQJS7igos1rkX6sBcOHCfZ5yFd+/L3ogUbjah+cCYlPreDG3T84YHhQy
         crN6hYb4Wzx9mLweToXgT6L1Uo2Jz0xrUOOoHA7yxmFhPFsG/LY9CRcU9A6Rjugs0Gvi
         ycSRymomVLfmM/7tvFaR7NaIRdZ1949U5f4zgqobSOoM9kNU5Q2ai07kfCrFWJAfA7Tx
         //Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WfH3ZgLhwu+xoTXF70X3gUOpVc+l6Mcncfd0VLq0bAo=;
        b=ukJGTVn+0VD42IzBNvh8+f88nVyunK9fC5JGFXHd07CbHrln6ul0e1qOKsLKN06PP4
         2TYikAD1ShG6XIgAvcmeZnBmz9J9xV9dqhh45u/bXP32+JnrR6LiGpm0CiRUqncCXYKp
         4zpuc+wfRETt7F7ng50SW2ScKcqXbj3fuHCs+psxebf4bit3nqwgtE7sNfCZhrqcCSGb
         BXjATkqo2wR3EDbX3c5F94irFL5F9XzQpeHAk/oOhOhT7nKtJaClJIwfbrFIt8uSOEft
         0w6pw2eXKsYE7cNbiI0ECGHkHl1OgJN0EtwUWNuxd7xA5LkeC0SjjQh0GZ2vw2cIE08t
         eqzw==
X-Gm-Message-State: AOUpUlGcHBNYBskUzTTtLCSMzExjb0b9vkaNajSradnKP8dukRoZKNTH
        2xOl6gMwlqIlkbzdOMmCAyI=
X-Google-Smtp-Source: AAOMgpfJqz59OtBAzmKIiqjg35GivfliigZSrzuE3e/mvGZPjkJr53YvtN8mfS3BBSyJmmUSgrg+9g==
X-Received: by 2002:a63:b349:: with SMTP id x9-v6mr966111pgt.337.1531822379412;
        Tue, 17 Jul 2018 03:12:59 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.210])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2809963pgb.14.2018.07.17.03.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 03:12:58 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 2/5] thermal: exynos: cleanup of clk err check for exynos_tmu_work
Date:   Tue, 17 Jul 2018 10:12:19 +0000
Message-Id: <1531822342-4293-2-git-send-email-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cleanup err check in exynos_tmu_work as clk internal
framework will perform if clk is enable/disable
so drop the double check of IS_ERR and other such references.

CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0164c9e..2dbde97 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -300,8 +300,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
+	clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -334,8 +333,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 err:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
+	clk_disable(data->clk_sec);
 out:
 	return ret;
 }
@@ -789,19 +787,16 @@ static void exynos_tmu_work(struct work_struct *work)
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
 
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
-
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
+	clk_enable(data->clk_sec);
 
 	/* TODO: take action based on particular interrupt */
 	data->tmu_clear_irqs(data);
 
+	clk_disable(data->clk_sec);
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 	enable_irq(data->irq);
@@ -1134,8 +1129,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 err_sclk:
 	clk_disable_unprepare(data->sclk);
 err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_disable_unprepare(data->clk_sec);
+	clk_disable_unprepare(data->clk_sec);
 err_clk:
 	clk_disable_unprepare(data->clk);
 err_sensor:
@@ -1155,8 +1149,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->sclk);
 	clk_disable_unprepare(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable_unprepare(data->clk_sec);
+	clk_disable_unprepare(data->clk_sec);
 
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
-- 
2.7.4

