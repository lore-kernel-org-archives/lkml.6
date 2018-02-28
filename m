Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbeB1QvN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:51:13 -0500
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:31508 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753074AbeB1QvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:51:11 -0500
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: DRI-devel <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>
Subject: [PATCH v6 0/3] drm: Introduce writeback connectors
Date: Wed, 28 Feb 2018 16:50:54 +0000
Message-Id: <20180228165057.26856-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v6 of the writeback connector series. Based on renewed
interest in the feature and recent efforts from Rob Clark I'm
refreshing the series to address some comments and feedback.

Main changes are to incorporate Rob Clark's atomic_commit() vfunc
for the connector helper funcs, change the signature of the
create_writeback_properties() function to return the error code
rather than a boolean false and making sure that the writeback job
doesn't get freed in the cleanup_work() function but when the
connector state gets discarded.

Additionally, based on Sean Paul's comments, I'm providing the
3rd patch in the series that adds a client cap for exposing the
writeback connectors to userspace. The idea was initially considered
unnecessary by Daniel Vetter here [1] but Sean thinks it is useful.
Note that the patch depends on the cleanup patch [2] sent earlier.


Comments are welcome on the suitability of this series.

Best regards,
Liviu


[1] https://lists.freedesktop.org/archives/dri-devel/2016-October/120519.html
[2] https://lists.freedesktop.org/archives/dri-devel/2018-February/167677.html

Brian Starkey (2):
  drm: Add writeback connector type
  drm: writeback: Add out-fences for writeback connectors

Liviu Dudau (1):
  drm: writeback: Add client capability for exposing writeback
    connectors

 Documentation/gpu/drm-kms.rst            |   9 +
 drivers/gpu/drm/Makefile                 |   2 +-
 drivers/gpu/drm/drm_atomic.c             | 227 ++++++++++++++++++-
 drivers/gpu/drm/drm_atomic_helper.c      |  30 +++
 drivers/gpu/drm/drm_connector.c          |   4 +-
 drivers/gpu/drm/drm_ioctl.c              |   5 +
 drivers/gpu/drm/drm_mode_config.c        |   5 +
 drivers/gpu/drm/drm_writeback.c          | 360 +++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h                 |  11 +
 include/drm/drm_connector.h              |  13 ++
 include/drm/drm_file.h                   |   7 +
 include/drm/drm_mode_config.h            |  23 ++
 include/drm/drm_modeset_helper_vtables.h |  11 +
 include/drm/drm_writeback.h              | 129 +++++++++++
 include/uapi/drm/drm.h                   |   9 +
 include/uapi/drm/drm_mode.h              |   1 +
 16 files changed, 835 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_writeback.c
 create mode 100644 include/drm/drm_writeback.h

-- 
2.16.2
