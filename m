Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754544AbeCROwB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 10:52:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42330 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbeCROwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 10:52:00 -0400
X-Google-Smtp-Source: AG47ELvERIGnL/5UNQL2MtYjp7UbuzD+IH6ZzkVa1g1kR0YDW7rTP0hYcptaSfjLD9dDPIeKRhqk9g==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/3] sound: usb: line6: Replace mdelay with msleep in line6_write_data
Date: Sun, 18 Mar 2018 22:51:59 +0800
Message-Id: <1521384719-23423-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

line6_write_data() is never called in atomic context.

The call chains ending up at line6_write_data() are:
[1] line6_write_data() <- toneport_setup() <- toneport_init() 
	<- line6_probe()
[2] line6_write_data() <- toneport_setup() <- toneport_reset_resume()

line6_probe() is called in toneport_probe(), pod_probe(), podhd_probe() 
and variax_probe(), which are set as ".probe" in usb_driver structure.
toneport_reset_resume() is set as ".reset_resume" in usb_driver structure.
These functions are not called in atomic context.

Despite never getting called from atomic context, line6_write_data()
calls mdelay for busy wait.
That is not necessary and can be replaced with msleep to 
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/usb/line6/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 0ff5a7d..29acd86 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -426,7 +426,7 @@ int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
 	}
 
 	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
-		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
+		msleep(LINE6_READ_WRITE_STATUS_DELAY);
 
 		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
 				      0x67,
-- 
1.9.1
