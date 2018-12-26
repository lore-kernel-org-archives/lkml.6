Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD098C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC832070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865323;
	bh=XbytHSzGyTLSqEJykfWhYWEYXJzKkuXJBvdY2ueRJlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fqz6SoDz8AFsA7ikV9AU7mGKX8NV4l2hPCoXZC5BtdwDBzf5sQ6o9lCJSOLvO/wVc
	 BcnQHyWJhkmHhoCPAcT2XpL8HtYTt+ioBZDZCPv8yeojQAkkbe99oJbpHu0+nyYmU1
	 teVNWgfZiDAWqyZJPkXETHJyTVq6ldctH6a0TIm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeLZXCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbeLZWgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39F7218E2;
        Wed, 26 Dec 2018 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863779;
        bh=XbytHSzGyTLSqEJykfWhYWEYXJzKkuXJBvdY2ueRJlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k09saUeCmV0HWTP63Yh/SCcY4IhT5f5zCyIb2Cq+0vnl8OsNyPhnGM1KCtkw4UiGC
         Ohp5rnboApC7GgsGweKa5ztCrrRRmsL05AnYhQiCHtgJjN4DeVlGrdNPjS3knM2110
         9i/IddGaSjIBYTKlQA3kaByqcVtn0Bb/EHy6z3ok=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 13/97] drm/amdgpu: Fix DEBUG_LOCKS_WARN_ON(depth <= 0) in amdgpu_ctx.lock
Date:   Wed, 26 Dec 2018 17:34:33 -0500
Message-Id: <20181226223557.149329-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

[ Upstream commit c554206077428af56cc2e0314b86b41cd030458c ]

If CS is submitted using guilty ctx, we terminate amdgpu_cs_parser_init
before locking ctx->lock, latter in amdgpu_cs_parser_fini we still are
trying to release the lock just becase parser->ctx != NULL.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b31d121a876b..81001d879322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -122,14 +122,14 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		goto free_chunk;
 	}
 
+	mutex_lock(&p->ctx->lock);
+
 	/* skip guilty context job */
 	if (atomic_read(&p->ctx->guilty) == 1) {
 		ret = -ECANCELED;
 		goto free_chunk;
 	}
 
-	mutex_lock(&p->ctx->lock);
-
 	/* get chunks */
 	chunk_array_user = u64_to_user_ptr(cs->in.chunks);
 	if (copy_from_user(chunk_array, chunk_array_user,
-- 
2.19.1

