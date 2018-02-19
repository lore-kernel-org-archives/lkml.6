Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeBSJ5C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:57:02 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35866 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752347AbeBSJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:56:13 -0500
X-Google-Smtp-Source: AH8x224DH5lH9KSP20AP0BGfRmeu+fGM4w4pfWDBBOzRoFRX+g85AqW9Fk2qT2P36uO4D77GeHm9LQ==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: use new ww_mutex_is_owned_by function
Date: Mon, 19 Feb 2018 10:56:08 +0100
Message-Id: <20180219095610.2747-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180219095610.2747-1-christian.koenig@amd.com>
References: <20180219095610.2747-1-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index eaa3cb0c3ad1..4c04b560e358 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1594,7 +1594,8 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	*map = mapping;
 
 	/* Double check that the BO is reserved by this CS */
-	if (READ_ONCE((*bo)->tbo.resv->lock.ctx) != &parser->ticket)
+	if (!ww_mutex_is_owned_by(&(*bo)->tbo.resv->lock, current,
+				  &parser->ticket))
 		return -EINVAL;
 
 	if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
-- 
2.14.1
