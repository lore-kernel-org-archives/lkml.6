Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABADC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95C320C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bZmns2wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95C320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJIDbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:31:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35195 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJIDbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:31:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so8333208pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONgysF60ZUNcVrGkyXF+8eIAF7brYjaHt32SnVKA+nE=;
        b=bZmns2wzJFqSKXb4aB2Ygp3fycg/tvvaPaumHtOXQpkWpoNDu31hxfZLPOg18NTkMV
         Zuv+wT4PufE2mChGMlkAYp3vWew4rnc4g8EtRlnyl4hrAfxMcWpQUeMbOoHq9cECDLU9
         wIgbE1VUgkH3/LxCiz7gkQo9tZB71YdNKFcpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONgysF60ZUNcVrGkyXF+8eIAF7brYjaHt32SnVKA+nE=;
        b=FlFA4VuMsPbMFAWADsfusnv8wEakDzHiWLhvbG6DMBDXJ5SRKY/uyhVYY1Koj4fib6
         d0ObMAiI38SWXBrtiWB+O+oGHaPtfzGaR6MU++BdX2vLXG6NB76YHjSDOrxrrv7F9YsW
         gqvK9haW0Rfu0XtrD4TpdoVWQhDKNeunBXIIFjN49pJO+zl0Igxw+E/h4+lm60pERFtS
         QmTRZb91jFSv3ShsDee0glmcQZEigbvh4HVY8B1mGNfqDbwK9OX4s1MZr2aZ0Hi7622I
         ANI/rRs2SDDc4P2r+DqgMsc5AaYR+Ch+mAU9Dj+ig/iBtc1/+HvoUFY1v5M9TfaxyUUs
         PPmQ==
X-Gm-Message-State: ABuFfohgiUkXDow0lK19YMQxVEBfuNbGvCyEi9XWG/Os4ZEDSus8HyVr
        X9rWwESaHpWFyj+zfsT2190I2A==
X-Google-Smtp-Source: ACcGV63NbPpEuWIt0mj6I8XWkaaXYEX1dPRZvL1k4pXhE+v/VJ27lHCMYu7x4doh6sLqJdo/w1ji8w==
X-Received: by 2002:a63:88c1:: with SMTP id l184-v6mr12843370pgd.431.1539029851096;
        Mon, 08 Oct 2018 13:17:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id n13-v6sm20266001pgr.73.2018.10.08.13.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 13:17:30 -0700 (PDT)
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
Subject: [PATCH v2] arm64: dts: qcom: sdm845: Add qspi (quad SPI) node
Date:   Mon,  8 Oct 2018 13:17:11 -0700
Message-Id: <20181008201711.152038-1-dianders@chromium.org>
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

Changes in v2:
- Node is named "spi" not "qspi"

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..97946f46f7f3 100644
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
 
+		qspi: spi@88df000 {
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

