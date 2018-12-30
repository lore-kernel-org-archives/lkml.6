Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8629C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DCE20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6Lgr+z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeL3Rs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:48:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36431 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeL3Rsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:48:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so22342102ljk.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=dFF8xyr2Vaw57wDmm/6wV3EIINyAuCDmINUT4XSQNjA=;
        b=b6Lgr+z3/x6C1Oduw1y55UdEorFOARltycmPbnm5M/eZ7tmezA/PENdCKgK8+rl4rT
         JSs/Uu/HWnncymX3zgNfiFvtR5PvxWyYVhZh6hgilm0Xo7K7XMJyX7gT9ZeSM91x9plF
         yeDWt1MmeMAXYd+7ja7QqlLw713NNDEG20+5H11DEEbxLVokm5vWzHVrvzSj7Jah52hV
         pcZ7XNvNqdcXdAc6gcw5/m4JFcHXDuaUZqaASl5TPTxRctppbrrYRRLWsGfK7ej/CY1R
         xnNj+mpXmYTTy1yE1EUm9RQI8IrxYriDZAEwsNcd9IL7wV8o98YXlJp3vJ/So/Z8Wy1Z
         dOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=dFF8xyr2Vaw57wDmm/6wV3EIINyAuCDmINUT4XSQNjA=;
        b=cx8zMo3pnJfS5AchOD0hYr+VEwKa3XjudLk5EEAH8JEYFooVQTRMdLKTl9EeaMcIJI
         gzyhvAxCd0QOOBBEgZs8wqYDvPBGJRd1Pogrn5Lzg5XF1QxLytX1ikdE4hnLZcB+URoy
         4m63ZtU1jSNCo6VEAnv16+32vTYkXC4tJ6fzJDRMVxfi6l8pH8uzfnpqF9Av5+Xgxd0O
         xurRKykO6U9Zx0bTsKATkaWCrKOC7F1HORypOt91Q1pg97Eg7ucDKyAOIsz6d9olaDCN
         T2PYWXVaF9JsSya/FRkanvDBkPzJpq/ycDE43g0u6ii4MtbFjFxeR/qM4KIp7jiCDiBa
         rSHA==
X-Gm-Message-State: AJcUukfojaMHchtZmWWvhnt5wcuUzhWZtGVy3lJbahUHop6Ce7yV+0Ax
        9Cy2+9f7O9oBi/9sSV+lrQLIZzrH/5Y=
X-Google-Smtp-Source: ALg8bN73+yJZffcnZzjqiwwxyOz7qH4iziUcbJw4xOytqubUWD5QIAs71MhMki1F+/gxvchhDzdTsw==
X-Received: by 2002:a2e:5c07:: with SMTP id q7-v6mr21256582ljb.119.1546192131690;
        Sun, 30 Dec 2018 09:48:51 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:48:51 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 0/14] drm: minimize drmP.h dependencies 
Date:   Sun, 30 Dec 2018 18:48:24 +0100
Message-Id: <20181230174838.32330-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal with this small series is to remove the last bits
that prevents us from removing drmP.h driver-by-driver or file by file.

- drmP.h is now stripped down to include files and forward declarations.
- All header files in include/drm/ no longer include drmP.h.

The series was made on top of drm-misc-next
Build tested using arm and x86 all{yes,mod}config

The patches are trivial but touches a lot of files,
so a lot of people on cc: for the individual patches.

I expect the full series to be applied to drm-misc-next

There are still ~700 uses of drmP.h so a long way ahead of
us to get rid of it.
(The last mail said 900 but that was a typo)

The kernel-doc parts that I authored in the following
may require some extra info as I know too little about
DRM to be able to write something really useful.
Or at least review by someone with knowledge of DRM,
but that goes for everything.

v2:
- DRM_SWITCH_POWER as enum (Daniel Vetter)
- Prefer forward decalration over includes (Laurent Pinchart)
- Updated drm_device to use kerneldoc style (Daniel Vetter)
- Improved commit messages (David Lechner)
- Split up patch when removing drmP.h from drm_gem_cma_helper.h
- rebased on top of drm-misc-next
- dropped patch already applied
- added reviewed-by from Laurent Pinchart (Laurent Pinchart)
- add drm_framebuffer.h patch
- add kernel-doc comments to drm_util.h
- moved EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h
- added note to drmP.h not to add new stuff and not to use in new files

	Sam


Sam Ravnborg (14):
      drm: drm_device.h: update comments to kerneldoc style
      drm: move DRM_SWITCH_POWER defines to drm_device.h
      drm: make drm_framebuffer.h self contained
      drm: make drm_file.h self contained
      drm: move drm_can_sleep() to drm_util.h
      drm: add kernel-doc comments to drm_util.h
      drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h
      drm: remove include of drmP.h from bridge/dw_hdmi.h
      drm: remove include of drmP.h from drm_encoder_slave.h
      drm: remove include of drmP.h from drm_modeset_helper.h
      drm/arc: do not reply on drmP.h from drm_gem_cma_helper.h
      drm/stm: do not reply on drmP.h from drm_gem_cma_helper.h
      drm/tinydrm: do not reply on drmP.h from drm_gem_cma_helper.h
      drm: remove drmP.h from drm_gem_cma_helper.h

 drivers/gpu/drm/amd/amdgpu/atom.c                  |   2 +
 drivers/gpu/drm/arc/arcpgu_crtc.c                  |   2 +
 drivers/gpu/drm/arc/arcpgu_drv.c                   |   6 +
 drivers/gpu/drm/arc/arcpgu_sim.c                   |   1 +
 drivers/gpu/drm/ast/ast_fb.c                       |   2 +
 drivers/gpu/drm/bridge/cdns-dsi.c                  |   2 +
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c    |   4 +
 drivers/gpu/drm/cirrus/cirrus_fbdev.c              |   1 +
 drivers/gpu/drm/drm_flip_work.c                    |   1 +
 drivers/gpu/drm/drm_framebuffer.c                  |   1 +
 drivers/gpu/drm/drm_modeset_helper.c               |   2 +
 drivers/gpu/drm/mgag200/mgag200_fb.c               |   1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |   1 +
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |   1 +
 drivers/gpu/drm/qxl/qxl_cmd.c                      |   2 +
 drivers/gpu/drm/radeon/atom.c                      |   2 +
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |   1 +
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c             |   1 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |   1 +
 drivers/gpu/drm/stm/drv.c                          |   6 +-
 drivers/gpu/drm/stm/ltdc.c                         |   9 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |   3 +
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c        |   3 +
 drivers/gpu/drm/tinydrm/hx8357d.c                  |   1 +
 drivers/gpu/drm/tinydrm/ili9225.c                  |   2 +
 drivers/gpu/drm/tinydrm/ili9341.c                  |   1 +
 drivers/gpu/drm/tinydrm/mi0283qt.c                 |   1 +
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 |   3 +
 drivers/gpu/drm/tinydrm/repaper.c                  |   1 +
 drivers/gpu/drm/tinydrm/st7586.c                   |   1 +
 drivers/gpu/drm/tinydrm/st7735r.c                  |   1 +
 drivers/gpu/drm/vc4/vc4_drv.h                      |   1 +
 include/drm/bridge/dw_hdmi.h                       |   6 +-
 include/drm/drmP.h                                 |  24 +--
 include/drm/drm_device.h                           | 228 +++++++++++++++------
 include/drm/drm_encoder_slave.h                    |   1 -
 include/drm/drm_file.h                             |   1 +
 include/drm/drm_framebuffer.h                      |   5 +-
 include/drm/drm_gem_cma_helper.h                   |   5 +-
 include/drm/drm_modeset_helper.h                   |   6 +-
 include/drm/drm_util.h                             |  49 ++++-
 41 files changed, 299 insertions(+), 93 deletions(-)
