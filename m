Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E73C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 01:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECAE20866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 01:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZvtF7Hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbeL3BAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 20:00:38 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38287 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeL3BAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 20:00:37 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so19334009ioj.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 17:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VoZCPAIOo56X8jxQuwnagM6/gHNO38r9aT3jg1gFLNQ=;
        b=hZvtF7HdC4PBbGNHsq08EbPnNJCEJlkqkO1dpopyVTkxEyIngtAzlS05Y4m92qHlhl
         MZxgU0QWBvAZF9Q5hhkXe4nMJSjA/OnnFIRfSPAD0zdW3X6H+f+Twh5cgAbWVu++Y6GT
         HJwicah4QOT01VhUDC/MEkaMJUn3dGexFGhAMlRS8I+tj75w1SXSACyOO4O9aSHHlWK7
         NOHICpkH5Affzmqi1K0euCSAu/+EyAh8IJ14Q/K/tbEzDkA/eD+qEK5OXNspPMk40gfv
         omhm1ATmz5bv36PFf1z4StbaB+cOfqs8fddQXGcOmo+ps1K6bmUY61cuPEDqmmVRz8uQ
         eyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VoZCPAIOo56X8jxQuwnagM6/gHNO38r9aT3jg1gFLNQ=;
        b=NWirrMljnj5ZwBGHj/37dq2nZKlAEQKBInhLdyMaAWNZfg3NVUiJ8lbnbkRHjB1h+q
         zitjHSO6CG7N4SSyjcitYoRwi0EzcQUdDcTexdVgLMzoLsRzpvU9hdYVTsuIhU2PAyrV
         upIwBuNdvSK+IgmXaMm6sc08XIy+rlBO/1x26DyhoBY+W5meuokJrFWecojx8IRLzwzv
         IKdf5qjlogA921hIja1EQASVqx8YFFmSt6SWm3Hf3UnLKWywsI7z9jTSBIhmPEEwOW9F
         4dm4jOHV20KPr9tL1rLtjj1bhygOiUU8mnUT/bl6bKhRJl3TN1y4GSpznBHlKs03gOPy
         ukGg==
X-Gm-Message-State: AJcUukcuKbi5JVyl5K3xn/GLWwByoiw5Ogzgc9Xz/LlRfV7CrMZpLmc1
        lE56mxCwCU9M8265tYmnFrR3FA==
X-Google-Smtp-Source: ALg8bN63F+DG1p7TH+rxIzS/lX363d9CqOk7NUhaCaf3DeqaUFXNZswo+JsLBl4XsutPoyg75RTxIg==
X-Received: by 2002:a5e:dd02:: with SMTP id t2mr3438495iop.106.1546131636124;
        Sat, 29 Dec 2018 17:00:36 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id o6sm5039048iom.74.2018.12.29.17.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 17:00:35 -0800 (PST)
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
Subject: [PATCH v5 2/2] drm/amd: validate user GEM object size
Date:   Sat, 29 Dec 2018 18:00:21 -0700
Message-Id: <20181230010021.196990-2-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181230010021.196990-1-yuzhao@google.com>
References: <20181223215239.173339-2-yuzhao@google.com>
 <20181230010021.196990-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating frame buffer, userspace may request to attach to a
previously allocated GEM object that is smaller than what GPU
requires. Validation must be done to prevent out-of-bound DMA,
otherwise it could be exploited to reveal sensitive data.

This fix is not done in a common code path because individual
driver might have different requirement.

Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 16af80ccd0a0..61c075a78ee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	int height;
 	struct amdgpu_device *adev = dev->dev_private;
 	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
 	int pitch = mode_cmd->pitches[0] / cpp;
@@ -557,6 +558,13 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
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

