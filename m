Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D522C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD2D20684
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G3IXlW0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD2D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJEI4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:56:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36200 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeJEI4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:56:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so2902569plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 18:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8WYS60pMXYaIH2cJoE+xgzFFDKfDQtT42NBS2ouWJw=;
        b=G3IXlW0J4mWSTzPQjPuhV2ytBAJosY3f4GNL4WOf0I6J0JHYKqRFANxhZlQFdDiGcL
         DBymHnDryZcdGAfSptbfw99DSGCtKacaJBGekThmNqQxCR/cziPA29vtBfgfjkaftls3
         jZq1IpRoOjooZpDrhlXwXpjltVDYHBgJv+EXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8WYS60pMXYaIH2cJoE+xgzFFDKfDQtT42NBS2ouWJw=;
        b=dDicY2NEeqdTPagUUiI6/o3NQJ7dWdZYLT5nwxE57YY9KEbh8AcK/JSf+DmQXBqWsP
         AusnN4v2K5AQ2p4Te9nQcVPgKErI56ljbaG3NYHjqcgYtUsWQXjUrA5Oz8iYd4FdivJ4
         PlCa6qC/Yiqc9knQ7rf5qG2N94bGZ8Jl/wEcBeq0iK9eZLQi6syyQomggfeASN/K+twC
         XNHz+uA4HxrC6Te0shnUUZ9mSwdwey0JdbZZTOffypGqTk6apTmr0ll8k+OcP0EBI3VG
         eZJiZgZc8C2h5wB5egaehQmrmf+F1+zXa0jPVEVVgQwl7pDQES3fQCZMfEosBAZVmeDE
         UIUA==
X-Gm-Message-State: ABuFfoiWBZ6yx60SNTig7Jfwo04BZMsATCp5SHsnoTgsCZ4xmfAG1tGM
        zl8QkEKFYlwkB+OT2s8evRTK0Q==
X-Google-Smtp-Source: ACcGV62hS2xlmE7f6YNwlroGO7Gv/UoVyQJccvdoLyLukQViXvvxy8ObOfzj60teSnxmyQPzFzqyWQ==
X-Received: by 2002:a17:902:70c3:: with SMTP id l3-v6mr9135140plt.185.1538704776669;
        Thu, 04 Oct 2018 18:59:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id n17-v6sm10607204pfj.84.2018.10.04.18.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 18:59:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Ryan Case <ryandcase@chromium.org>, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: Add qspi (quad SPI) node
Date:   Thu,  4 Oct 2018 18:59:02 -0700
Message-Id: <20181005015902.134192-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Quad SPI controller to the main sdm845 device tree file.
Boards will be expected to assign the proper pinctrl depending on how
many chip selects they have hooked up and how many data lines.

This depends on commit 48735597f7bd ("clk: qcom: Add qspi (Quad SPI)
clock defines for sdm845 to header") to add the needed defines.  It
also shouldn't land until the patch ("dt-bindings: spi: Qualcomm Quad
SPI(QSPI) documentation") [1] lands.

[1] https://lkml.kernel.org/r/20181002214709.162330-1-ryandcase@chromium.org

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..cfc96262e8dd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -822,6 +822,41 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
+			qspi_clk: qspi-clk {
+				pinmux {
+					pins = "gpio95";
+					function = "qspi_clk";
+				};
+			};
+
+			qspi_cs0: qspi-cs0 {
+				pinmux {
+					pins = "gpio90";
+					function = "qspi_cs";
+				};
+			};
+
+			qspi_cs1: qspi-cs1 {
+				pinmux {
+					pins = "gpio89";
+					function = "qspi_cs";
+				};
+			};
+
+			qspi_data01: qspi-data01 {
+				pinmux-data {
+					pins = "gpio91", "gpio92";
+					function = "qspi_data";
+				};
+			};
+
+			qspi_data12: qspi-data12 {
+				pinmux-data {
+					pins = "gpio93", "gpio94";
+					function = "qspi_data";
+				};
+			};
+
 			qup_i2c0_default: qup-i2c0-default {
 				pinmux {
 					pins = "gpio0", "gpio1";
@@ -1070,6 +1105,18 @@
 			};
 		};
 
+		qspi: qspi@88df000 {
+			compatible = "qcom,sdm845-qspi", "qcom,qspi-v1";
+			reg = <0x88df000 0x600>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+				 <&gcc GCC_QSPI_CORE_CLK>;
+			clock-names = "iface", "core";
+			status = "disabled";
+		};
+
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
 			reg = <0x88e2000 0x400>;
-- 
2.19.0.605.g01d371f741-goog

