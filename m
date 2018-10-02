Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA43C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C1721471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Skmjrjhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C1721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeJBINM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 04:13:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37075 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 04:13:12 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so383388iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZRLEg/khkM0SzLqkCsZQ/zq/wkAgq0+EC+MlucU/IsA=;
        b=SkmjrjhhgUfcXDzfzIiIP9ycIycVITzYkuuhcBNPPAPwS2PeLv3ss8pfjt89/tslVl
         22XzIypRA/Hk1pv0RTSMagiPtU6KjJu+0gL08Vof/VsYP9bnC2IxxyHPcde7v0+oMDgw
         PrsNdjT+PhxpRrBvQkcI7eqt+GBb0Z5FNZ7IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZRLEg/khkM0SzLqkCsZQ/zq/wkAgq0+EC+MlucU/IsA=;
        b=YgjgK2NsIfPhpoB+qufVBT99zh0vZyZ6dNEnOgMDmgfT5W8hrxCKLTAmwJzEuXrTRY
         GXMSF2vHSVB7qHRA1AR5pRU1Yyi0elAjoomgHq2xy8KR9CX98kYAWh2QQEnn6c2cdwkW
         KylYt3bjdKL53wHZ8CdhIK57jiNe30C5gC/sQUSkrJx8pACQlKPO9s1F734IK12C1PSm
         BZ9mbk4ghixjiZQDIeMs6JqMizCSsCWgax4b9kxhka4X8SmGFlp9Co/6kVufCtV8jZds
         DQw8Qcmfcqk+SlDPh5h6diPnGrQPaRTQBgKhVwJqbgfz/+U0wbMm1Vp6EB6wBH6ZKw7t
         8DRQ==
X-Gm-Message-State: ABuFfoij1Z3tyR3VtokqpHq1h9N1JWuL5Fp8+D+cuZ3B/1DPls4mMaiD
        yXvCkUJb3QK09+l1ZOEf4WjZjg==
X-Google-Smtp-Source: ACcGV618PuKLNWPtYK2nilaDbMlBqKoeBzz5skkz2FUUxWljHkTHw/Ywi3ep4NLeDwKi06IrETUXjA==
X-Received: by 2002:a62:2ec2:: with SMTP id u185-v6mr14060774pfu.134.1538443950581;
        Mon, 01 Oct 2018 18:32:30 -0700 (PDT)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id t69-v6sm26865095pgd.43.2018.10.01.18.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:32:30 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Mon,  1 Oct 2018 18:31:41 -0700
Message-Id: <20181002013142.209751-1-ryandcase@chromium.org>
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

