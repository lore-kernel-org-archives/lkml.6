Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeBTM73 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:59:29 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36526 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeBTM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:58:32 -0500
X-Google-Smtp-Source: AH8x227dJJy8+7laUPe+FrUiYkRjM9KaoZdR4kB6R9AnIeA2ny2Y6LpzaUR30hVqBHqIqKypr93NQA==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/amdgpu: use new ww_mutex_is_owned_by function
Date: Tue, 20 Feb 2018 13:58:27 +0100
Message-Id: <20180220125829.27060-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180220125829.27060-1-christian.koenig@amd.com>
References: <20180220125829.27060-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of accessing ww_mutex internals directly use the provided
function to check if the ww_mutex was indeed locked by the current
command submission.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index eaa3cb0c3ad1..6db26a3144dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1594,7 +1594,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	*map = mapping;
 
 	/* Double check that the BO is reserved by this CS */
-	if (READ_ONCE((*bo)->tbo.resv->lock.ctx) != &parser->ticket)
+	if (!ww_mutex_is_owned_by(&(*bo)->tbo.resv->lock, &parser->ticket))
 		return -EINVAL;
 
 	if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
-- 
2.14.1
