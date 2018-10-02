Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C69C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4C12083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fa990wLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4C12083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJBH4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:56:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34858 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeJBH4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:56:34 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so333159iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8I6Jym4kLTCHfh2W4EcwaZ+ucwVAPiGe+Zc/eOX2fVc=;
        b=fa990wLZSBy4aJLxxpSUgz93kSJ3z+0IPqpUbgrwb6SMVnYjnC3foUWNbTaXQHuPXx
         UvmE6PiKmmQ2HKmvqVXPJBHx+TLSvr1PhsLms6+vmSKjH4YFRpulWJcv28v9de+VGLv8
         PU4SVtJYA9ykyRfUnkbfnpRqqdjnLf5eWjEOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8I6Jym4kLTCHfh2W4EcwaZ+ucwVAPiGe+Zc/eOX2fVc=;
        b=UT3l2RYgfCBL5ge5xQJV+SfSEGfjZq27tgwyFPI/Mc9+FkXg8c1+HtAxtO6x9O7qf1
         0VWzwt0ozvJybiD90n+DTL6z0qfGnCMCO/C7tFB+Vf/HFkamv7Y120z7vTrei9TjU6Ej
         hiMEvmhxQLrKRQllHqDXJulDUwtPTge/kpKkBE3xXf2GKlaJtal+PjGLXEjhZSYBN9Tr
         nvemiTzREnkspJbSSN8gmk/4uvk4tiSWc+zKHzHWR6QtGd0Bln6EziRnSvSG3GA6bnBi
         e8iAWiwdGCAIFuVfSfk/PWinOoyNEyxLAUbLn3Q4uQiB3D8g1xLnbY3c0MsrTz/fdvgE
         FA3A==
X-Gm-Message-State: ABuFfoixAgMK0EgNd/vIQKGER0sbCo7IpXNuYbZa8RMWaxebbppqt/an
        lmXIJ3UwR7/kH4vK4b5cZhcgIA==
X-Google-Smtp-Source: ACcGV608aqC5+ADxk3KGFDLgfqrsv4qVNGg1Uc0SuYcjlpk1c79HDXLaoHcAyzmUNgTMHlPM+3FRoQ==
X-Received: by 2002:a17:902:1566:: with SMTP id b35-v6mr14260350plh.135.1538442959383;
        Mon, 01 Oct 2018 18:15:59 -0700 (PDT)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id q23-v6sm22065835pfd.44.2018.10.01.18.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:15:58 -0700 (PDT)
From:   Ryan Case <ryandcase@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Mon,  1 Oct 2018 18:15:41 -0700
Message-Id: <20181002011542.204937-1-ryandcase@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
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

Changes in v4:
- Changed qspi@ to spi@ and device@ to flash@ to match Rob's review

Changes in v3:
- Added generic compatible string in addition to specific SoC

Changes in v2:
- Added commit text
- Removed invalid property
- Updated example to match sdm845 with attached spi-nor

 .../bindings/spi/qcom,spi-qcom-qspi.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
new file mode 100644
index 000000000000..1d64b61f5171
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
@@ -0,0 +1,36 @@
+Qualcomm Quad Serial Peripheral Interface (QSPI)
+
+The QSPI controller allows SPI protocol communication in single, dual, or quad
+wire transmission modes for read/write access to slaves such as NOR flash.
+
+Required properties:
+- compatible:	An SoC specific identifier followed by "qcom,qspi-v1", such as
+		"qcom,sdm845-qspi", "qcom,qspi-v1"
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
+	qspi: spi@88df000 {
+		compatible = "qcom,sdm845-qspi", "qcom,qspi-v1";
+		reg = <0x88df000 0x600>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "iface", "core";
+		clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			 <&gcc GCC_QSPI_CORE_CLK>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <25000000>;
+			spi-tx-bus-width = <2>;
+			spi-rx-bus-width = <2>;
+		};
+	};
-- 
2.19.0.605.g01d371f741-goog

