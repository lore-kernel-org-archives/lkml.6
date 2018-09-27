Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93C820836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93C820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeI0PbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:31:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI0PbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:31:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 177B81117;
        Thu, 27 Sep 2018 09:13:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.18 74/88] drm/atomic: Use drm_drv_uses_atomic_modeset() for debugfs creation
Date:   Thu, 27 Sep 2018 11:03:55 +0200
Message-Id: <20180927090309.614592493@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit 3c499ea0c662e2f38aafbd4f516b08aab8cfa0e5 upstream.

As pointed out by Daniel Vetter, we should be usinng
drm_drv_uses_atomic_modeset() for determining whether or not we want to
make the debugfs nodes for atomic instead of checking DRIVER_ATOMIC, as
the former isn't an accurate representation of whether or not the driver
is actually using atomic modesetting internally (even though it might
not be exposing atomic capabilities).

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180917173733.21293-1-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_atomic.c  |    2 +-
 drivers/gpu/drm/drm_debugfs.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1838,7 +1838,7 @@ static void __drm_state_dump(struct drm_
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 
-	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
+	if (!drm_drv_uses_atomic_modeset(dev))
 		return;
 
 	list_for_each_entry(plane, &config->plane_list, head) {
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -150,7 +150,7 @@ int drm_debugfs_init(struct drm_minor *m
 		return ret;
 	}
 
-	if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
+	if (drm_drv_uses_atomic_modeset(dev)) {
 		ret = drm_atomic_debugfs_init(minor);
 		if (ret) {
 			DRM_ERROR("Failed to create atomic debugfs files\n");


