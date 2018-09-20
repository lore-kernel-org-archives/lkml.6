Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27099ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58C521535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UMjB5ZsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58C521535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeIUE2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:28:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37529 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeIUE2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:28:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id q5-v6so1534578pli.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RiuVd/eZH5Dz5Al4lGnHguqs2hmX6x+p1WFc9tapVFo=;
        b=UMjB5ZsOkYGRBEBUN6VY8V8MlY4QpwKCyMWxqjhMskEmH2c/yuoDTHUgAQI64Td16y
         Tse4b6oxcDl0NXszrxXrHVUOmOp6+AoSUMNEfSi2UpsXJtGAfRQmXTpna+dzoOQWNmdV
         3+ktGArbsRjZIoy3pUK2VzJ45l5mxDr4Fw7bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RiuVd/eZH5Dz5Al4lGnHguqs2hmX6x+p1WFc9tapVFo=;
        b=k/G5RzSvsdbt9ocIeNWDy3eEdVYRj3nb7k8D6wvyBejO1XRAXoHQfsf5fPhBPPbXYN
         BAKGYCX/+l3OEa5D1hDwxSP7Ai+CcqjmHicZXHK6SW3kK2EcRew6ah6EXYroO8+ylRIm
         KgWznWoA5E5mPJHepR8SmHFDZdvJEz7g6Qtf2l183QR/M0gq2kg/w2TMt6KWZQ9OhHtd
         ZvHdcLMKn6xQoPnpFO472rWuZP0snWvMBNp3rQaFYccFTYps6RLPFFblBPfQHJtimgyx
         VwBn1VR51QTy7bmBvxlBlTA5iqcJP57sBV02ySnGo9rQZ2R/dDLidXI0NpAP3d4A+ip0
         SO1w==
X-Gm-Message-State: APzg51DIeWdNjz0GIWaNTeILCjYcfe4/TyJlnAHSZesw0Pmug9MTZMjw
        LsoZWLvb6uGkbQjuxhOOOGjAv6F+WoxXAA==
X-Google-Smtp-Source: ANB0VdY7/jrOf08BnYvB0mIfE1cfdUJfmMhOyMxXZHwXXXeTZ1v9ad11S6BfFqOEzxyjWLQO2EJgzw==
X-Received: by 2002:a17:902:be07:: with SMTP id r7-v6mr40715365pls.275.1537483368108;
        Thu, 20 Sep 2018 15:42:48 -0700 (PDT)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id t15-v6sm38704730pfa.158.2018.09.20.15.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:42:47 -0700 (PDT)
From:   Ryan Case <ryandcase@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Thu, 20 Sep 2018 15:40:54 -0700
Message-Id: <20180920224055.164856-1-ryandcase@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Girish Mahadevan <girishm@codeaurora.org>

Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.

Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

Changes in v2:
- Added commit text
- Removed invalid property
- Updated example to match sdm845 with attached spi-nor

 .../bindings/spi/qcom,spi-qcom-qspi.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
new file mode 100644
index 000000000000..ecfb1e2bd520
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
@@ -0,0 +1,36 @@
+Qualcomm Quad Serial Peripheral Interface (QSPI)
+
+The QSPI controller allows SPI protocol communication in single, dual, or quad
+wire transmission modes for read/write access to slaves such as NOR flash.
+
+Required properties:
+- compatible:	Should contain:
+		"qcom,sdm845-qspi"
+- reg:		Should contain the base register location and length.
+- interrupts:	Interrupt number used by the controller.
+- clocks:	Should contain the core and AHB clock.
+- clock-names:	Should be "core" for core clock and "iface" for AHB clock.
+
+SPI slave nodes must be children of the SPI master node and can contain
+properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+
+	qspi: qspi@88df000 {
+		compatible = "qcom,sdm845-qspi";
+		reg = <0x88df000 0x600>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "iface", "core";
+		clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			 <&gcc GCC_QSPI_CORE_CLK>;
+
+		device@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <25000000>;
+			spi-tx-bus-width = <2>;
+			spi-rx-bus-width = <2>;
+		};
+	};
-- 
2.19.0.444.g18242da7ef-goog

