Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A51C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59BD214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Nk/j5WWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59BD214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeHVMSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:18:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45982 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbeHVMSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:18:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id p52-v6so879518eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rAzeZPpkLXm+S3HvDpqe2gOLTvp6aw7vSq8ch9u5vVc=;
        b=Nk/j5WWS6SVT2XvS+2eRge6Pgkdoqu6oZIKoqI/ggOr4nMstAJWt8mNXEDn4c/dJu+
         bYI7Doo+FSrVo6rRXKiwb/DSmrM/Z/+aANUuU1HbLyZ+Jdc9AtyHwOHXAp0A/9EATl62
         IBIOoZWwNG6Ud1VoJjrkzVh6JVQgqj5AmqD34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rAzeZPpkLXm+S3HvDpqe2gOLTvp6aw7vSq8ch9u5vVc=;
        b=RK7mhvK/eJSbm83a1nwCNKgJbEf7RlK4KV/fthm+BrBtH3LD2lPjHFQHLOeYJkLgnt
         Po7ofqTSAA8Tf7+QopGgyGTLAJGhMT+8GWXCXmdvsy11ba853+jBRazNIfgAeYV8frKh
         JekdgFyX5TurBqXTl4cN9ncKkVWy3g1rkX9cOEiww1xEpuU3n85rKNh4luQzF/EHY+e5
         diqJjh88BgyPofx1Ow0UrOeVxO2xJh4Bj+IpVBpQnTMMDhgNyJ504nSgcdymRU1hiMEh
         XIE2naQAdOoJo6C6ViWHAgK3sc4trIWPUFlXEvZhUkkXWGV7NuFs0H8NEAZDTi9KAqwi
         Jw5g==
X-Gm-Message-State: AOUpUlGav0WRpO2wQS/sCeEYRtQZDvDd2HTaIHubAPIxmEIw12nX9V7T
        HLtrkxGLjuZLR10Sn5rCFPcR6w==
X-Google-Smtp-Source: AA+uWPwroOnIZiO092ahZiBlDVFB/sBJkDRxjB3R290paXBz/YxovTW/rg9cD0k5LwUOBXVi4d8LJg==
X-Received: by 2002:a50:afc4:: with SMTP id h62-v6mr65306370edd.251.1534928053542;
        Wed, 22 Aug 2018 01:54:13 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id r21-v6sm636418eds.7.2018.08.22.01.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 01:54:12 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 1/4] fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
Date:   Wed, 22 Aug 2018 10:54:02 +0200
Message-Id: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was only added for the drm's fbdev emulation support, so that it
would try harder to show the Oops.

Unfortunately this never really worked reliably, and in practice ended
up pushing the real Oops off the screen due to plentyfull locking,
sleep-while-atomic and other issues. So we removed all that support
from the fbdev emulation a while back. Aside: We've also removed the
kgdb support, for similar reasons.

Since it's such a small patch I figured I don't split this up into the
usual 3-phase removal.

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: David Lechner <david@lechnology.com>
Cc: nouveau@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 1 -
 drivers/staging/vboxvideo/vbox_fb.c     | 3 +--
 drivers/video/fbdev/core/fbcon.c        | 1 -
 include/linux/fb.h                      | 4 ----
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 844498c4267c..20a260887be3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -379,7 +379,6 @@ nouveau_fbcon_create(struct drm_fb_helper *helper,
 		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA |
 			      FBINFO_HWACCEL_FILLRECT |
 			      FBINFO_HWACCEL_IMAGEBLIT;
-	info->flags |= FBINFO_CAN_FORCE_OUTPUT;
 	info->fbops = &nouveau_fbcon_sw_ops;
 	info->fix.smem_start = fb->nvbo->bo.mem.bus.base +
 			       fb->nvbo->bo.mem.bus.offset;
diff --git a/drivers/staging/vboxvideo/vbox_fb.c b/drivers/staging/vboxvideo/vbox_fb.c
index 43c39eca4ae1..034f8ffa8f20 100644
--- a/drivers/staging/vboxvideo/vbox_fb.c
+++ b/drivers/staging/vboxvideo/vbox_fb.c
@@ -155,8 +155,7 @@ static int vboxfb_create(struct drm_fb_helper *helper,
 	 * The last flag forces a mode set on VT switches even if the kernel
 	 * does not think it is needed.
 	 */
-	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT |
-		      FBINFO_MISC_ALWAYS_SETPAR;
+	info->flags = FBINFO_DEFAULT | FBINFO_MISC_ALWAYS_SETPAR;
 	info->fbops = &vboxfb_ops;
 
 	/*
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5fb156bdcf4e..2b5bb52b1798 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1104,7 +1104,6 @@ static void fbcon_init(struct vc_data *vc, int init)
 	if (p->userfont)
 		charcnt = FNTCHARCNT(p->fontdata);
 
-	vc->vc_panic_force_write = !!(info->flags & FBINFO_CAN_FORCE_OUTPUT);
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
diff --git a/include/linux/fb.h b/include/linux/fb.h
index aa74a228bb92..fa8c6f9c9c3a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -457,10 +457,6 @@ struct fb_tile_ops {
  */
 #define FBINFO_BE_MATH  0x100000
 
-/* report to the VT layer that this fb driver can accept forced console
-   output like oopses */
-#define FBINFO_CAN_FORCE_OUTPUT     0x200000
-
 struct fb_info {
 	atomic_t count;
 	int node;
-- 
2.18.0

