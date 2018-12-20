Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF95C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3B121741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298160;
	bh=N37Hvjupbx6iupCnZNp7o9Kmo/LKLom12hE382b/4YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wBY66yKW21RdcmuRQUTztwTtEht8DAg93CorYxBWqT0POUsajCTU25rLkHqdgXqXM
	 KwFzy5kkC3iUjUraOYh2Ywri29sBMVhU7HpNuf8eIcj5mYzLGGior2mHpE1oNiyrx4
	 k3LB+MkRNx8GKCi4cwqbmwKUhMNZJwW9vhZZDpyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbeLTJ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732663AbeLTJ3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F9C20989;
        Thu, 20 Dec 2018 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298152;
        bh=N37Hvjupbx6iupCnZNp7o9Kmo/LKLom12hE382b/4YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRKh/40B/2/bt0FtoX9hd3c7uEIq+MXIMybB9ToPInyuKQxkQ9/KGYA8Og/RXdL7f
         3ozRGtc1iOsOLF9lM8qP87LswE62HgHrEJPPhHBHVUQH+KevLi9hxc2Few4aL+q5yG
         OCcaj2u9ik0DcyJJME05B16bJlpAEjzyM5gVy030=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 19/67] drm/ttm: fix LRU handling in ttm_buffer_object_transfer
Date:   Thu, 20 Dec 2018 10:18:31 +0100
Message-Id: <20181220085904.315882814@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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



