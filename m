Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CF0C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1237520838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895970;
	bh=+id0EtMXuFTnS8eRCI4jBFvXLd6scc8WoqwYmjnB750=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pkmC/m7/P4GLFgsy8JE3Hif6txg1X//jqWqZGkEWWXVx1QvXjevdr3cLZZJv+Ybah
	 fRH3dGu83R2CSsHl0oSJB9yd3ueWfGEC0W6vD4aRt6NtxGhB3IOOmjlhHc5C7J8nyf
	 PlzNuqU0c04PUEnCqa7Bm3hLZh6jXvx4BJM7Uqc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbfBKOjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731851AbfBKOjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34CC2081B;
        Mon, 11 Feb 2019 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895959;
        bh=+id0EtMXuFTnS8eRCI4jBFvXLd6scc8WoqwYmjnB750=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItNE7XGb50juYJ5D4IXXEt1YJCj2pmO+fjYFCkdFP+N/+Tg9w6ld99EJw3bEYCchM
         5qJOJe6KEXQjXtBLs8bMRIUXBMwGBGJDJpLvkaACCJpG3c8oIpNTsV9UvSu8QJhBSA
         aDD+hmeDcUryR85PqBK8/22hqPvtOHoK5xV4XwmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Muchun Song <smuchun@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 007/313] gpiolib: Fix possible use after free on label
Date:   Mon, 11 Feb 2019 15:14:47 +0100
Message-Id: <20190211141853.348441595@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b3ab6c428423..fd713326dcfc 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2279,6 +2279,12 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
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
@@ -2289,6 +2295,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		desc_set_label(desc, label ? : "?");
 		status = 0;
 	} else {
+		kfree_const(label);
 		status = -EBUSY;
 		goto done;
 	}
@@ -2305,6 +2312,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 
 		if (status < 0) {
 			desc_set_label(desc, NULL);
+			kfree_const(label);
 			clear_bit(FLAG_REQUESTED, &desc->flags);
 			goto done;
 		}
@@ -2400,6 +2408,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 			chip->free(chip, gpio_chip_hwgpio(desc));
 			spin_lock_irqsave(&gpio_lock, flags);
 		}
+		kfree_const(desc->label);
 		desc_set_label(desc, NULL);
 		clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
 		clear_bit(FLAG_REQUESTED, &desc->flags);
@@ -3221,11 +3230,19 @@ EXPORT_SYMBOL_GPL(gpiod_cansleep);
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
index 21ddbe440030..acc4279ad5e3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -142,7 +142,7 @@ int gpiod_is_active_low(const struct gpio_desc *desc);
 int gpiod_cansleep(const struct gpio_desc *desc);
 
 int gpiod_to_irq(const struct gpio_desc *desc);
-void gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
+int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
 
 /* Convert between the old gpio_ and new gpiod_ interfaces */
 struct gpio_desc *gpio_to_desc(unsigned gpio);
@@ -465,10 +465,12 @@ static inline int gpiod_to_irq(const struct gpio_desc *desc)
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



