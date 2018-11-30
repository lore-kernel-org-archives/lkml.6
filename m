Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488BEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112E220868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdnKfvyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112E220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeK3XGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:06:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35946 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeK3XGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:06:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so5024502wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PewPBIfHqgDIhsBbmdKcbv8XqYd2zo9JJpyybokY34A=;
        b=gdnKfvygXVffpqjavb78W/XobM+3rZRXkGDOc7KKNczonTROzNw7uSEKh/HpLFCEWC
         pFXCXbIaFBR4201Arr1aE+Z9KMvQiRccYvqqqcOrFifpMBfOpvDqQQK3RW33EzM58Iov
         lWM77s922qoGLJ7nzqrkvE1ZJmtng9QEvMdwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PewPBIfHqgDIhsBbmdKcbv8XqYd2zo9JJpyybokY34A=;
        b=fJXUoBvHyTIhPcZp2PyQ7WnW3TbbZqvvzEV2qc5W8Q1PYKw1Q2GCwmf8oPyd7EUl8X
         6hpEHtWvCVkxo7t9SazMFo7QNmlJZNUCYuz/LI8O2wmamH8fJRn6K95B64NjMMUZyAmi
         EQCAg57f3gGbyCLTj6jNXaEKx/ybeskouXjuVNtUyXm+fHFsTv+ABTBQEbdHCXydWLyk
         dTkNlXPSLOA1uA/0rlf1ibm4MtElfm5Q76ILaJzYagYap4xHWiwQaRdwoPOxj2OmNKVz
         ne5UlulJqOWr9vDtM2HSUgcx3NlLAJNiABnay4MCUegeepTr8JV0/6iaGVddo4+4KXkZ
         +Iug==
X-Gm-Message-State: AA+aEWbuWlLgFcmSbWPguuoSUz0DNtJw/aFUKQ3gHy9J4oKlMUG2I2li
        y7X2OqIxB6eG1zEH9TSAEeULGuQUSEQ=
X-Google-Smtp-Source: AFSGD/Uao2eukvk1LfT1gdQnycCNt4T0V44SVmCo2BRtA4UhL/IDkN+CvMddvdMhpSpEA8hmHCaMJg==
X-Received: by 2002:adf:b783:: with SMTP id s3mr4881802wre.274.1543579068201;
        Fri, 30 Nov 2018 03:57:48 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c12sm3861303wrs.82.2018.11.30.03.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:57:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: qcom-ctrl: simplify getting .driver_data
Date:   Fri, 30 Nov 2018 11:57:41 +0000
Message-Id: <20181130115742.16813-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130115742.16813-1-srinivas.kandagatla@linaro.org>
References: <20181130115742.16813-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index db1f5135846a..ad3e2e23f56e 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -654,8 +654,7 @@ static int qcom_slim_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int qcom_slim_runtime_suspend(struct device *device)
 {
-	struct platform_device *pdev = to_platform_device(device);
-	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
+	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(device);
 	int ret;
 
 	dev_dbg(device, "pm_runtime: suspending...\n");
@@ -672,8 +671,7 @@ static int qcom_slim_runtime_suspend(struct device *device)
 
 static int qcom_slim_runtime_resume(struct device *device)
 {
-	struct platform_device *pdev = to_platform_device(device);
-	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
+	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(device);
 	int ret = 0;
 
 	dev_dbg(device, "pm_runtime: resuming...\n");
-- 
2.19.2

