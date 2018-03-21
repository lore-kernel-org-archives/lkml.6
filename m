Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeCUO60 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:58:26 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:44741 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeCUO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:58:23 -0400
X-Google-Smtp-Source: AG47ELsK5NdNoflyTm89AQNOBxrMktr5RHBVkOqb9oi00CpbVL8FGciN6Fkh+6xGWge0EMCiMZa1Vw==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v3] drm/xen-front: Add support for Xen PV display frontend
Date: Wed, 21 Mar 2018 16:58:12 +0200
Message-Id: <1521644293-14612-1-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hello!

This patch series adds support for Xen [1] para-virtualized
frontend display driver. It implements the protocol from
include/xen/interface/io/displif.h [2].
Accompanying backend [3] is implemented as a user-space application
and its helper library [4], capable of running as a Weston client
or DRM master.
Configuration of both backend and frontend is done via 
Xen guest domain configuration options [5].

*******************************************************************************
* Driver limitations
*******************************************************************************
 1. Configuration options 1.1 (contiguous display buffers) and 2 (backend
    allocated buffers) below are not supported at the same time.

 2. Only primary plane without additional properties is supported.

 3. Only one video mode supported which resolution is configured via XenStore.

 4. All CRTCs operate at fixed frequency of 60Hz.

*******************************************************************************
* Driver modes of operation in terms of display buffers used
*******************************************************************************
 Depending on the requirements for the para-virtualized environment, namely
 requirements dictated by the accompanying DRM/(v)GPU drivers running in both
 host and guest environments, number of operating modes of para-virtualized
 display driver are supported:
  - display buffers can be allocated by either frontend driver or backend
  - display buffers can be allocated to be contiguous in memory or not

 Note! Frontend driver itself has no dependency on contiguous memory for
       its operation.

*******************************************************************************
* 1. Buffers allocated by the frontend driver.
*******************************************************************************

 The below modes of operation are configured at compile-time via
 frontend driver's kernel configuration.

 1.1. Front driver configured to use GEM CMA helpers
      This use-case is useful when used with accompanying DRM/vGPU driver in
      guest domain which was designed to only work with contiguous buffers,
      e.g. DRM driver based on GEM CMA helpers: such drivers can only import
      contiguous PRIME buffers, thus requiring frontend driver to provide
      such. In order to implement this mode of operation para-virtualized
      frontend driver can be configured to use GEM CMA helpers.

 1.2. Front driver doesn't use GEM CMA
      If accompanying drivers can cope with non-contiguous memory then, to
      lower pressure on CMA subsystem of the kernel, driver can allocate
      buffers from system memory.

 Note! If used with accompanying DRM/(v)GPU drivers this mode of operation
   may require IOMMU support on the platform, so accompanying DRM/vGPU
   hardware can still reach display buffer memory while importing PRIME
   buffers from the frontend driver.

*******************************************************************************
* 2. Buffers allocated by the backend
*******************************************************************************

 This mode of operation is run-time configured via guest domain configuration
 through XenStore entries.

 For systems which do not provide IOMMU support, but having specific
 requirements for display buffers it is possible to allocate such buffers
 at backend side and share those with the frontend.
 For example, if host domain is 1:1 mapped and has DRM/GPU hardware expecting
 physically contiguous memory, this allows implementing zero-copying
 use-cases.


I would like to thank at least, but not at last the following
people/communities who helped this driver to happen ;)

1. My team at EPAM for continuous support
2. Xen community for answering tons of questions on different
modes of operation of the driver with respect to virtualized
environment.
3. Rob Clark for "GEM allocation for para-virtualized DRM driver" [6]
4. Maarten Lankhorst for "Atomic driver and old remove FB behavior" [7]
5. Ville Syrjälä for "Questions on page flips and atomic modeset" [8]

Changes since v2:
*******************************************************************************
- no changes to Xen related code (shared buffer handling, event channels etc.)
- rework DRM driver release with hotplug (Daniel)
- squash xen_drm_front and xen_drm_front_drv as they depend on each
  other too heavily now
- remove platform driver and instantiate DRM device
  from xenbus driver directly
- have serializing mutex per connector, not a single one,
  so we don't introduce a bottle neck for multiple connectors
- minor comments addressed (Daniel)

Changes since v1:
*******************************************************************************
- use SPDX license identifier, set license to GPLv2 OR MIT
- changed midlayers to direct function calls, removed:
  - front_ops
  - gem_ops
- renamed xenbus_driver callbacks to align with exisitng PV drivers
- re-worked backend error handling with connector hotplug uevents
- removed vblank handling so user-space doesn't have an impression
  we really support that
- directly use front's mode_set in display enable/disable
- removed BUG_ON, error handling implemented
- moved driver documentation into Documentation/gpu
- other comments from Xen community addressed (Boris and Juergen)
- squashed Xen and DRM patches for better interrconnection visibility
- for your convenience driver is available at [11]

Thank you,
Oleksandr Andrushchenko

Oleksandr Andrushchenko (1):
  drm/xen-front: Add support for Xen PV display frontend

 Documentation/gpu/drivers.rst               |   1 +
 Documentation/gpu/xen-front.rst             |  43 ++
 drivers/gpu/drm/Kconfig                     |   2 +
 drivers/gpu/drm/Makefile                    |   1 +
 drivers/gpu/drm/xen/Kconfig                 |  30 +
 drivers/gpu/drm/xen/Makefile                |  16 +
 drivers/gpu/drm/xen/xen_drm_front.c         | 833 ++++++++++++++++++++++++++++
 drivers/gpu/drm/xen/xen_drm_front.h         | 198 +++++++
 drivers/gpu/drm/xen/xen_drm_front_cfg.c     |  77 +++
 drivers/gpu/drm/xen/xen_drm_front_cfg.h     |  37 ++
 drivers/gpu/drm/xen/xen_drm_front_conn.c    | 145 +++++
 drivers/gpu/drm/xen/xen_drm_front_conn.h    |  27 +
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c | 383 +++++++++++++
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.h |  81 +++
 drivers/gpu/drm/xen/xen_drm_front_gem.c     | 333 +++++++++++
 drivers/gpu/drm/xen/xen_drm_front_gem.h     |  41 ++
 drivers/gpu/drm/xen/xen_drm_front_gem_cma.c |  73 +++
 drivers/gpu/drm/xen/xen_drm_front_kms.c     | 323 +++++++++++
 drivers/gpu/drm/xen/xen_drm_front_kms.h     |  28 +
 drivers/gpu/drm/xen/xen_drm_front_shbuf.c   | 432 +++++++++++++++
 drivers/gpu/drm/xen/xen_drm_front_shbuf.h   |  72 +++
 21 files changed, 3176 insertions(+)
 create mode 100644 Documentation/gpu/xen-front.rst
 create mode 100644 drivers/gpu/drm/xen/Kconfig
 create mode 100644 drivers/gpu/drm/xen/Makefile
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_cfg.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_cfg.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_conn.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_conn.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_evtchnl.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem_cma.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_kms.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_kms.h
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.h

-- 
2.7.4
