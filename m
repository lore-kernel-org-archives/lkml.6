Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B88CC6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4D92145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4D92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJIGHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeJIGHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:07:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88A933084258;
        Mon,  8 Oct 2018 22:53:12 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9CEB105705C;
        Mon,  8 Oct 2018 22:53:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] drm/atomic_helper: Disallow new modesets on unregistered connectors
Date:   Mon,  8 Oct 2018 18:52:56 -0400
Message-Id: <20181008225303.2907-2-lyude@redhat.com>
In-Reply-To: <20181008225303.2907-1-lyude@redhat.com>
References: <20181008225303.2907-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 08 Oct 2018 22:53:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the exception of modesets which would switch the DPMS state of a
connector from on to off, we want to make sure that we disallow all
modesets which would result in enabling a new monitor or a new mode
configuration on a monitor if the connector for the display in question
is no longer registered. This allows us to stop userspace from trying to
enable new displays on connectors for an MST topology that were just
removed from the system, without preventing userspace from disabling
DPMS on those connectors.

Changes since v5:
- Fix typo in comment, nothing else

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/drm_atomic_helper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 6f66777dca4b..e6a2cf72de5e 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -319,6 +319,26 @@ update_connector_routing(struct drm_atomic_state *state,
 		return 0;
 	}
 
+	crtc_state = drm_atomic_get_new_crtc_state(state,
+						   new_connector_state->crtc);
+	/*
+	 * For compatibility with legacy users, we want to make sure that
+	 * we allow DPMS On->Off modesets on unregistered connectors. Modesets
+	 * which would result in anything else must be considered invalid, to
+	 * avoid turning on new displays on dead connectors.
+	 *
+	 * Since the connector can be unregistered at any point during an
+	 * atomic check or commit, this is racy. But that's OK: all we care
+	 * about is ensuring that userspace can't do anything but shut off the
+	 * display on a connector that was destroyed after its been notified,
+	 * not before.
+	 */
+	if (!READ_ONCE(connector->registered) && crtc_state->active) {
+		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] is not registered\n",
+				 connector->base.id, connector->name);
+		return -EINVAL;
+	}
+
 	funcs = connector->helper_private;
 
 	if (funcs->atomic_best_encoder)
@@ -363,7 +383,6 @@ update_connector_routing(struct drm_atomic_state *state,
 
 	set_best_encoder(state, new_connector_state, new_encoder);
 
-	crtc_state = drm_atomic_get_new_crtc_state(state, new_connector_state->crtc);
 	crtc_state->connectors_changed = true;
 
 	DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] using [ENCODER:%d:%s] on [CRTC:%d:%s]\n",
-- 
2.17.1

