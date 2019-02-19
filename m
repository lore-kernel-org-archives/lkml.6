Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EF22183F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WtU17fpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfBSQHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:07:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34464 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbfBSQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:07:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so22675430wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74S/ZZSWu6G0IEBZISG2HDi0WMyGHQlJBkHM4LFbqVk=;
        b=WtU17fpFVE3t1D3pSQy5s2wHZqW7lwdaK1QQ1rMmSHiEUbbX6yRl1Fe9Im17v1Si85
         ZyBqFCU+kFJ3FQCJ/C6/To0XYd5KP3CZf3p0r9Ls+6J4SyIHwqfVdWLn8ETAD9lLaL5x
         HvFZJ+SExGZk682PfRdKrUnSnAZ3yv/Q2WIDq1xOr3CiJV5s8/EwkMOpl19FzDUSNkB5
         0JnRc4Z5PMP03JaMweSuXb6kqQFCePfQpeqj5cOOmgQC3prNFOQf2wUS7CIK0W2Y2eBn
         8Pzku8AHdiVrqjYR/OkoexR6+89rsxyjCrok7eN52F1ALLwZlbRteZoWSiMt2XngKnA+
         rW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74S/ZZSWu6G0IEBZISG2HDi0WMyGHQlJBkHM4LFbqVk=;
        b=sHCxZzJEN8g5T0ZrD4sWLBqfYQNILlm0VMQcmzgkhnv5ZSxlGSvp5+zvMTPh7ieYQp
         NY1z2lz4wmJ0mttq/fj2iRce3Vwa2Ty+DqjT8UKkRfOiQxcQKHf2v2jeW6B8fHXmC8Dp
         nqigXAUzqcqLcsnDej3u43WlILQr6n00DdCOTJ1PZD/Z8srF8EKcmpRIYcRNkhPHnhLw
         Zxi7grQ3d05XD7EigKtVvz8U+Zjhx/mV/WpCUEzFbIwUMVZozxHM/lHqE00u10SXuu9h
         /r3CwDZQ8oZGZw99ne8yXU/cdieEQ8FeKoGSQ31RyTk6K/6KtX77CfsTI95OeJw6sfed
         Pqzg==
X-Gm-Message-State: AHQUAuYiZjN6fyzbsJAGgHuGZAzUw4HAWEcMkP2s6yQCKAmCcD4vkUF2
        3yg3ULBG+t2zy/tETPmxKjhK6C8+/4Q=
X-Google-Smtp-Source: AHgI3IZsVzFDN0U2x0jNbiKO6sdHpyXlavuYozsq0RZuD74s+6SRhZWU+/6Ivl5kzoFAiKCjEJveBw==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr20409274wru.135.1550592425803;
        Tue, 19 Feb 2019 08:07:05 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h17sm12161381wrq.17.2019.02.19.08.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:07:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 7/7] gpio: mockup: rework debugfs interface
Date:   Tue, 19 Feb 2019 17:06:50 +0100
Message-Id: <20190219160650.9614-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219160650.9614-1-brgl@bgdev.pl>
References: <20190219160650.9614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Modify the way the debugfs interface works in gpio-mockup. Introduce
the concept of dummy pull config which will keep the mockup lines in
known state. The pull values can be modified by writing to the debugfs
files corresponding to lines. Lines in input mode always report the
current pull value, lines in output mode change the line value but
it will revert back to the one specified by current pull when released.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 117 ++++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index c498b0fbbec8..154d959e8993 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -47,6 +47,7 @@ enum {
 struct gpio_mockup_line_status {
 	int dir;
 	int value;
+	int pull;
 };
 
 struct gpio_mockup_chip {
@@ -188,15 +189,56 @@ static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
 	return irq_sim_irqnum(&chip->irqsim, offset);
 }
 
-static ssize_t gpio_mockup_event_write(struct file *file,
-				       const char __user *usr_buf,
-				       size_t size, loff_t *ppos)
+static void gpio_mockup_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+
+	__gpio_mockup_set(chip, offset, chip->lines[offset].pull);
+}
+
+static ssize_t gpio_mockup_debugfs_read(struct file *file,
+					char __user *usr_buf,
+					size_t size, loff_t *ppos)
 {
 	struct gpio_mockup_dbgfs_private *priv;
 	struct gpio_mockup_chip *chip;
 	struct seq_file *sfile;
+	struct gpio_chip *gc;
+	char buf[3];
+	int val, rv;
+
+	if (*ppos != 0)
+		return 0;
+
+	sfile = file->private_data;
+	priv = sfile->private;
+	chip = priv->chip;
+	gc = &chip->gc;
+
+	val = gpio_mockup_get(gc, priv->offset);
+	snprintf(buf, sizeof(buf), "%d\n", val);
+
+	rv = copy_to_user(usr_buf, buf, sizeof(buf));
+	if (rv)
+		return rv;
+
+	return sizeof(buf) - 1;
+}
+
+static ssize_t gpio_mockup_debugfs_write(struct file *file,
+					 const char __user *usr_buf,
+					 size_t size, loff_t *ppos)
+{
+	struct gpio_mockup_dbgfs_private *priv;
+	int rv, val, curr, irq, irq_type;
+	struct gpio_mockup_chip *chip;
+	struct seq_file *sfile;
 	struct gpio_desc *desc;
-	int rv, val;
+	struct gpio_chip *gc;
+	struct irq_sim *sim;
+
+	if (*ppos != 0)
+		return -EINVAL;
 
 	rv = kstrtoint_from_user(usr_buf, size, 0, &val);
 	if (rv)
@@ -206,24 +248,70 @@ static ssize_t gpio_mockup_event_write(struct file *file,
 
 	sfile = file->private_data;
 	priv = sfile->private;
-	desc = priv->desc;
 	chip = priv->chip;
+	gc = &chip->gc;
+	desc = &gc->gpiodev->descs[priv->offset];
+	sim = &chip->irqsim;
+
+	mutex_lock(&chip->lock);
+
+	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
+	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
+		curr = __gpio_mockup_get(chip, priv->offset);
+		if (curr == val)
+			goto out;
 
-	gpiod_set_value_cansleep(desc, val);
-	irq_sim_fire(&chip->irqsim, priv->offset);
+		irq = irq_sim_irqnum(sim, priv->offset);
+		irq_type = irq_get_trigger_type(irq);
+
+		if ((val == 1 && (irq_type & IRQ_TYPE_EDGE_RISING)) ||
+		    (val == 0 && (irq_type & IRQ_TYPE_EDGE_FALLING)))
+			irq_sim_fire(sim, priv->offset);
+	}
+
+	/* Change the value unless we're actively driving the line. */
+	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
+	    !test_bit(FLAG_IS_OUT, &desc->flags))
+		__gpio_mockup_set(chip, priv->offset, val);
+
+out:
+	chip->lines[priv->offset].pull = val;
+	mutex_unlock(&chip->lock);
 
 	return size;
 }
 
-static int gpio_mockup_event_open(struct inode *inode, struct file *file)
+static int gpio_mockup_debugfs_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, NULL, inode->i_private);
 }
 
-static const struct file_operations gpio_mockup_event_ops = {
+/*
+ * Each mockup chip is represented by a directory named after the chip's device
+ * name under /sys/kernel/debug/gpio-mockup/. Each line is represented by
+ * a file using the line's offset as the name under the chip's directory.
+ *
+ * Reading from the line's file yields the current *value*, writing to the
+ * line's file changes the current *pull*. Default pull for mockup lines is
+ * down.
+ *
+ * Examples:
+ * - when a line pulled down is requested in output mode and driven high, its
+ *   value will return to 0 once it's released
+ * - when the line is requested in output mode and driven high, writing 0 to
+ *   the corresponding debugfs file will change the pull to down but the
+ *   reported value will still be 1 until the line is released
+ * - line requested in input mode always reports the same value as its pull
+ *   configuration
+ * - when the line is requested in input mode and monitored for events, writing
+ *   the same value to the debugfs file will be a noop, while writing the
+ *   opposite value will generate a dummy interrupt with an appropriate edge
+ */
+static const struct file_operations gpio_mockup_debugfs_ops = {
 	.owner = THIS_MODULE,
-	.open = gpio_mockup_event_open,
-	.write = gpio_mockup_event_write,
+	.open = gpio_mockup_debugfs_open,
+	.read = gpio_mockup_debugfs_read,
+	.write = gpio_mockup_debugfs_write,
 	.llseek = no_llseek,
 };
 
@@ -258,7 +346,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 		priv->desc = &gc->gpiodev->descs[i];
 
 		evfile = debugfs_create_file(name, 0200, chip->dbg_dir, priv,
-					     &gpio_mockup_event_ops);
+					     &gpio_mockup_debugfs_ops);
 		if (IS_ERR_OR_NULL(evfile))
 			goto err;
 	}
@@ -266,7 +354,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	return;
 
 err:
-	dev_err(dev, "error creating debugfs event files\n");
+	dev_err(dev, "error creating debugfs files\n");
 }
 
 static int gpio_mockup_name_lines(struct device *dev,
@@ -342,6 +430,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	gc->direction_input = gpio_mockup_dirin;
 	gc->get_direction = gpio_mockup_get_direction;
 	gc->to_irq = gpio_mockup_to_irq;
+	gc->free = gpio_mockup_free;
 
 	chip->lines = devm_kcalloc(dev, gc->ngpio,
 				   sizeof(*chip->lines), GFP_KERNEL);
@@ -415,7 +504,7 @@ static int __init gpio_mockup_init(void)
 			return -EINVAL;
 	}
 
-	gpio_mockup_dbg_dir = debugfs_create_dir("gpio-mockup-event", NULL);
+	gpio_mockup_dbg_dir = debugfs_create_dir("gpio-mockup", NULL);
 	if (IS_ERR_OR_NULL(gpio_mockup_dbg_dir))
 		gpio_mockup_err("error creating debugfs directory\n");
 
-- 
2.20.1

