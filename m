Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D680C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF352083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4I8d3wN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF352083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeHATwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:52:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39248 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbeHATwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:52:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id a11-v6so11200921pgw.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=E4I8d3wNONArDWRcwggM9crw+nnQTuugbXliRmPzEbNtiOVGiIXks9gXsGxdipwUGh
         zzGTlk1brCXeo2Ma3WR5QH13Z3UdSp0jcnUXrCM32mZYY/Sf/VrgB3H0ffbV5qPvQnAn
         2q7wwFyEruApCbJJOQdQdYSFy82iCczBeXzxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=QwdYCmc/iT+zovCHql45yeBXjL4OTQcBbUNmj8PYMppXw65wsSQfSkLYkiYSJqKyez
         C9lppGs5j4aOkIq1bf4iSgOrO0Z2XHlUJjatM6bIdGJlME+L93iyuJvNb2fc0Gt3Rpwo
         ocDapfA8Aj9WQk4u4/18PVKJnJtfmscX7jOcmu8TSq51lup3JRfRRGYPYZFoxz5fzR5a
         /7ABJ6cx76AeK+OMD/q1OIETIv91nvkwM5aXSa3VjhVB4NrJOv5+1p01/FRoLGaGZJyB
         kewvof5pzYYNyzR8c9qVercVIWpcnuEB2h/kfrnqSeHFNEsaokJyQyGahFer0g8G7ZFd
         3Vyg==
X-Gm-Message-State: AOUpUlFudySxwSI7Al6H0DflgCJmCyHgyGPzXCJvivLhbqaR/sOReP1s
        dSZYRs09gbqP4rTzQn4d2ZLu
X-Google-Smtp-Source: AAOMgpfbnbgyS+EQSDwM+IxhO6D+Q7Oynt5LdmjoSAIwAXlzdtwYtkxSeSPaUduv0GgM/mXHjbMNlg==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr27548991pfi.123.1533146723601;
        Wed, 01 Aug 2018 11:05:23 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c1:5a70:e532:a47d:7290:5aa6])
        by smtp.gmail.com with ESMTPSA id x80-v6sm12961649pfe.129.2018.08.01.11.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 11:05:15 -0700 (PDT)
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
Subject: [PATCH v8 4/6] arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
Date:   Wed,  1 Aug 2018 23:32:30 +0530
Message-Id: <20180801180232.23680-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
References: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
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

