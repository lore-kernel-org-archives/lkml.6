Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01467C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 07:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5896C273E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 07:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="d2Q9tS7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5896C273E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbeF3HaC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 03:30:02 -0400
Received: from smtpbg63.qq.com ([103.7.29.150]:44019 "EHLO smtpbg63.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbeF3HaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 03:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1530343794;
        bh=zkqjS82u1hqtK9xBBOZ21R1oeOtqcsj3dNihm3Wafwk=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=d2Q9tS7iwRi5Ong0kMvKnMJBheRZ85x7oWidJP+tMT3r8cHzwiju1jazq3Ah+oITp
         g0g2iTTlPWRfu3+iHDVtFo3pgACOG/SZPlJdPQ2wf1lol8aOFyEqL//nqpF20p9Mod
         ULQgwcHcYqqVhMOZf/oDCOVdjVfZkzRZcna/LOOk=
X-QQ-mid: esmtp2t1530343793tcyrfxffn
Received: from localhost.localdomain (unknown [218.72.0.54])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 30 Jun 2018 15:29:51 +0800 (CST)
X-QQ-SSF: B100000000000090FG100000000000V
X-QQ-FEAT: s2GiS5gUmyJ3RVc6u15Oo0EehHKYBsglbvB+sWxD8oHOAKDjNCtWkgpZwG4dI
        sJESbiWhmNVBezqxpfNrDLagr9+9oEcmNfA3czaQx0aq/08DUj3eD3hdEM/6Eb8uujFhFFe
        3IOFF3eC1vooQ1QQ6iugpm0zrjo+EY4wCRkF+gSmN4VRBWQzE6FenAlowbtwOJQ6H4lwRfO
        oscB9K4JaFtuiRVHIQLmfYjSKzTFL8hLMfNmVP48rgKhvglUJw5jQK8DCrGgCOyDUPdHSyW
        w5qeNZTwacyPQz80UdO5ZPRCW0ldhb8xM5aw==
X-QQ-GoodBg: 0
From:   Yisheng Xie <ysxie@foxmail.com>
To:     b.zolnierkie@samsung.com, keescook@chromium.org,
        j.w.r.degoede@gmail.com, david@lechnology.com
Cc:     andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yisheng Xie <ysxie@foxmail.com>
Subject: [PATCH v2 fbdev-for-next 1/2] fbcon: introduce for_each_registered_fb() helper
Date:   Sat, 30 Jun 2018 15:29:49 +0800
Message-Id: <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgweb:bgweb116
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

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yisheng Xie <ysxie@foxmail.com>
---
v2:
 - rebase it to fbdev-for-next branch and add one more loop to replace - per Hans
 - Macro should be protected against nested conditionals. - per Andy
 drivers/video/fbdev/core/fbcon.c | 31 +++++++++++--------------------
 drivers/video/fbdev/core/fbmem.c |  4 +---
 include/linux/fb.h               |  4 ++++
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5fb156b..e30d3a1 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2234,8 +2234,8 @@ static int fbcon_switch(struct vc_data *vc)
 	 *
 	 * info->currcon = vc->vc_num;
 	 */
-	for (i = 0; i < FB_MAX; i++) {
-		if (registered_fb[i] != NULL && registered_fb[i]->fbcon_par) {
+	for_each_registered_fb(i) {
+		if (registered_fb[i]->fbcon_par) {
 			struct fbcon_ops *o = registered_fb[i]->fbcon_par;
 
 			o->currcon = vc->vc_num;
@@ -3124,11 +3124,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
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
 
@@ -3609,10 +3607,8 @@ static int fbcon_output_notifier(struct notifier_block *nb,
 	deferred_takeover = false;
 	logo_shown = FBCON_LOGO_DONTSHOW;
 
-	for (i = 0; i < FB_MAX; i++) {
-		if (registered_fb[i])
-			fbcon_fb_registered(registered_fb[i]);
-	}
+	for_each_registered_fb(i)
+		fbcon_fb_registered(registered_fb[i]);
 
 	return NOTIFY_OK;
 }
@@ -3638,11 +3634,9 @@ static void fbcon_start(void)
 
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
@@ -3669,15 +3663,12 @@ static void fbcon_exit(void)
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
index aa74a22..fd31e6f 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -650,6 +650,10 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 extern int num_registered_fb;
 extern struct class *fb_class;
 
+#define for_each_registered_fb(i)		\
+	for (i = 0; i < FB_MAX; i++)		\
+		if (!registered_fb[i]) {} else
+
 extern int lock_fb_info(struct fb_info *info);
 
 static inline void unlock_fb_info(struct fb_info *info)
-- 
1.9.1

