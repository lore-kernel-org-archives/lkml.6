Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeDSTUo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:20:44 -0400
Received: from anholt.net ([50.246.234.109]:57488 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeDSTUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:20:41 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/2] Broadcom V3D driver (7268/7278)
Date: Thu, 19 Apr 2018 12:20:33 -0700
Message-Id: <20180419192035.19898-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my first pass at submitting the DRM driver for V3D 3.x/4.x,
"v3d".  I've previously been calling this project "vc5", but given
that I also support a device that's called "vc6" already, I figured it
was time to rename.

I'm quite happy with the ABI.  My only concern as far as merging is
that without GMP support, clients can access each other's memory even
without having a GEM handle.  Authenticated DRI clients on other
platforms have been able to do so, but I would like to prevent that if
possible.  Given that I was planning on having the GMP, I didn't flag
my ioctls as requiring authentication.  If this seems like a problem,
I'd be happy to slap the authentication flag on BO submit, which I
think would be enough to match the security provided by other drivers.
I have a branch for GMP, but it's going to be a while before I finish
it, I think.

Userspace for this driver is currently merged to Mesa but the build is
disabled.  I figure I'll rename its driver to "v3d" and enable it once
this is merged.

Eric Anholt (2):
  dt-bindings: Add a new binding for Broadcom V3D 3.x and newer GPUs.
  drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+

 .../bindings/display/brcm,bcm-v3d.txt         |  28 +
 Documentation/gpu/drivers.rst                 |   1 +
 MAINTAINERS                                   |   9 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/v3d/Kconfig                   |   9 +
 drivers/gpu/drm/v3d/Makefile                  |  18 +
 drivers/gpu/drm/v3d/v3d_bo.c                  | 392 ++++++++++
 drivers/gpu/drm/v3d/v3d_debugfs.c             | 191 +++++
 drivers/gpu/drm/v3d/v3d_drv.c                 | 371 ++++++++++
 drivers/gpu/drm/v3d/v3d_drv.h                 | 305 ++++++++
 drivers/gpu/drm/v3d/v3d_fence.c               |  58 ++
 drivers/gpu/drm/v3d/v3d_gem.c                 | 671 ++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_irq.c                 | 211 ++++++
 drivers/gpu/drm/v3d/v3d_mmu.c                 | 122 ++++
 drivers/gpu/drm/v3d/v3d_regs.h                | 295 ++++++++
 drivers/gpu/drm/v3d/v3d_sched.c               | 230 ++++++
 drivers/gpu/drm/v3d/v3d_trace.h               |  82 +++
 drivers/gpu/drm/v3d/v3d_trace_points.c        |   9 +
 include/uapi/drm/v3d_drm.h                    | 191 +++++
 20 files changed, 3196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
 create mode 100644 drivers/gpu/drm/v3d/Kconfig
 create mode 100644 drivers/gpu/drm/v3d/Makefile
 create mode 100644 drivers/gpu/drm/v3d/v3d_bo.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_debugfs.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_drv.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_drv.h
 create mode 100644 drivers/gpu/drm/v3d/v3d_fence.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_gem.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_irq.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_mmu.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_regs.h
 create mode 100644 drivers/gpu/drm/v3d/v3d_sched.c
 create mode 100644 drivers/gpu/drm/v3d/v3d_trace.h
 create mode 100644 drivers/gpu/drm/v3d/v3d_trace_points.c
 create mode 100644 include/uapi/drm/v3d_drm.h

-- 
2.17.0
