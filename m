Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF98C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A588206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AxF5SgW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A588206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeI0DJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:09:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43884 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeI0DJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:09:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so194569pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oPXfRUavzh753OXkq9vHdENqWn9BcDJg+SBrDcsIEI=;
        b=AxF5SgW9GX0qb7nuKAJfmzUT/RdDlS1FlSDoI1rB48xYiwKwVwQgk2n2+WaWpVoSxp
         UUUWGw/Vul0PYxeTmV+bDx0usUZCa5nplWD22yPKflOEFcVjFSOmD2b1/2LhJlHBvqof
         A2hLYHgM5McyFfNcfdaAGMNgwezKLbPwa8Wkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oPXfRUavzh753OXkq9vHdENqWn9BcDJg+SBrDcsIEI=;
        b=FeOfr/bDI+FU0UMXnPPUooapauHsTckJENLqfriZHaRc5zarUxajhL4XkBQpYN6X26
         4q8k+IEBDOSSMaRfPBP3osS1H9qI/kXPbdjN5fleajvyKPQcP85YMfFKo2WigCvWCS1C
         0CiYtt6/CrchwlqsdkwIkjliiG4iSQE6Znoio3DtOWh4cCOkvdven/7pgLOi/ymmij8y
         msYS8OFrbczOOL7Yh6R7HRz/+920WW1Ot2BBJrrhRsz24P2PRYhY1ODNyZYnyhKbsrLZ
         dZnGSYcv51hAHSSvK8qOOMICBUOIb2RPRRGwv9pVTW4KJ3uDt/C5XpcGMuo3eFrQnvX6
         dhQw==
X-Gm-Message-State: ABuFfojXMDBgdZEtL0fgnIQWHQqxVEX1Bx0HLORqnGGu/y5rXFpWTOJr
        d8/EVYd29V+eGtffSIz456g6GivZDT4=
X-Google-Smtp-Source: ACcGV63WojWa3kZ009DeB5XXPQ/Yh+ruY4c4HrdJLR9+YzgJSNMO0HGMiHp82jv8HaNVu7BjAJLbIA==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32-v6mr7752322plj.194.1537995278267;
        Wed, 26 Sep 2018 13:54:38 -0700 (PDT)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id s23-v6sm22091pgg.67.2018.09.26.13.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 13:54:37 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Wed, 26 Sep 2018 13:52:03 -0700
Message-Id: <20180926205204.184898-1-ryandcase@chromium.org>
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
index 000000000000..e13f5bb314ad
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
+	qspi: qspi@88df000 {
+		compatible = "qcom,sdm845-qspi", "qcom,qspi-v1";
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
2.19.0.605.g01d371f741-goog

