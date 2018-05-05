Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeEEAKq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 20:10:46 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40895 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeEEAKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 20:10:43 -0400
X-Google-Smtp-Source: AB8JxZoHrpidLPiPVr8KmkBJhiQhXV4l+tHsWSAcDtvSNggrGvG612STRyYIAi0v8z0GNTLaMoubuw==
Date: Fri, 4 May 2018 17:10:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tirupathi Reddy <tirupath@codeaurora.org>
Cc: bjorn.andersson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] Input: pm8941-pwrkey: add resin key capabilities
Message-ID: <20180505001039.GA112416@dtor-ws>
References: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tirupathi,

On Fri, Mar 23, 2018 at 11:53:12AM +0530, Tirupathi Reddy wrote:
> Add resin key support to handle different types of key events
> defined in different platforms.
> 
> Signed-off-by: Tirupathi Reddy <tirupath@codeaurora.org>
> ---
>  .../bindings/input/qcom,pm8941-pwrkey.txt          | 32 +++++++++
>  drivers/input/misc/pm8941-pwrkey.c                 | 81 ++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> index 07bf55f..c671636 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> @@ -32,6 +32,32 @@ PROPERTIES
>  	Definition: presence of this property indicates that the KPDPWR_N pin
>  		    should be configured for pull up.
>  
> +RESIN SUBNODE
> +
> +The HW module can generate other optional key events like RESIN(reset-in pin).
> +The RESIN pin can be configured to support different key events on different
> +platforms. The resin key is described by the following properties.
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: key change interrupt; The format of the specifier is
> +		    defined by the binding document describing the node's
> +		    interrupt parent.
> +
> +- linux,code:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: The input key-code associated with the resin key.
> +		    Use the linux event codes defined in
> +		    include/dt-bindings/input/linux-event-codes.h
> +
> +- bias-pull-up:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: presence of this property indicates that the RESIN pin
> +		    should be configured for pull up.
> +
>  EXAMPLE
>  
>  	pwrkey@800 {
> @@ -40,4 +66,10 @@ EXAMPLE
>  		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
>  		debounce = <15625>;
>  		bias-pull-up;
> +
> +		resin {
> +			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			bias-pull-up;
> +		};
>  	};

The new key and power key bindings are very similar, I would prefer if
we shared the parsing code and our new DTS looked like:

		power {
			...
		};
 
		resin {
			...
		};

(we can easily keep backward compatibility with power properties being
in device node).

> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> index 18ad956..6e45d01 100644
> --- a/drivers/input/misc/pm8941-pwrkey.c
> +++ b/drivers/input/misc/pm8941-pwrkey.c
> @@ -20,6 +20,7 @@
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/reboot.h>
>  #include <linux/regmap.h>
> @@ -28,6 +29,7 @@
>  
>  #define PON_RT_STS			0x10
>  #define  PON_KPDPWR_N_SET		BIT(0)
> +#define  PON_RESIN_N_SET		BIT(1)
>  
>  #define PON_PS_HOLD_RST_CTL		0x5a
>  #define PON_PS_HOLD_RST_CTL2		0x5b
> @@ -37,6 +39,7 @@
>  #define  PON_PS_HOLD_TYPE_HARD_RESET	7
>  
>  #define PON_PULL_CTL			0x70
> +#define  PON_RESIN_PULL_UP		BIT(0)
>  #define  PON_KPDPWR_PULL_UP		BIT(1)
>  
>  #define PON_DBC_CTL			0x71
> @@ -46,6 +49,7 @@
>  struct pm8941_pwrkey {
>  	struct device *dev;
>  	int irq;
> +	u32 resin_key_code;
>  	u32 baseaddr;
>  	struct regmap *regmap;
>  	struct input_dev *input;
> @@ -130,6 +134,24 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t pm8941_resinkey_irq(int irq, void *_data)
> +{
> +	struct pm8941_pwrkey *pwrkey = _data;
> +	unsigned int sts;
> +	int error;
> +	u32 key_code = pwrkey->resin_key_code;
> +
> +	error = regmap_read(pwrkey->regmap,
> +			    pwrkey->baseaddr + PON_RT_STS, &sts);
> +	if (error)
> +		return IRQ_HANDLED;
> +
> +	input_report_key(pwrkey->input, key_code, !!(sts & PON_RESIN_N_SET));
> +	input_sync(pwrkey->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int __maybe_unused pm8941_pwrkey_suspend(struct device *dev)
>  {
>  	struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);
> @@ -153,9 +175,56 @@ static int __maybe_unused pm8941_pwrkey_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(pm8941_pwr_key_pm_ops,
>  			 pm8941_pwrkey_suspend, pm8941_pwrkey_resume);
>  
> +static int pm8941_resin_key_init(struct pm8941_pwrkey *pwrkey,
> +			struct device_node *np)
> +{
> +	int error, irq;
> +	bool pull_up;
> +
> +	/*
> +	 * Get the standard-key parameters. This might not be
> +	 * specified if there is no key mapping on the reset line.
> +	 */
> +	error = of_property_read_u32(np, "linux,code", &pwrkey->resin_key_code);
> +	if (error) {
> +		dev_err(pwrkey->dev, "failed to read key-code for resin key\n");
> +		return error;
> +	}
> +
> +	pull_up = of_property_read_bool(np, "bias-pull-up");
> +
> +	irq = irq_of_parse_and_map(np, 0);

irq_of_parse_and_map() returns unsigned.

> +	if (irq < 0) {
> +		dev_err(pwrkey->dev, "failed to get resin irq\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Register key configuration */
> +	input_set_capability(pwrkey->input, EV_KEY, pwrkey->resin_key_code);
> +
> +	error = regmap_update_bits(pwrkey->regmap,
> +				   pwrkey->baseaddr + PON_PULL_CTL,
> +				   PON_RESIN_PULL_UP,
> +				   pull_up ? PON_RESIN_PULL_UP : 0);
> +	if (error) {
> +		dev_err(pwrkey->dev, "failed to set resin pull: %d\n", error);
> +		return error;
> +	}
> +
> +	error = devm_request_threaded_irq(pwrkey->dev, irq, NULL,
> +					  pm8941_resinkey_irq, IRQF_ONESHOT,
> +					  "pm8941_resinkey", pwrkey);
> +	if (error)
> +		dev_err(pwrkey->dev, "failed requesting resin key IRQ: %d\n",
> +			error);
> +
> +	return error;
> +}
> +
>  static int pm8941_pwrkey_probe(struct platform_device *pdev)
>  {
>  	struct pm8941_pwrkey *pwrkey;
> +	struct device_node *np = NULL;
>  	bool pull_up;
>  	u32 req_delay;
>  	int error;
> @@ -241,6 +310,18 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> +	np = of_find_node_by_name(pdev->dev.of_node, "resin");
> +	if (np) {
> +		/* resin key capabilities are defined in device node */
> +		error = pm8941_resin_key_init(pwrkey, np);
> +		of_node_put(np);
> +		if (error) {
> +			dev_err(&pdev->dev, "failed resin key initialization: %d\n",
> +				error);
> +			return error;
> +		}
> +	}
> +
>  	error = input_register_device(pwrkey->input);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to register input device: %d\n",
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 

Can you please try the version below and let me know if it works for
you?

Thanks!

-- 
Dmitry


Input: pm8941-pwrkey - add resin key capabilities

From: Tirupathi Reddy <tirupath@codeaurora.org>

Add resin key support to handle different types of key events
defined in different platforms.

Signed-off-by: Tirupathi Reddy <tirupath@codeaurora.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../bindings/input/qcom,pm8941-pwrkey.txt          |   56 ++++++-
 drivers/input/misc/pm8941-pwrkey.c                 |  163 +++++++++++++-------
 2 files changed, 161 insertions(+), 58 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
index 07bf55f6e0b9a..314bc7fd767d7 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
@@ -13,6 +13,14 @@ PROPERTIES
 	Value type: <prop-encoded-array>
 	Definition: base address of registers for block
 
+- debounce:
+	Usage: optional
+	Value type: <u32>
+	Definition: time in microseconds that key must be pressed or released
+		    for state change interrupt to trigger.
+
+POWER SUBNODE
+
 - interrupts:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -20,11 +28,13 @@ PROPERTIES
 		    defined by the binding document describing the node's
 		    interrupt parent.
 
-- debounce:
+- linux,code:
 	Usage: optional
 	Value type: <u32>
-	Definition: time in microseconds that key must be pressed or released
-		    for state change interrupt to trigger.
+	Definition: The input key-code associated with the power key.
+		    Use the linux event codes defined in
+		    include/dt-bindings/input/linux-event-codes.h
+		    When property is omitted KEY_POWER is assumed.
 
 - bias-pull-up:
 	Usage: optional
@@ -32,12 +42,48 @@ PROPERTIES
 	Definition: presence of this property indicates that the KPDPWR_N pin
 		    should be configured for pull up.
 
+RESIN SUBNODE (optional)
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
 		compatible = "qcom,pm8941-pwrkey";
 		reg = <0x800>;
-		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
 		debounce = <15625>;
-		bias-pull-up;
+
+		power {
+			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+			linux,code = <KEY_POWER>;
+			bias-pull-up;
+		};
+
+		resin {
+			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			bias-pull-up;
+		};
 	};
diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 18ad956454f1e..ac079b0b94c9a 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -20,7 +20,9 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 
@@ -28,6 +30,7 @@
 
 #define PON_RT_STS			0x10
 #define  PON_KPDPWR_N_SET		BIT(0)
+#define  PON_RESIN_N_SET		BIT(1)
 
 #define PON_PS_HOLD_RST_CTL		0x5a
 #define PON_PS_HOLD_RST_CTL2		0x5b
@@ -37,19 +40,21 @@
 #define  PON_PS_HOLD_TYPE_HARD_RESET	7
 
 #define PON_PULL_CTL			0x70
+#define  PON_RESIN_PULL_UP		BIT(0)
 #define  PON_KPDPWR_PULL_UP		BIT(1)
 
 #define PON_DBC_CTL			0x71
 #define  PON_DBC_DELAY_MASK		0x7
 
-
 struct pm8941_pwrkey {
 	struct device *dev;
-	int irq;
-	u32 baseaddr;
 	struct regmap *regmap;
 	struct input_dev *input;
 
+	u32 baseaddr;
+	u32 power_keycode;
+	u32 resin_keycode;
+
 	unsigned int revision;
 	struct notifier_block reboot_notifier;
 };
@@ -122,41 +127,90 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
 	error = regmap_read(pwrkey->regmap,
 			    pwrkey->baseaddr + PON_RT_STS, &sts);
 	if (error)
-		return IRQ_HANDLED;
+		goto out;
+
+	if (pwrkey->power_keycode != KEY_RESERVED)
+		input_report_key(pwrkey->input, pwrkey->power_keycode,
+				 sts & PON_KPDPWR_N_SET);
+
+	if (pwrkey->resin_keycode != KEY_RESERVED)
+		input_report_key(pwrkey->input, pwrkey->resin_keycode,
+				 sts & PON_RESIN_N_SET);
 
-	input_report_key(pwrkey->input, KEY_POWER, !!(sts & PON_KPDPWR_N_SET));
 	input_sync(pwrkey->input);
 
+out:
 	return IRQ_HANDLED;
 }
 
-static int __maybe_unused pm8941_pwrkey_suspend(struct device *dev)
+static int pm8941_key_init(struct device_node *np,
+			   struct pm8941_pwrkey *pwrkey,
+			   unsigned int *keycode,
+			   unsigned int default_keycode,
+			   u32 pull_up_bit,
+			   const char *keyname,
+			   bool wakeup)
 {
-	struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);
+	char *irq_devname;
+	unsigned int irq;
+	int error;
+	bool pull_up;
 
-	if (device_may_wakeup(dev))
-		enable_irq_wake(pwrkey->irq);
+	error = of_property_read_u32(np, "linux,code", keycode);
+	if (error) {
+		if (default_keycode == KEY_RESERVED) {
+			dev_err(pwrkey->dev,
+				"failed to read key-code for %s key\n",
+				keyname);
+			return error;
+		}
+
+		*keycode = default_keycode;
+	}
 
-	return 0;
-}
+	/* Register key configuration */
+	input_set_capability(pwrkey->input, EV_KEY, *keycode);
 
-static int __maybe_unused pm8941_pwrkey_resume(struct device *dev)
-{
-	struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);
+	pull_up = of_property_read_bool(np, "bias-pull-up");
+	error = regmap_update_bits(pwrkey->regmap,
+				   pwrkey->baseaddr + PON_PULL_CTL,
+				   pull_up_bit, pull_up ? pull_up_bit : 0);
+	if (error) {
+		dev_err(pwrkey->dev, "failed to set %s pull: %d\n",
+			keyname, error);
+		return error;
+	}
 
-	if (device_may_wakeup(dev))
-		disable_irq_wake(pwrkey->irq);
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		dev_err(pwrkey->dev, "failed to get %s irq\n", keyname);
+		return -EINVAL;
+	}
 
-	return 0;
-}
+	irq_devname = devm_kasprintf(pwrkey->dev,
+				     GFP_KERNEL, "pm8941_%skey", keyname);
+	if (!irq_devname)
+		return -ENOMEM;
+
+	error = devm_request_threaded_irq(pwrkey->dev, irq, NULL,
+					  pm8941_pwrkey_irq, IRQF_ONESHOT,
+					  irq_devname, pwrkey);
+	if (error)
+		dev_err(pwrkey->dev, "failed requesting %s key IRQ: %d\n",
+			keyname, error);
 
-static SIMPLE_DEV_PM_OPS(pm8941_pwr_key_pm_ops,
-			 pm8941_pwrkey_suspend, pm8941_pwrkey_resume);
+	if (wakeup) {
+		device_init_wakeup(pwrkey->dev, true);
+		dev_pm_set_wake_irq(pwrkey->dev, irq);
+	}
+
+	return error;
+}
 
 static int pm8941_pwrkey_probe(struct platform_device *pdev)
 {
 	struct pm8941_pwrkey *pwrkey;
-	bool pull_up;
+	struct device_node *np;
 	u32 req_delay;
 	int error;
 
@@ -168,8 +222,6 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pull_up = of_property_read_bool(pdev->dev.of_node, "bias-pull-up");
-
 	pwrkey = devm_kzalloc(&pdev->dev, sizeof(*pwrkey), GFP_KERNEL);
 	if (!pwrkey)
 		return -ENOMEM;
@@ -182,12 +234,6 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	pwrkey->irq = platform_get_irq(pdev, 0);
-	if (pwrkey->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
-		return pwrkey->irq;
-	}
-
 	error = of_property_read_u32(pdev->dev.of_node, "reg",
 				     &pwrkey->baseaddr);
 	if (error)
@@ -195,6 +241,18 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 
 	error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_REV2,
 			    &pwrkey->revision);
+	if (error) {
+		dev_err(&pdev->dev, "failed to read revision: %d\n", error);
+		return error;
+	}
+
+	req_delay = (req_delay << 6) / USEC_PER_SEC;
+	req_delay = ilog2(req_delay);
+
+	error = regmap_update_bits(pwrkey->regmap,
+				   pwrkey->baseaddr + PON_DBC_CTL,
+				   PON_DBC_DELAY_MASK,
+				   req_delay);
 	if (error) {
 		dev_err(&pdev->dev, "failed to set debounce: %d\n", error);
 		return error;
@@ -211,34 +269,36 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 	pwrkey->input->name = "pm8941_pwrkey";
 	pwrkey->input->phys = "pm8941_pwrkey/input0";
 
-	req_delay = (req_delay << 6) / USEC_PER_SEC;
-	req_delay = ilog2(req_delay);
 
-	error = regmap_update_bits(pwrkey->regmap,
-				   pwrkey->baseaddr + PON_DBC_CTL,
-				   PON_DBC_DELAY_MASK,
-				   req_delay);
-	if (error) {
-		dev_err(&pdev->dev, "failed to set debounce: %d\n", error);
-		return error;
+	np = of_get_child_by_name(pdev->dev.of_node, "power");
+	if (!np) {
+		/*
+		 * Fall back to older format with power key properties
+		 * attached to the device itself.
+		 */
+		of_node_get(pdev->dev.of_node);
 	}
 
-	error = regmap_update_bits(pwrkey->regmap,
-				   pwrkey->baseaddr + PON_PULL_CTL,
-				   PON_KPDPWR_PULL_UP,
-				   pull_up ? PON_KPDPWR_PULL_UP : 0);
+	error = pm8941_key_init(np, pwrkey, &pwrkey->power_keycode, KEY_POWER,
+				PON_KPDPWR_PULL_UP, "pwr", true);
+	of_node_put(np);
 	if (error) {
-		dev_err(&pdev->dev, "failed to set pull: %d\n", error);
+		dev_err(&pdev->dev,
+			"failed power key initialization: %d\n", error);
 		return error;
 	}
 
-	error = devm_request_threaded_irq(&pdev->dev, pwrkey->irq,
-					  NULL, pm8941_pwrkey_irq,
-					  IRQF_ONESHOT,
-					  "pm8941_pwrkey", pwrkey);
-	if (error) {
-		dev_err(&pdev->dev, "failed requesting IRQ: %d\n", error);
-		return error;
+	np = of_find_node_by_name(pdev->dev.of_node, "resin");
+	if (np) {
+		error = pm8941_key_init(np, pwrkey,
+					&pwrkey->resin_keycode, KEY_RESERVED,
+					PON_RESIN_PULL_UP, "resin", false);
+		of_node_put(np);
+		if (error) {
+			dev_err(&pdev->dev,
+				"failed resin key initialization: %d\n", error);
+			return error;
+		}
 	}
 
 	error = input_register_device(pwrkey->input);
@@ -257,8 +317,6 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, pwrkey);
-	device_init_wakeup(&pdev->dev, 1);
-
 	return 0;
 }
 
@@ -282,7 +340,6 @@ static struct platform_driver pm8941_pwrkey_driver = {
 	.remove = pm8941_pwrkey_remove,
 	.driver = {
 		.name = "pm8941-pwrkey",
-		.pm = &pm8941_pwr_key_pm_ops,
 		.of_match_table = of_match_ptr(pm8941_pwr_key_id_table),
 	},
 };
