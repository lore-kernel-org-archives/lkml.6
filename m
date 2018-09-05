Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133462075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133462075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeIENwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:52:51 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:58218 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIENwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:52:50 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id XlPU1y00K3XaVaC01lPUyE; Wed, 05 Sep 2018 11:23:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fxU24-0006p3-EA; Wed, 05 Sep 2018 11:23:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fxTlB-0002aS-3x; Wed, 05 Sep 2018 11:06:01 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] gpio: Propagate errors from gpiod_set_array_value_complex()
Date:   Wed,  5 Sep 2018 11:05:54 +0200
Message-Id: <20180905090555.9888-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905090555.9888-1-geert+renesas@glider.be>
References: <20180905090555.9888-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal helper function gpiod_set_array_value_complex() was changed to
return an error value, but not all gpiolib callers were updated to
propagate the new error up.

Fixes: 3027743f83f867d8 ("gpio: Remove VLA from gpiolib")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/driver-api/gpio/consumer.rst | 12 ++++++------
 drivers/gpio/gpiolib.c                     | 22 +++++++++++-----------
 include/linux/gpio/consumer.h              | 20 +++++++++++---------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index a4e340c1859439ad..c7302c7e0f858995 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -334,15 +334,15 @@ The following functions get or set the values of an array of GPIOs::
 					   struct gpio_desc **desc_array,
 					   int *value_array);
 
-	void gpiod_set_array_value(unsigned int array_size,
-				   struct gpio_desc **desc_array,
-				   int *value_array)
+	int gpiod_set_array_value(unsigned int array_size,
+				  struct gpio_desc **desc_array,
+				  int *value_array)
 	int gpiod_set_raw_array_value(unsigned int array_size,
 				      struct gpio_desc **desc_array,
 				      int *value_array)
-	void gpiod_set_array_value_cansleep(unsigned int array_size,
-					    struct gpio_desc **desc_array,
-					    int *value_array)
+	int gpiod_set_array_value_cansleep(unsigned int array_size,
+					   struct gpio_desc **desc_array,
+					   int *value_array)
 	int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					       struct gpio_desc **desc_array,
 					       int *value_array)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8f8a199939350a9..b8486e204b9e8c69 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3184,13 +3184,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
  * This function should be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
  */
-void gpiod_set_array_value(unsigned int array_size,
-			   struct gpio_desc **desc_array, int *value_array)
+int gpiod_set_array_value(unsigned int array_size,
+			  struct gpio_desc **desc_array, int *value_array)
 {
 	if (!desc_array)
-		return;
-	gpiod_set_array_value_complex(false, false, array_size, desc_array,
-				      value_array);
+		return -EINVAL;
+	return gpiod_set_array_value_complex(false, false, array_size,
+					     desc_array, value_array);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value);
 
@@ -3542,15 +3542,15 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
  *
  * This function is to be called from contexts that can sleep.
  */
-void gpiod_set_array_value_cansleep(unsigned int array_size,
-				    struct gpio_desc **desc_array,
-				    int *value_array)
+int gpiod_set_array_value_cansleep(unsigned int array_size,
+				   struct gpio_desc **desc_array,
+				   int *value_array)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
-		return;
-	gpiod_set_array_value_complex(false, true, array_size, desc_array,
-				      value_array);
+		return -EINVAL;
+	return gpiod_set_array_value_complex(false, true, array_size,
+					     desc_array, value_array);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 21ddbe4400308ee5..54ca52f67e8cf38b 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -106,8 +106,8 @@ int gpiod_get_value(const struct gpio_desc *desc);
 int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array, int *value_array);
 void gpiod_set_value(struct gpio_desc *desc, int value);
-void gpiod_set_array_value(unsigned int array_size,
-			   struct gpio_desc **desc_array, int *value_array);
+int gpiod_set_array_value(unsigned int array_size,
+			  struct gpio_desc **desc_array, int *value_array);
 int gpiod_get_raw_value(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
@@ -123,9 +123,9 @@ int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
 				   int *value_array);
 void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
-void gpiod_set_array_value_cansleep(unsigned int array_size,
-				    struct gpio_desc **desc_array,
-				    int *value_array);
+int gpiod_set_array_value_cansleep(unsigned int array_size,
+				   struct gpio_desc **desc_array,
+				   int *value_array);
 int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
@@ -341,12 +341,13 @@ static inline void gpiod_set_value(struct gpio_desc *desc, int value)
 	/* GPIO can never have been requested */
 	WARN_ON(1);
 }
-static inline void gpiod_set_array_value(unsigned int array_size,
-					 struct gpio_desc **desc_array,
-					 int *value_array)
+static inline int gpiod_set_array_value(unsigned int array_size,
+					struct gpio_desc **desc_array,
+					int *value_array)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(1);
+	return 0;
 }
 static inline int gpiod_get_raw_value(const struct gpio_desc *desc)
 {
@@ -395,12 +396,13 @@ static inline void gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
 	/* GPIO can never have been requested */
 	WARN_ON(1);
 }
-static inline void gpiod_set_array_value_cansleep(unsigned int array_size,
+static inline int gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
 					    int *value_array)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(1);
+	return 0;
 }
 static inline int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc)
 {
-- 
2.17.1

