Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C224C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E604020849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676068;
	bh=ttrfBu99qtgWpRc0a/8Ui+TleXiT555AvdMlbmPBL0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wt5zvnb60A0iQIreXK3HOW0UHwHM8VSp3wk3YIecgsTlhRARIg0r86odYojPcMlYF
	 0Ps1viRm6JuHZ2IET20zh3UjBW4Kry9Fg+m6y7nKGXxydH+7VkWkIY0wzigtmqeh0t
	 avGlIaDwX5AFYO5vJXSMcc0zO0xo1Byg8+r/fNtw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E604020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeLMElG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbeLMEcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92AFF20873;
        Thu, 13 Dec 2018 04:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675528;
        bh=ttrfBu99qtgWpRc0a/8Ui+TleXiT555AvdMlbmPBL0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhlZlkDGxJ9UoDkHUjM63u6x38moGCmBa4QyGuJ2ewEBn5qa2go/+00/wbMS1rgAt
         E5k/zXMzRnoITOwO0CcKYdulZt1SsvqKkio7S6GZhWqa4USKvqRB5a/jzgB24guLUr
         1smfet6qBII5xo4Ig+qvQa6P3n+uirVDSeJTv/jU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 05/34] drm/msm: Grab a vblank reference when waiting for commit_done
Date:   Wed, 12 Dec 2018 23:31:31 -0500
Message-Id: <20181213043200.76295-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
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
index 73bae382eac3..5c58a98f67c0 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -98,7 +98,12 @@ static void msm_atomic_wait_for_commit_done(struct drm_device *dev,
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

