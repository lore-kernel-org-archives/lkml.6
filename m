Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05465ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67C121521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ju4FPyuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67C121521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeITH3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:29:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33645 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeITH3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:29:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so303550pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yN2zUY5edYc6D8gSNP8BZ4gN3nerLrJ4B3IZw7tW/wQ=;
        b=Ju4FPyuktZjGg3MFdV9C1fWMFbigCumIKYUIY7VFCyyjN9kj9+OXgAr46JwG8cCnnG
         N4+9cEMqOwu+/17oWRq6TPNm/IG2IDHvHIEDnq0xjD9yxVhVw7kz0GdRAOEAeFSMkpjo
         5BxR9XVQZjKlgOBxGO9uaGzTeX2EH2vIsZmVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yN2zUY5edYc6D8gSNP8BZ4gN3nerLrJ4B3IZw7tW/wQ=;
        b=q18zN3uESqDiDjPRqQJG/3ZAiqqknhaSKwkRTS2PP5CQGcIp8O7qEiArcwJN3vG3T9
         cyIIoYR6SGGKN5YS4TZO3FJTurabOR+Bk63To1C0jeWRgCWdCvGA07IopXSFgBX7fxBT
         2Xvihol1ZlNX19AAzbceR39JZbMTA7Ij7+gmgGSpPX4kTJsToriZRc5X42HF6zzjl8AV
         GBroZRBBAEoogftIb3Fs31wMZMZX9jmMdUKAgwgFiAdTG/FIl7Oj/kupfEZq81eoFkR5
         6Dm6nSrmEmvORtzLLgT64NSFut53fV1bJoczX4jU4KvgEgbpdhhxFMov4MGhpt8duYDe
         2G/A==
X-Gm-Message-State: APzg51CFv7k0E6RYewEkZKWpD3XEWmKxdw7okg2fXUFxkW68QklJl/Gk
        fESY+snfsB+5dgcmxk6Ny+P3lw==
X-Google-Smtp-Source: ANB0VdYL3awTwr+aQiCqiLtHKoz4ZUQnt+u5/IeMi5qy1zd3oKZqQVJQYyTRxac4fjIB5AUpse+c3Q==
X-Received: by 2002:a63:d518:: with SMTP id c24-v6mr33226908pgg.357.1537408107138;
        Wed, 19 Sep 2018 18:48:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s27-v6sm49841820pfk.133.2018.09.19.18.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:48:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] power: reset: qcom-pon: Add pms405 pon support
Date:   Wed, 19 Sep 2018 18:50:44 -0700
Message-Id: <20180920015044.15686-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Update the binding and driver for pms405 pon.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.txt | 5 ++++-
 drivers/power/reset/qcom-pon.c                             | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
index 651491bb63b7..5705f575862d 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
@@ -6,7 +6,10 @@ and resin along with the Android reboot-mode.
 This DT node has pwrkey and resin as sub nodes.
 
 Required Properties:
--compatible: "qcom,pm8916-pon"
+-compatible: Must be one of:
+	"qcom,pm8916-pon"
+	"qcom,pms405-pon"
+
 -reg: Specifies the physical address of the pon register
 
 Optional subnode:
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 0c4caaa7e88f..3fa1642d4c54 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -74,6 +74,7 @@ static int pm8916_pon_probe(struct platform_device *pdev)
 
 static const struct of_device_id pm8916_pon_id_table[] = {
 	{ .compatible = "qcom,pm8916-pon" },
+	{ .compatible = "qcom,pms405-pon" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
-- 
2.18.0

