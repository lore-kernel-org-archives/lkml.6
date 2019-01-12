Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C87C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD273206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXzcnTst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfALTdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:33:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39086 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfALTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:33:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so13106909lfh.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=5gQDezgNvD9rw/OMyrgOuEd4s4J4abE6kQmFizhzV60=;
        b=SXzcnTstArMionUiwIK2Tnn3KjwW2ZLQN1szl00zH8JS86NDpEOXCbGWNjgqIW4vRx
         73SVXpA9VE7i1hKsWq3tfbN7GSiHvSHJvYz4fUK/UGu39iG07XkiA6hS7fMX7xU4Qads
         YtdG3mQCF1+Jkf7lpnay9nIkipGmrpRulUI19i4Qe06AAAkq44XKsYwOiNA0UseSLYGu
         GqyClhoSRrbAM+FtrRcnJzj4OuWjcy1tzPUGLpmamboJkfv9HSc/vx9E/01l0eMPDwFJ
         Me/tlsTKm6wQLLYZ+gkQLCrI8VfotdQZ/hFUfoq72OSmPfwDNxRIQ9Om+7O/Pq3tghWR
         GF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=5gQDezgNvD9rw/OMyrgOuEd4s4J4abE6kQmFizhzV60=;
        b=tf3vMN0Ke1v5g13pz4roJ1ZlvQUaoeog2VwY+1CqTW/ls9aKKaWNv/9sHtHgB5sTvk
         RZ9pA9jHShSi+MPkL622eN/GxFiTl69zl2KeruLDoH3/tfj88MQZMYYqUyJoSN5VyTUV
         BGbIMot3eN8KWD+qqzCQSURec/kIjLxdaTUZ72bvmN8Da57Xr1xlUS+CM0FKGHMvthZb
         Hrrz/n23L4cGbJgqZ/rQn/oaMEDQe2lXUVtcZmCLBC/GrLIde7670iMZlSP46TrqXAow
         MtnTlsCtbdcbpyybVdmspy0b6i0JrjuMs7KC86qPodYpU4YLJryngbOoATvi2VlgC8Pd
         xtSw==
X-Gm-Message-State: AJcUukdHzl9NcRtkPWkv0Afl14P1d1gKwNgHeQaIlA/WNtb4/YPtnu4z
        uz6AjzPTR5um53EstTiWWP0=
X-Google-Smtp-Source: ALg8bN5VGA0xq6/kFRd3X1KX20g3xe3Gb1qVHTbwSF3JZFif5l3VwIyrVgiKK8GvfG0MxHMT1mLpfQ==
X-Received: by 2002:a19:9653:: with SMTP id y80mr10426973lfd.66.1547321602481;
        Sat, 12 Jan 2019 11:33:22 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id d82sm15624452lfd.82.2019.01.12.11.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 11:33:21 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Clark <robdclark@gmail.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 0/8] drm: minimize drmP.h dependencies
Date:   Sat, 12 Jan 2019 20:32:43 +0100
Message-Id: <20190112193251.20450-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patchset, with merged patches removed.
And one patch split in merge frindly bits.

As noted in the commit message for kirin a hack
to kirin/Kconfig was required to build it on my box.
It would be good if we could have this driver covered
by COMPILE_TEST.
There are likely others that could benefit from the same, but
this driver got my attention as Daniel reported build errors
that my setup did not trigger.
Build failed with my arm (32bit) toolchain, I did not investigate
this further.

From the original mail:

- drmP.h is now stripped down to include files and forward declarations.
- All header files in include/drm/ no longer include drmP.h.

The series was made on top of drm-misc-next
Build tested using arm and x86 allmodconfig

The patches are trivial but touches a lot of files,
so a lot of people on cc: for the individual patches.

I expect the full series to be applied to drm-misc-next

	Sam

v4:
- Rebased on top of drm-misc-next and dropped patches already merged
- Include build test of kirin (Daniel)
- Plug drm_util.h into drm-internals.rst (Daniel)
- Fix kernel-doc syntax in drm_util.h (Daniel)
- Split removal of drmP.h from drm_modeset_helper.h
  in smaller patches, to ease the merge process

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



Sam Ravnborg (8):
      drm: move drm_can_sleep() to drm_util.h
      drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h
      drm/stm: prepare for drmP.h removal from drm_modeset_helper.h
      drm/hisilicon/kirin: prepare for drmP.h removal from drm_modeset_helper.h
      drm/arcpgu: prepare for drmP.h removal from drm_modeset_helper.h
      drm/bridge: cdns: prepare for drmP.h removal from drm_modeset_helper.h
      drmi/rcar-du: prepare for drmP.h removal from drm_modeset_helper.h
      drm: remove drmP.h from drm_modeset_helper.h

 Documentation/gpu/drm-internals.rst             |  9 +++++
 drivers/gpu/drm/amd/amdgpu/atom.c               |  2 +
 drivers/gpu/drm/arc/arcpgu_sim.c                |  3 +-
 drivers/gpu/drm/ast/ast_fb.c                    |  2 +
 drivers/gpu/drm/bridge/cdns-dsi.c               |  2 +
 drivers/gpu/drm/cirrus/cirrus_fbdev.c           |  1 +
 drivers/gpu/drm/drm_damage_helper.c             |  1 +
 drivers/gpu/drm/drm_flip_work.c                 |  1 +
 drivers/gpu/drm/drm_framebuffer.c               |  1 +
 drivers/gpu/drm/drm_modeset_helper.c            |  2 +
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    | 11 +++--
 drivers/gpu/drm/mgag200/mgag200_fb.c            |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c        |  1 +
 drivers/gpu/drm/omapdrm/omap_fbdev.c            |  1 +
 drivers/gpu/drm/qxl/qxl_cmd.c                   |  2 +
 drivers/gpu/drm/radeon/atom.c                   |  2 +
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c |  1 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c             |  1 +
 drivers/gpu/drm/stm/drv.c                       |  4 ++
 drivers/gpu/drm/stm/ltdc.c                      |  7 ++++
 drivers/gpu/drm/vc4/vc4_drv.h                   |  1 +
 include/drm/drmP.h                              | 19 +++------
 include/drm/drm_modeset_helper.h                |  6 ++-
 include/drm/drm_util.h                          | 53 ++++++++++++++++++++++++-
 24 files changed, 115 insertions(+), 19 deletions(-)
