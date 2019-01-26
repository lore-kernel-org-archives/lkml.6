Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA5EC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7001C218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvNhZmIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfAZMZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:25:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36632 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbfAZMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:25:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so10551156ljk.3;
        Sat, 26 Jan 2019 04:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iHGpzzDxSY24Z16cE/9INPchFaLmbUq/b31/6GBzQF8=;
        b=kvNhZmIKxhn5DhEkhi4IJ0EClP4jKtuxAxkD8Q6QOC9tENceM+3tF/Yq59gT/MwQSm
         RVp+i4KBh2AOxyJ/KTpFhU7sljZvIaOrS+12hMV3f/DEErWfvnZfPOgn5rgx58NW/52Q
         4GLxcXl46i9UHRKS+/6HSSJ7RSILmRtBQ2eVELAY/mwQnEuM1u58fO7y2NXlALcqIBlH
         6FiiZRQ2peT59FkboLJEQpug70SFAWExHM9r8IlcPPxwZ9j+2+jcJO9vJ6f/ELHWbwGO
         0JU9OoAiGrAjAWCSzWigoF9909L/3sJHkHkW9hF+PE8Mhp1yMoksJK77XdaSU8W7gWpM
         SZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iHGpzzDxSY24Z16cE/9INPchFaLmbUq/b31/6GBzQF8=;
        b=Y49f1jzZ83hj5xpZrQTI2s8iCc7BncLuOSF/gkgytDorO1BHSFFo/0EUTgPp1/xg5b
         C23vqjbCOrIaYmHa58I14fDUq1XE6xlPMGmmmtKKqUAHCCkMaYlZQgqrXFhfq+9UOA1V
         0/xGkEOhdmNuirkAUaXJsc5sMjdAPfWzxoGhOgM3+gRBNj+COibXMXefcN1v/nYvBJPo
         sYAfVC07AWasS5HqjLx+KNUM8yu/i56T10cFbxDKF0ad4Y78j2E+j6fxssxYqUjSFnPW
         zG5CifY6pLGWYcmTaz6eTzgdttZjAbCgJmVOaKcuyO5iVZi5P4zh4VBhL0V3Z42oH44m
         ZLnA==
X-Gm-Message-State: AJcUukf7K6iYJ46FspdUqv/ZGNVGUiQV0L6/iCzKoFFKoVFBp2ZufXbu
        UwSESaU/i3QMAPVZiPT8+2Q=
X-Google-Smtp-Source: ALg8bN53vK7VZK4Lti14nTln8OCjVFipOAdFvOWpzQ8jDJkr15Ole5zHsVxVdl5hSxYxUZLY+sDV9g==
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr11601191ljb.89.1548505555189;
        Sat, 26 Jan 2019 04:25:55 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id j138sm2070288lfg.64.2019.01.26.04.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 04:25:54 -0800 (PST)
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
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v6 5/5] drm: remove drmP.h from drm_modeset_helper.h
Date:   Sat, 26 Jan 2019 13:25:27 +0100
Message-Id: <20190126122527.11647-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190126122527.11647-1-sam@ravnborg.org>
References: <20190126122527.11647-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of drmP.h from drm_modeset_helper.h
the drmP.h are no longer included by any include files
in include/drm.
The drmP.h file is thus only included explicit
either in .c files or in local .h files.
This makes the process of deleting the drmP.h includes easier
as we have a more local dependency chain.

v2:
- moved updates of .c files in drm/ to a dedicated
  patch. This allows the updates to the *.c files
  to be committed without the removal part.
  So this patch can wait if it causes build failures
  due to pending changes

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drm_modeset_helper.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index efa337f03129..995fd981cab0 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -23,7 +23,11 @@
 #ifndef __DRM_KMS_HELPER_H__
 #define __DRM_KMS_HELPER_H__
 
-#include <drm/drmP.h>
+struct drm_crtc;
+struct drm_crtc_funcs;
+struct drm_device;
+struct drm_framebuffer;
+struct drm_mode_fb_cmd2;
 
 void drm_helper_move_panel_connectors_to_head(struct drm_device *);
 
-- 
2.12.0

