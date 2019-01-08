Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D626C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3749E2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976852;
	bh=QAuzKGbon8A2K7gB7ShJNWYV2hyYv0vmnci+VJQ1o6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HQt9kiVvsLqaZKDUY8t/76fAMwvnnDbkmF7xYKk+3DdHzBiSsjhdTBfdJU04zOTck
	 9P5LNCuKtW7wK0YnPXn3D7xKxSaFeFXXUOl6K/QPxOFI2qxnOoj9P9makxQNmihE4S
	 lcM47gXUjJgwbR5cJo60wJQUTKb3VROl1mK7Rg5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfAHTrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731466AbfAHTct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B917920645;
        Tue,  8 Jan 2019 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975968;
        bh=QAuzKGbon8A2K7gB7ShJNWYV2hyYv0vmnci+VJQ1o6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8ay6QEIx9GU/c2L7cSLFtZd9ilJOtzM7FpZpuLdbUqHl7GW9ey+cVWBXE4LxeMp9
         qo1LIaLQOS85DVs1Pr/jDbonQT1ZswSrXzL01qr/FP/xpTEkFV1RxDZLqeJsIzH9rd
         E0vZFWHZTn0z4USl07HJxCk7hOazbUx0rMt23ZEc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 13/53] drm/amdgpu: Correct get_crtc_scanoutpos behavior when vpos >= vtotal
Date:   Tue,  8 Jan 2019 14:31:41 -0500
Message-Id: <20190108193222.123316-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 520f08df45fbe300ed650da786a74093d658b7e1 ]

When variable refresh rate is active the hardware counter can return
a position >= vtotal. This results in a vpos being returned from
amdgpu_display_get_crtc_scanoutpos that's a positive value. The
positive value indicates to the caller that the display is
currently in scanout when the display is actually still in vblank.

This is because the vfront porch duration is unknown with variable
refresh active and will end when either a page flip occurs or the
timeout specified by the driver/display is reached.

The behavior of the amdgpu_display_get_crtc_scanoutpos remains the
same when the position is below vtotal. When the position is above
vtotal the function will return a value that is effectively -vbl_end,
the size of the vback porch.

The only caller affected by this change is the DRM helper for
calculating vblank timestamps. This change corrects behavior for
calculating the page flip timestamp from being the previous timestamp
to the calculation to the next timestamp when position >= vtotal.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 6ad243293a78..8c0a208e43c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -855,7 +855,12 @@ int amdgpu_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 	/* Inside "upper part" of vblank area? Apply corrective offset if so: */
 	if (in_vbl && (*vpos >= vbl_start)) {
 		vtotal = mode->crtc_vtotal;
-		*vpos = *vpos - vtotal;
+
+		/* With variable refresh rate displays the vpos can exceed
+		 * the vtotal value. Clamp to 0 to return -vbl_end instead
+		 * of guessing the remaining number of lines until scanout.
+		 */
+		*vpos = (*vpos < vtotal) ? (*vpos - vtotal) : 0;
 	}
 
 	/* Correct for shifted end of vbl at vbl_end. */
-- 
2.19.1

