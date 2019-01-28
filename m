Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78677C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A62173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692396;
	bh=Pvg5B9F4tecx/bOmiYjKXwTdadFwK2EXttTnRi7aOig=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D40+YI33pXmPCrVxLUVrjMdQHI9dElHHMKJjt9U+pWn4ZlyyA/5iH4ScEsfc0tUPY
	 gn/49xn3PerG8IPVvDRAFrZ2xQoQPU1xm2HscY3MkOJqztS5Zm/brtDfDQNCnFM5oi
	 JM188RTTk5pnGJ2UfApcMhPw2FKMPimoDzH9DzSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbfA1QTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388679AbfA1QTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:19:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC0672084A;
        Mon, 28 Jan 2019 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692391;
        bh=Pvg5B9F4tecx/bOmiYjKXwTdadFwK2EXttTnRi7aOig=;
        h=From:To:Cc:Subject:Date:From;
        b=DJECOCbaNEBWZYPvnrVZ+cLdB3aQ6+FrGVk9PKqIF9t8BHbNb0LqBMucbk8AP+tGR
         IQfcH+wasSN+UhKY9hiyOT9f16t19D54oEwQe7mwaZV+LezlVzPS4tlOJrP5N3vYhI
         z745+jNnQYFvET2ZAmSenDFyWr/b0tfPEXK+XCTc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 001/107] drm/bufs: Fix Spectre v1 vulnerability
Date:   Mon, 28 Jan 2019 11:18:01 -0500
Message-Id: <20190128161947.57405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit a37805098900a6e73a55b3a43b7d3bcd987bb3f4 ]

idx can be indirectly controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/gpu/drm/drm_bufs.c:1420 drm_legacy_freebufs() warn: potential
spectre issue 'dma->buflist' [r] (local cap)

Fix this by sanitizing idx before using it to index dma->buflist

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181016095549.GA23586@embeddedor.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_bufs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index adb1dd7fde5f..9ccd7d702cd3 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -36,6 +36,8 @@
 #include <drm/drmP.h>
 #include "drm_legacy.h"
 
+#include <linux/nospec.h>
+
 static struct drm_map_list *drm_find_matching_map(struct drm_device *dev,
 						  struct drm_local_map *map)
 {
@@ -1413,6 +1415,7 @@ int drm_legacy_freebufs(struct drm_device *dev, void *data,
 				  idx, dma->buf_count - 1);
 			return -EINVAL;
 		}
+		idx = array_index_nospec(idx, dma->buf_count);
 		buf = dma->buflist[idx];
 		if (buf->file_priv != file_priv) {
 			DRM_ERROR("Process %d freeing buffer not owned\n",
-- 
2.19.1

