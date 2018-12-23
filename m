Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7805C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6A5218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev6bRFMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeLWVwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 16:52:47 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43569 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeLWVwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 16:52:47 -0500
Received: by mail-io1-f66.google.com with SMTP id q17so4436184ior.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 13:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XygzaLnlh8fA4HxjIg+gRtTOPZSyENnxsvJMnBxmHwE=;
        b=ev6bRFMpf8JJPHuT6xoVyte6dSoRD6ARYbZSs0YjusLUeTtHzXH2qH7+90BFNfoqZN
         uqWtHfbKDarjHd2ygI1IWBau43OpTPn9YWa5ptSyh1k3aGjWFmcJz/17wBm1Hobx+PNg
         DVY6QIaSHlLE9ifi2NbJq2IRCVj41mPFZrtJfWyt8IOWRsUoH+xMqK544PWRq0V0fzbS
         xrMFbn2AgTd+970gcNKp3RK5Gv8OlXKteDZv7T2IcnWz178vBeg4vLHokWBUy+Il479N
         XhzPb597bS9fGcNQKrQRfwsLI4/RkVHeTF4LFtMTPC3eLvVPzRSNYjxH+Gf9tSKLqHGF
         vsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XygzaLnlh8fA4HxjIg+gRtTOPZSyENnxsvJMnBxmHwE=;
        b=kzXQoqpLxRnSZ8wAgwKh1OiNqwuucXdts+fgRCaLr3VNxsmK0EaJjktx651Rz5ne1h
         eVAXsjye0+eBet2iRZKnvq/3SMrKzVT2k9jm3tu6a61fnlBHSlGiby4Iagl5dG9Y9aqn
         u3ZZgomW1pDAaXVOFEnSc9KkJf3o5//8/Aes+31y+TwSPBR6+vD7xSjJ4dKo8dgt1g+m
         wPUSY7sHiLU4/crSpHDyKPBhH9MmzqY68Qan4gCN5mUXariuZBGmt7LfnlhRgs6ZRc4h
         WB9sAlzGbVP8n2G4JMik6EeyHaLjAJoKUFq39J9nBgHsCxMVLtUHAV1Lyb+1PYQEApe7
         Y2qQ==
X-Gm-Message-State: AJcUukeuUvuGs2b97sD+Ek4BDcI6/mpiktPIiyfMWTC2qYFncs0WGolN
        GVYqjb3nFD37FnmUL1iaPZNIXA==
X-Google-Smtp-Source: ALg8bN6ZJ1Ux5od/pGxwoVH1E5XiRYEa+BvmZn+u1HXAMxUVHFafMX6xGGe3TGPdo8amHA5GfGQ86Q==
X-Received: by 2002:a6b:ee16:: with SMTP id i22mr7203946ioh.124.1545601966020;
        Sun, 23 Dec 2018 13:52:46 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id v74sm10386881ita.27.2018.12.23.13.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 13:52:45 -0800 (PST)
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
Subject: [PATCH v4 1/2] drm/amd: validate user pitch alignment
Date:   Sun, 23 Dec 2018 14:52:38 -0700
Message-Id: <20181223215239.173339-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181222192712.9420-1-yuzhao@google.com>
References: <20181222192712.9420-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace may request pitch alignment that is not supported by GPU.
Some requests 32, but GPU ignores it and uses default 64 when cpp is
4. If GEM object is allocated based on the smaller alignment, GPU
DMA will go out of bound.

For GPU that does frame buffer compression, DMA writing out of bound
memory will cause memory corruption.

Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 686a26de50f9..af0626a2b528 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,15 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	struct amdgpu_device *adev = dev->dev_private;
+	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
+	int pitch = amdgpu_align_pitch(adev, mode_cmd->width, cpp, false);
+
+	if (mode_cmd->pitches[0] != pitch) {
+		DRM_DEBUG_KMS("Invalid pitch: expecting %d but got %d\n",
+			      pitch, mode_cmd->pitches[0]);
+		return ERR_PTR(-EINVAL);
+	}
 
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (obj ==  NULL) {
-- 
2.20.1.415.g653613c723-goog

