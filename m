Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeCGIKU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:10:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbeCGIKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:10:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E34D7602A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tirupath@codeaurora.org
From: Tirupathi Reddy <tirupath@codeaurora.org>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: tirupath@codeaurora.org, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V1] Input: pm8941-pwrkey: add resin key capabilities
Date: Wed,  7 Mar 2018 13:39:33 +0530
Message-Id: <1520410173-2507-1-git-send-email-tirupath@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resin key support to handle different types of key events
defined in different platforms.

Signed-off-by: Tirupathi Reddy <tirupath@codeaurora.org>
---
 .../bindings/input/qcom,pm8941-pwrkey.txt          | 20 ++++++-
 drivers/input/misc/pm8941-pwrkey.c                 | 63 +++++++++++++++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
index 07bf55f..1c437e9 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
@@ -20,6 +20,14 @@ PROPERTIES
 		    defined by the binding document describing the node's
 		    interrupt parent.
 
+- interrupt-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Interrupt names.  This list must match up 1-to-1 with the
+		    interrupts specified in the 'interrupts' property. "kpdpwr"
+		    must be specified.  "resin" may be specified for some
+		    platforms.
+
 - debounce:
 	Usage: optional
 	Value type: <u32>
@@ -32,12 +40,22 @@ PROPERTIES
 	Definition: presence of this property indicates that the KPDPWR_N pin
 		    should be configured for pull up.
 
+- linux,code:
+	Usage: required for "resin" key
+	Value type: <u32>
+	Definition: The input key-code associated with the resin key.
+		    Use the linux event codes defined in
+		    include/dt-bindings/input/linux-event-codes.h
+
 EXAMPLE
 
 	pwrkey@800 {
 		compatible = "qcom,pm8941-pwrkey";
 		reg = <0x800>;
-		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>,
+			     <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+		interrupt-names = "kpdpwr", "resin";
 		debounce = <15625>;
 		bias-pull-up;
+		linux,code = <KEY_VOLUMEDOWN>;
 	};
diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 18ad956..3f801cf 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -28,6 +28,7 @@
 
 #define PON_RT_STS			0x10
 #define  PON_KPDPWR_N_SET		BIT(0)
+#define  PON_RESIN_N_SET		BIT(1)
 
 #define PON_PS_HOLD_RST_CTL		0x5a
 #define PON_PS_HOLD_RST_CTL2		0x5b
@@ -46,6 +47,8 @@
 struct pm8941_pwrkey {
 	struct device *dev;
 	int irq;
+	int resin_irq;
+	u32 resin_key_code;
 	u32 baseaddr;
 	struct regmap *regmap;
 	struct input_dev *input;
@@ -130,6 +133,24 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t pm8941_resinkey_irq(int irq, void *_data)
+{
+	struct pm8941_pwrkey *pwrkey = _data;
+	unsigned int sts;
+	int error;
+
+	error = regmap_read(pwrkey->regmap,
+			    pwrkey->baseaddr + PON_RT_STS, &sts);
+	if (error)
+		return IRQ_HANDLED;
+
+	input_report_key(pwrkey->input, pwrkey->resin_key_code,
+			 !!(sts & PON_RESIN_N_SET));
+	input_sync(pwrkey->input);
+
+	return IRQ_HANDLED;
+}
+
 static int __maybe_unused pm8941_pwrkey_suspend(struct device *dev)
 {
 	struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);
@@ -153,6 +174,35 @@ static int __maybe_unused pm8941_pwrkey_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(pm8941_pwr_key_pm_ops,
 			 pm8941_pwrkey_suspend, pm8941_pwrkey_resume);
 
+static int pm8941_resin_key_init(struct pm8941_pwrkey *pwrkey)
+{
+	int error;
+
+	/*
+	 * Get the standard-key parameters. This might not be
+	 * specified if there is no key mapping on the reset line.
+	 */
+	error = of_property_read_u32(pwrkey->dev->of_node, "linux,code",
+			&pwrkey->resin_key_code);
+	if (error) {
+		dev_err(pwrkey->dev, "failed to read key-code for resin key\n");
+		return error;
+	}
+
+	/* Register key configuration */
+	input_set_capability(pwrkey->input, EV_KEY, pwrkey->resin_key_code);
+
+	error = devm_request_threaded_irq(pwrkey->dev, pwrkey->resin_irq,
+					  NULL, pm8941_resinkey_irq,
+					  IRQF_ONESHOT,
+					  "pm8941_resinkey", pwrkey);
+	if (error)
+		dev_err(pwrkey->dev, "failed requesting resin key IRQ: %d\n",
+			error);
+
+	return error;
+}
+
 static int pm8941_pwrkey_probe(struct platform_device *pdev)
 {
 	struct pm8941_pwrkey *pwrkey;
@@ -182,7 +232,7 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	pwrkey->irq = platform_get_irq(pdev, 0);
+	pwrkey->irq = platform_get_irq_byname(pdev, "kpdpwr");
 	if (pwrkey->irq < 0) {
 		dev_err(&pdev->dev, "failed to get irq\n");
 		return pwrkey->irq;
@@ -241,6 +291,17 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	pwrkey->resin_irq = platform_get_irq_byname(pdev, "resin");
+	if (pwrkey->resin_irq >= 0) {
+		/* resin key capabilities are defined in device node */
+		error = pm8941_resin_key_init(pwrkey);
+		if (error) {
+			dev_err(&pdev->dev, "failed resin key initialization: %d\n",
+				error);
+			return error;
+		}
+	}
+
 	error = input_register_device(pwrkey->input);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register input device: %d\n",
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
