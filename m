Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754510AbeCROvl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 10:51:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42923 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbeCROvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 10:51:39 -0400
X-Google-Smtp-Source: AG47ELtaJEjYk7h9isKhaOOcZ+A03wGlqxtqmBsLceSFpSnjiXvgu/ywSqwJmDOZil/xqdJtZ9C7ug==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/3] sound: usb: line6: Replace mdelay with msleep in line6_read_data
Date: Sun, 18 Mar 2018 22:51:33 +0800
Message-Id: <1521384693-23336-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

line6_read_data() is never called in atomic context.

The call chains ending up at line6_read_data() are:
[1] line6_read_data() <- line6_read_serial_number() -> pod_startup4()
[2] line6_read_data() <- line6_read_serial_number() <- 
	podhd_startup_workqueue()
[3] line6_read_data() <- podhd_dev_start() <- podhd_startup_workqueue()
[4] line6_read_data() <- line6_read_serial_number() <- toneport_init()
	<- line6_probe()
[5] line6_read_data() <- toneport_init() <- line6_probe()

pod_startup4() and podhd_startup_workqueue() are set in INIT_WORK().
line6_probe() is called in toneport_probe(), pod_probe(), podhd_probe() 
and variax_probe(), which are set as ".probe" in usb_driver structure.
These functions are not called in atomic context.

Despite never getting called from atomic context, line6_read_data()
calls mdelay for busy wait.
That is not necessary and can be replaced with msleep to 
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/usb/line6/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 0ff5a7d..af99e73 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -356,7 +356,7 @@ int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
 
 	/* Wait for data length. We'll get 0xff until length arrives. */
 	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
-		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
+		msleep(LINE6_READ_WRITE_STATUS_DELAY);
 
 		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
 				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
-- 
1.9.1
