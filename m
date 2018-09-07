Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE63DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ADD20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ADD20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbeIHCZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbeIHCZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9974EA95;
        Fri,  7 Sep 2018 21:42:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Bernie Thompson <bernie@plugable.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.4 40/47] fb: fix lost console when the user unplugs a USB adapter
Date:   Fri,  7 Sep 2018 23:10:36 +0200
Message-Id: <20180907210908.742052597@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 8c5b044299951acd91e830a688dd920477ea1eda upstream.

I have a USB display adapter using the udlfb driver and I use it on an ARM
board that doesn't have any graphics card. When I plug the adapter in, the
console is properly displayed, however when I unplug and re-plug the
adapter, the console is not displayed and I can't access it until I reboot
the board.

The reason is this:
When the adapter is unplugged, dlfb_usb_disconnect calls
unlink_framebuffer, then it waits until the reference count drops to zero
and then it deallocates the framebuffer. However, the console that is
attached to the framebuffer device keeps the reference count non-zero, so
the framebuffer device is never destroyed. When the USB adapter is plugged
again, it creates a new device /dev/fb1 and the console is not attached to
it.

This patch fixes the bug by unbinding the console from unlink_framebuffer.
The code to unbind the console is moved from do_unregister_framebuffer to
a function unbind_console. When the console is unbound, the reference
count drops to zero and the udlfb driver frees the framebuffer. When the
adapter is plugged back, a new framebuffer is created and the console is
attached to it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Bernie Thompson <bernie@plugable.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: stable@vger.kernel.org
[b.zolnierkie: preserve old behavior for do_unregister_framebuffer()]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/core/fbmem.c |   38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1687,12 +1687,12 @@ static int do_register_framebuffer(struc
 	return 0;
 }
 
-static int do_unregister_framebuffer(struct fb_info *fb_info)
+static int unbind_console(struct fb_info *fb_info)
 {
 	struct fb_event event;
-	int i, ret = 0;
+	int ret;
+	int i = fb_info->node;
 
-	i = fb_info->node;
 	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
 		return -EINVAL;
 
@@ -1707,17 +1707,29 @@ static int do_unregister_framebuffer(str
 	unlock_fb_info(fb_info);
 	console_unlock();
 
+	return ret;
+}
+
+static int __unlink_framebuffer(struct fb_info *fb_info);
+
+static int do_unregister_framebuffer(struct fb_info *fb_info)
+{
+	struct fb_event event;
+	int ret;
+
+	ret = unbind_console(fb_info);
+
 	if (ret)
 		return -EINVAL;
 
 	pm_vt_switch_unregister(fb_info->dev);
 
-	unlink_framebuffer(fb_info);
+	__unlink_framebuffer(fb_info);
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
 	fb_destroy_modelist(&fb_info->modelist);
-	registered_fb[i] = NULL;
+	registered_fb[fb_info->node] = NULL;
 	num_registered_fb--;
 	fb_cleanup_device(fb_info);
 	event.info = fb_info;
@@ -1730,7 +1742,7 @@ static int do_unregister_framebuffer(str
 	return 0;
 }
 
-int unlink_framebuffer(struct fb_info *fb_info)
+static int __unlink_framebuffer(struct fb_info *fb_info)
 {
 	int i;
 
@@ -1742,6 +1754,20 @@ int unlink_framebuffer(struct fb_info *f
 		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 		fb_info->dev = NULL;
 	}
+
+	return 0;
+}
+
+int unlink_framebuffer(struct fb_info *fb_info)
+{
+	int ret;
+
+	ret = __unlink_framebuffer(fb_info);
+	if (ret)
+		return ret;
+
+	unbind_console(fb_info);
+
 	return 0;
 }
 EXPORT_SYMBOL(unlink_framebuffer);


