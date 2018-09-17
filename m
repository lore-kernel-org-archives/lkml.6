Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B5BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE986214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE986214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeIQXGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbeIQXGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3F1130024C4;
        Mon, 17 Sep 2018 17:37:51 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-121-187.rdu2.redhat.com [10.10.121.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2974218354;
        Mon, 17 Sep 2018 17:37:48 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/atomic: Use drm_drv_uses_atomic_modeset() for debugfs creation
Date:   Mon, 17 Sep 2018 13:37:33 -0400
Message-Id: <20180917173733.21293-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 17 Sep 2018 17:37:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Daniel Vetter, we should be usinng
drm_drv_uses_atomic_modeset() for determining whether or not we want to
make the debugfs nodes for atomic instead of checking DRIVER_ATOMIC, as
the former isn't an accurate representation of whether or not the driver
is actually using atomic modesetting internally (even though it might
not be exposing atomic capabilities).

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/drm_atomic.c  | 2 +-
 drivers/gpu/drm/drm_debugfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3eb061e11e2e..018fcdb353d2 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -2067,7 +2067,7 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 
-	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
+	if (!drm_drv_uses_atomic_modeset(dev))
 		return;
 
 	list_for_each_entry(plane, &config->plane_list, head) {
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 6f28fe58f169..373bd4c2b698 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -151,7 +151,7 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 		return ret;
 	}
 
-	if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
+	if (drm_drv_uses_atomic_modeset(dev)) {
 		ret = drm_atomic_debugfs_init(minor);
 		if (ret) {
 			DRM_ERROR("Failed to create atomic debugfs files\n");
-- 
2.17.1

