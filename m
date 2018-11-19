Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A63C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C99F2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="slqrpGXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C99F2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbeKTDKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387731AbeKTDKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:10:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9888C2145D;
        Mon, 19 Nov 2018 16:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645961;
        bh=uUHRKn8w4IOzyxPRH9QMBpd1hE5cV/kbOkCrFlEIzw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slqrpGXJasZlLxvu0F9Y+7q3ul7XsRrKBvHmWc+MQoRjQtIrB7GBGgCcodp8cQ1gX
         fiC4BjLAIoazX4uUdpmCnwEGg/YmV5C/zOytqDM4Bi+g10Gt/EYnyMUEk/jVWk22CB
         lAuAadcrRYZwieN8PYkb0LBTb0eECfbNw+DBuXDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.18 153/171] drm/atomic_helper: Disallow new modesets on unregistered connectors
Date:   Mon, 19 Nov 2018 17:29:09 +0100
Message-Id: <20181119162640.027321851@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

commit e96550956fbcd090629c0e2b5b8cded2eded2adf upstream.

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
Link: https://patchwork.freedesktop.org/patch/msgid/20181008232437.5571-2-lyude@redhat.com
(cherry picked from commit 4d80273976bf880c4bed9359b8f2d45663140c86)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_atomic_helper.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -306,6 +306,26 @@ update_connector_routing(struct drm_atom
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
@@ -350,7 +370,6 @@ update_connector_routing(struct drm_atom
 
 	set_best_encoder(state, new_connector_state, new_encoder);
 
-	crtc_state = drm_atomic_get_new_crtc_state(state, new_connector_state->crtc);
 	crtc_state->connectors_changed = true;
 
 	DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] using [ENCODER:%d:%s] on [CRTC:%d:%s]\n",


