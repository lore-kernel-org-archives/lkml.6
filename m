Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4079C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A9E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696149;
	bh=kWpK/HnV9JtBXaeQN26gB/YUUoXK8zH4so1rYdjcUzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FnSh8QfqdOBGhnmeky+eeLaNrQvIcXAaWAt9aP0e53fhKo9HMFm3/50BeL0LMYjLG
	 nv/2DmppsSv4PKmxJVZvSSSd8oh89MHw9V1LOJxQ52FQo0eTAL7YSQOkXSLEOThwFW
	 3lEeCZHbE814PcfelucxaCuFz9pYQC9X0HXbls1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbfA1RW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfA1QDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB5072082E;
        Mon, 28 Jan 2019 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691402;
        bh=kWpK/HnV9JtBXaeQN26gB/YUUoXK8zH4so1rYdjcUzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAs+PY4kM5joeBfhV/axAibLYvK/IbWxQq4bVkBsNmzuqoSDh2QAYpiHhJCDeiDoP
         WylogY45p7st6Y7ysucItWfxOPEdFMZ44OZa6RFknCC1Fe1meHgAoUEvDouh/fwZ0A
         jj7JqlcBPvRbdYa1TDXUEyUJ6HlwMWy2KbmszV9o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 082/258] drm: Clear state->acquire_ctx before leaving drm_atomic_helper_commit_duplicated_state()
Date:   Mon, 28 Jan 2019 10:56:28 -0500
Message-Id: <20190128155924.51521-82-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit aa394b0dd68cb00c483e151dcd84713d4d517ed1 ]

drm_atomic_helper_commit_duplicated_state() sets state->acquire_ctx to
the context given in the argument and leaves it in state after it
quits. The lifetime of state and context are not guaranteed to be the
same, so we shouldn't leave that pointer hanging around. This patch
resets the context to NULL to avoid any oopses.

Changes in v2:
- Added to the set

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20181129150423.239081-1-sean@poorly.run
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index f77bff5aa307..23397c08be11 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3192,7 +3192,7 @@ EXPORT_SYMBOL(drm_atomic_helper_suspend);
 int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 					      struct drm_modeset_acquire_ctx *ctx)
 {
-	int i;
+	int i, ret;
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state;
 	struct drm_connector *connector;
@@ -3211,7 +3211,11 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 	for_each_new_connector_in_state(state, connector, new_conn_state, i)
 		state->connectors[i].old_state = connector->state;
 
-	return drm_atomic_commit(state);
+	ret = drm_atomic_commit(state);
+
+	state->acquire_ctx = NULL;
+
+	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_duplicated_state);
 
-- 
2.19.1

