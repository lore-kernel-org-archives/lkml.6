Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC142089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC142089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeJBULm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbeJBULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:41 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0DAF2BF0;
        Tue,  2 Oct 2018 13:28:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 103/228] drm/v3d: Take a lock across GPU scheduler job creation and queuing.
Date:   Tue,  2 Oct 2018 06:23:20 -0700
Message-Id: <20181002132506.362311375@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Anholt <eric@anholt.net>

[ Upstream commit 7122b68b8a9692dcc3acf89595f04c492872115f ]

Between creation and queueing of a job, you need to prevent any other
job from being created and queued.  Otherwise the scheduler's fences
may be signaled out of seqno order.

v2: move mutex unlock to the error label.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Link: https://patchwork.freedesktop.org/patch/msgid/20180606174851.12433-1-eric@anholt.net
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/v3d/v3d_drv.h |    5 +++++
 drivers/gpu/drm/v3d/v3d_gem.c |    4 ++++
 2 files changed, 9 insertions(+)

--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -85,6 +85,11 @@ struct v3d_dev {
 	 */
 	struct mutex reset_lock;
 
+	/* Lock taken when creating and pushing the GPU scheduler
+	 * jobs, to keep the sched-fence seqnos in order.
+	 */
+	struct mutex sched_lock;
+
 	struct {
 		u32 num_allocated;
 		u32 pages_allocated;
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -550,6 +550,7 @@ v3d_submit_cl_ioctl(struct drm_device *d
 	if (ret)
 		goto fail;
 
+	mutex_lock(&v3d->sched_lock);
 	if (exec->bin.start != exec->bin.end) {
 		ret = drm_sched_job_init(&exec->bin.base,
 					 &v3d->queue[V3D_BIN].sched,
@@ -576,6 +577,7 @@ v3d_submit_cl_ioctl(struct drm_device *d
 	kref_get(&exec->refcount); /* put by scheduler job completion */
 	drm_sched_entity_push_job(&exec->render.base,
 				  &v3d_priv->sched_entity[V3D_RENDER]);
+	mutex_unlock(&v3d->sched_lock);
 
 	v3d_attach_object_fences(exec);
 
@@ -594,6 +596,7 @@ v3d_submit_cl_ioctl(struct drm_device *d
 	return 0;
 
 fail_unreserve:
+	mutex_unlock(&v3d->sched_lock);
 	v3d_unlock_bo_reservations(dev, exec, &acquire_ctx);
 fail:
 	v3d_exec_put(exec);
@@ -615,6 +618,7 @@ v3d_gem_init(struct drm_device *dev)
 	spin_lock_init(&v3d->job_lock);
 	mutex_init(&v3d->bo_lock);
 	mutex_init(&v3d->reset_lock);
+	mutex_init(&v3d->sched_lock);
 
 	/* Note: We don't allocate address 0.  Various bits of HW
 	 * treat 0 as special, such as the occlusion query counters


