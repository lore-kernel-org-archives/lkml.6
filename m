Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B6820836
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B6820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbeGQVnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:43:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38913 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbeGQVnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:43:24 -0400
Received: by mail-pl0-f68.google.com with SMTP id p23-v6so994324plo.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xpbzuM+x+J+tSdNkdVIiy6pINZ/Pf+E8xLgWI3gX3J0=;
        b=TswaDt1RRmxrvTcaYLFywjMVibj1Y7RSu0wVtGk9boDnl7AGbhY9YcDZZohD3BOs/J
         k7jgolXtU9/vgQiYBbV2szyKmro7LPZzcN3vgpTJBMIyYhXOaBAX7HkXABiF2n2SZGRr
         uYg+3l6pPUMt4ZRZdDmTpr2rpkXg0mcyFn5jODBobJzmeRLY9/qWj2iQ9NGDgjb37os7
         QUMOxLwk/dSDCJiLbcN/7D1gYtoj1A2vRcJ9Iz//hzxUpmSP+WGx3ZgSzZm2gv5kOA95
         URJ62BxPcMvXVShXwR3AsDKTEd6VfGos+NqnuKvLJQNx6fWxH2oHx70rbW4x7hHtX1f6
         cgCw==
X-Gm-Message-State: AOUpUlHPXk/j9AUAA82kY0sVkdtbKj056c3ke8ATniJj6Rnxl2pDT3HF
        J+S/QdnJysbnTyKvjcmWlUwQug==
X-Google-Smtp-Source: AAOMgpfMck+pSiFTLyynyINsXkz4+VPy+onEpmwHuLEuI73lZjpd1kuRhB5EHviO+Z19Miu5mdaU1g==
X-Received: by 2002:a17:902:aa07:: with SMTP id be7-v6mr3093082plb.109.1531861735661;
        Tue, 17 Jul 2018 14:08:55 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b23-v6sm5081924pfc.49.2018.07.17.14.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:08:54 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 1/3] thermal: qcom-spmi: Allow to disable stage 2 shutdown
Date:   Tue, 17 Jul 2018 14:08:13 -0700
Message-Id: <20180717210815.245639-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the temperature reaches stage 2 the PMIC performs by default a
'partial shutdown', unless software override is enabled. It is not well
defined which peripherals are affected by a 'partial shutdown'. Drivers
might be unhappy when their devices suddenly disappear and prevent an
orderly shutdown.

Add an optional device tree property that allows to disable stage 2
shutdown.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v4:
- patch added to the series
---
 .../bindings/thermal/qcom-spmi-temp-alarm.txt |  3 ++
 drivers/thermal/qcom-spmi-temp-alarm.c        | 28 +++++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 290ec06fa33a..377c94fa1821 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -15,6 +15,8 @@ Optional properties:
 - io-channels:     Should contain IIO channel specifier for the ADC channel,
                    which report chip die temperature.
 - io-channel-names: Should contain "thermal".
+- stage2-shutdown-disabled: boolean to disable a partial shutdown of the PMIC
+                            when the temperature reaches stage 2
 
 Example:
 
@@ -23,6 +25,7 @@ Example:
 		reg = <0x2400 0x100>;
 		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
 		#thermal-sensor-cells = <0>;
+		stage2-shutdown-disabled;
 
 		io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
 		io-channel-names = "thermal";
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index ad4f3a8d6560..acbb0dbec79e 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -37,7 +37,9 @@
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
-#define SHUTDOWN_CTRL1_OVERRIDE_MASK	GENMASK(7, 6)
+#define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
+#define SHUTDOWN_CTRL1_OVERRIDE_S2_MASK	GENMASK(6, 6)
+#define SHUTDOWN_CTRL1_OVERRIDE_S3_MASK	GENMASK(7, 7)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
@@ -198,7 +200,8 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
  * current thermal stage and threshold. Setup threshold control and
  * disable shutdown override.
  */
-static int qpnp_tm_init(struct qpnp_tm_chip *chip)
+static int qpnp_tm_init(struct qpnp_tm_chip *chip,
+			bool disable_stage2_shutdown)
 {
 	unsigned int stage;
 	int ret;
@@ -224,13 +227,18 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 			     (stage - 1) * TEMP_STAGE_STEP +
 			     TEMP_THRESH_MIN;
 
-	/*
-	 * Set threshold and disable software override of stage 2 and 3
-	 * shutdowns.
-	 */
+	/* Set threshold and disable software override of stage 3 shutdown. */
 	chip->thresh = THRESH_MIN;
-	reg &= ~(SHUTDOWN_CTRL1_OVERRIDE_MASK | SHUTDOWN_CTRL1_THRESHOLD_MASK);
+	reg &= ~(SHUTDOWN_CTRL1_OVERRIDE_S3_MASK |
+		 SHUTDOWN_CTRL1_THRESHOLD_MASK);
 	reg |= chip->thresh & SHUTDOWN_CTRL1_THRESHOLD_MASK;
+
+	/* Disable stage 2 shutdown if requested */
+	if (disable_stage2_shutdown)
+		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
+	else
+		reg &= ~SHUTDOWN_CTRL1_OVERRIDE_S2_MASK;
+
 	ret = qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 	if (ret < 0)
 		return ret;
@@ -248,6 +256,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	struct device_node *node;
 	u8 type, subtype;
 	u32 res;
+	bool stage2_shutdown_disabled;
 	int ret, irq;
 
 	node = pdev->dev.of_node;
@@ -302,7 +311,10 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 
 	chip->subtype = subtype;
 
-	ret = qpnp_tm_init(chip);
+	stage2_shutdown_disabled = of_property_read_bool(node,
+						"stage2-shutdown-disabled");
+
+	ret = qpnp_tm_init(chip, stage2_shutdown_disabled);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "init failed\n");
 		return ret;
-- 
2.18.0.203.gfac676dfb9-goog

