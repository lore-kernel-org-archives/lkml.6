Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C0ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957852150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="daH5aI5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957852150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbeITHaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:30:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbeITHaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:30:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so3563806pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TH6B8WSzd10W48SEVbkFc6rDiVSy0C3hDys859up1d4=;
        b=daH5aI5/54SMpB6AWMNqMhS1OY1gIsDRikwSaVsKuoQZS5lZEhNkCHn5J1EbXydWQQ
         48cEAl14YHVPQv8TAtYAkqDUX+rYyuG+tMhbZXF3gmoYNitM/NsBgdcqOZEdoyjqeigk
         yjfgcx275l0YYDjgDoUygJ93zy6o8+5osRjjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TH6B8WSzd10W48SEVbkFc6rDiVSy0C3hDys859up1d4=;
        b=J8Stb1thmkFnLRByi7qa4siS/60a1wU0pbH5KFHsSPFvtD+GyJk5PIF3IaeUfRVFpn
         hjslXjO+IQD6Cz9i7APkzV/INCUiNc2iR3+z/FxKpVd8qudd25GybdDjVUHSf3i1s1gu
         h2IYIeLnb7ZAjXBNyRKcJcS52VAheZYTTVdarANE9mvmjl2A9lrFsklFQELcrV9CtZJW
         zDbYAkkBULRcNpttKYJWMP19qjE90e/ihbmPwTnqYMTyurSYZ+aAwPvQvkktg6+iKSFw
         qsbNBAFzGv6IZU7+BO9ZPbAmsWfI5/eu4TUN0QxbKbrvOeezE2ke3zeHK0AOhSBRR35+
         JcaA==
X-Gm-Message-State: APzg51BUvGq1jIxPb8iAZhr3bgapyq+0Mx4/UQO6KvRNvPVsyDWAsShR
        7ed5EIeQvxbugxPZ4uh1L1Ob/7N0J0vTF+JS
X-Google-Smtp-Source: ANB0VdZSQzHkoRTvJAVVn6/G9R2Ks1aOkNsHhMdIdM1l7+10fHRLQk1xoj4LJgiupXkiSivVbNSdmQ==
X-Received: by 2002:a62:c0a:: with SMTP id u10-v6mr39027862pfi.43.1537408174380;
        Wed, 19 Sep 2018 18:49:34 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x24-v6sm28927336pfh.67.2018.09.19.18.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:49:33 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: q6v5: Propagate EPROBE_DEFER
Date:   Wed, 19 Sep 2018 18:51:51 -0700
Message-Id: <20180920015151.15957-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case that the interrupts fail to result because of the
interrupt-controller not yet being registered the
platform_get_irq_byname() call will fail with -EPROBE_DEFER, but passing
this into devm_request_threaded_irq() will result in -EINVAL being
returned, the driver is therefor not reprobed later.

Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_q6v5.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 61a760ee4aac..e9ab90c19304 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -198,6 +198,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
+	if (q6v5->fatal_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
 					NULL, q6v5_fatal_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -208,6 +211,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
+	if (q6v5->ready_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
 					NULL, q6v5_ready_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -218,6 +224,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
+	if (q6v5->handover_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
 					NULL, q6v5_handover_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -229,6 +238,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	disable_irq(q6v5->handover_irq);
 
 	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
+	if (q6v5->stop_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
 					NULL, q6v5_stop_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-- 
2.18.0

