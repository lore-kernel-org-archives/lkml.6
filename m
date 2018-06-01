Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeFAIbd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:31:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:29767 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeFAIbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:31:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,465,1520924400";
   d="scan'208";a="229074686"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] Input: gpio-keys - Switch to bitmap_zalloc()
Date: Fri,  1 Jun 2018 11:31:19 +0300
Message-Id: <20180601083120.40352-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601083120.40352-1-andriy.shevchenko@linux.intel.com>
References: <20180601083120.40352-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/keyboard/gpio_keys.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 052e37675086..492a971b95b5 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -196,7 +196,7 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
 	ssize_t ret;
 	int i;
 
-	bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
+	bits = bitmap_zalloc(n_events, GFP_KERNEL);
 	if (!bits)
 		return -ENOMEM;
 
@@ -216,7 +216,7 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
 	buf[ret++] = '\n';
 	buf[ret] = '\0';
 
-	kfree(bits);
+	bitmap_free(bits);
 
 	return ret;
 }
@@ -240,7 +240,7 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 	ssize_t error;
 	int i;
 
-	bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
+	bits = bitmap_zalloc(n_events, GFP_KERNEL);
 	if (!bits)
 		return -ENOMEM;
 
@@ -284,7 +284,7 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 	mutex_unlock(&ddata->disable_lock);
 
 out:
-	kfree(bits);
+	bitmap_free(bits);
 	return error;
 }
 
-- 
2.17.0
