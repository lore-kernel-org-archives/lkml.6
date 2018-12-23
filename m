Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCB42184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQ6IRTp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLWVw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 16:52:56 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52459 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeLWVwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 16:52:55 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so13967841itg.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4T60ebSd3XIwaQkfiltqImM3j39ie8rJCcw2QWQ+cE=;
        b=qQ6IRTp0R0sDr0+/cQCb1bhVRyBuCmCtaXTPV3kTBlaLObAmpzTVBfH0HjRoXAuZfC
         d3WBdioCF184RSxQOc/d2ADGit34MQFBudOgHqi7yZBUFb7qxfXXtSGrEfB3EULjV76U
         4PVUdpS2tmMm3pZfI1Ky5aZH/eAe1sxuW2CSvYB09tRZCFEA4amu7vEF/kKrX51Z/aLk
         48095xl+iY0FrKoNb7Qv0/4RnhZSCYGdYal88WBZlDTP++qo/OyQ4I1EjgDKehU+v5Af
         ZZuKdN8KraBtlUTkxwahdlgn22t5eBdw6Jvpamxou5NrVhOCRSb3l39iVj1OMBkj3B5U
         iaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4T60ebSd3XIwaQkfiltqImM3j39ie8rJCcw2QWQ+cE=;
        b=d51UwzH2Ue56jdh1S3YNMvalgFe2BdlD3gRltM/hwBO2fThbYOaKYDISxDdLcTJ0yM
         cA/4alb+KuVSedS7+bZyMd1mgsvmEugV8kfdx2f12R2unM/Ruv+Wx7Q1dWquTrI6qSNF
         MtSlFlRuixe7PX/nZ6cwCEGWTFYMpi4IWSauPpmyVvNG2+M+nqmP3BHvjbIdrCdOpuW/
         fAqU9kdSrRuYBdZ47zvbfDA76+C2E4tHr5xiQxsI8FFAgXSwUN6zgYbK02hKT0Dybhvc
         yOm4mhMeiFGdw+O5Z7K5T09//li8p+AqHhcKVZvhm+f/+7pK+5Hi19D79QBA1pLJT7yl
         CcTQ==
X-Gm-Message-State: AA+aEWYidJWbbyl4VH/8NIRo6uArqDQd7b+yQJlSLaIIYVBU/kqrLGZd
        VZynXWVEnqCAVsh6guZLjb5IEw==
X-Google-Smtp-Source: ALg8bN5eaPeMB6wtGxTyPsVHIjBWbJ3noWa+b7wMn1wFlFQ6EWxGO3Y1wQN6EW3JzLyfmKWVWfrm1g==
X-Received: by 2002:a24:878c:: with SMTP id f134mr7405915ite.81.1545601973690;
        Sun, 23 Dec 2018 13:52:53 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id v74sm10386881ita.27.2018.12.23.13.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 13:52:53 -0800 (PST)
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
Subject: [PATCH v4 2/2] drm/amd: validate user GEM object size
Date:   Sun, 23 Dec 2018 14:52:39 -0700
Message-Id: <20181223215239.173339-2-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181223215239.173339-1-yuzhao@google.com>
References: <20181222192712.9420-1-yuzhao@google.com>
 <20181223215239.173339-1-yuzhao@google.com>
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
index af0626a2b528..9aa23cb20873 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	int height;
 	struct amdgpu_device *adev = dev->dev_private;
 	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
 	int pitch = amdgpu_align_pitch(adev, mode_cmd->width, cpp, false);
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

