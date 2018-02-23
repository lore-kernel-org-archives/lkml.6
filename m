Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBWDHi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:07:38 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46120 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeBWDHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:07:36 -0500
X-Google-Smtp-Source: AG47ELsIINl0awDFfyJDSU/TBeN1czZUQ0vgj5i6BrPGZ4n2SGJtDt9NhSqF59yxYUEUzMeGXu14S21/sOeUXFgEiiE=
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 23 Feb 2018 13:07:34 +1000
Message-ID: <CAPM=9tyzUeaFEsLp7cOYNqz17T3u4DTn7pD6LJkUxp3mxFZcog@mail.gmail.com>
Subject: [git pull] drm fixes for v4.16-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A bunch of fixes for rc3,

Exynos fixes for using monotonic timestamps, register definitions and
removal of unused file
ipu-v3 - minor changes, make some register arrays const+static, fix some leaks
meson: fix for vsync
atomic: fix for memory leak
EDID parser: add quirks for some more non-desktop devices, and a 6-bit
panel fix.
drm_mm: fix a bug in the core drm mm hole handling
cirrus: fix lut loading regression

Lastly there is a deadlock fix around runtime suspend for secondary
GPUs, there was a deadlock
between one thread trying to wait for a workqueue job to finish in the
runtime suspend path,
and the workqueue job it was waiting for, in turn waiting for a
runtime_get_sync to return. The
fixes avoids it by not doing the runtime sync in the workqueue as then
we always wait for all
those tasks to complete before we runtime suspend.

Dave.

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://people.freedesktop.org/~airlied/linux tags/drm-fixes-for-v4.16-rc3

for you to fetch changes up to b17800e9b7cb30e3a83d0b0ff4dc9872f0dad8c4:

  Merge tag 'imx-drm-next-2018-02-22' of
git://git.pengutronix.de/git/pza/linux into drm-fixes (2018-02-23
11:11:57 +1000)

----------------------------------------------------------------
exynos, meson, ipuv3, secondary gpu, cirrus, edid quirk fixes

----------------------------------------------------------------
Arnd Bergmann (1):
      drm/exynos: g2d: use monotonic timestamps

Chris Wilson (1):
      drm: Handle unexpected holes in color-eviction

Colin Ian King (1):
      gpu: ipu-v3: make const arrays int_reg static, shrinks object size

Corentin Labbe (1):
      drm/exynos: remove exynos_drm_rotator.h

Daniel Vetter (1):
      drm/cirrus: Load lut in crtc_commit

Dave Airlie (4):
      Merge tag 'exynos-drm-fixes-for-v4.16-rc3' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge tag 'drm-misc-fixes-2018-01-31' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-misc-fixes-2018-02-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'imx-drm-next-2018-02-22' of
git://git.pengutronix.de/git/pza/linux into drm-fixes

Jan Luebbe (1):
      gpu: ipu-csi: add 10/12-bit grayscale support to mbus_code_to_bus_cfg

Jani Nikula (1):
      drm/tve200: fix kernel-doc documentation comment include

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA

Leo (Sunpeng) Li (1):
      drm/atomic: Fix memleak on ERESTARTSYS during non-blocking commits

Lukas Wunner (5):
      workqueue: Allow retrieval of current task's work struct
      drm: Allow determining if current task is output poll worker
      drm/nouveau: Fix deadlock on runtime suspend
      drm/radeon: Fix deadlock on runtime suspend
      drm/amdgpu: Fix deadlock on runtime suspend

Markus Elfring (1):
      drm/exynos: g2d: Delete an error message for a failed memory
allocation in two functions

Neil Armstrong (1):
      drm/meson: fix vsync buffer update

Philipp Zabel (5):
      gpu: ipu-cpmem: add 8-bit grayscale support to ipu_cpmem_set_image
      gpu: ipu-cpmem: add 16-bit grayscale support to ipu_cpmem_set_image
      drm/edid: quirk Oculus Rift headsets as non-desktop
      drm/edid: quirk Windows Mixed Reality headsets as non-desktop
      drm/edid: quirk Sony PlayStation VR headset as non-desktop

Sylwester Nawrocki (1):
      drm: exynos: Use proper macro definition for HDMI_I2S_PIN_SEL_1

Tobias Jordan (2):
      gpu: ipu-v3: pre: fix device node leak in ipu_pre_lookup_by_phandle
      gpu: ipu-v3: prg: fix device node leak in ipu_prg_lookup_by_phandle

Wolfram Sang (1):
      drm/exynos: fix comparison to bitshift when dealing with a mask

 Documentation/gpu/tve200.rst                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 58 +++++++++++++-------
 drivers/gpu/drm/cirrus/cirrus_mode.c           | 40 ++++++++------
 drivers/gpu/drm/drm_atomic_helper.c            | 15 ++++++
 drivers/gpu/drm/drm_edid.c                     | 21 ++++++++
 drivers/gpu/drm/drm_mm.c                       | 21 ++++++--
 drivers/gpu/drm/drm_probe_helper.c             | 20 +++++++
 drivers/gpu/drm/exynos/exynos_drm_g2d.c        | 12 ++---
 drivers/gpu/drm/exynos/exynos_drm_rotator.h    | 19 -------
 drivers/gpu/drm/exynos/exynos_hdmi.c           |  7 ++-
 drivers/gpu/drm/exynos/regs-fimc.h             |  2 +-
 drivers/gpu/drm/exynos/regs-hdmi.h             |  2 +-
 drivers/gpu/drm/meson/meson_crtc.c             |  6 +++
 drivers/gpu/drm/meson/meson_drv.h              |  3 ++
 drivers/gpu/drm/meson/meson_plane.c            |  7 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.c    | 18 +++++--
 drivers/gpu/drm/radeon/radeon_connectors.c     | 74 +++++++++++++++++---------
 drivers/gpu/ipu-v3/ipu-common.c                |  4 +-
 drivers/gpu/ipu-v3/ipu-cpmem.c                 |  2 +
 drivers/gpu/ipu-v3/ipu-csi.c                   |  2 +
 drivers/gpu/ipu-v3/ipu-pre.c                   |  3 ++
 drivers/gpu/ipu-v3/ipu-prg.c                   |  3 ++
 include/drm/drm_atomic.h                       |  9 ++++
 include/drm/drm_crtc_helper.h                  |  1 +
 include/linux/workqueue.h                      |  1 +
 kernel/workqueue.c                             | 16 ++++++
 26 files changed, 261 insertions(+), 107 deletions(-)
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_rotator.h
