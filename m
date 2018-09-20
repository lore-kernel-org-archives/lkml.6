Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55A0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DF52150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hp0ByJ3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DF52150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeITH14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:27:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45719 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeITH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:27:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id w9-v6so405425pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=E6zcIw9zQ5bCQE64THbvHJveHe9wTWSLs4jU/7WjM7Y=;
        b=Hp0ByJ3wyin48Yr7ImhmijYfBNSpuhBuqaP8YFlyuCtaASe7LzsoZY9Q4drTdTrIdp
         ipfeMBu8EBzzjqsZl4RGly1qv2tA6lfPfBsQQcd8tvt8G/VGLvCKsjkrWzM7gdLW0qNH
         AX+0uqeQTF1y3CfDcbJw+5bLMpdhFtPGMxvVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E6zcIw9zQ5bCQE64THbvHJveHe9wTWSLs4jU/7WjM7Y=;
        b=INPaXSnIgPbynJefzmc/DM1thdr87njp/ULISfbwP3nJQbX2vo1opzrP4QlwkX0j1E
         T1oknA6AcCHssdVcwovDqRWJ+1grTYjLhIwWqa7bMGDORBTUzIw+rq0GlnRcadsVAI3v
         NZbCf1R1lazQipWUEvthJ9FiO1W/cOo4Edmul/d00kPMZ6N0U3wPdJQ/hm7A09kO6QfN
         mTKmOFY+UGMYD94y8a6+cP3iDfs1Brj1mjcyRenZkkLoy+yf3O/OEJfG78ag7i0I90W6
         SVpCEB2/v2n1SxJ5GQeMNEKaWRb0z/fBNMrsrBj7lVc5r0d2OWLvzDOJ4xNP6lxdkOrc
         u2gg==
X-Gm-Message-State: APzg51B9SzU9xqzbPWjNQ4p0UZ7WygDrk/xNrcpY7nuRzEW8mIriAgsR
        Su1V+nGMGZccMDYea5khE39h8g==
X-Google-Smtp-Source: ANB0VdapX4mo2iYeEgPwgq9WsVI06BWgIXhJcP89uolWDXH0MT3N19h/iLvl65zE0leVuOVm5k4/4g==
X-Received: by 2002:a62:5047:: with SMTP id e68-v6mr38112206pfb.157.1537408031833;
        Wed, 19 Sep 2018 18:47:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m15-v6sm67227308pfk.149.2018.09.19.18.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:47:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: pm8941-pwrkey - Add pms405 pwrkey support
Date:   Wed, 19 Sep 2018 18:49:28 -0700
Message-Id: <20180920014928.15422-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Update the binding and driver for pms405 pwrkey.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt | 1 +
 drivers/input/misc/pm8941-pwrkey.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
index 34ab5763f494..736fba3bad54 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
@@ -8,6 +8,7 @@ PROPERTIES
 	Definition: must be one of:
 		    "qcom,pm8941-pwrkey"
 		    "qcom,pm8941-resin"
+		    "qcom,pms405-pwrkey"
 
 - reg:
 	Usage: required
diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 48153e0ca19a..fccf63263c1c 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -317,6 +317,7 @@ static const struct pm8941_data resin_data = {
 static const struct of_device_id pm8941_pwr_key_id_table[] = {
 	{ .compatible = "qcom,pm8941-pwrkey", .data = &pwrkey_data },
 	{ .compatible = "qcom,pm8941-resin", .data = &resin_data },
+	{ .compatible = "qcom,pms405-pwrkey", .data = &pwrkey_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8941_pwr_key_id_table);
-- 
2.18.0

