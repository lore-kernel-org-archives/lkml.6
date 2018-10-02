Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C16C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFBA2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L36rxzaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFBA2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJCEdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:33:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35290 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeJCEdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:33:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8-v6so2384799plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CAWn/MCat9imowTLcWTJbWTBWu0DvQZeFmhEx8GmINg=;
        b=L36rxzaI3kJMp8VhLHSkJ5GMznqOFIl0kd3fQo2gT4w2igugbJLSBpzH1s17GVl1h2
         1RTME+F7TF1uYInTK+Pf/8X3c+knbqO2BVJOCQk5UCDg+5J5xghT08FbJREcM3Eyyj8l
         DAkL81zqaL9RhjOuFME9xcb9/O1QEW6g3Ggbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CAWn/MCat9imowTLcWTJbWTBWu0DvQZeFmhEx8GmINg=;
        b=riSdJbiJf+bjYQfFPxj0uTQzUiaK0/wNg8W+HDsLIe2T7VHLu86jiBK7qn5doNZEZw
         tlj8Bovzoawc5ax8L1xwBHwqIOM95c8spYrLDHDzX5gOrI0BY+Io4PkxQ26XgQlnnp7/
         /ciZKUdjkQMha/QugN0GzENDnj/qQl+53IOW8d3m4rYQcySNp/TDkPiRd2w0C5odJ5hi
         B9Og1BlVFNsA1T28cg0RQrqTDHdJMKffKM7jLwPQxT1KBDz1d5K84poSQ7HVcQHOxe1C
         SczG/7vme6WJC19hHy2Sc52IBQQ5NoQwfYF+duZ1gF+Cmzb5rUDOymDN135VmRrsJebZ
         YDvQ==
X-Gm-Message-State: ABuFfoj0C6zIvb6t8dXvqKGrzb71nVangC9aqr2chkqsc1RY3hwUQsVJ
        1ZpPsSNDxGzjS5/PhTBgsgs3ag==
X-Google-Smtp-Source: ACcGV62AkTaM1d9QBZsFL0XYJL9X+2owGlJyyN2AtxBBw7zPHDAnnT1JYJF9f4KnYOUP17eZlYTefA==
X-Received: by 2002:a17:902:b585:: with SMTP id a5-v6mr18131125pls.259.1538516872111;
        Tue, 02 Oct 2018 14:47:52 -0700 (PDT)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id w2-v6sm21070910pfk.140.2018.10.02.14.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:47:51 -0700 (PDT)
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
Subject: [PATCH v6 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Tue,  2 Oct 2018 14:47:07 -0700
Message-Id: <20181002214709.162330-1-ryandcase@chromium.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v6:
- None

Changes in v5:
- None

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

