Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0D4C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100E124C70
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="js7+/iSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100E124C70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeFWQMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:12:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41593 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeFWQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:12:45 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so4857066ply.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=js7+/iSs7THKH8rb8FANEunLq3zlH08Q8E3IHUFDmqnh3obvvRtLGsWKV74Oy1n4kq
         JFcf9pewZkF80SmmBrWn7c5UT3c5fszuyOabGnFyIf5pi38Rv7PMQ6JF4CphWoLhI5NR
         fycl62gdJZsg+QG3LXFz3GQcPehbr+ym8c7o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL0fWQKe6YDVk5gZXK2gEuAVrBvPcSCEQHWulUbgBug=;
        b=dRl5wyFZ3Id/56AJi/ECRp9C4TEQamPniFETEfLW5DXn4l6Wrmo4c+0iFwzYuAvvs4
         FKLlGMg20xoTTknIJapKr1760h3Ph4fhQviAX9mAgSZqVojDgk9X+LHbtYa5QMX2d22r
         GoOcK7xylvjRj5P2HD6HFuFETyuD6PPMYGZXJ182oco04/lj2ZgQuoLE7Uzw9lGrEUKn
         9Xuudyr7kYZDZ6J8RNXwQ9falVjqG2D1Tmgg6M51Dgs5Lr+Lt7rF0jnzPp8klCE1gLIh
         4Cy2CBPZ9zKBiOH4cVIakLU6QsKQ+xz0x3SWX6VNTLvHIX+pFV7ZFPC4dQooLZMjvjCM
         y59g==
X-Gm-Message-State: APt69E0B2UW3jq2moiFbC7INzH5LBLbA7tFp913DLby8pZFVodZfWvZw
        JjrLXBTGRCUWnVpaMP8TJaPc
X-Google-Smtp-Source: ADUXVKJ5Gbctb/OUE3d47ML0g5avpPM2fJCzS1mA+D13gKyNr2ncByuyiYXYAWpBw43apTwT0zpo8Q==
X-Received: by 2002:a17:902:422:: with SMTP id 31-v6mr6018394ple.320.1529770364616;
        Sat, 23 Jun 2018 09:12:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:100:fa16:6549:5166:32c7:2dab])
        by smtp.gmail.com with ESMTPSA id n26-v6sm2732745pfi.168.2018.06.23.09.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 09:12:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de,
        linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
Date:   Sat, 23 Jun 2018 21:41:46 +0530
Message-Id: <20180623161147.15672-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
References: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
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

