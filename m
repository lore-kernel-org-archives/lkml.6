Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C583C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CACA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CACA2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbeIHC2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbeIHC2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:46 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 450051007;
        Fri,  7 Sep 2018 21:45:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.18 123/145] udlfb: dont switch if we are switching to the same videomode
Date:   Fri,  7 Sep 2018 23:09:49 +0200
Message-Id: <20180907210913.177920077@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 564f1807379298dfdb12ed0d5b25fcb89c238527 upstream.

The udlfb driver reprograms the hardware everytime the user switches the
console, that makes quite unusable when working on the console.

This patch makes the driver remember the videomode we are in and avoid
reprogramming the hardware if we switch to the same videomode.

We mask the "activate" field and the "FB_VMODE_SMOOTH_XPAN" flag when
comparing the videomode, because they cause spurious switches when
switching to and from the Xserver.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/udlfb.c |   18 ++++++++++++++++--
 include/video/udlfb.h       |    1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1041,10 +1041,24 @@ static int dlfb_ops_set_par(struct fb_in
 	int result;
 	u16 *pix_framebuffer;
 	int i;
+	struct fb_var_screeninfo fvs;
+
+	/* clear the activate field because it causes spurious miscompares */
+	fvs = info->var;
+	fvs.activate = 0;
+	fvs.vmode &= ~FB_VMODE_SMOOTH_XPAN;
+
+	if (!memcmp(&dlfb->current_mode, &fvs, sizeof(struct fb_var_screeninfo)))
+		return 0;
 
 	result = dlfb_set_video_mode(dlfb, &info->var);
 
-	if ((result == 0) && (dlfb->fb_count == 0)) {
+	if (result)
+		return result;
+
+	dlfb->current_mode = fvs;
+
+	if (dlfb->fb_count == 0) {
 
 		/* paint greenscreen */
 
@@ -1056,7 +1070,7 @@ static int dlfb_ops_set_par(struct fb_in
 				   info->screen_base);
 	}
 
-	return result;
+	return 0;
 }
 
 /* To fonzi the jukebox (e.g. make blanking changes take effect) */
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -56,6 +56,7 @@ struct dlfb_data {
 	atomic_t bytes_identical; /* saved effort with backbuffer comparison */
 	atomic_t bytes_sent; /* to usb, after compression including overhead */
 	atomic_t cpu_kcycles_used; /* transpired during pixel processing */
+	struct fb_var_screeninfo current_mode;
 };
 
 #define NR_USB_REQUEST_I2C_SUB_IO 0x02


