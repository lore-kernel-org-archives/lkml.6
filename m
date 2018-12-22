Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BDDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5509621939
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3JUNh7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404173AbeLVT1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:27:24 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55673 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389727AbeLVT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:27:21 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so11598389ith.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 11:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFwfU0xFXcufPFumdupMa7jS24fXn34AP1pLKb4kCHc=;
        b=H3JUNh7gyzAt3zQW3K8PlL9xDQEwoxt955071gj9oeSBgv84H4omG1ZkCxfy403x0R
         dYWYkT5cUxbjUK/A3CH0ml7nAJ24PkC3D8wBXoIjk6RdVc04gDRdy1h6+lL/S8F69ZiE
         qprdUVdE4nbWc8dM9waCjDlZwstbtmmZtu1DT+wmlODSx9Zh5WUmzxYKXA9bk3mYnu4m
         AXoDMfgVi+UzxJRFGrrFDLdjQceyac+AkeeOz4EeX8xTvbS0lkeDmj8HRtLmaLtxDyfq
         xccS6z+TfiS4CZpEs6q/JYk1Hy1adBGCCSsde55mohGwqsMxNfq6IRdRxxjF1dysCVTC
         nUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFwfU0xFXcufPFumdupMa7jS24fXn34AP1pLKb4kCHc=;
        b=V5rHJT1zMhIv1tChIfzJCffkhv9nVrnUhhSRySvPDBVk5eTrmwVqfhfRfczeyr3Wul
         HjYyMXqCBF0SChjc4xZ/Gh/xZIP495+25MTALzMFUgX1PR+PF3TfUiagpvwIaSkyX+se
         9CRjBrdHLk/3FvEdJ1xQH96G1VHXtKsP3HscCAGvilusg3Ujajd+BVJ04VaZEnfGGDOt
         py16JB1av4pED7voDNUi8q9mIL0udqIJLJUpSemXbbkF/T5v01DXnMEDjDyDDXzckBLi
         Zu5H5s1UN0S3Yt8jzEn+/t8QBGua5XOKJZ6qzT0rkMZgZjL9exiTXIi3jnZ4iRWONDif
         6hoQ==
X-Gm-Message-State: AA+aEWb1PP1fTOdDY6cFFZjjG89X4ItMb4gWrBVl8I+EWlYSEG14Q4VH
        rgtkkrUOkQnzfxMoBz8IP+WvMg==
X-Google-Smtp-Source: AFSGD/XE9Yqmag/ApeSRSul62xM712ZoAzSsbhqpJPVrnQ8mVJFTO9lBNDNH1rKSmuH5HSGb/3bSgA==
X-Received: by 2002:a02:7a58:: with SMTP id z24mr5086061jad.22.1545506839427;
        Sat, 22 Dec 2018 11:27:19 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id y23sm10377045ita.1.2018.12.22.11.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 11:27:18 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     David Zhou <David1.Zhou@amd.com>, Samuel Li <Samuel.Li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 2/2] drm/amd: validate user GEM object size
Date:   Sat, 22 Dec 2018 12:27:12 -0700
Message-Id: <20181222192712.9420-2-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181222192712.9420-1-yuzhao@google.com>
References: <20181221194739.25523-1-yuzhao@google.com>
 <20181222192712.9420-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating frame buffer, userspace may request to attach to a
previously allocated GEM object that is smaller than what GPU
requires. Validation must be done to prevent out-of-bound DMA,
which could not only corrupt memory but also reveal sensitive data.

This fix is not done in a common code path because individual
driver might have different requirement.

Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 883a4df2386d..a58fb8e021c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	int height;
 	struct amdgpu_device *adev = dev->dev_private;
 	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
 	int pitch = amdgpu_align_pitch(adev, mode_cmd->pitches[0], cpp, false);
@@ -550,6 +551,13 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	height = ALIGN(mode_cmd->height, 8);
+	if (obj->size < pitch * height) {
+		DRM_DEBUG_KMS("Invalid GEM size: expecting >= %d but got %zu\n",
+			      pitch * height, obj->size);
+		return ERR_PTR(-EINVAL);
+	}
+
 	amdgpu_fb = kzalloc(sizeof(*amdgpu_fb), GFP_KERNEL);
 	if (amdgpu_fb == NULL) {
 		drm_gem_object_put_unlocked(obj);
-- 
2.20.1.415.g653613c723-goog

