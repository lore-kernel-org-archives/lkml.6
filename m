Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97941C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D845215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D845215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeI0R4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:56:08 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:51976 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeI0R4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:56:07 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id gbeE1y00T3XaVaC01beEgw; Thu, 27 Sep 2018 13:38:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g5UcY-0001V3-Hx; Thu, 27 Sep 2018 13:38:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g5UcY-00080P-Gq; Thu, 27 Sep 2018 13:38:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Laura Abbott <labbott@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/3] gpio: Propagate errors from gpiod_set_array_value_complex()
Date:   Thu, 27 Sep 2018 13:38:09 +0200
Message-Id: <20180927113810.30721-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927113810.30721-1-geert+renesas@glider.be>
References: <20180927113810.30721-1-geert+renesas@glider.be>
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
v2:
  - Rebase on top of gpio array rework.
---
 Documentation/driver-api/gpio/consumer.rst | 16 ++++++------
 drivers/gpio/gpiolib.c                     | 30 ++++++++++++----------
 include/linux/gpio/consumer.h              | 28 ++++++++++----------
 3 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index ba4973829faef238..5e4d8aa68913529c 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -340,18 +340,18 @@ The following functions get or set the values of an array of GPIOs::
 					   struct gpio_array *array_info,
 					   unsigned long *value_bitmap);
 
-	void gpiod_set_array_value(unsigned int array_size,
-				   struct gpio_desc **desc_array,
-				   struct gpio_array *array_info,
-				   unsigned long *value_bitmap)
+	int gpiod_set_array_value(unsigned int array_size,
+				  struct gpio_desc **desc_array,
+				  struct gpio_array *array_info,
+				  unsigned long *value_bitmap)
 	int gpiod_set_raw_array_value(unsigned int array_size,
 				      struct gpio_desc **desc_array,
 				      struct gpio_array *array_info,
 				      unsigned long *value_bitmap)
-	void gpiod_set_array_value_cansleep(unsigned int array_size,
-					    struct gpio_desc **desc_array,
-					    struct gpio_array *array_info,
-					    unsigned long *value_bitmap)
+	int gpiod_set_array_value_cansleep(unsigned int array_size,
+					   struct gpio_desc **desc_array,
+					   struct gpio_array *array_info,
+					   unsigned long *value_bitmap)
 	int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					       struct gpio_desc **desc_array,
 					       struct gpio_array *array_info,
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a53d17745d210480..843a8075ac437d57 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3306,15 +3306,16 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
  * This function should be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
  */
-void gpiod_set_array_value(unsigned int array_size,
-			   struct gpio_desc **desc_array,
-			   struct gpio_array *array_info,
-			   unsigned long *value_bitmap)
+int gpiod_set_array_value(unsigned int array_size,
+			  struct gpio_desc **desc_array,
+			  struct gpio_array *array_info,
+			  unsigned long *value_bitmap)
 {
 	if (!desc_array)
-		return;
-	gpiod_set_array_value_complex(false, false, array_size, desc_array,
-				      array_info, value_bitmap);
+		return -EINVAL;
+	return gpiod_set_array_value_complex(false, false, array_size,
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value);
 
@@ -3723,16 +3724,17 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
  *
  * This function is to be called from contexts that can sleep.
  */
-void gpiod_set_array_value_cansleep(unsigned int array_size,
-				    struct gpio_desc **desc_array,
-				    struct gpio_array *array_info,
-				    unsigned long *value_bitmap)
+int gpiod_set_array_value_cansleep(unsigned int array_size,
+				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
+				   unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
-		return;
-	gpiod_set_array_value_complex(false, true, array_size, desc_array,
-				      array_info, value_bitmap);
+		return -EINVAL;
+	return gpiod_set_array_value_complex(false, true, array_size,
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index d7fbe30ece849cd7..136aeca37740decf 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -117,10 +117,10 @@ int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_array *array_info,
 			  unsigned long *value_bitmap);
 void gpiod_set_value(struct gpio_desc *desc, int value);
-void gpiod_set_array_value(unsigned int array_size,
-			   struct gpio_desc **desc_array,
-			   struct gpio_array *array_info,
-			   unsigned long *value_bitmap);
+int gpiod_set_array_value(unsigned int array_size,
+			  struct gpio_desc **desc_array,
+			  struct gpio_array *array_info,
+			  unsigned long *value_bitmap);
 int gpiod_get_raw_value(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
@@ -139,10 +139,10 @@ int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap);
 void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
-void gpiod_set_array_value_cansleep(unsigned int array_size,
-				    struct gpio_desc **desc_array,
-				    struct gpio_array *array_info,
-				    unsigned long *value_bitmap);
+int gpiod_set_array_value_cansleep(unsigned int array_size,
+				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
+				   unsigned long *value_bitmap);
 int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
@@ -361,13 +361,14 @@ static inline void gpiod_set_value(struct gpio_desc *desc, int value)
 	/* GPIO can never have been requested */
 	WARN_ON(1);
 }
-static inline void gpiod_set_array_value(unsigned int array_size,
-					 struct gpio_desc **desc_array,
-					 struct gpio_array *array_info,
-					 unsigned long *value_bitmap)
+static inline int gpiod_set_array_value(unsigned int array_size,
+					struct gpio_desc **desc_array,
+					struct gpio_array *array_info,
+					unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(1);
+	return 0;
 }
 static inline int gpiod_get_raw_value(const struct gpio_desc *desc)
 {
@@ -419,13 +420,14 @@ static inline void gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
 	/* GPIO can never have been requested */
 	WARN_ON(1);
 }
-static inline void gpiod_set_array_value_cansleep(unsigned int array_size,
+static inline int gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
 					    struct gpio_array *array_info,
 					    unsigned long *value_bitmap)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(1);
+	return 0;
 }
 static inline int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc)
 {
-- 
2.17.1

