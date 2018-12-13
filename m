Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D94C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CDE20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675594;
	bh=QW1MSBku8/10q+xpmvsf5YZa8MJn1+v2uvoEKFpGnRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D5xUjWHpBLZDILzI53E6AswgTDb84UZzRiMIHtOXXUMLR/QvUArpLt7EiTXtFwGch
	 981TP7gXkbBR0yjlm+oJjOj9CtN8r9j7Y/vowpunVEkvhLj6AvNBuafmBJCk6Lgme7
	 nJlOyKVLYpKQ9u1m1OhjPeQqDuCE/PVJxWCB0AaY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CDE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeLMEdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbeLMEdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A24F20672;
        Thu, 13 Dec 2018 04:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675587;
        bh=QW1MSBku8/10q+xpmvsf5YZa8MJn1+v2uvoEKFpGnRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTyE0JjrBxtmzCT7p1Q1VsT3lp6rpjy5eif/DRD7RZDXxqD1KyuMjmc3CwMRQouwV
         bo7B81MqPTQhuQIrkL//jF6YE5AlIbH2NYzgNiRP8AA0MfPIn5Y5DEL4/ki9w78eBV
         f6rhb4VP1SGIlENmDiRCHXjRbJxWlMprsjZ1Rso8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 05/23] drm/msm: Grab a vblank reference when waiting for commit_done
Date:   Wed, 12 Dec 2018 23:32:41 -0500
Message-Id: <20181213043259.76643-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043259.76643-1-sashal@kernel.org>
References: <20181213043259.76643-1-sashal@kernel.org>
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
index 7eb253bc24df..221eaea651d4 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -107,7 +107,12 @@ static void msm_atomic_wait_for_commit_done(struct drm_device *dev,
 		if (old_state->legacy_cursor_update)
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

