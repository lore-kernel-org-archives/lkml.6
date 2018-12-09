Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270D3C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2E320661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2E320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeLIWNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:13:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37924 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726500AbeLIWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:13:32 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73N-0002ih-Mu; Sun, 09 Dec 2018 21:55:57 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003Gv-7D; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mikulas Patocka" <mpatocka@redhat.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.915146703@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 060/328] udlfb: don't switch if we are switching to
 the same videomode
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

commit 564f1807379298dfdb12ed0d5b25fcb89c238527 upstream.

The udlfb driver reprograms the hardware everytime the user switches the
console, that makes quite unusable when working on the console.

This patch makes the driver remember the videomode we are in and avoid
reprogramming the hardware if we switch to the same videomode.

We mask the "activate" field and the "FB_VMODE_SMOOTH_XPAN" flag when
comparing the videomode, because they cause spurious switches when
switching to and from the Xserver.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[bwh: Backported to 3.16: Pointer to struct dlfb_data is named "dev" rather
 than "dlfb"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/udlfb.c | 18 ++++++++++++++++--
 include/video/udlfb.h       |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1057,10 +1057,24 @@ static int dlfb_ops_set_par(struct fb_in
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
+	if (!memcmp(&dev->current_mode, &fvs, sizeof(struct fb_var_screeninfo)))
+		return 0;
 
 	result = dlfb_set_video_mode(dev, &info->var);
 
-	if ((result == 0) && (dev->fb_count == 0)) {
+	if (result)
+		return result;
+
+	dev->current_mode = fvs;
+
+	if (dev->fb_count == 0) {
 
 		/* paint greenscreen */
 
@@ -1072,7 +1086,7 @@ static int dlfb_ops_set_par(struct fb_in
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

