Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeC2NTo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:19:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41545 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeC2NTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:19:42 -0400
X-Google-Smtp-Source: AIpwx48IwnvISSU7UkmPz1HS0Wl/f2wnLBKkmqfmCR8JVj0GfizRU7vJPdMzXid7HaktPHEmHHWagg==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper DRM driver
Date: Thu, 29 Mar 2018 16:19:30 +0300
Message-Id: <20180329131931.29957-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hello!

When using Xen PV DRM frontend driver then on backend side one will need
to do copying of display buffers' contents (filled by the
frontend's user-space) into buffers allocated at the backend side.
Taking into account the size of display buffers and frames per seconds
it may result in unneeded huge data bus occupation and performance loss.

This helper driver allows implementing zero-copying use-cases
when using Xen para-virtualized frontend display driver by
implementing a DRM/KMS helper driver running on backend's side.
It utilizes PRIME buffers API to share frontend's buffers with
physical device drivers on backend's side:

 - a dumb buffer created on backend's side can be shared
   with the Xen PV frontend driver, so it directly writes
   into backend's domain memory (into the buffer exported from
   DRM/KMS driver of a physical display device)
 - a dumb buffer allocated by the frontend can be imported
   into physical device DRM/KMS driver, thus allowing to
   achieve no copying as well

For that reason number of IOCTLs are introduced:
 -  DRM_XEN_ZCOPY_DUMB_FROM_REFS
    This will create a DRM dumb buffer from grant references provided
    by the frontend
 - DRM_XEN_ZCOPY_DUMB_TO_REFS
   This will grant references to a dumb/display buffer's memory provided
   by the backend
 - DRM_XEN_ZCOPY_DUMB_WAIT_FREE
   This will block until the dumb buffer with the wait handle provided
   be freed

With this helper driver I was able to drop CPU usage from 17% to 3%
on Renesas R-Car M3 board.

This was tested with Renesas' Wayland-KMS and backend running as DRM master.

Thank you,
Oleksandr

Oleksandr Andrushchenko (1):
  drm/xen-zcopy: Add Xen zero-copy helper DRM driver

 Documentation/gpu/drivers.rst               |   1 +
 Documentation/gpu/xen-zcopy.rst             |  32 +
 drivers/gpu/drm/xen/Kconfig                 |  25 +
 drivers/gpu/drm/xen/Makefile                |   5 +
 drivers/gpu/drm/xen/xen_drm_zcopy.c         | 880 ++++++++++++++++++++++++++++
 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c | 154 +++++
 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h |  38 ++
 include/uapi/drm/xen_zcopy_drm.h            | 129 ++++
 8 files changed, 1264 insertions(+)
 create mode 100644 Documentation/gpu/xen-zcopy.rst
 create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c
 create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h
 create mode 100644 include/uapi/drm/xen_zcopy_drm.h

-- 
2.16.2
