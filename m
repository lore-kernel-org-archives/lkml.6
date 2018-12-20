Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F80217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297844;
	bh=No/3/WtrRb1c1E+wGqRsr53qeK8fHr7sbuyh2mBQetk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eO1uez34mavYvDfs8qGCWMxzcNQl1fXF1YVDn8JKPBjx3G6/x9TDxgXOMXDcmt7UX
	 CXt4M3sYt1TZX2H2J7W1JqqcMQjE+iiOBLWaUEIM6dUjL8SY//0YEtIGXMFBWq2Bxe
	 68slTz5NA8wfXmuP3ZnstsjV6me4XoSXWHu4pz4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeLTJYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:24:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731728AbeLTJX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0555F2177B;
        Thu, 20 Dec 2018 09:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297837;
        bh=No/3/WtrRb1c1E+wGqRsr53qeK8fHr7sbuyh2mBQetk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zh6P8/Yq2Wy1T6iHwjJwTumkzEDWDxtfbcHzAeEw8gHg0EFYHxxrB69WwQzthxfcg
         Bud/Nw1ys8QDPZqYCby7RbNmBo872DAWyJhKe98cvcnHMRwIRIxuWpbk81NXlqQaAK
         0AZ+cpSNSRrVgUdfBZBl4wLqpPpJ4OuF6F2yjAGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 35/61] drm/msm: Grab a vblank reference when waiting for commit_done
Date:   Thu, 20 Dec 2018 10:18:35 +0100
Message-Id: <20181220085845.163060980@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



