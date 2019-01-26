Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99772C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6772C218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnUgTU7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfAZMZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:25:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46050 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfAZMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:25:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so8758567lfa.12;
        Sat, 26 Jan 2019 04:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RQJNFNIjmYLP71EGQCtMn4dHFGn+z8AinizUQEi5mZo=;
        b=jnUgTU7onaMY3nIv6qEAfinaja3izr12rGlTKuCWTZ/ke4zB4UiIoaoTKlxsuOxgeA
         Qklp/z1ILoJN8BUBeAx4O2kP2+DYFSgJBGBgBQAnq8u5nE9elpBy452tic5qsAWwBMpZ
         uvNLFXmKcBi0ktDjj38yJ6Wy+5dEJK2xpG1q1g+yABQr5Nr5JJ2c+wcTg/eEMRO2sIEl
         A4Ep7AtSRBLFv5Tbu7Bi+IDaPEYsVHwr9tue0QvALDclzGNwEMKb0dIR2wxQ6at9pCZf
         aNZY7MdlojhevTb1mYEpXKaUlMxvkAUeFb2tSmop/ITK5aISEMnBXSmBUBuBzqJJyCZP
         ToQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RQJNFNIjmYLP71EGQCtMn4dHFGn+z8AinizUQEi5mZo=;
        b=UM2XeJsRw4s+ca/ldSVhZiVtvNaMJl9Ho3J+t+oVUB7Jh2491dgHHbyMFX3gxNBI6T
         3AjpTOEioaZ/zIpKB2vNgZ9MSlsfPo9AtHM03+yvQiUO77gfbtwptem3v9kQjRjOqOP4
         LymXLMH8OJImpvaasmTucPRF3p4qXYU+DWqoyBR1fgeNRsutyorr72Kg9bNaWpwEP26S
         bD5EsBhQpr4SehPN2W1trOJdPHbZfS5VsCUQj96C+pnaWvnLbSX7Ql3cYauz8Dbxce+c
         phyW0HLWgcX6/D1JGA4SegtE40Vj8FxXb7mGVPhtWpTuJeN13HbPsiCzpXKlAQBJTQr2
         8+/Q==
X-Gm-Message-State: AJcUukc5zXmZpGlY5ywdbv4/v+bR+TjsCPENQ1SsujDmgiIBkis0QZoG
        TDyI+jScCJ4B7jRtIBLLWag=
X-Google-Smtp-Source: ALg8bN5a3JLSFqmOFbqLGbjjaaVQLSQpeiLYq3xKVORqEICV3ttg5F5SeKk7vwmPjC34l6Huw4N7uw==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr12080603lfb.140.1548505550404;
        Sat, 26 Jan 2019 04:25:50 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id j138sm2070288lfg.64.2019.01.26.04.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 04:25:49 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v6 1/5] staging/vboxvideo: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 26 Jan 2019 13:25:23 +0100
Message-Id: <20190126122527.11647-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190126122527.11647-1-sam@ravnborg.org>
References: <20190126122527.11647-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused vboxvideo to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

In the files touched sort the include files

Build tested on x86 and arm allmodconfig / allyesconfig.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/staging/vboxvideo/vbox_drv.c  |  6 +++++-
 drivers/staging/vboxvideo/vbox_fb.c   | 18 ++++++++++--------
 drivers/staging/vboxvideo/vbox_mode.c |  5 ++++-
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vboxvideo/vbox_drv.c b/drivers/staging/vboxvideo/vbox_drv.c
index cc6532d8c2fa..d1b0d7b4886a 100644
--- a/drivers/staging/vboxvideo/vbox_drv.c
+++ b/drivers/staging/vboxvideo/vbox_drv.c
@@ -7,11 +7,15 @@
  *          Michael Thayer <michael.thayer@oracle.com,
  *          Hans de Goede <hdegoede@redhat.com>
  */
-#include <linux/module.h>
 #include <linux/console.h>
+#include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/vt_kern.h>
 
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_ioctl.h>
 
 #include "vbox_drv.h"
 
diff --git a/drivers/staging/vboxvideo/vbox_fb.c b/drivers/staging/vboxvideo/vbox_fb.c
index 397496cf0bdf..83a04afd1766 100644
--- a/drivers/staging/vboxvideo/vbox_fb.c
+++ b/drivers/staging/vboxvideo/vbox_fb.c
@@ -6,20 +6,22 @@
  * Authors: Dave Airlie <airlied@redhat.com>
  *          Michael Thayer <michael.thayer@oracle.com,
  */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/tty.h>
-#include <linux/sysrq.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/fb.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/sysrq.h>
+#include <linux/tty.h>
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 
 #include "vbox_drv.h"
 #include "vboxvideo.h"
diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
index 1aaff02c07ff..213551394495 100644
--- a/drivers/staging/vboxvideo/vbox_mode.c
+++ b/drivers/staging/vboxvideo/vbox_mode.c
@@ -10,14 +10,17 @@
  *          Hans de Goede <hdegoede@redhat.com>
  */
 #include <linux/export.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 
+#include "hgsmi_channels.h"
 #include "vbox_drv.h"
 #include "vboxvideo.h"
-#include "hgsmi_channels.h"
 
 /*
  * Set a graphics mode.  Poke any required values into registers, do an HGSMI
-- 
2.12.0

