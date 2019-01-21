Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B90C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C76420989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079367;
	bh=s85YtZrR2NcAWvIX7Mzr15oHV+WicK1iRPGXMn9GlHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DDcC/awN0Lwgmg/YROzdmyxTaTYm6V/2CEecblwpjhCsEYjdaxTYNbnqDPqMQPSBa
	 otd0l0FJHYY4tCOMSaK18IcWNA684oYBLg9igu75NFKz2kvRxH0ypuyoJwdozz1/7J
	 ZuJL/Rm5uXeyH/gxX+38CFfL4gfuWY1gy8tXLsTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbfAUOCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbfAUOCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F8020989;
        Mon, 21 Jan 2019 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079362;
        bh=s85YtZrR2NcAWvIX7Mzr15oHV+WicK1iRPGXMn9GlHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fF74a+DZDEo41J6LzCcTU1yP6XpFDhEPF7m51TGTE6B6qk38z5dmpUwV5Z5bOaiQW
         NTac+sbjSZff1v2iAbHhlKwzxooqYQe+swS0R/LVyeruwFFD2Eaepa7+URi3l6OmR1
         gfb/kKifGRFM+PsdDATDRjkI7Jyi5kkm0SVChVjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Mironov <mironov.ivan@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.19 98/99] drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock
Date:   Mon, 21 Jan 2019 14:49:30 +0100
Message-Id: <20190121134919.998208187@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Mironov <mironov.ivan@gmail.com>

commit 66a8d5bfb518f9f12d47e1d2dce1732279f9451e upstream.

Strict requirement of pixclock to be zero breaks support of SDL 1.2
which contains hardcoded table of supported video modes with non-zero
pixclock values[1].

To better understand which pixclock values are considered valid and how
driver should handle these values, I briefly examined few existing fbdev
drivers and documentation in Documentation/fb/. And it looks like there
are no strict rules on that and actual behaviour varies:

	* some drivers treat (pixclock == 0) as "use defaults" (uvesafb.c);
	* some treat (pixclock == 0) as invalid value which leads to
	  -EINVAL (clps711x-fb.c);
	* some pass converted pixclock value to hardware (uvesafb.c);
	* some are trying to find nearest value from predefined table
          (vga16fb.c, video_gx.c).

Given this, I believe that it should be safe to just ignore this value if
changing is not supported. It seems that any portable fbdev application
which was not written only for one specific device working under one
specific kernel version should not rely on any particular behaviour of
pixclock anyway.

However, while enabling SDL1 applications to work out of the box when
there is no /etc/fb.modes with valid settings, this change affects the
video mode choosing logic in SDL. Depending on current screen
resolution, contents of /etc/fb.modes and resolution requested by
application, this may lead to user-visible difference (not always):
image will be displayed in a right way, but it will be aligned to the
left instead of center. There is no "right behaviour" here as well, as
emulated fbdev, opposing to old fbdev drivers, simply ignores any
requsts of video mode changes with resolutions smaller than current.

The easiest way to reproduce this problem is to install sdl-sopwith[2],
remove /etc/fb.modes file if it exists, and then try to run sopwith
from console without X. At least in Fedora 29, sopwith may be simply
installed from standard repositories.

[1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c, vesa_timings
[2] http://sdl-sopwith.sourceforge.net/

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 79e539453b34e ("DRM: i915: add mode setting support")
Fixes: 771fe6b912fca ("drm/radeon: introduce kernel modesetting for radeon hardware")
Fixes: 785b93ef8c309 ("drm/kms: move driver specific fb common code to helper functions (v2)")
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20190108072353.28078-3-mironov.ivan@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_fb_helper.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1690,9 +1690,14 @@ int drm_fb_helper_check_var(struct fb_va
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_framebuffer *fb = fb_helper->fb;
 
-	if (var->pixclock != 0 || in_dbg_master())
+	if (in_dbg_master())
 		return -EINVAL;
 
+	if (var->pixclock != 0) {
+		DRM_DEBUG("fbdev emulation doesn't support changing the pixel clock, value of pixclock is ignored\n");
+		var->pixclock = 0;
+	}
+
 	/*
 	 * Changes struct fb_var_screeninfo are currently not pushed back
 	 * to KMS, hence fail if different settings are requested.


