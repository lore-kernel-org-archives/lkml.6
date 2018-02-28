Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519821916; cv=none;
        d=google.com; s=arc-20160816;
        b=mve3YzxvtUSiav2F6tuVtPfRKH//pdswOuDIKo3LME7jmj9kZCjW3ELpH/sDfLq6ck
         cdQHO82x8VlhV90tlUtTn/ZqC3Qbbvda6l+xqIi30+zF5ayXsUC4wC3Vtk09XpZCHSX6
         jR871ZBOBHVfbZi35saHPoRTtQB97kfftMDiK1wtLXm6yuL+W8bRMrqeUGpAc2BE8j7M
         U/+9AjHIttuba9GTPSuHJGUL8DVi+wZL4xQZnvNBckEZjZoDMZ9rJ1pEwDuYMq9Nxkaz
         3CBKI5iiuOMlE+XXM0RsWzAOCvHyc0ytsdOos4R3RnvhInSiCDSxI+BHRcf0tnlD9JGE
         O8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=PHB58ugZyHCrmN8anIQa/VSNJ5iqk7j285imOYhNisc=;
        b=Tz6qad2EYdK5TDB0tmG1DcywQoLDdiXSTBHB3dn3qZsF08tF/XIc4IiPcQwZHE/hIy
         gjE8drJIZi55NqodsMEgU+PfWCxL/sT3sfRo7gf4kHqCP5iZpeA3NuAWeWCJMfCu4dWK
         HlUh3/N85grGdf+HUszlt7VrNQxlwoeXTdWIzTB37clph5JMD75y4aaz951cvsd24kic
         qA9PTV1Kle51l/19kZKpRru5RsJO+Q/8rIjlO8lMFFnFBNne67IAm9AjLknVNNViuIXB
         90EIxiNMzAmky4wYDvnI4wba/wamXOD/cBKD3zugUMNWxHlKQzdtEM1I+vMNvJk3ZiwN
         bGuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XkYGAGzL;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XkYGAGzL;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x226etYuwbMuEB4sSadcsT14E6WSSS6v9U3dXw/bZ8fDQjwYSKTqJphzGoWzquZuKmPhk7VGcPA==
From: Baolin Wang <baolin.wang@linaro.org>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: gregkh@linuxfoundation.org,
	lumotuwe@gmail.com,
	arvind.yadav.cs@gmail.com,
	josephl@nvidia.com,
	kstewart@linuxfoundation.org,
	pombredanne@nexb.com,
	tglx@linutronix.de,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	arnd@arndb.de,
	baolin.wang@linaro.org
Subject: [PATCH v3] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Wed, 28 Feb 2018 20:44:36 +0800
Message-Id: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593648786277200792?=
X-GMAIL-MSGID: =?utf-8?q?1593648786277200792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some platforms (such as Spreadtrum platform), the GPIO keys can only
be triggered by level type. So this patch introduces one property to
indicate if the GPIO trigger type is level trigger or edge trigger.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v2:
 - Use 'interrupt' property to indicate the irq type.

Changes since v1:
 - Diable the GPIO irq until reversing the GPIO level type.
---
 drivers/input/keyboard/gpio_keys.c |   32 ++++++++++++++++++++++++++++++--
 include/linux/gpio_keys.h          |    3 +++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613d..9e05c80 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -385,6 +385,20 @@ static void gpio_keys_gpio_work_func(struct work_struct *work)
 	struct gpio_button_data *bdata =
 		container_of(work, struct gpio_button_data, work.work);
 
+	if (bdata->button->level_trigger) {
+		unsigned int trigger =
+			irq_get_trigger_type(bdata->irq) & ~IRQF_TRIGGER_MASK;
+		int state = gpiod_get_raw_value_cansleep(bdata->gpiod);
+
+		if (state)
+			trigger |= IRQF_TRIGGER_LOW;
+		else
+			trigger |= IRQF_TRIGGER_HIGH;
+
+		irq_set_irq_type(bdata->irq, trigger);
+		enable_irq(bdata->irq);
+	}
+
 	gpio_keys_gpio_report_event(bdata);
 
 	if (bdata->button->wakeup)
@@ -397,6 +411,9 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 
 	BUG_ON(irq != bdata->irq);
 
+	if (bdata->button->level_trigger)
+		disable_irq_nosync(bdata->irq);
+
 	if (bdata->button->wakeup) {
 		const struct gpio_keys_button *button = bdata->button;
 
@@ -566,7 +583,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		INIT_DELAYED_WORK(&bdata->work, gpio_keys_gpio_work_func);
 
 		isr = gpio_keys_gpio_isr;
-		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+		if (button->level_trigger)
+			irqflags = gpiod_is_active_low(bdata->gpiod) ?
+				IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
+		else
+			irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 
 	} else {
 		if (!button->irq) {
@@ -696,10 +717,17 @@ static void gpio_keys_close(struct input_dev *input)
 	device_property_read_string(dev, "label", &pdata->name);
 
 	device_for_each_child_node(dev, child) {
-		if (is_of_node(child))
+		if (is_of_node(child)) {
 			button->irq =
 				irq_of_parse_and_map(to_of_node(child), 0);
 
+			if (button->irq)
+				button->level_trigger =
+					irq_get_trigger_type(button->irq) &
+					(IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW) ?
+					true : false;
+		}
+
 		if (fwnode_property_read_u32(child, "linux,code",
 					     &button->code)) {
 			dev_err(dev, "Button without keycode\n");
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77..1286136 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -16,6 +16,8 @@
  * @debounce_interval:	debounce ticks interval in msecs
  * @can_disable:	%true indicates that userspace is allowed to
  *			disable button via sysfs
+ * @level_trigger:	indicate if the button's interrupt type is
+ *			level trigger or not
  * @value:		axis value for %EV_ABS
  * @irq:		Irq number in case of interrupt keys
  */
@@ -28,6 +30,7 @@ struct gpio_keys_button {
 	int wakeup;
 	int debounce_interval;
 	bool can_disable;
+	bool level_trigger;
 	int value;
 	unsigned int irq;
 };
-- 
1.7.9.5
