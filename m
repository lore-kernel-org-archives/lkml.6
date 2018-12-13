Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1658FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24672080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676704;
	bh=87wMa19j3zV9fhlC6uKzNhaqNhRh5ySWn9cJ3RS0zc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NLW5NjF+UDtG5cEMNu+zxUk7HR5JkHofv8D+jFGgiWy2wtOF+UjUJebsRt6yUc1XM
	 X5b9S3QqP0I0oJF0Ag5uj95kB05PRCE2XNwc+wzQe2yY5HExw/1/dvJl3KxkpScA4k
	 RV0Y96EWKuylihQ/6qmy6UMlvtfZGeDnTLKaSVhk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24672080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeLMEvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbeLME3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B3620879;
        Thu, 13 Dec 2018 04:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675344;
        bh=87wMa19j3zV9fhlC6uKzNhaqNhRh5ySWn9cJ3RS0zc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+lR2YP18yMmSdaraIoykjOBbrf8tcfwngvCGeLXfHwhMTElEP0bF8Z0Jbc889Ylq
         IGLrW5AsDy1itskMpZeDBBKl+FdHfDczDfXYM9r91fpiZG4V1+UPvntT0Yo28caAkx
         GfL78PWY5OoadAWHfzZnIbe7Pwe/1GoSPaorksio=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 16/73] drm/msm: Grab a vblank reference when waiting for commit_done
Date:   Wed, 12 Dec 2018 23:27:41 -0500
Message-Id: <20181213042838.75160-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit 3b712e43e3876b42b38321ecf790a1f5fe59c834 ]

Similar to the atomic helpers, we should enable vblank while we're
waiting for the commit to finish. DPU needs this, MDP5 seems to work
fine without it.

Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_atomic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index c1f1779c980f..2b7bb6e166d3 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -32,7 +32,12 @@ static void msm_atomic_wait_for_commit_done(struct drm_device *dev,
 		if (!new_crtc_state->active)
 			continue;
 
+		if (drm_crtc_vblank_get(crtc))
+			continue;
+
 		kms->funcs->wait_for_crtc_commit_done(kms, crtc);
+
+		drm_crtc_vblank_put(crtc);
 	}
 }
 
-- 
2.19.1

