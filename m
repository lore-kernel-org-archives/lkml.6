Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388F9C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED73D20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED73D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeLIWJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37408 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728075AbeLIWJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:13 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002ik-KP; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003GW-1W; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Bernie Thompson" <bernie@plugable.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Dave Airlie" <airlied@redhat.com>,
        "Ladislav Michl" <ladis@linux-mips.org>,
        "Mikulas Patocka" <mpatocka@redhat.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.894408828@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 055/328] fb: fix lost console when the user unplugs a
 USB adapter
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
[b.zolnierkie: preserve old behavior for do_unregister_framebuffer()]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/core/fbmem.c | 38 +++++++++++++++++++++++++++-----
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

