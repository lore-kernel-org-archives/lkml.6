Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F8AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A5E2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzc+d/th"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391802AbeLUTsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:48:42 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50987 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbeLUTsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:48:40 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so8565956iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1U2AwO/N/jknlju2KBeVedZCjqcgimQmTmzWdyXLJs=;
        b=gzc+d/thmNWuyju4oxtAiaxswAkDuKxAkMrXdVY7O0IKcpb4yYaEoaBgwL5NrK79hK
         2taWiZ4pCl7oTbhcfwBQaPf6GLtI64jlKo8saEqAR7yJ7TXRBuTcPOKyJPhOXKrc1Sgp
         BU7fkkLuEx8EITaUgN+jehZNtmwC/TGBditWKcGD9H+kKHg191fV3wcgzPHxfEk+0YiK
         44Vo4feJbQ2uGsMhaa0PlVDd395iu/1uz9yMFD+yMg1E5QiyE+qnXPjPG99Kok4eCaSB
         ymtJ0INEncVfkoHjZ4tkM9N8MH/U0lKgJOrhw7WhWTqPTbF3FFKy6ySDptzQ3sLyMZiv
         HBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1U2AwO/N/jknlju2KBeVedZCjqcgimQmTmzWdyXLJs=;
        b=shgxw7aULHN2YJNKMHbRvz7acHxfd5zZMw/X0v6SATITpX186C0Ppy/Q1MJCND0G9S
         Rp9lqedBz+8RxE4ye9hN99N5i+cNEKKliZqT5mvXw9b2XM5r7FPKwrkB+kOWYVlftFem
         zXalT7QW6Yh06TJzB37wCjzYEdHNzDLtko2/cBqHM+mPR2oV74at7DGLEJA+61VSguyh
         7aTfCFS0UTmvRzgS1opIxseH74S1nB+mZ53v69/+b/zyp5jzWsxD4ka++aHchVWRFeN+
         5W7MHHcqgfS+l5L3yBu8tbJZIrZDW9qLYd69d2xqizYnwb3iHsEZMf+Dstx4dP9kwYaT
         bSUQ==
X-Gm-Message-State: AA+aEWYVDVE4GRkPfxLxwbL8wHoTaqeO3Ce1gOhAXWKGRtKSLC+Jmz27
        Y/XDhKxdqW1dJKD7a7gYBBz8ag==
X-Google-Smtp-Source: AFSGD/WwurslkpG+QZjCsyn3F/zleglrYUeArhFGd+bbwr51oSaakvhopn0gs65h8yDQp6dnc3HEdA==
X-Received: by 2002:a02:5184:: with SMTP id s126mr2381213jaa.12.1545421718311;
        Fri, 21 Dec 2018 11:48:38 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id h14sm11157581ior.41.2018.12.21.11.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:48:37 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     David Zhou <David1.Zhou@amd.com>, Samuel Li <Samuel.Li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        Joerg Roedel <joro@8bytes.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 2/2] drm/amd: validate user GEM object size
Date:   Fri, 21 Dec 2018 12:47:39 -0700
Message-Id: <20181221194739.25523-2-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181221194739.25523-1-yuzhao@google.com>
References: <20181221031053.240161-2-yuzhao@google.com>
 <20181221194739.25523-1-yuzhao@google.com>
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

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 883a4df2386d..098d6a816ee1 100644
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
+		DRM_DEBUG_KMS("Invalid GEM size: expecting >= %d but got %ld\n",
+			      pitch * height, obj->size);
+		return ERR_PTR(-EINVAL);
+	}
+
 	amdgpu_fb = kzalloc(sizeof(*amdgpu_fb), GFP_KERNEL);
 	if (amdgpu_fb == NULL) {
 		drm_gem_object_put_unlocked(obj);
-- 
2.20.1.415.g653613c723-goog

