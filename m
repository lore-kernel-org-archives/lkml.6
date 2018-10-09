Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00836C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB3A21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nJs9gOoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB3A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJJFwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:52:39 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44756 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:52:38 -0400
Received: by mail-vs1-f67.google.com with SMTP id w194so3175788vsc.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CPGFW2DQC4f1MgxoiuDkDHORIrgQre84IqugeepP430=;
        b=nJs9gOoYJg5yYbcF8xxeW2UXHNDrF6FtoiNpTxqf2s5AMxk3sMq0snuZ0YzZTYzFa3
         dZDEXDeh7cPe1iyHEEqU6kzsQ2WpJfWxIBXctAVLjtij1R8cFSHzo+A+XEMxPDgi7KfP
         m9YYPas2bf4zqRwSod1XwGnltaDiWoyS82dqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CPGFW2DQC4f1MgxoiuDkDHORIrgQre84IqugeepP430=;
        b=uOzWVq6AGIQanb3q/fH/dAGp2SCQ6ebt6OHzqei+LmnBckFl/WlDvyFiUGPiPn6TDt
         AwkWV+BpF/l6IxBQZiuBs5adEgF8qt1vJDVt+3GaLAAc9K/jmAwJxJhCVlFmydVwWJNc
         ufrDULOWxZs5zFiAPHP+YXmShNGfBCG55MEJZ7ksHNkmxhML8kgVK4MxrexZD1FlAfXE
         KSz5+aMghwGYINjWYh4hwygJ9nrMjiCLllXkRhKPL2I9ubxxYmrH0ypc2ZOmdr1umjAU
         vL4rbgJpXsa6IDydMbLGmb4J8oIT63jQmkqUHsSkdpL8p3G3+QcRE3D39zPol6uKHPzI
         x2lA==
X-Gm-Message-State: ABuFfojKCedq7DyTXZk0+eC2hnokHB34qtpQUZPG9HO/eQosuE9CY5h3
        YKdkSoC/LtvbmhnxSS67uxWXSg==
X-Google-Smtp-Source: ACcGV60t1qxjWBxKmPdvKDR2M929CD7tjYIjSorLWKy9Rp7CnN4LV0CAUubvFZ3D6uGYA7lZexeUFA==
X-Received: by 2002:a67:4e54:: with SMTP id c81mr11260418vsb.72.1539124410761;
        Tue, 09 Oct 2018 15:33:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id w75sm7328200vsh.21.2018.10.09.15.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 15:33:29 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] remoteproc: qcom: q6v5: shore up resource probe handling
Date:   Tue,  9 Oct 2018 15:25:27 -0700
Message-Id: <20181009222527.74260-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d5269c4553a6 ("remoteproc: qcom: q6v5: Propagate EPROBE_DEFER")
fixed up our probe code to handle -EPROBE_DEFER, but it ignored one of
our interrupts, and it also didn't really handle all the other error
codes you might get (e.g., with a bad DT definition). Handle those all
explicitly.

Fixes: d5269c4553a6 ("remoteproc: qcom: q6v5: Propagate EPROBE_DEFER")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/remoteproc/qcom_q6v5.c | 44 +++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index edeb2e43209e..7d6a98072b21 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -187,6 +187,14 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	init_completion(&q6v5->stop_done);
 
 	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
+	if (q6v5->wdog_irq < 0) {
+		if (q6v5->wdog_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve wdog IRQ: %d\n",
+				q6v5->wdog_irq);
+		return q6v5->wdog_irq;
+	}
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->wdog_irq,
 					NULL, q6v5_wdog_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -197,8 +205,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
-	if (q6v5->fatal_irq == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (q6v5->fatal_irq < 0) {
+		if (q6v5->fatal_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve fatal IRQ: %d\n",
+				q6v5->fatal_irq);
+		return q6v5->fatal_irq;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
 					NULL, q6v5_fatal_interrupt,
@@ -210,8 +223,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
-	if (q6v5->ready_irq == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (q6v5->ready_irq < 0) {
+		if (q6v5->ready_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve ready IRQ: %d\n",
+				q6v5->ready_irq);
+		return q6v5->ready_irq;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
 					NULL, q6v5_ready_interrupt,
@@ -223,8 +241,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
-	if (q6v5->handover_irq == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (q6v5->handover_irq < 0) {
+		if (q6v5->handover_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve handover IRQ: %d\n",
+				q6v5->handover_irq);
+		return q6v5->handover_irq;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
 					NULL, q6v5_handover_interrupt,
@@ -237,8 +260,13 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	disable_irq(q6v5->handover_irq);
 
 	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
-	if (q6v5->stop_irq == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (q6v5->stop_irq < 0) {
+		if (q6v5->stop_irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to retrieve stop IRQ: %d\n",
+				q6v5->stop_irq);
+		return q6v5->stop_irq;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
 					NULL, q6v5_stop_interrupt,
-- 
2.19.0.605.g01d371f741-goog

