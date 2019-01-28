Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449CBC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1550021741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694956;
	bh=7FZ5EnI9asJP8DlS8twIMU6gHDY2EtJVMTWbxVeu1hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1na0cXhylSCHK1G39X3FENE6WfAhh7aJCmlxcejF2GbzXkD97Xit6gnaxjmHKCZas
	 cZADI30RrdpUUdmuVKnJYPgUebn8z1abgmPCHeginQO3vsxyyws1S59MnZu5ioHBFP
	 ivI+8g9GX2Y0RUr07LAOcR0Ghgq1dzrU61F9E71M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbfA1RCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:02:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732627AbfA1QOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:14:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B8920879;
        Mon, 28 Jan 2019 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692052;
        bh=7FZ5EnI9asJP8DlS8twIMU6gHDY2EtJVMTWbxVeu1hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlOcYc3Y30Uj6oBDASMjUFahvtIWuSikrmSihCWNzv4wueAovRl72VF/Yse++iRVf
         I08RcQ/MiG8TBQ2y5m7UkaAspRAGCLP8CxyNI7aKTCrvRmOz7IK3+gQEPqaBcMgjp4
         N+2N2mgtJmPKqJ7ZVi8ga2xw2A8ayoTmgVmZD0Bs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 054/170] drm: Clear state->acquire_ctx before leaving drm_atomic_helper_commit_duplicated_state()
Date:   Mon, 28 Jan 2019 11:10:04 -0500
Message-Id: <20190128161200.55107-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index 1f08d597b87a..d05ed0521e20 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2899,7 +2899,7 @@ EXPORT_SYMBOL(drm_atomic_helper_suspend);
 int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 					      struct drm_modeset_acquire_ctx *ctx)
 {
-	int i;
+	int i, ret;
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state;
 	struct drm_connector *connector;
@@ -2918,7 +2918,11 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
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

