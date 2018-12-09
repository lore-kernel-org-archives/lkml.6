Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3532BC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E8020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E8020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeLIWIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:08:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37322 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727992AbeLIWIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:08:18 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002il-Go; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003Gb-2L; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ladislav Michl" <ladis@linux-mips.org>,
        "Bernie Thompson" <bernie@plugable.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.773209576@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 056/328] video: udlfb: Remove noisy warnings
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

From: Ladislav Michl <ladis@linux-mips.org>

commit de4b74bda8e87a4ed45ebc2c26cc3e2eaae38429 upstream.

These warnings comes from times of driver development and do
not carry any usefull debugging information.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Cc: Bernie Thompson <bernie@plugable.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/udlfb.c | 20 --------------------
 1 file changed, 20 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -924,11 +924,7 @@ static void dlfb_free(struct kref *kref)
 
 	if (dev->backing_buffer)
 		vfree(dev->backing_buffer);
-
 	kfree(dev->edid);
-
-	pr_warn("freeing dlfb_data %p\n", dev);
-
 	kfree(dev);
 }
 
@@ -945,8 +941,6 @@ static void dlfb_free_framebuffer(struct
 	struct fb_info *info = dev->info;
 
 	if (info) {
-		int node = info->node;
-
 		unregister_framebuffer(info);
 
 		if (info->cmap.len != 0)
@@ -962,8 +956,6 @@ static void dlfb_free_framebuffer(struct
 
 		/* Assume info structure is freed after this point */
 		framebuffer_release(info);
-
-		pr_warn("fb_info for /dev/fb%d has been freed\n", node);
 	}
 
 	/* ref taken in probe() as part of registering framebfufer */
@@ -1064,8 +1056,6 @@ static int dlfb_ops_set_par(struct fb_in
 	u16 *pix_framebuffer;
 	int i;
 
-	pr_notice("set_par mode %dx%d\n", info->var.xres, info->var.yres);
-
 	result = dlfb_set_video_mode(dev, &info->var);
 
 	if ((result == 0) && (dev->fb_count == 0)) {
@@ -1168,8 +1158,6 @@ static int dlfb_realloc_framebuffer(stru
 	unsigned char *new_fb;
 	unsigned char *new_back = NULL;
 
-	pr_warn("Reallocating framebuffer. Addresses will change!\n");
-
 	new_len = info->fix.line_length * info->var.yres;
 
 	if (PAGE_ALIGN(new_len) > old_len) {
@@ -1420,9 +1408,6 @@ static ssize_t edid_show(
 	if (off + count > dev->edid_size)
 		count = dev->edid_size - off;
 
-	pr_info("sysfs edid copy %p to %p, %d bytes\n",
-		dev->edid, buf, (int) count);
-
 	memcpy(buf, dev->edid, count);
 
 	return count;
@@ -1448,7 +1433,6 @@ static ssize_t edid_store(
 	if (!dev->edid || memcmp(src, dev->edid, src_size))
 		return -EINVAL;
 
-	pr_info("sysfs written EDID is new default\n");
 	dlfb_ops_set_par(fb_info);
 	return src_size;
 }
@@ -1831,8 +1815,6 @@ static void dlfb_free_urb_list(struct dl
 	int ret;
 	unsigned long flags;
 
-	pr_notice("Freeing all render urbs\n");
-
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
 
@@ -1911,8 +1893,6 @@ static int dlfb_alloc_urb_list(struct dl
 	dev->urbs.count = i;
 	dev->urbs.available = i;
 
-	pr_notice("allocated %d %d byte urbs\n", i, (int) size);
-
 	return i;
 }
 

