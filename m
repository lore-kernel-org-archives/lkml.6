Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77928C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC8A2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217310;
	bh=OQ+07Dh7TAh1dFcwG7KI8NcPTiVi/D49OZ3vo1M0QQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fNxWaAUk2DicpiJ8GxFMwJNgcsFvA5vdU1PI7bC1gSq34SgUev6nKFjm/R0PR81k+
	 GPV9ckpEIbcC062qfQZpeC/y9e9gVQmr5Fycn/Wag/lLdj7v5TDMksoOVBdmXtS6aT
	 zjZzr/IoX1x56bTtUmxX8dYfbnnzkz/pe/YObTbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbfAKOfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389626AbfAKOfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E662063F;
        Fri, 11 Jan 2019 14:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217303;
        bh=OQ+07Dh7TAh1dFcwG7KI8NcPTiVi/D49OZ3vo1M0QQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cX3Y07ofr6yBZOj272DUS2uHCMcXBvdC9pzPTI2X37tz9OpJZzpjWdRc9gUTlJOrE
         TDq+8mH4YN6TkjQndDChFZHW0TNJgZWw5Sm/LGZFy6BANXasWf7cw9gybNBVj4R7zO
         /meS7ZeS1TKUSOWoSqnvLfvs3o2KnEOmm5EIEAIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/148] drm/amdgpu: Fix DEBUG_LOCKS_WARN_ON(depth <= 0) in amdgpu_ctx.lock
Date:   Fri, 11 Jan 2019 15:13:11 +0100
Message-Id: <20190111131114.863293100@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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



