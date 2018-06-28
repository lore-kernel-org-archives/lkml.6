Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5780C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708FE24CB4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bSIpnobd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708FE24CB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeF1Q2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:28:51 -0400
Received: from smtpbg298.qq.com ([184.105.67.102]:32990 "EHLO smtpbg298.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753040AbeF1Q2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:28:50 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 12:28:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1530203328;
        bh=bZYI38z6ho5xlx54PgTehgQhbrnBKv64KAJMQs/bC6U=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=bSIpnobdMwmaaW4OlVrFxm+esZ4fVuRbCKXKwR1LBNrMVCa4gzX1rYRxvfGJ8pDZn
         eldvAc5/adwfxhve6tRrpNGGTkaX2M8o52X3UlFgSNk3c6OOI8pLB++7H4psMBBTFe
         a/lR3T/YPVfAq0gqllgJM4q5/GrProlfjvZJ5D/A=
X-QQ-mid: esmtp2t1530202816t5wlg9qx2
Received: from localhost.localdomain (unknown [218.72.0.54])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 29 Jun 2018 00:20:15 +0800 (CST)
X-QQ-SSF: B100000000000070FG120000000000V
X-QQ-FEAT: p/Y2uUKTrsyRzbCDfHn7YaZUTirfsgL8pGJW2wMGpMkWy5vI3s3wtQHiTb7nF
        505zIGfUMUtPjixwKcgZgOXHFnPntdzakDf0XO8svUour7JY7taRhE7KoMGJbHHDSNh5WSb
        tqFfftd0rQJsnkBJ5nJv9OQaucqlcCZ4FLc3wNzkGoh7xrFFLwanJqc5ZrOXFURgPYs+ow7
        +JGYy3o90tgJ0d5YzKI7sFiu10PA1nonwlTyUV2lb0hcKzMBKKdNDMfxja+OKVQjROXU0JC
        6hjMaIVXdJ4xBSWaRdqmMw1llixs6zgpW7dA==
X-QQ-GoodBg: 0
From:   Yisheng Xie <ysxie@foxmail.com>
To:     b.zolnierkie@samsung.com, keescook@chromium.org,
        j.w.r.degoede@gmail.com, david@lechnology.com
Cc:     andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yisheng Xie <ysxie@foxmail.com>
Subject: [PATCH] fbcon: introduce for_each_registered_fb() helper
Date:   Fri, 29 Jun 2018 00:20:09 +0800
Message-Id: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
X-QQ-FName: A1FFDC7A76AE4C82BE4DF7BD98E76F79
X-QQ-LocalIP: 10.208.130.95
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following pattern is often used:

 for (i = 0; i < FB_MAX; i++) {
        if (registered_fb[i]) {
                ...
        }
 }

Therefore, as Andy's suggestion, for_each_registered_fb() helper can
be introduced to make the code easier to read and write by reducing
indentation level. It also saves few lines of code in each occurrence.

This patch convert all part here at the same time.

Signed-off-by: Yisheng Xie <ysxie@foxmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 25 +++++++++----------------
 drivers/video/fbdev/core/fbmem.c |  4 +---
 include/linux/fb.h               |  4 ++++
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c910e74..610853d 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2220,8 +2220,8 @@ static int fbcon_switch(struct vc_data *vc)
 	 *
 	 * info->currcon = vc->vc_num;
 	 */
-	for (i = 0; i < FB_MAX; i++) {
-		if (registered_fb[i] != NULL && registered_fb[i]->fbcon_par) {
+	for_each_registered_fb(i) {
+		if (registered_fb[i]->fbcon_par) {
 			struct fbcon_ops *o = registered_fb[i]->fbcon_par;
 
 			o->currcon = vc->vc_num;
@@ -3103,11 +3103,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 	if (idx == info_idx) {
 		info_idx = -1;
 
-		for (i = 0; i < FB_MAX; i++) {
-			if (registered_fb[i] != NULL) {
-				info_idx = i;
-				break;
-			}
+		for_each_registered_fb(i) {
+			info_idx = i;
+			break;
 		}
 	}
 
@@ -3562,11 +3560,9 @@ static void fbcon_start(void)
 
 		console_lock();
 
-		for (i = 0; i < FB_MAX; i++) {
-			if (registered_fb[i] != NULL) {
-				info_idx = i;
-				break;
-			}
+		for_each_registered_fb(i) {
+			info_idx = i;
+			break;
 		}
 
 		do_fbcon_takeover(0);
@@ -3586,15 +3582,12 @@ static void fbcon_exit(void)
 	kfree((void *)softback_buf);
 	softback_buf = 0UL;
 
-	for (i = 0; i < FB_MAX; i++) {
+	for_each_registered_fb(i) {
 		int pending = 0;
 
 		mapped = 0;
 		info = registered_fb[i];
 
-		if (info == NULL)
-			continue;
-
 		if (info->queue.func)
 			pending = cancel_work_sync(&info->queue);
 		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 609438d..645c6ac 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1593,10 +1593,8 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
 	int i, ret;
 
 	/* check all firmware fbs and kick off if the base addr overlaps */
-	for (i = 0 ; i < FB_MAX; i++) {
+	for_each_registered_fb(i) {
 		struct apertures_struct *gen_aper;
-		if (!registered_fb[i])
-			continue;
 
 		if (!(registered_fb[i]->flags & FBINFO_MISC_FIRMWARE))
 			continue;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index aa74a22..3e13b95 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -650,6 +650,10 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 extern int num_registered_fb;
 extern struct class *fb_class;
 
+#define for_each_registered_fb(i)		\
+	for (i = 0; i < FB_MAX; i++)		\
+		if (registered_fb[i])
+
 extern int lock_fb_info(struct fb_info *info);
 
 static inline void unlock_fb_info(struct fb_info *info)
-- 
1.9.1

