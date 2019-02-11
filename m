Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4533CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EE620838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896120;
	bh=RHd1Mi7b1FOIOVCT2MarXi4McRknbt7iKs0zOl3F1rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KVkKNk7Rgz7FWtmB1IX+PM4zpS58PZgoyrr3pU6l/10OfaRZTXORW1+rXmv0b8Mua
	 +vlVcOnWQphCo2a9a9c9fY1wYpqZy7kVgXq4EfiA/LtMsy9VFj8meygFznbJsauv0H
	 NCMof36n6hM1w5lLshpaz7384npRaPWmd8oD8nHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbfBKOl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:41:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731816AbfBKOlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:41:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22BBF20700;
        Mon, 11 Feb 2019 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896114;
        bh=RHd1Mi7b1FOIOVCT2MarXi4McRknbt7iKs0zOl3F1rU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqRfhunztmeaxhQZlsilBejWT4vtigq0+gleP8N/acPSOLkNhymXfq9Z6aDt3jqqm
         jsGmDx8i5A5a38VcUIkDFfgC5UmC4ptFRYqTsbYsR9WREKstJ+ZRMm1z8Hk6WEqXZ5
         jlOyewbaLnQsJSqlnNlscDzvsPHYAJ9xm+oFZCc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/313] drm: Clear state->acquire_ctx before leaving drm_atomic_helper_commit_duplicated_state()
Date:   Mon, 11 Feb 2019 15:15:57 +0100
Message-Id: <20190211141859.019177196@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



