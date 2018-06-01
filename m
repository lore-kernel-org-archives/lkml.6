Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbeFAIbg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:31:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:31731 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbeFAIbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:31:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,465,1520924400";
   d="scan'208";a="45607095"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] Input: evdev - Switch to bitmap_zalloc()
Date: Fri,  1 Jun 2018 11:31:20 +0300
Message-Id: <20180601083120.40352-3-andriy.shevchenko@linux.intel.com>
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
 drivers/input/evdev.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c81c79d01d93..3f87ef973bc7 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -481,7 +481,7 @@ static int evdev_release(struct inode *inode, struct file *file)
 	evdev_detach_client(evdev, client);
 
 	for (i = 0; i < EV_CNT; ++i)
-		kfree(client->evmasks[i]);
+		bitmap_free(client->evmasks[i]);
 
 	kvfree(client);
 
@@ -925,17 +925,15 @@ static int evdev_handle_get_val(struct evdev_client *client,
 {
 	int ret;
 	unsigned long *mem;
-	size_t len;
 
-	len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
-	mem = kmalloc(len, GFP_KERNEL);
+	mem = bitmap_malloc(maxbit, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
 
 	spin_lock_irq(&dev->event_lock);
 	spin_lock(&client->buffer_lock);
 
-	memcpy(mem, bits, len);
+	bitmap_copy(mem, bits, maxbit);
 
 	spin_unlock(&dev->event_lock);
 
@@ -947,7 +945,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
 	if (ret < 0)
 		evdev_queue_syn_dropped(client);
 
-	kfree(mem);
+	bitmap_free(mem);
 
 	return ret;
 }
@@ -1003,13 +1001,13 @@ static int evdev_set_mask(struct evdev_client *client,
 	if (!cnt)
 		return 0;
 
-	mask = kcalloc(sizeof(unsigned long), BITS_TO_LONGS(cnt), GFP_KERNEL);
+	mask = bitmap_zalloc(cnt, GFP_KERNEL);
 	if (!mask)
 		return -ENOMEM;
 
 	error = bits_from_user(mask, cnt - 1, codes_size, codes, compat);
 	if (error < 0) {
-		kfree(mask);
+		bitmap_free(mask);
 		return error;
 	}
 
@@ -1018,7 +1016,7 @@ static int evdev_set_mask(struct evdev_client *client,
 	client->evmasks[type] = mask;
 	spin_unlock_irqrestore(&client->buffer_lock, flags);
 
-	kfree(oldmask);
+	bitmap_free(oldmask);
 
 	return 0;
 }
-- 
2.17.0
