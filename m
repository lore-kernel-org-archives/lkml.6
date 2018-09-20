Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F1EECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B739621531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pci4h3ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B739621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbeIUBEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47033 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbeIUBEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so4807160pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T80GjCa0DMwxYtCVqkR4Wxt15OnIR0TvjpRXiH/ixL4=;
        b=Pci4h3kouhEsck8AUPW+3dRC+H1jBj+PZXIq3XUSVLm1lSioblCBJ3jw4XLOBbRSl0
         zMkv+LBm5yGTSM2wbAGqHpi4PtfjDvMML8eG+PV9BIcssXkafnv2O6wZ/+P41x+kec40
         rzCYZy6TJlZHwXt9wpWrUmLJRwnbnd5Gb+Z5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T80GjCa0DMwxYtCVqkR4Wxt15OnIR0TvjpRXiH/ixL4=;
        b=dyIgYhCuiR9Xe8d2YQEwNX7gjtvAzZdCct2fZoHKpnXoyvIQk0W24tAp1DTddKzaQi
         m9XRsc8C4iL9boeqNvKgEGbAQ5Sy+klQJewrLutZZlm6dxgxWlsgW2AnaYue9E2QRsfi
         EgTCbI8KjLC5x5BKdXBbByetow2XaJd84mEMZ8TByyjrxMJw4e43K8ehoemfjyt5ftVT
         TOMWKVE84b4RcnXXT3M8XW8SpohrMluVu4AeeHTjxU/B5UKBzYF5z8vXiL+qSK9mcl72
         Na68YF2pWofLuPbOsgnmhvqESOkGTS0F5OYcuYK1Q6/psqgcS0iUsGGLr7Nv4gXQPP47
         qPeQ==
X-Gm-Message-State: APzg51Dd4hhIqf9vsMPz5BjCRUss0eWfUx5hKx1F1m0HIlcC6v1do8by
        DzGFCWEFm8CeQs8zUOrEiJ4ZKg==
X-Google-Smtp-Source: ANB0VdYXudojwRjHobHUeF10CTy7MCmkaqEmkyMYtQIeH6rL2QG4teZKb4hhDuOilPj9dyp/NAmhmQ==
X-Received: by 2002:a63:d74f:: with SMTP id w15-v6mr38338400pgi.306.1537471161180;
        Thu, 20 Sep 2018 12:19:21 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:20 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 39/44] coresight: catu: Claim device before use
Date:   Thu, 20 Sep 2018 13:18:14 -0600
Message-Id: <1537471099-19781-40-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Use the CLAIM protocol to grab the ownership of the component when
in use.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index ff94e58845b7..170fbb66bda2 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -406,6 +406,7 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
 
 static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 {
+	int rc;
 	u32 control, mode;
 	struct etr_buf *etr_buf = data;
 
@@ -418,6 +419,10 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 		return -EBUSY;
 	}
 
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		return rc;
+
 	control |= BIT(CATU_CONTROL_ENABLE);
 
 	if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
@@ -459,6 +464,7 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
 	int rc = 0;
 
 	catu_write_control(drvdata, 0);
+	coresight_disclaim_device_unlocked(drvdata->base);
 	if (catu_wait_for_ready(drvdata)) {
 		dev_info(drvdata->dev, "Timeout while waiting for READY\n");
 		rc = -EAGAIN;
-- 
2.7.4

