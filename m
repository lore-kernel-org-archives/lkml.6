Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeDEAGB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:06:01 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:58452 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752311AbeDEAGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:06:00 -0400
From: Deepak Rawat <drawat@vmware.com>
To: <dri-devel@lists.freedesktop.org>, <thellstrom@vmware.com>,
        <syeh@vmware.com>
CC: <linux-graphics-maintainer@vmware.com>, <daniel@ffwll.ch>,
        <ville.syrjala@linux.intel.com>, <lukasz.spintzyk@displaylink.com>,
        <noralf@tronnes.org>, <robdclark@gmail.com>, <gustavo@padovan.org>,
        <maarten.lankhorst@linux.intel.com>, <seanpaul@chromium.org>,
        <airlied@linux.ie>, <linux-kernel@vger.kernel.org>,
        Deepak Rawat <drawat@vmware.com>
Subject: [RFC 0/3] drm: page-flip with damage
Date: Wed, 4 Apr 2018 16:49:05 -0700
Message-ID: <1522885748-67122-1-git-send-email-drawat@vmware.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is extension to Lukasz Spintzyk earlier draft of damage interface for drm.
Bascially a new plane property is added called "DAMAGE_CLIPS" which is simply
an array of drm_rect (exported to userspace as drm_mode_rect). The clips
represents damage in framebuffer coordinate of attached fb to the plane.

Helper iterator is added to traverse the damage rectangles and get the damage
clips in framebuffer, plane or crtc coordinates as need by driver
implementation. Finally a helper to reset damage in case need full update is
required. Drivers interested in page-flip with damage should call this from
atomic_check hook.

With the RFC for atomic implementation of dirtyfb ioctl I was thinking
should we need to consider dirty_fb flags, especially
DRM_MODE_FB_DIRTY_ANNOTATE_COPY to be passed with atomic
DAMAGE_CLIPS property blob? I didn't considered that untill now. If no driver
uses that in my opinion for simplicity this can be ignored?

About overlaping of damage rectangles is also not finalized. This really
depends on driver specific implementation and can be left open-ended?

My knowledge is limited to vmwgfx so would like to hear about other driver use
cases and this can be modified in keeping other drivers need.

Going forward driver implementation for vmwgfx and user-space implementation
of kmscube/weston will be next step to test the changes.

Thanks,
Deepak

Deepak Rawat (2):
  drm: Add helper iterator functions to iterate over plane damage.
  drm: Add helper to validate damage during modeset_check

Lukasz Spintzyk (1):
  drm: Add DAMAGE_CLIPS property to plane

 drivers/gpu/drm/drm_atomic.c        |  42 +++++++++
 drivers/gpu/drm/drm_atomic_helper.c | 173 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_mode_config.c   |   5 ++
 drivers/gpu/drm/drm_plane.c         |  12 +++
 include/drm/drm_atomic_helper.h     |  41 +++++++++
 include/drm/drm_mode_config.h       |  15 ++++
 include/drm/drm_plane.h             |  16 ++++
 include/uapi/drm/drm_mode.h         |  15 ++++
 8 files changed, 319 insertions(+)

-- 
2.7.4
