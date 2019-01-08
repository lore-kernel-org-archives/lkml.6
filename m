Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB2CC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBFD20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975834;
	bh=OGaIugmgZ3J/K8vadnwfwUTqckxLGgZ8rpLqOd726cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GFrBobPJB7Y1+vHFC+ona9PgBIT63F6TW5QnYY4OILGigjIefViFxqizkbeIHCV/O
	 vLrCdevVIacsbd2PT2KZv3ZRiiZLo/lgP7L7Hmgb18of6KoeVD0vLIRdSVNcjkMwUG
	 0MyM1JhYvW+zXLGsxZpAJjpUmHdANJ2MZ7fGUQE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfAHTae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbfAHTaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDDEC20645;
        Tue,  8 Jan 2019 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975829;
        bh=OGaIugmgZ3J/K8vadnwfwUTqckxLGgZ8rpLqOd726cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xZ7DiG5rjwTwzkVNz12tOw3T+3q5d0YKVQwb6OBiYmKUE/W+BmvT/tcE9cEofuZp1
         HqzMxiBL2aIilp2exGT+5zFiDpVREI9s0IWfZL9EOauOFRsMV5j/QAunOPrKTKIjIU
         OkPOicmuRTXOWeMPTfK8x3GkT7Ewrn5cqKJwwHLI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 26/97] drm/amdgpu: Correct get_crtc_scanoutpos behavior when vpos >= vtotal
Date:   Tue,  8 Jan 2019 14:28:35 -0500
Message-Id: <20190108192949.122407-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
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
index 686a26de50f9..9c940bbed608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -857,7 +857,12 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
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

