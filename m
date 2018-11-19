Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C96206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="awNuinpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C96206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407217AbeKTDgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:36:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38219 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406861AbeKTDga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:36:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so4850734plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qgs9dW8J2ciuq8Fdw9KElZ0yIlhVVHPqlEym1CikztU=;
        b=awNuinpBOz2Uxa0Trxuic49+/zGEiKNHKPOv/28kQK972Q4uVKDnZa+OLia8Y+YqIV
         2NNCIsCC4dZHfkER7x+dvqE2nJpLrSvcWl1aK+Z/AxEIZz/MYsHZSJi2qd/ywssPAGzV
         iZqe8Ui8k8G5UPu6YnaWcHUzN/h57mTqWUdz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qgs9dW8J2ciuq8Fdw9KElZ0yIlhVVHPqlEym1CikztU=;
        b=ppFOnfYO1kI2hD2HhwQ1kgbd3hKuLKqb9Fvc9G1IUUbS2V51xglGdg5jwgCElNVdv3
         Dr5od7Y5VO8jgjtuwKmHGOdYGkwvuXVhDeGseH2A4upBXHSmiT2z6cBe2pShun57AQWL
         bq3YvH2IFA02yerkk4ercYqeFGmvwCz1yquhjeCR6FpdYBbuAL/xALA/g1QielmnoAuJ
         Y7pKOM+8abRt2t4GxLS8HpD+np6qLafOj1X3Gr1kMFguYTMjR6p78B+4+j/cceZUr2ZS
         li0yANjpiiGNZPZkYt8vUQiGm3+MEsbFZUfBowYUnBCShIerBQDMqPzm5bvEn9xVGI70
         M7UA==
X-Gm-Message-State: AGRZ1gLaI4h40Ec/BlsAA88V7eCTuLlwnNU0U2ezOb50kJ/aHDA3Go0p
        OSoJvgAuMHdUrcIXZNpXaWvP
X-Google-Smtp-Source: AJdET5eIpLM6Lyy6W9haxiS0+Ruy1emHNxMXwDziqUM2SsnmiDZ3zgMluvE0h78YCiYOPw8vB0/OTg==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr23344807plg.310.1542647530665;
        Mon, 19 Nov 2018 09:12:10 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:12:09 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/16] dt-bindings: timer: Document RDA8810PL SoC timer
Date:   Mon, 19 Nov 2018 22:39:33 +0530
Message-Id: <20181119170939.19153-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RDA Micro RDA8810PL SoC timer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/timer/rda,8810pl-timer.txt       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
new file mode 100644
index 000000000000..06cc2b00be12
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
@@ -0,0 +1,21 @@
+RDA Micro RDA8810PL Timer
+
+Required properties:
+- compatible      :  "rda,8810pl-timer"
+- reg             :  Offset and length of the register set for the device.
+- interrupts      :  Should contain the interrupts.
+- interrupt-names :  Valid names are: "hwtimer", "ostimer".
+                     See ../resource-names.txt
+
+Example:
+
+		apb@20900000 {
+			compatible = "simple-bus";
+			...
+			timer@10000 {
+				compatible = "rda,8810pl-timer";
+				reg = <0x10000 0x1000>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+					     <17 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "hwtimer", "ostimer";
+			};
-- 
2.17.1

