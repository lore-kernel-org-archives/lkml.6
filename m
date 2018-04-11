Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDKCOT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:14:19 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36035 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeDKCOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:14:17 -0400
X-Google-Smtp-Source: AIpwx4/RO2oGsj6muOFwt+IZJD2PpWnASRl86lkkzPupXWWaEesXk42HiyGG/B8tO2qpSk7kyYNejg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: stefan@osg.samsung.com, alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: ieee802154: atusb: Replace GFP_ATOMIC with GFP_KERNEL in atusb_probe
Date: Wed, 11 Apr 2018 10:14:10 +0800
Message-Id: <1523412850-2260-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atusb_probe() is never called in atomic context.
This function is only set as ".probe" in struct usb_driver.

Despite never getting called from atomic context,
atusb_probe() calls usb_alloc_urb() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ieee802154/atusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index ef68851..ab6a505 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -789,7 +789,7 @@ static int atusb_probe(struct usb_interface *interface,
 	atusb->tx_dr.bRequest = ATUSB_TX;
 	atusb->tx_dr.wValue = cpu_to_le16(0);
 
-	atusb->tx_urb = usb_alloc_urb(0, GFP_ATOMIC);
+	atusb->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!atusb->tx_urb)
 		goto fail;
 
-- 
1.9.1
