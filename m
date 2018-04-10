Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDJOOR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:14:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46418 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbeDJOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:14:16 -0400
X-Google-Smtp-Source: AIpwx4/yfgN1gSry5nA0ao193ZtTh0FhHK8oSPXOVIn1170fRmDYzf+zyLD6++VAwgFPzFgpfHnZAQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: inaky.perez-gonzalez@intel.com
Cc: linux-wimax@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: wimax: i2400m: Replace GFP_ATOMIC with GFP_KERNEL in i2400m_tx_setup
Date: Tue, 10 Apr 2018 22:14:07 +0800
Message-Id: <1523369647-32271-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2400m_tx_setup() is never called in atomic context.

The call chains ending up at i2400m_tx_setup() are:
[1] i2400m_tx_setup() <- __i2400m_dev_start() <- 
	__i2400m_dev_reset_handle()
[2] i2400m_tx_setup() <- __i2400m_dev_start() <- i2400m_dev_start() <- 
	i2400m_setup() <- i2400mu_probe()
[3] i2400m_tx_setup() <- __i2400m_dev_start() <- i2400m_post_reset() <- 
	i2400mu_post_reset()

__i2400m_dev_reset_handle() is only set as a parameter of INIT_WORK() in 
i2400m_init().
i2400mu_probe() is only set as ".probe" in struct usb_driver.
i2400mu_post_reset() is only set as ".post_reset" in struct usb_driver.
These functions are not called in atomic context.

Despite never getting called from atomic context,
i2400m_tx_setup() calls kmalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/wimax/i2400m/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/tx.c b/drivers/net/wimax/i2400m/tx.c
index f20886a..cfbc187 100644
--- a/drivers/net/wimax/i2400m/tx.c
+++ b/drivers/net/wimax/i2400m/tx.c
@@ -973,7 +973,7 @@ int i2400m_tx_setup(struct i2400m *i2400m)
 	 * the WS was scheduled on another CPU */
 	INIT_WORK(&i2400m->wake_tx_ws, i2400m_wake_tx_work);
 
-	tx_buf = kmalloc(I2400M_TX_BUF_SIZE, GFP_ATOMIC);
+	tx_buf = kmalloc(I2400M_TX_BUF_SIZE, GFP_KERNEL);
 	if (tx_buf == NULL) {
 		result = -ENOMEM;
 		goto error_kmalloc;
-- 
1.9.1
