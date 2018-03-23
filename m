Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCWGXn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 02:23:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWGXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 02:23:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FC6D6016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tirupath@codeaurora.org
From: Tirupathi Reddy <tirupath@codeaurora.org>
To: dmitry.torokhov@gmail.com, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: tirupath@codeaurora.org, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] Input: pm8941-pwrkey: add resin key capabilities
Date: Fri, 23 Mar 2018 11:53:12 +0530
Message-Id: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resin key support to handle different types of key events
defined in different platforms.

Signed-off-by: Tirupathi Reddy <tirupath@codeaurora.org>
---
 .../bindings/input/qcom,pm8941-pwrkey.txt          | 32 +++++++++
 drivers/input/misc/pm8941-pwrkey.c                 | 81 ++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
index 07bf55f..c671636 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
@@ -32,6 +32,32 @@ PROPERTIES
 	Definition: presence of this property indicates that the KPDPWR_N pin
 		    should be configured for pull up.
 
+RESIN SUBNODE
+
+The HW module can generate other optional key events like RESIN(reset-in pin).
+The RESIN pin can be configured to support different key events on different
+platforms. The resin key is described by the following properties.
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: key change interrupt; The format of the specifier is
+		    defined by the binding document describing the node's
+		    interrupt parent.
+
+- linux,code:
+	Usage: required
+	Value type: <u32>
+	Definition: The input key-code associated with the resin key.
+		    Use the linux event codes defined in
+		    include/dt-bindings/input/linux-event-codes.h
+
+- bias-pull-up:
+	Usage: optional
+	Value type: <empty>
+	Definition: presence of this property indicates that the RESIN pin
+		    should be configured for pull up.
+
 EXAMPLE
 
 	pwrkey@800 {
@@ -40,4 +66,10 @@ EXAMPLE
 		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
 		debounce = <15625>;
 		bias-pull-up;
+
+		resin {
+			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			bias-pull-up;
+		};
 	};
diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 18ad956..6e45d01 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -20,6 +20,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
@@ -28,6 +29,7 @@
 
 #define PON_RT_STS			0x10
 #define  PON_KPDPWR_N_SET		BIT(0)
+#define  PON_RESIN_N_SET		BIT(1)
 
 #define PON_PS_HOLD_RST_CTL		0x5a
 #define PON_PS_HOLD_RST_CTL2		0x5b
@@ -37,6 +39,7 @@
 #define  PON_PS_HOLD_TYPE_HARD_RESET	7
 
 #define PON_PULL_CTL			0x70
+#define  PON_RESIN_PULL_UP		BIT(0)
 #define  PON_KPDPWR_PULL_UP		BIT(1)
 
 #define PON_DBC_CTL			0x71
@@ -46,6 +49,7 @@
 struct pm8941_pwrkey {
 	struct device *dev;
 	int irq;
+	u32 resin_key_code;
 	u32 baseaddr;
 	struct regmap *regmap;
 	struct input_dev *input;
@@ -130,6 +134,24 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t pm8941_resinkey_irq(int irq, void *_data)
+{
+	struct pm8941_pwrkey *pwrkey = _data;
+	unsigned int sts;
+	int error;
+	u32 key_code = pwrkey->resin_key_code;
+
+	error = regmap_read(pwrkey->regmap,
+			    pwrkey->baseaddr + PON_RT_STS, &sts);
+	if (error)
+		return IRQ_HANDLED;
+
+	input_report_key(pwrkey->input, key_code, !!(sts & PON_RESIN_N_SET));
+	input_sync(pwrkey->input);
+
+	return IRQ_HANDLED;
+}
+
 static int __maybe_unused pm8941_pwrkey_suspend(struct device *dev)
 {
 	struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);
@@ -153,9 +175,56 @@ static int __maybe_unused pm8941_pwrkey_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(pm8941_pwr_key_pm_ops,
 			 pm8941_pwrkey_suspend, pm8941_pwrkey_resume);
 
+static int pm8941_resin_key_init(struct pm8941_pwrkey *pwrkey,
+			struct device_node *np)
+{
+	int error, irq;
+	bool pull_up;
+
+	/*
+	 * Get the standard-key parameters. This might not be
+	 * specified if there is no key mapping on the reset line.
+	 */
+	error = of_property_read_u32(np, "linux,code", &pwrkey->resin_key_code);
+	if (error) {
+		dev_err(pwrkey->dev, "failed to read key-code for resin key\n");
+		return error;
+	}
+
+	pull_up = of_property_read_bool(np, "bias-pull-up");
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq < 0) {
+		dev_err(pwrkey->dev, "failed to get resin irq\n");
+		return -EINVAL;
+	}
+
+	/* Register key configuration */
+	input_set_capability(pwrkey->input, EV_KEY, pwrkey->resin_key_code);
+
+	error = regmap_update_bits(pwrkey->regmap,
+				   pwrkey->baseaddr + PON_PULL_CTL,
+				   PON_RESIN_PULL_UP,
+				   pull_up ? PON_RESIN_PULL_UP : 0);
+	if (error) {
+		dev_err(pwrkey->dev, "failed to set resin pull: %d\n", error);
+		return error;
+	}
+
+	error = devm_request_threaded_irq(pwrkey->dev, irq, NULL,
+					  pm8941_resinkey_irq, IRQF_ONESHOT,
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
+	struct device_node *np = NULL;
 	bool pull_up;
 	u32 req_delay;
 	int error;
@@ -241,6 +310,18 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	np = of_find_node_by_name(pdev->dev.of_node, "resin");
+	if (np) {
+		/* resin key capabilities are defined in device node */
+		error = pm8941_resin_key_init(pwrkey, np);
+		of_node_put(np);
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
