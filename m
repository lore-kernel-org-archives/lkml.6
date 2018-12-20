Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F428C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40490217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298028;
	bh=DuJdRJFnvgBOzjGz58IHAaAXXvIzCiAYC+naEfaLZJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fqJ89zMvXP3I7J4Ip0lsc3+8+Obo7FpcBd+kc/ZGvzrWpO2NyLsCqzaSKsgLqTDxT
	 XUqicQXQe3lFWkNsMZ3pefAHKaIIcZjw+NhsI8oRaKXZbGVaoC/scUKsjShXXq0HYA
	 w+fCZjxyL7XMj0KGuwi3YhIe0r8cXxNfBM/ZyIEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeLTJ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:27:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbeLTJ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E6B21852;
        Thu, 20 Dec 2018 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298017;
        bh=DuJdRJFnvgBOzjGz58IHAaAXXvIzCiAYC+naEfaLZJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMa34ZYbeVwNAWvf3rgH/VXo5HTNuSIflOsARyKzVEwbQh1Y11WjEbGlwbs2ECsYt
         1/lOCDbD7hmlbP8n6wRtfp1keSidcusi8Dr+RAe/3dliiU5Za83z2+VYlflzTPbXWg
         XQsz4bSTSJp6Bh+4A52VzZixiiqCNo2cLYMtVoCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 41/72] drm/msm: Grab a vblank reference when waiting for commit_done
Date:   Thu, 20 Dec 2018 10:18:40 +0100
Message-Id: <20181220085923.966567772@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 025d454163b0..8f77047a226d 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -93,7 +93,12 @@ static void msm_atomic_wait_for_commit_done(struct drm_device *dev,
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



