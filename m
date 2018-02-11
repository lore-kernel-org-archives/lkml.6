Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518332136; cv=none;
        d=google.com; s=arc-20160816;
        b=PrOukDmV6O95DCQC7Kn+xKiIR3qQ+L3mmfsRijUluvXnJ9kDgfSuw66Xh/zzFIDo9n
         LRvW1ZAtNRjkjGKfn6q4bsxVwh7w3JG7Aks9xyXqd0rEXTF6cGE6mlU2EPGtL+s9mIFi
         8WdLz/YW6RUUILnDDjjTJizmWMuL8AeGCEWhlx2zMttkgWtYZpm1q5TT0OSwX2MK4PYJ
         SQVXoN2MRM37znOp980s1UaYvtnIAgmW0FF32DT+BrdbE4ee65Jj0vmjWee43XkZqnPA
         ysaiIvnjh0tReTOEOb32WnpRcrdNLVcotR083ian8TKFnqRYLflTsVSQHEKoa3y5th3K
         WNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=tQ8sP6z9GC2+zIHcZaVMgbpRZcgIb+mPHO8lsNT9SfU=;
        b=cIeI2SDwB9ho61Tgp5/jar5geHaz4aM8mwucs2ZU8zy4ybOQEN2EHVMXpqPMmGIUA0
         4aAYolA7RVExe1d22qnVmaM4xElQs100aXGIqGJETmEU/dKvc6GGl0QH6JQupcFocLRp
         6ETGCNTw6x198dHqs8Yyz9GRtLnGSY/5FIxdBJOupZ7lcHiixRo5g4O9/qVaUS8hlGpV
         h+kFeOM60yVIoBS9GOoZoSkUz5fSOHe9XnvSwMnrPzPD09qks+Mxak0whKXXQ7AiYM+d
         1hfTcXbMHs3UClKuOq+nnUJ8MLr9TwoUaHVaCdTeEC/b3Q8pihgqn1/uWCQBv4tmTp3G
         OdNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dkuvnzSO;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dkuvnzSO;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x224qxoS4d5+ZDdCJXA3FDvjSEP4hD0NC78qn1Y21C4WdmSEtvbjyUK8XE2xoCXNpyQlad69Z3A==
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
	baolin.wang@linaro.org
Subject: [PATCH v2] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Sun, 11 Feb 2018 14:55:04 +0800
Message-Id: <7fc26df245d56fd2014532b56e67630e76e2c513.1518316248.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591902511604872416?=
X-GMAIL-MSGID: =?utf-8?q?1592086637971123008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some platforms (such as Spreadtrum platform), the GPIO keys can only
be triggered by level type. So this patch introduces one property to
indicate if the GPIO trigger type is level trigger or edge trigger.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - Diable the GPIO irq until reversing the GPIO level type.
---
 .../devicetree/bindings/input/gpio-keys.txt        |    2 ++
 drivers/input/keyboard/gpio_keys.c                 |   26 +++++++++++++++++++-
 include/linux/gpio_keys.h                          |    1 +
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index a949404..e3104bd 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -29,6 +29,8 @@ Optional subnode-properties:
 	- linux,can-disable: Boolean, indicates that button is connected
 	  to dedicated (not shared) interrupt which can be disabled to
 	  suppress events from the button.
+	- gpio-key,level-trigger: Boolean, indicates that button's interrupt
+	  type is level trigger. Otherwise it is edge trigger as default.
 
 Example nodes:
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613d..218698a 100644
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
@@ -721,6 +742,9 @@ static void gpio_keys_close(struct input_dev *input)
 		button->can_disable =
 			fwnode_property_read_bool(child, "linux,can-disable");
 
+		button->level_trigger =
+			fwnode_property_read_bool(child, "gpio-key,level-trigger");
+
 		if (fwnode_property_read_u32(child, "debounce-interval",
 					 &button->debounce_interval))
 			button->debounce_interval = 5;
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index d06bf77..5095645 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -28,6 +28,7 @@ struct gpio_keys_button {
 	int wakeup;
 	int debounce_interval;
 	bool can_disable;
+	bool level_trigger;
 	int value;
 	unsigned int irq;
 };
-- 
1.7.9.5
