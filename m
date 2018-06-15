Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 59874C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B61208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B61208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965887AbeFONVL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:21:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:30593 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965760AbeFONUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:20:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 06:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="50163145"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2018 06:20:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7B8D24A2; Fri, 15 Jun 2018 16:20:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
Date:   Fri, 15 Jun 2018 16:20:17 +0300
Message-Id: <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/evdev.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c81c79d01d93..370206f987f9 100644
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
+	mem = bitmap_alloc(maxbit, GFP_KERNEL);
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
2.17.1

