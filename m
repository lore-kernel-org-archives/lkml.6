Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF96C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0507723C0C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq/LUNve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0507723C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934324AbeFVBaO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:30:14 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:46262 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933948AbeFVBaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:30:12 -0400
Received: by mail-qt0-f182.google.com with SMTP id h5-v6so4656567qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 18:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VP+WO7h2lSHEDN1nT/iP+HVE2pGbtFb9LE1wze3gUD4=;
        b=aq/LUNveLlmfyS52/knW5fNS4oxsOWM1comQsz+MHOl9We8lGnVZOOYzrQCjbvqZAX
         vHSYfz9ElHWTbEmBEAxef9ffX7shFhqoKHFg12nqEgdFS/E+mVfpuwBWnWf7jFsb2uha
         Cmt28LCHChmieitDC86kYKmCeQVb0wt3ScDlvsC+HoWp7wGrppPu/4z64PdlnZru0hYT
         NkLjmgw8YeYLye04dScQiNLHSMSBfPKcNnB00S+pajUfL46XxTYHz6TrhHgwPf8mvuiT
         lCXUPk1GQnp+SNgowDRKano8qaDesPozBfn3pk0UDV5EYafmVDnNvAVRN9b6ZJV3++SS
         SWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VP+WO7h2lSHEDN1nT/iP+HVE2pGbtFb9LE1wze3gUD4=;
        b=tiTP6IedxHpgJGjemYf11alNVLHNbLRSAaGVJ6bkMEXp29ubIXjCRCd2IwdSUjFxit
         7IhBaBxqTQ7clAAm5QGL/Y6kkXOONl7c3ENPxxbbDSehLT2aZcID6OZSbVL8MKslTQRF
         tlZ/yrHitH94qteD6RyhzFd1jiA9/ZpJshFXXZA+XNEf1ArRBcbQCApj+6mgQDovk0kb
         p2Jbp/IPn6x0j6WhRtre7yM4B92o1nWndgG89eCcjvxz2KwWQTcdNMRehGQqMwiTvCpp
         QhELKyRKSzqq7C6LK1Utou/w+cy1Fo2CWq9vJUahYG/3JFyrEdKU0qGEKhZFxpBTVz77
         WBUQ==
X-Gm-Message-State: APt69E0SH3PVYXSkLOq7JBJQ1aY3uE6mEJmq5JLLaOrmSkXHe6kqaXi8
        N1ez2sFazFs6TCDkimgTZ3mtm/hkIy2r9tZRA4CoWw==
X-Google-Smtp-Source: ADUXVKLvg6ocxe2KM5Qdn8mK9bjvK9ukmn6rIVM7plqh8MUlcuqrsZYS2c6ivQAjl54l1QvLQ9J546cvMJ064N89Y+w=
X-Received: by 2002:a0c:b3d5:: with SMTP id b21-v6mr24604142qvf.80.1529631011360;
 Thu, 21 Jun 2018 18:30:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3f3d:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 18:30:10
 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Jun 2018 11:30:10 +1000
Message-ID: <CAPM=9tx37yB=4evJh6UvhWWf+mEH-_Wo0CWKwcorR0EQN9J4Ew@mail.gmail.com>
Subject: [git pull] drm fixes for 4.18-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just run of the mill fixes,

core: one regression fix in device unplug
qxl: one regression fix for might sleep in cursor handling
nouveau: one regression fix in multi-screen cursor handling
amdgpu: switch off DC by default on Kaveri and older and some minor fixes
i915: some GEM regression fixes and doublescan mode fixes
sun4i: revert fix for a regression
sii8620 bridge: misc fixes

Thanks,
Dave.

drm-fixes-2018-06-22:
amd, i915, qxl, nouveau, sun4i, atmel, and bridge fixes.
The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40=
:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-06-22

for you to fetch changes up to f3294568bbb19cbfc53451de192df6daae80f9b3:

  Merge tag 'drm-misc-fixes-2018-06-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2018-06-22
11:03:43 +1000)

----------------------------------------------------------------
amd, i915, qxl, nouveau, sun4i, atmel, and bridge fixes.

----------------------------------------------------------------
Andrzej Hajda (2):
      drm/bridge/sii8620: simplify hardware reset procedure
      drm/bridge/sii8620: fix loops in EDID fetch logic

Ben Skeggs (1):
      drm/nouveau/kms/nv50-: cursors always use core channel vram ctxdma

Chris Wilson (2):
      drm/i915: Apply batch location restrictions before pinning
      drm/i915/execlists: Avoid putting the error pointer

Dave Airlie (6):
      Merge branch 'linux-4.18' of git://github.com/skeggsb/linux into drm-=
fixes
      Merge tag 'drm-misc-next-fixes-2018-06-15' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-misc-fixes-2018-06-12' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2018-06-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2018-06-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Harry Wentland (1):
      drm/amdgpu: Don't default to DC support for Kaveri and older

James Zhu (1):
      drm/amdgpu:All UVD instances share one idle_work handle

Jeremy Cline (1):
      drm/qxl: Call qxl_bo_unref outside atomic context

Kenneth Graunke (1):
      drm/i915: Enable provoking vertex fix on Gen9 systems.

Maciej Purski (6):
      drm/bridge/sii8620: fix display modes validation
      drm/bridge/sii8620: fix potential buffer overflow
      drm/bridge/sii8620: start MHL transmission after HDMI signal detectio=
n
      drm/bridge/sii8620: remove HSIC initialization
      drm/bridge/sii8620: fix HDMI cable connection to dongle
      drm/bridge/sii8620: fix display of packed pixel modes in MHL2

Michel D=C3=A4nzer (4):
      drm/amdgpu: Use kvmalloc_array for allocating VRAM manager nodes arra=
y
      drm/amdgpu: Update pin_size values before unpinning BO
      drm/amdgpu: Refactor amdgpu_vram_mgr_bo_invisible_size helper
      drm/amdgpu: Make amdgpu_vram_mgr_bo_invisible_size always accurate

Mika Kuoppala (1):
      drm/i915: Fix context ban and hang accounting for client

Oleksandr Andrushchenko (1):
      drm: Fix possible race conditions while unplugging DRM device

Paul Kocialkowski (1):
      Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"

Rajan Vaja (1):
      drm/amd/pp: Fix uninitialized variable

Stefan Agner (1):
      drm/atmel-hlcdc: check stride values in the first plane

Ville Syrj=C3=A4l=C3=A4 (4):
      drm/i915: Allow DBLSCAN user modes with eDP/LVDS/DSI
      drm/i915: Fix PIPESTAT irq ack on i965/g4x
      drm/i915: Disallow interlaced modes on g4x DP outputs
      drm/i915: Turn off g4x DP port in .post_disable()

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  39 ++-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |   2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |   2 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               | 309 ++++++++---------=
----
 drivers/gpu/drm/drm_drv.c                          |  14 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  21 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  57 ++--
 drivers/gpu/drm/i915/i915_gem_context.c            |   2 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |  49 ++--
 drivers/gpu/drm/i915/i915_irq.c                    |  12 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   5 +
 drivers/gpu/drm/i915/intel_crt.c                   |  20 ++
 drivers/gpu/drm/i915/intel_display.c               |  16 +-
 drivers/gpu/drm/i915/intel_dp.c                    |  34 ++-
 drivers/gpu/drm/i915/intel_dp_mst.c                |   6 +
 drivers/gpu/drm/i915/intel_dsi.c                   |   6 +
 drivers/gpu/drm/i915/intel_dvo.c                   |   6 +
 drivers/gpu/drm/i915/intel_hdmi.c                  |   6 +
 drivers/gpu/drm/i915/intel_lrc.c                   |  18 +-
 drivers/gpu/drm/i915/intel_lvds.c                  |   5 +
 drivers/gpu/drm/i915/intel_sdvo.c                  |   6 +
 drivers/gpu/drm/i915/intel_tv.c                    |  12 +-
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c        |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |  13 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   7 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  25 --
 31 files changed, 408 insertions(+), 337 deletions(-)
