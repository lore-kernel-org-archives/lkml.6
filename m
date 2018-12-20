Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3C1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5C120989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298157;
	bh=xk1/BjSEE3bbjpEMG0nIv+rKbZ9Od78dAktpOOyHoCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VyuMq1oox7SdRecWdR3eXk2jPUY70FL9e1hbqjiUzlDhwESDFkSVs1938vnyBIEfn
	 RWZB+MHNnMmoBWOBvgIf5YSFs/NnB47H7qdnt/jSUczHFk+KYbwSpQ7HX9qaIvBocG
	 rvBKdetoY+jlgH7Ek4b98cKKjsfrWUemB73H75T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbeLTJ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732645AbeLTJ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B87620989;
        Thu, 20 Dec 2018 09:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298149;
        bh=xk1/BjSEE3bbjpEMG0nIv+rKbZ9Od78dAktpOOyHoCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Da6xB4OiuuQ+6b6XAnoSb3YG/6ndtbqN9jzOAC/CfF1DmPjO4JgQy+wtRP2fXWbRV
         mAe+hAE++eO1GIifkYWvCMU0onvD4v2nEm/tOmBLM7gt1+XkiFxMHhxSpVFPDj6DON
         P7PbHGZRpUrJQzf/9v163wsvWhq+P1LeEgk3qUMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/67] drm/msm: Grab a vblank reference when waiting for commit_done
Date:   Thu, 20 Dec 2018 10:18:30 +0100
Message-Id: <20181220085904.278309198@linuxfoundation.org>
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



