Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 83F8BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC16208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC16208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeFLNwy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:52:54 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:54046 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933203AbeFLNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:52:52 -0400
Received: from e110455-lin.cambridge.arm.com (e110455-lin.cambridge.arm.com [10.2.131.61])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id w5CDqX1l016479;
        Tue, 12 Jun 2018 14:52:33 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Gustavo Padovan <gustavo@padovan.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH v10 0/3] drm: Introduce writeback connectors
Date:   Tue, 12 Jun 2018 14:52:30 +0100
Message-Id: <20180612135233.18575-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v10 of the writeback connector series. Compared to v9 I've
reverted to the v6 way of cleaning up the writeback job in the cleanup_work()
function, where we also drop the reference to the job's framebuffer. I was
trying to come up with a reference counted implementation for the job, but
Sean Paul pointed out to Brian that it seems to be safe to free work_struct
structures in the workqueue callback, so we are going back to the original
implementation.

While doing that, I've also updated the patcheset to use the latest
drm_framebuffer_{put,get,assign} functions for managing the framebuffer
reference that the wriback job holds.

I will ask Gustavo to pull this series into drm-misc if there are no further
comments.

Best regards,
Liviu

Brian Starkey (2):
  drm: Add writeback connector type
  drm: writeback: Add out-fences for writeback connectors

Liviu Dudau (1):
  drm: writeback: Add client capability for exposing writeback
    connectors

 Documentation/gpu/drm-kms.rst            |   9 +
 drivers/gpu/drm/Makefile                 |   2 +-
 drivers/gpu/drm/drm_atomic.c             | 223 ++++++++++++++-
 drivers/gpu/drm/drm_atomic_helper.c      |  25 ++
 drivers/gpu/drm/drm_connector.c          |   4 +-
 drivers/gpu/drm/drm_ioctl.c              |   7 +
 drivers/gpu/drm/drm_mode_config.c        |   5 +
 drivers/gpu/drm/drm_writeback.c          | 350 +++++++++++++++++++++++
 include/drm/drm_atomic.h                 |  11 +
 include/drm/drm_connector.h              |  13 +
 include/drm/drm_file.h                   |   7 +
 include/drm/drm_mode_config.h            |  23 ++
 include/drm/drm_modeset_helper_vtables.h |  11 +
 include/drm/drm_writeback.h              | 130 +++++++++
 include/uapi/drm/drm.h                   |   9 +
 include/uapi/drm/drm_mode.h              |   1 +
 16 files changed, 819 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_writeback.c
 create mode 100644 include/drm/drm_writeback.h

-- 
2.17.1

