Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B9AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7135420881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697954;
	bh=UaU2v9q9c1g8rto2aM2CQUEMVCf4hkrzL06mthyZTik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tr/5hmrAzDlyb413cNNh2Hx0Uf/xhDvjhy6nKTB6E6kpuR8kTZy8o7O8CfeB4o9TM
	 xJLcPG0EXCPf+M5DBO8eBOlfZqgqoeLwfkNCXzZ61eiLTRHbNRBwX65jlStwt26oaE
	 3RIt1+s0i9RVAnlkarzw4iydTbtcmIksRTLZafXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfA1Rwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:52:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfA1Pnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:43:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547582175B;
        Mon, 28 Jan 2019 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690231;
        bh=UaU2v9q9c1g8rto2aM2CQUEMVCf4hkrzL06mthyZTik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwIYFsnMNgg7q7pbpnppuF/VxtsGqGkyUAHzUdY5ty4XA8G/7ZiLsasgAjuxq3e8+
         uVnninDFZP/7Kr962estvB75qhT7gpijqazb56u9xxt9iUJGCNmyj0ItrqytZE5eSH
         6saUx4M60xzyoIWlqA1YT26m9e6yL4GgickaasWE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Muchun Song <smuchun@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 008/304] gpiolib: Fix possible use after free on label
Date:   Mon, 28 Jan 2019 10:38:45 -0500
Message-Id: <20190128154341.47195-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muchun Song <smuchun@gmail.com>

[ Upstream commit 18534df419041e6c1f4b41af56ee7d41f757815c ]

gpiod_request_commit() copies the pointer to the label passed as
an argument only to be used later. But there's a chance the caller
could immediately free the passed string(e.g., local variable).
This could trigger a use after free when we use gpio label(e.g.,
gpiochip_unlock_as_irq(), gpiochip_is_requested()).

To be on the safe side: duplicate the string with kstrdup_const()
so that if an unaware user passes an address to a stack-allocated
buffer, we won't get the arbitrary label.

Also fix gpiod_set_consumer_name().

Signed-off-by: Muchun Song <smuchun@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c        | 25 +++++++++++++++++++++----
 include/linux/gpio/consumer.h |  6 ++++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a2cbb474901c..33266460e81c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2299,6 +2299,12 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	unsigned long		flags;
 	unsigned		offset;
 
+	if (label) {
+		label = kstrdup_const(label, GFP_KERNEL);
+		if (!label)
+			return -ENOMEM;
+	}
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	/* NOTE:  gpio_request() can be called in early boot,
@@ -2309,6 +2315,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		desc_set_label(desc, label ? : "?");
 		status = 0;
 	} else {
+		kfree_const(label);
 		status = -EBUSY;
 		goto done;
 	}
@@ -2325,6 +2332,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 
 		if (status < 0) {
 			desc_set_label(desc, NULL);
+			kfree_const(label);
 			clear_bit(FLAG_REQUESTED, &desc->flags);
 			goto done;
 		}
@@ -2420,6 +2428,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 			chip->free(chip, gpio_chip_hwgpio(desc));
 			spin_lock_irqsave(&gpio_lock, flags);
 		}
+		kfree_const(desc->label);
 		desc_set_label(desc, NULL);
 		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
 		clear_bit(FLAG_REQUESTED, &desc->flags);
@@ -3375,11 +3384,19 @@ EXPORT_SYMBOL_GPL(gpiod_cansleep);
  * @desc: gpio to set the consumer name on
  * @name: the new consumer name
  */
-void gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
+int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
 {
-	VALIDATE_DESC_VOID(desc);
-	/* Just overwrite whatever the previous name was */
-	desc->label = name;
+	VALIDATE_DESC(desc);
+	if (name) {
+		name = kstrdup_const(name, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+	}
+
+	kfree_const(desc->label);
+	desc_set_label(desc, name);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiod_set_consumer_name);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index f2f887795d43..ed070512b40e 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -162,7 +162,7 @@ int gpiod_is_active_low(const struct gpio_desc *desc);
 int gpiod_cansleep(const struct gpio_desc *desc);
 
 int gpiod_to_irq(const struct gpio_desc *desc);
-void gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
+int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
 
 /* Convert between the old gpio_ and new gpiod_ interfaces */
 struct gpio_desc *gpio_to_desc(unsigned gpio);
@@ -495,10 +495,12 @@ static inline int gpiod_to_irq(const struct gpio_desc *desc)
 	return -EINVAL;
 }
 
-static inline void gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
+static inline int gpiod_set_consumer_name(struct gpio_desc *desc,
+					  const char *name)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(1);
+	return -EINVAL;
 }
 
 static inline struct gpio_desc *gpio_to_desc(unsigned gpio)
-- 
2.19.1

