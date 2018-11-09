Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA36CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F74D20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F74D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeKJGHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:07:33 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37656 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeKJGHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:07:33 -0500
Received: from localhost.localdomain (unknown [85.140.188.106])
        by mail.ispras.ru (Postfix) with ESMTPSA id 438155400FB;
        Fri,  9 Nov 2018 23:25:20 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Bernie Thompson <bernie@plugable.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] udlfb: fix NULL pointer dereference in dlfb_usb_probe()
Date:   Fri,  9 Nov 2018 23:25:10 +0300
Message-Id: <1541795110-3179-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If memory allocation for dlfb fails, error handling code
unconditionally dereference NULL pointer.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 68a958a915ca ("udlfb: handle unplug properly")
---
 drivers/video/fbdev/udlfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 070026a7e55a..9643fe7c8349 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1590,7 +1590,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 	int i;
 	const struct device_attribute *attr;
 	struct dlfb_data *dlfb;
-	struct fb_info *info;
+	struct fb_info *info = NULL;
 	int retval = -ENOMEM;
 	struct usb_device *usbdev = interface_to_usbdev(intf);
 
@@ -1701,8 +1701,8 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 	return 0;
 
 error:
-	if (dlfb->info) {
-		dlfb_ops_destroy(dlfb->info);
+	if (info) {
+		dlfb_ops_destroy(info);
 	} else if (dlfb) {
 		usb_put_dev(dlfb->udev);
 		kfree(dlfb);
-- 
2.7.4

