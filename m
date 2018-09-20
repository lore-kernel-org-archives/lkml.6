Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DDBECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676FC206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbC2dmmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676FC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbeITHZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:25:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45050 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeITHZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:25:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so3590440pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G4bPyJhhSNlsKKV6SLTb+myeaA6Y62ufubLkyYNljbI=;
        b=cbC2dmmrFsUPqWGbNM0kjKNTQZNFZ+vptLzC+MLtlrzeUf0b860uqbV2h7aCF81PW1
         5rOEVgjcNfWX8SMg2kyctEYjPFNpzXjgauGpbp/V0+5zfERXNjW8okEwtz3JFCW6gRPh
         CJOwQNL6zul3aUmecQbyxYYy8gCTkZtpbLN0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G4bPyJhhSNlsKKV6SLTb+myeaA6Y62ufubLkyYNljbI=;
        b=shUyOl5F2X/55wdQSM+hJ2zCsm9zXE7xFxv1HlD1H1KAug7R4J7W+6FZedhrKi8ZuW
         meijqSkBsBZvOM+bfHOlBTprWNmTuPgxvcORlSucfZwxYiZg2NWjhwSywsfnAc9RJPDv
         5iSOMYV1fF3fYMBg6nxBkBF2yCLhhwYqlkQn0FCsD2IxipGw8s4/VP5SscdUZ7xZQXYD
         M5s082Ui5QInGpMscCtQrbYEq0M14pVsU1u5UWQ9cetV624hclG3/1kNJMxGUhBoYmnr
         9ctLYnctk8MBA9nLDUGk3ROYgFd8kberqSEAOW9Kic18SX2r7LG0nz/Qi26jmadXSOLb
         5Sfw==
X-Gm-Message-State: APzg51AlxlXNdn65A5ZU5VKecanjyPflUzyk19Ox5SdXyfZ3otV4p29V
        vLe9LUCDe52IQ1RY77cstG6Hyw==
X-Google-Smtp-Source: ANB0VdY5aRDUtaDWQpTn+EWjjPoxPhKCkNU17SK4qi/qPsp7QQtDXz1Eha+il1cG5ORi0FGuGYugwA==
X-Received: by 2002:a63:f616:: with SMTP id m22-v6mr33242278pgh.293.1537407888785;
        Wed, 19 Sep 2018 18:44:48 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e202-v6sm38716634pfh.16.2018.09.19.18.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:44:48 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: spmi-gpio: Add pms405 gpio support
Date:   Wed, 19 Sep 2018 18:47:05 -0700
Message-Id: <20180920014705.15144-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Update the binding and driver for pms405-gpios

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index ffd4345415f3..ab4000eab07d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -19,6 +19,7 @@ PMIC's from Qualcomm.
 		    "qcom,pm8998-gpio"
 		    "qcom,pma8084-gpio"
 		    "qcom,pmi8994-gpio"
+		    "qcom,pms405-gpio"
 
 		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
 		    if the device is on an spmi bus or an ssbi bus respectively
@@ -91,6 +92,7 @@ to specify in a pin configuration subnode:
 		    gpio1-gpio26 for pm8998
 		    gpio1-gpio22 for pma8084
 		    gpio1-gpio10 for pmi8994
+		    gpio1-gpio11 for pms405
 
 - function:
 	Usage: required
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index a29efbe08f48..b54891998caa 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1055,6 +1055,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pmi8994-gpio" },  /* 10 GPIO's */
 	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
+	{ .compatible = "qcom,pms405-gpio" }, /* 11 GPIO's */
 	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
 	{ },
 };
-- 
2.18.0

