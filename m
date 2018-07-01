Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539AEC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B549249B8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBgcWRF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B549249B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030556AbeGARZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:25:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45895 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934169AbeGARYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:24:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id y24-v6so2137247pfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=jBgcWRF3onHf5SlxJPi6RBaz1BggehPSAddx9BF7k61SSJHWglA7FEprYWQRw+uTGQ
         BhaGWY6R6jni7Y6/IDy3u5qzYNsvlHoieaZJ9HiSRfhk8UWjdT2ONdxQn7hJh91DG+I8
         Z3A9y1mcn7OWiMWda1M4gYqItb/jH4guNePUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=ZXOaPjSaK7B+5dA5jnfJl7la7nedXia685lrZDEeBglLxic8Xu6EXNxQwidiOGDE1H
         27ayAYy17OY2eygiXa68Edc2TyeMWcmLIRCQj1zpsd2FJP/ihPqFXiGjhz/aWXd8mVD+
         fXK5WmTWQzAnD3O6AHtZLEOMQQqhTC6gthAOeUtfZaBktDowibaQl65fdU2G05A9UYrH
         DupJIhFVSPIPS8dh3acS8sbe+UCG9zh+r2rLoTMuX1bxvsW0pPGY7zNHa60oAgEZi+KB
         p93mbN8cZAACxI73vmK8wucRrGC1Z1jArvsRRmvF+lLhkLu//6OJwQUsewNJsGyj0Hw0
         p8GA==
X-Gm-Message-State: APt69E3GU+kzanumFlQFyA3RDg6Zy4bciDE3CGOcKsci6tzCTJebpvkN
        CIptulamiM9cyOTh4BuVuogA
X-Google-Smtp-Source: ADUXVKKCLXIV5bTI2TY52xJSWOvWdZsFyb8IbCwVrnaLLjuFpjpQ9avX9xzeRhBEJQevpyDPwctvqg==
X-Received: by 2002:a65:6688:: with SMTP id b8-v6mr19451142pgw.24.1530465861208;
        Sun, 01 Jul 2018 10:24:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:900:ea77:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id f10-v6sm17989836pgr.30.2018.07.01.10.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 10:24:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 4/6] arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
Date:   Sun,  1 Jul 2018 22:53:03 +0530
Message-Id: <20180701172305.15663-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable I2C1 and I2C2 exposed on the low speed expansion connector in
Bubblegum-96 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index d0ba35df9015..57ae374cfb5a 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "s900.dtsi"
+#include "s900-bubblegum-96-pins.dtsi"
 
 / {
 	compatible = "ucrobotics,bubblegum-96", "actions,s900";
@@ -35,6 +36,16 @@
 	clocks = <&cmu CLK_UART5>;
 };
 
+&i2c1 {
+	status = "okay";
+	clocks = <&cmu CLK_I2C1>;
+};
+
+&i2c2 {
+	status = "okay";
+	clocks = <&cmu CLK_I2C2>;
+};
+
 /*
  * GPIO name legend: proper name = the GPIO line is used as GPIO
  *         NC = not connected (pin out but not routed from the chip to
-- 
2.17.1

