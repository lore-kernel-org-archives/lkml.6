Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4318BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1A82177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297699;
	bh=tXkvE51Nh0VuvkEta3rtxohv3Ghe4q1VuJE3CHnFdOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OqFAkK+2CMQTqcewLjA2Hpnz04rvFbU3/ZwLAnLMrH3xlv7u2YrZh3MlD5FBPCNGz
	 46wOzdvJUp33Us1Tt8ZB4TwUTNAjCYbhOHhYKJWuKI1Ri9aTTnRTO4hIf0k/wpaeFg
	 4r/s7cuoPi5FLJS1ql7uF2CbvjumVZotzD04vj9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbeLTJVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731117AbeLTJVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9977C2177E;
        Thu, 20 Dec 2018 09:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297694;
        bh=tXkvE51Nh0VuvkEta3rtxohv3Ghe4q1VuJE3CHnFdOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAeuM54/YdqA4IrBsZ8F+MbVooltPQKAgJ2BMK99XbK/xtsF8EC3yKiCIy5xI/ADR
         AYWwi2W75sHvWwrOztc3cXoRW5ZEQu7ZNGAat3c5acBQoEUVPpU8+vSaduvG4i+kJO
         jPHYJ92trmZuwcRVXYk9TfbTMwSnAejy8PhJBeLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 22/40] drm/msm: Grab a vblank reference when waiting for commit_done
Date:   Thu, 20 Dec 2018 10:18:34 +0100
Message-Id: <20181220085827.355559756@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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



