Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FFCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A368420665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imwrOBDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfAHT3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:29:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39217 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfAHT3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so3828567lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/dCl7bQ7GmuZ0Qe+DsKMNf8SxYTup9k/YGufaXp3sAs=;
        b=imwrOBDIeJxtP0JanSDOyYzHg2wr3CkA54F1PlHRYG65qa9F0n+YuUrPoNUCvO4dYj
         YTa/KG/5pLAu3xzXAHgZl6UR3RlBfvFd958ntCXyFdlailVOKfp3C64IbpV1WwopQ4a0
         OhqNgraYFF058zJD61TLogaJr6TGJacnKXKWeUmqU0jj1nVWxfTgJic2/XZ110LDl2Ta
         LJNsdAPrcDkIw4Lp6X51q7fNjKYraik1dzTOkzAp3WXs9GqlBdaCpU+mClZ+DYCHGLJq
         QIyhzThgozMvhSmC/TDlU4tpiG58KB6rldpRFy61NUH8tZ0zIqMCyV/yT6neU3294SN+
         HZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=/dCl7bQ7GmuZ0Qe+DsKMNf8SxYTup9k/YGufaXp3sAs=;
        b=m7qvlnPjT1VfO+OAsCoYplsCjyguiayJ7IYj+b1P/E70isL3MMbh/OShd4FDcvt3o4
         1udOlfRWY8n4xPJLHKO2maJb8EoZ38+vLqQxOVf0lvth4FB3VGdyxkPRybBkukbtLSPt
         FNmOPmFbVa9rZt41jM1Z2K/L/JvgekmWhm16xc2P9wkeuDzWCCpAStabkAfI6YHwnwCi
         Fk7S1HNdgqb/ReegIFQByh4zdu9hWvGHFSgETb50CZiR0vAp7WGL8sinZh4bBxO11K7g
         wQE7saM0CbwvOhnk8m46jQnleAohjBUhSY2Lk9CZIVTbmyaW5ln2pLgboLlFh/eoQWDz
         SaWQ==
X-Gm-Message-State: AJcUukdon/310bJp1x2sinXxzI394PSMFve+Iw6cgZWIXO0byp0pIN/K
        k8CYhCS1KPwls+3SKuEfLC8=
X-Google-Smtp-Source: ALg8bN5XF99trmruzRORjBrNxGx7wZzqhcSJmoEid2rTFThZV2eKQe+fiwbD7uPbgRkRGNyL2DMjWQ==
X-Received: by 2002:a19:f813:: with SMTP id a19mr1708969lff.67.1546975786420;
        Tue, 08 Jan 2019 11:29:46 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:45 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 0/12] drm: minimize drmP.h dependencies
Date:   Tue,  8 Jan 2019 20:29:27 +0100
Message-Id: <20190108192939.15255-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- drmP.h is now stripped down to include files and forward declarations.
- All header files in include/drm/ no longer include drmP.h.

The series was made on top of drm-misc-next
Build tested using arm and x86 all{yes,mod}config

The patches are trivial but touches a lot of files,
so a lot of people on cc: for the individual patches.

I expect the full series to be applied to drm-misc-next

There are still ~700 uses of drmP.h so a long way ahead of
us to get rid of it.

The kernel-doc parts that I authored in the following
may require some extra info as I know too little about
DRM to be able to write something really useful.
Or at least review by someone with knowledge of DRM,
but that goes for everything.

v3:
- Added Acks/Reviewed annotations (thanks!)
- Add forward of drm_gem_object to drm_framebuffer.h (Noralf)
- Drop "drm: move DRM_IF_VERSION to drm_internal.h" as it is applied to drm-misc
- Drop "drm: make drm_file.h self contained" as Jan made a similar patch that was appleid to drm-misc
- Rebased on top of drm-misc-next

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

Sam Ravnborg (12):
      drm: drm_device.h: update comments to kernel-doc style
      drm: move DRM_SWITCH_POWER defines to drm_device.h
      drm: make drm_framebuffer.h self contained
      drm: move drm_can_sleep() to drm_util.h
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
 include/drm/drm_framebuffer.h                      |  10 +-
 include/drm/drm_gem_cma_helper.h                   |   5 +-
 include/drm/drm_modeset_helper.h                   |   6 +-
 include/drm/drm_util.h                             |  52 ++++-
 40 files changed, 304 insertions(+), 95 deletions(-)


