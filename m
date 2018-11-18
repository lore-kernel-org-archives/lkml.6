Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6AF20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OY/FNrOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6AF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeKSGZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:25:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43223 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeKSGZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:25:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so13511295plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bsmVjtiMK8WJcKjywtifKfWnpdc/gONJDLiz9m2CbA0=;
        b=OY/FNrOkc+BKBJvPHVM04QdJNM5DmD8g4OP4D5bGOuTUr+hp8kTERVFfm6HtLfMER1
         BUdRTTTw+KZpg7pb3AT9S+pZWEjxyjIUsCIZtGXQRynJJrBQeaixGenPIye2TR4L0g+x
         3TU6RG4DkR8qJSRJXTZjxPIkOC7qQaAFJdNSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bsmVjtiMK8WJcKjywtifKfWnpdc/gONJDLiz9m2CbA0=;
        b=rlIwxJJKUeLwB1xqgmYbr3zurS+stfMgnEDGIuAI3W5XtFFdqY2TzKruepYznKixg4
         bLa+l2hv1mTZvwDatNjyJX/4dwoLcIT+nXbCA6xtpGmzBPXR2OUaAkpUFOHtyI49J3yG
         /1ZnxSJLy2GVmO0T2bIwWPFAPfzsjOvgj1f3/YKynw4z0Z5vQm1jXnfWfYhfFacNlng6
         rfxrPbprNVvw6CAiHlZHkpB0T8vvKthX8ezW6bPFLJasz982/yVsOqcHXetAye36YV6D
         W3xYGYlHnsDuUy/U6okwZNRZd76jFii+dUKF4cDWDjaUVOFibFZGeq9ALOGw4flTDRlz
         F02g==
X-Gm-Message-State: AGRZ1gLaBlh/tH9YhUyNdOnGAm8I/fZRUtJbmBuPJsh4kv6AhuRZi/gY
        m10NDJq2hGY1ErgfJZjfB2Z1KA==
X-Google-Smtp-Source: AJdET5f27Q+xHhwzg7La+bZ3lBvafPMW/EuDLV5z+1IFjl1+B1wvPVYA8fUl6xsYI4rpbuoMzDj7CA==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14-v6mr10902092plo.109.1542571446339;
        Sun, 18 Nov 2018 12:04:06 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p15-v6sm64102434pfj.72.2018.11.18.12.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 12:04:05 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: qcom: qcs404: Specify pinctrl state for UART
Date:   Sun, 18 Nov 2018 12:01:33 -0800
Message-Id: <20181118200135.25258-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118200135.25258-1-bjorn.andersson@linaro.org>
References: <20181118200135.25258-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BLSP1 UART2 is used as debug uart on the EVB development board, define
pinmux state for the UART in the platform dtsi and pinconf state for it
in the board dts.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index a39924efebe4..2ed9b0a0e5f2 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -186,3 +186,17 @@
 		};
 	};
 };
+
+/* PINCTRL - additions to nodes defined in qcs404.dtsi */
+
+&blsp1_uart2_default {
+	rx {
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tx {
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9b5c16562bbe..9ec5c85fcb81 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -272,6 +272,18 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+
+			blsp1_uart2_default: blsp1-uart2-default {
+				rx {
+					pins = "gpio18";
+					function = "blsp_uart_rx_a2";
+				};
+
+				tx {
+					pins = "gpio17";
+					function = "blsp_uart_tx_a2";
+				};
+			};
 		};
 
 		gcc: clock-controller@1800000 {
@@ -343,6 +355,8 @@
 			clock-names = "core", "iface";
 			dmas = <&blsp1_dma 5>, <&blsp1_dma 4>;
 			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_uart2_default>;
 			status = "okay";
 		};
 
-- 
2.18.0

