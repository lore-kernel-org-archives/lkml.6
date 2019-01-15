Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7BAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6253220645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571474;
	bh=IRNzO+2Zl1SmgS6VHKDGA2x4frRpMU80oYlVWSZvv9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QzCp+j/QTpZJTxvlThBem3y3Myqep1OEjVw8W+xJ51fMXYoSK978CMxNcMZE9bUnH
	 AGMQg97dAkUoAOJZTwl0tA13IB4p2oAmoC3OZ/cHuXZvHo/m84UZNXsM5gUxs8Bk4n
	 5D28YyvltKS6hD3BHUAdjOR5f+YKwd4CcDh4a2K4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbfAOQ5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:57:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbfAOQk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF7220868;
        Tue, 15 Jan 2019 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570427;
        bh=IRNzO+2Zl1SmgS6VHKDGA2x4frRpMU80oYlVWSZvv9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wf8EPsiU8zM380KnBYEg3YWdcHqY3y65MwhrBFPHwObqDOcKLuePXQsIYRaJFkMEF
         BrGIDwc8e94fZRg6C4Z7ywtQB3Db0r2rSyGbyV/u5QwC6GPJOnfQkoBOg7Y88PXdCT
         QA6zo0M41iDc0cMDtjsFVy6pqiW1bxhsx2lig8o4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, saahriktu <mail@saahriktu.org>,
        Ivan Mironov <mironov.ivan@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.14 19/27] drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2
Date:   Tue, 15 Jan 2019 17:36:08 +0100
Message-Id: <20190115154902.452701794@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
References: <20190115154901.189747728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Mironov <mironov.ivan@gmail.com>

commit 62d85b3bf9d978ed4b6b2aeef5cf0ccf1423906e upstream.

SDL 1.2 sets all fields related to the pixel format to zero in some
cases[1]. Prior to commit db05c48197759 ("drm: fb-helper: Reject all
pixel format changing requests"), there was an unintentional workaround
for this that existed for more than a decade. First in device-specific DRM
drivers, then here in drm_fb_helper.c.

Previous code containing this workaround just ignores pixel format fields
from userspace code. Not a good thing either, as this way, driver may
silently use pixel format different from what client actually requested,
and this in turn will lead to displaying garbage on the screen. I think
that returning EINVAL to userspace in this particular case is the right
option, so I decided to left code from problematic commit untouched
instead of just reverting it entirely.

Here is the steps required to reproduce this problem exactly:
	1) Compile fceux[2] with SDL 1.2.15 and without GTK or OpenGL
	   support. SDL should be compiled with fbdev support (which is
	   on by default).
	2) Create /etc/fb.modes with following contents (values seems
	   not used, and just required to trigger problematic code in
	   SDL):

		mode "test"
		    geometry 1 1 1 1 1
		    timings 1 1 1 1 1 1 1
		endmode

	3) Create ~/.fceux/fceux.cfg with following contents:

		SDL.Hotkeys.Quit = 27
		SDL.DoubleBuffering = 1

	4) Ensure that screen resolution is at least 1280x960 (e.g.
	   append "video=Virtual-1:1280x960-32" to the kernel cmdline
	   for qemu/QXL).

	5) Try to run fceux on VT with some ROM file[3]:

		# ./fceux color_test.nes

[1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c,
    FB_SetVideoMode()
[2] http://www.fceux.com
[3] Example ROM: https://github.com/bokuweb/rustynes/blob/master/roms/color_test.nes

Reported-by: saahriktu <mail@saahriktu.org>
Suggested-by: saahriktu <mail@saahriktu.org>
Cc: stable@vger.kernel.org
Fixes: db05c48197759 ("drm: fb-helper: Reject all pixel format changing requests")
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
[danvet: Delete misleading comment.]
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20190108072353.28078-2-mironov.ivan@gmail.com
Link: https://patchwork.freedesktop.org/patch/msgid/20190108072353.28078-2-mironov.ivan@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_fb_helper.c |  126 +++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 53 deletions(-)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1509,6 +1509,64 @@ static bool drm_fb_pixel_format_equal(co
 	       var_1->transp.msb_right == var_2->transp.msb_right;
 }
 
+static void drm_fb_helper_fill_pixel_fmt(struct fb_var_screeninfo *var,
+					 u8 depth)
+{
+	switch (depth) {
+	case 8:
+		var->red.offset = 0;
+		var->green.offset = 0;
+		var->blue.offset = 0;
+		var->red.length = 8; /* 8bit DAC */
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	case 15:
+		var->red.offset = 10;
+		var->green.offset = 5;
+		var->blue.offset = 0;
+		var->red.length = 5;
+		var->green.length = 5;
+		var->blue.length = 5;
+		var->transp.offset = 15;
+		var->transp.length = 1;
+		break;
+	case 16:
+		var->red.offset = 11;
+		var->green.offset = 5;
+		var->blue.offset = 0;
+		var->red.length = 5;
+		var->green.length = 6;
+		var->blue.length = 5;
+		var->transp.offset = 0;
+		break;
+	case 24:
+		var->red.offset = 16;
+		var->green.offset = 8;
+		var->blue.offset = 0;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	case 32:
+		var->red.offset = 16;
+		var->green.offset = 8;
+		var->blue.offset = 0;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.offset = 24;
+		var->transp.length = 8;
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  * drm_fb_helper_check_var - implementation for &fb_ops.fb_check_var
  * @var: screeninfo to check
@@ -1539,6 +1597,20 @@ int drm_fb_helper_check_var(struct fb_va
 	}
 
 	/*
+	 * Workaround for SDL 1.2, which is known to be setting all pixel format
+	 * fields values to zero in some cases. We treat this situation as a
+	 * kind of "use some reasonable autodetected values".
+	 */
+	if (!var->red.offset     && !var->green.offset    &&
+	    !var->blue.offset    && !var->transp.offset   &&
+	    !var->red.length     && !var->green.length    &&
+	    !var->blue.length    && !var->transp.length   &&
+	    !var->red.msb_right  && !var->green.msb_right &&
+	    !var->blue.msb_right && !var->transp.msb_right) {
+		drm_fb_helper_fill_pixel_fmt(var, fb->format->depth);
+	}
+
+	/*
 	 * drm fbdev emulation doesn't support changing the pixel format at all,
 	 * so reject all pixel format changing requests.
 	 */
@@ -1848,59 +1920,7 @@ void drm_fb_helper_fill_var(struct fb_in
 	info->var.yoffset = 0;
 	info->var.activate = FB_ACTIVATE_NOW;
 
-	switch (fb->format->depth) {
-	case 8:
-		info->var.red.offset = 0;
-		info->var.green.offset = 0;
-		info->var.blue.offset = 0;
-		info->var.red.length = 8; /* 8bit DAC */
-		info->var.green.length = 8;
-		info->var.blue.length = 8;
-		info->var.transp.offset = 0;
-		info->var.transp.length = 0;
-		break;
-	case 15:
-		info->var.red.offset = 10;
-		info->var.green.offset = 5;
-		info->var.blue.offset = 0;
-		info->var.red.length = 5;
-		info->var.green.length = 5;
-		info->var.blue.length = 5;
-		info->var.transp.offset = 15;
-		info->var.transp.length = 1;
-		break;
-	case 16:
-		info->var.red.offset = 11;
-		info->var.green.offset = 5;
-		info->var.blue.offset = 0;
-		info->var.red.length = 5;
-		info->var.green.length = 6;
-		info->var.blue.length = 5;
-		info->var.transp.offset = 0;
-		break;
-	case 24:
-		info->var.red.offset = 16;
-		info->var.green.offset = 8;
-		info->var.blue.offset = 0;
-		info->var.red.length = 8;
-		info->var.green.length = 8;
-		info->var.blue.length = 8;
-		info->var.transp.offset = 0;
-		info->var.transp.length = 0;
-		break;
-	case 32:
-		info->var.red.offset = 16;
-		info->var.green.offset = 8;
-		info->var.blue.offset = 0;
-		info->var.red.length = 8;
-		info->var.green.length = 8;
-		info->var.blue.length = 8;
-		info->var.transp.offset = 24;
-		info->var.transp.length = 8;
-		break;
-	default:
-		break;
-	}
+	drm_fb_helper_fill_pixel_fmt(&info->var, fb->format->depth);
 
 	info->var.xres = fb_width;
 	info->var.yres = fb_height;


