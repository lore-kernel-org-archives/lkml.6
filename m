Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8BEC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF1420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676709;
	bh=BFCEHZ8AjQgoMgw7tXT0yCDibWtijqsfaZm2itt84Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GMFiGKXMCm2nrTF1/OK0QtHkd58om98/SAbhtvVzcGcEBgr1vkhzIlONJZbgz36H7
	 N+1JXTrWPHbswuYeATlfZTWXgaK5y0SdqZFjWwQKUo4041RZglkWAf95Gx+1CGSxho
	 zydhmtqW+IUm/NZ5XduuRPMU1AvmqgVXaeOLPZas=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF1420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeLMEvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:51:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbeLME3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 346D42087F;
        Thu, 13 Dec 2018 04:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675345;
        bh=BFCEHZ8AjQgoMgw7tXT0yCDibWtijqsfaZm2itt84Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNHPWXcdEgxcGgB6FpUqwz5tv5Ur+V/JA2EVYNrwtfH4fl5XV2wpAPc0KGoBsvJSU
         xjJ9ZXMkqY00kIW2txYFvNQmeFdHtMe1eyc5g/jB45aSX/GZH14mqkFvAFVKV1HQKi
         m9GJp9yBBHZ3ntOz0M5z1ChoLzvFgndRDxsRX9y8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 17/73] drm/ttm: fix LRU handling in ttm_buffer_object_transfer
Date:   Wed, 12 Dec 2018 23:27:42 -0500
Message-Id: <20181213042838.75160-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit d6e820fcd4cf08b11d291a1dd7bbd0636914647c ]

We need to set the NO_EVICT flag on the ghost object or otherwise we are
adding it to the LRU.

When it is added to the LRU we can run into a race between destroying
and evicting it again.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 046a6dda690a..40904e84f883 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -492,8 +492,10 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	if (!fbo)
 		return -ENOMEM;
 
-	ttm_bo_get(bo);
 	fbo->base = *bo;
+	fbo->base.mem.placement |= TTM_PL_FLAG_NO_EVICT;
+
+	ttm_bo_get(bo);
 	fbo->bo = bo;
 
 	/**
-- 
2.19.1

