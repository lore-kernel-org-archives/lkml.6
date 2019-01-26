Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC948C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904AF218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCG6eOU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfAZMZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:25:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38230 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfAZMZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:25:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so10532153lja.5;
        Sat, 26 Jan 2019 04:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=iIFy/R33nyHV1c7xcjReKoqytJb3jV7diMIO3jFmDIw=;
        b=gCG6eOU4tCRQHDHh2NFtppqD/NA+8oLhj+iHaA4tkxLZD1hqyUN2HYPuWgyn52ptur
         SERquHOR1KQu20czthyGzvNhXsU199xzj0i7ecbohLTAuksKwID4NfhtH+OeEKS6iDWD
         qasZWaUHOQ6oWpsiHtZfsDcmfntwymGYqM7HyaG3CcVVbKjTzX15t1nhzaezyx1XZ879
         lBWOiaR2g+FhcH5j8vC7v3djFLSlGv2tFhM4Vl5KcrBGgPzm9oLDhg1n5uXlmeMXG/2X
         KLFKhLhIIDMk6JuJAj6dj9kOE3ZG6Ilyvxp+COL544uijxCvBaPxrAsNHxKPHYlb9o5l
         PoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=iIFy/R33nyHV1c7xcjReKoqytJb3jV7diMIO3jFmDIw=;
        b=SX63majIPf0HHekL7kBD4NXXkGdm91rpvDGEaC5e+WSmeMzC+n79thjPZq6Hi7966m
         o6np2t6QAFpIGYFWbC5THQ2arQ+6a3kd3lCJPexlXXyLhfxt22tx9ZEBVMXoZd46PtQU
         NCrkFuaH4r5wUxdSPKshjBQd2uQU94/pf8iJNftaeWD/uvuexybYbBM5vxTpTSViIDw+
         kftjHTiktE+WglU+fSli+QJh6UP/AnhuVH8gdZjmmz/hMwAbNYqzs+1QIHfF9GwllBs3
         dxWhmgRp9tQDiiFX1B7l8phWwX42qbVei5EOWmWE00lPEgKTcaa2R5ghGkag3NVxrrxd
         kJpw==
X-Gm-Message-State: AJcUukcfAIuBxxP3sxIoTRUog0EzrB/+lT2QGIZu6K+vVmI30Wp0v3pr
        w/zGT8jgwdxNfOJ1Orgm4t2qXTq9
X-Google-Smtp-Source: ALg8bN5oJpNZcHLMe3k+53k/PW87s12c8IS1alenEUDBQTZscE+AkBGO+KIR0OXEapUlDVIImXnU0A==
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr11737730ljb.11.1548505542512;
        Sat, 26 Jan 2019 04:25:42 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id j138sm2070288lfg.64.2019.01.26.04.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 04:25:41 -0800 (PST)
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
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] drm: minimize drmP.h dependencies
Date:   Sat, 26 Jan 2019 13:25:22 +0100
Message-Id: <20190126122527.11647-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patchset, with merged patches removed, new patches added.

> From the original mail:

        - drmP.h is now stripped down to include files
          and forward declarations.
        - All header files in include/drm/ no longer include drmP.h.

The series was made on top of drm-misc-next:
f1a2a540c86441016ce3dff6590b7a09080871de ("video/hdmi: Add an enum for HDMI packet types")

Build tested using arm and x86, ia64, alpha, sparc32, sparc64
Included staging/vboxvideo in the build test - which revealed
the build issues Daniel had identifed

This series include fixes to i915 as it looks in drm-misc.
This series also include fixes to stagin/vboxvideo, which I
expect to be committet to drm-misc due to the final patch
(drmP.h removal from drm_modeset_helper.h) depending on this patch.

Daniel - thanks for being paitent and applying this piecemal.

        Sam
v6:
- include fixes to vboxvideo (Daniel)
- include i915 build fixes
- revised/new rcar-du patch (lots of new build failures popped up)
- split updates to drm/*.c file to dedicated patch,
  to make the final removal patch slimmer

v5:
- Rebased on top of drm-misc-next and dropped patches already merged
- Sorted list of include files where they are touched (Laurent)
- Collected ack's, reviewed by's

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

Sam Ravnborg (5):
      staging/vboxvideo: prepare for drmP.h removal from drm_modeset_helper.h
      drm/i915: prepare for drmP.h removal from drm_modeset_helper.h
      drm/rcar-du: prepare for drmP.h removal from drm_modeset_helper.h
      drm: prepare for drmP.h removal from drm_modeset_helper.h
      drm: remove drmP.h from drm_modeset_helper.h

 drivers/gpu/drm/drm_damage_helper.c       |  1 +
 drivers/gpu/drm/drm_modeset_helper.c      |  2 ++
 drivers/gpu/drm/i915/i915_drv.c           |  4 +++-
 drivers/gpu/drm/i915/intel_atomic.c       |  2 ++
 drivers/gpu/drm/i915/intel_atomic_plane.c |  2 ++
 drivers/gpu/drm/i915/intel_display.c      | 29 ++++++++++++++++-------------
 drivers/gpu/drm/i915/intel_pm.c           |  7 +++++--
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c    |  3 +++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c     |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     |  2 ++
 drivers/gpu/drm/rcar-du/rcar_du_plane.c   |  2 ++
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c     |  1 +
 drivers/staging/vboxvideo/vbox_drv.c      |  6 +++++-
 drivers/staging/vboxvideo/vbox_fb.c       | 18 ++++++++++--------
 drivers/staging/vboxvideo/vbox_mode.c     |  5 ++++-
 include/drm/drm_modeset_helper.h          |  6 +++++-
 16 files changed, 64 insertions(+), 27 deletions(-)
