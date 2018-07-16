Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5C5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969F7208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7AtPHHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969F7208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeGPOA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:00:56 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33510 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeGPOA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:00:56 -0400
Received: by mail-lf0-f67.google.com with SMTP id u14-v6so32262920lfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ix+yxRd1GRySziQI95ggQSolzs26/X4BBwZ7n6ggkqI=;
        b=b7AtPHHnqoN/2MvAJGc6aoUdvnRV0FyssAiCvHKQL1w4G8YwDSbWnM2VxRUJON4/ep
         OSJvM7ISTscDJmp0s4BRhUnjfgSWccUoCgWyAxItZB0CHB6NyYy6plISIsCwJASrzjmc
         /bGlDa64NmdMe7Z1q2Hnn5jFQz1meOM6hw3pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ix+yxRd1GRySziQI95ggQSolzs26/X4BBwZ7n6ggkqI=;
        b=A6JTkbwDFt2oHpPhwYwcd6turkBfWGJH/Z+OoAwVkq1HTS2sk9Y4susBt80nHsI10x
         6yXfLqkanSNz0Xes00AS2s/Q+nTMqT+kOxqyKd45qGChpD448EuqSrscQbD9WrHNQNeR
         licRIZwPVDEDF9oUkA5UbqhXHjGN96tNs4L+8KH0vEdG7FhUfVaPLXy5QFLzceZL78bf
         r5xY1TLBZMBu1EfjGCrFj6ER3qcl5ydoOq3wnbTCJHkOaEv+KXcNyIbAGvAnEEbXWLjT
         cA0c+VCHNvIDPGN4990cvWmF2a+SC1wKzBLrB7r709VPAvLPOf/JTU+dug6AHWFpCIqz
         K0JA==
X-Gm-Message-State: AOUpUlFjafb7xgEvUnk351JzCdGWrS0phmBkDdZOPwnHR/tgYE0E+JCf
        HW2lK6xTuya853VYjAAfDZY2lA==
X-Google-Smtp-Source: AAOMgpdXfb0d8GiXEgYBBGTUdENh7LtAqQbnormrT0WvKmZjsDpI8nB6o9IX6OGATQu8BoOIkA8kPg==
X-Received: by 2002:a19:385a:: with SMTP id d26-v6mr12121389lfj.47.1531748006344;
        Mon, 16 Jul 2018 06:33:26 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id x3-v6sm4915998ljb.25.2018.07.16.06.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:33:25 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, johan@kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] regulator: qcom_spmi: Do not initialise static to NULL
Date:   Mon, 16 Jul 2018 15:32:53 +0200
Message-Id: <20180716133255.1506-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716133255.1506-1-niklas.cassel@linaro.org>
References: <20180716133255.1506-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:

ERROR: do not initialise statics to NULL
+static struct regmap *saw_regmap = NULL;

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index ba3d5e63ada6..5246f5b870c2 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1060,7 +1060,7 @@ static irqreturn_t spmi_regulator_vs_ocp_isr(int irq, void *data)
 #define SAW3_AVS_CTL_TGGL_MASK	0x8000000
 #define SAW3_AVS_CTL_CLEAR_MASK	0x7efc00
 
-static struct regmap *saw_regmap = NULL;
+static struct regmap *saw_regmap;
 
 static void spmi_saw_set_vdd(void *data)
 {
-- 
2.17.1

