Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A450CECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF5021531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSaZ0Es6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF5021531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389086AbeIUBET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38308 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbeIUBES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so4800515plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZQN6xPGKIW6glHZexLLxjYGOYgPeCk+jeaAojs1cWHQ=;
        b=jSaZ0Es6z/aw9H1R3PsvJd0l4YafThGWssA9gwkuflwAm4dlzISK6Cy2WIJtiGe7Wy
         jTegSCuFh4QTKuOd7s5EGb2rxnPRMDEExWOQy/cMZ2rkt4iDjQhcZHFtbx21ZrH95Xm5
         QcuCuH6qfLx981Zzo01RdvOyRuiWZGfOmAOLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZQN6xPGKIW6glHZexLLxjYGOYgPeCk+jeaAojs1cWHQ=;
        b=WazMdsDJCpiXtHAAlYCMygFK5/MENux4vvRbqMfj83+5hBj4QrEca2J7JCYuQMGtJh
         GcQ66KzZCpda9aoJBWX33Rl8LTA0KC6JbBpw4o/rUh6+5oOzbnuDooREzI02+DGHk9G2
         w9Zn0GO85UuNOIynv6no1bX6M1ZTeIfH10iOGYMiyy+/ow9AZLGHCV2eQDOrB9PbOZQf
         pM/k12Q46nI18PuSq6c2INiARsdZDJhEHc2IIzkT48CbnfYx843wEDEXtgV9whR2Wyhn
         7XFrDDLSfOfIM5l/rMbzTmuj5jYROEjzmdoV/jgsYed0d6zu/JPQUnCyJZ03+XPnTmIq
         7VNw==
X-Gm-Message-State: APzg51AqTFERbkqbxTwzn2tIUgkQ1g5Ox4iXv8l2lw6nwHDbqdP7gC0Y
        MTWCHhJAIpy5Zy1RUdiFNjhyOA==
X-Google-Smtp-Source: ANB0VdZ4lpQC0zfNh0jpsyM+y0hDUeHkUB4a7iIYtzKYeGNf48MxYfOpBRQWMxPTGt97cwMx5mjtyg==
X-Received: by 2002:a17:902:724c:: with SMTP id c12-v6mr40234625pll.326.1537471159687;
        Thu, 20 Sep 2018 12:19:19 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:18 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 38/44] coresight: funnel: Claim devices before use
Date:   Thu, 20 Sep 2018 13:18:13 -0600
Message-Id: <1537471099-19781-39-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Use the CLAIM protocol to grab the ownership of the component.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index ee7a30bf9480..927925151509 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -25,6 +25,7 @@
 #define FUNNEL_HOLDTIME_MASK	0xf00
 #define FUNNEL_HOLDTIME_SHFT	0x8
 #define FUNNEL_HOLDTIME		(0x7 << FUNNEL_HOLDTIME_SHFT)
+#define FUNNEL_ENSx_MASK	0xff
 
 /**
  * struct funnel_drvdata - specifics associated to a funnel component
@@ -42,31 +43,42 @@ struct funnel_drvdata {
 	unsigned long		priority;
 };
 
-static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
+static int funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 {
 	u32 functl;
+	int rc = 0;
 
 	CS_UNLOCK(drvdata->base);
 
 	functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
+	/* Claim the device only when we enable the first slave */
+	if (!(functl & FUNNEL_ENSx_MASK)) {
+		rc = coresight_claim_device_unlocked(drvdata->base);
+		if (rc)
+			goto done;
+	}
+
 	functl &= ~FUNNEL_HOLDTIME_MASK;
 	functl |= FUNNEL_HOLDTIME;
 	functl |= (1 << port);
 	writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
 	writel_relaxed(drvdata->priority, drvdata->base + FUNNEL_PRICTL);
-
+done:
 	CS_LOCK(drvdata->base);
+	return rc;
 }
 
 static int funnel_enable(struct coresight_device *csdev, int inport,
 			 int outport)
 {
+	int rc;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	funnel_enable_hw(drvdata, inport);
+	rc = funnel_enable_hw(drvdata, inport);
 
-	dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
-	return 0;
+	if (!rc)
+		dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
+	return rc;
 }
 
 static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
@@ -79,6 +91,10 @@ static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
 	functl &= ~(1 << inport);
 	writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
 
+	/* Disclaim the device if none of the slaves are now active */
+	if (!(functl & FUNNEL_ENSx_MASK))
+		coresight_disclaim_device_unlocked(drvdata->base);
+
 	CS_LOCK(drvdata->base);
 }
 
-- 
2.7.4

