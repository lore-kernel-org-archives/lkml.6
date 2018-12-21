Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F68FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152412190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCaGiSFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391789AbeLUTsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:48:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34630 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbeLUTsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:48:38 -0500
Received: by mail-io1-f66.google.com with SMTP id l22so1410152ioh.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OVSHWNk4j44/NEJZil+PbDIgCZZhA/ex4ZcaIDuIdNg=;
        b=JCaGiSFYD9ft5Lkz7OBzPHNtnRTBR4/G5K64IYtqPYdKrKFhZulOfM/WRr0UhGqJr8
         kOb+bGv6ZcT6p5P8P41uZDNAcxFE6ujqz5DglMfxaWF+JGk7cBLudFRjFTGQqf4cEImf
         k17piPpEIFQaGyMyp7Z5FXtLkY8zZW781kDGeYg4JtEiSets/Uv0tzbvySl5tlqFKGZz
         81dZbkKZgxNodLiK8la3gOi0dXGU+DRB6w/qH5GK9d15/04l88bfrEUKiNun874uaGm6
         arSdRhxlp42FW5xQCzZ3g0xWTA6HY/5bfoA8UAeVNpaFYUSahR3ZHCX3fc2n7F8EofN2
         K+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVSHWNk4j44/NEJZil+PbDIgCZZhA/ex4ZcaIDuIdNg=;
        b=Q0J1xF9RdKJWkDQ6LXqTisH9OBo6Qm13J5P/EOBmgNo7poeOx676D9+DBepQQJ5MPZ
         meibvVxIPoeY5R7j/ejnTCEG8MIRwvQ15gYjhb8gL2ghdQkoRax5KRseyGNYqJh5+mN0
         3uYPbyGjQUaqG26+/F1QLDpF2LgphedrTjHxhRTiHtQMra8QQLISVDhvq34q6XC/HEWa
         MKn9JmY5Jb7D/q0lFjvFp2ryOsN/NzQHTS3bSGtRu7QJwZ4thi841hGLGLHiNYVEpjNo
         24BtHOqFil4awWGBynhFhs9yNddDLBLGUPXRMWJjGnTm2pNLxsloUVhnHrE1b98pehPo
         h2sQ==
X-Gm-Message-State: AJcUukcDJJflKkB6MjfwDQyVNtw+6Af91Y5/T0ESA32RzBPiN9RTg8Iy
        mg/o4iNLsDMpmIi807yC829JOQ==
X-Google-Smtp-Source: ALg8bN7EzMSdimFpeWv2OFnyN75T8884AgdZU/jmOV8UYdfZCL9mQXCzwJ9vlxNo+9Ff8YUqtjCPpw==
X-Received: by 2002:a6b:8d11:: with SMTP id p17mr2611416iod.74.1545421717331;
        Fri, 21 Dec 2018 11:48:37 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id h14sm11157581ior.41.2018.12.21.11.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:48:36 -0800 (PST)
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
Subject: [PATCH v2 1/2] drm/amd: validate user pitch alignment
Date:   Fri, 21 Dec 2018 12:47:38 -0700
Message-Id: <20181221194739.25523-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181221031053.240161-2-yuzhao@google.com>
References: <20181221031053.240161-2-yuzhao@google.com>
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

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 686a26de50f9..883a4df2386d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -527,6 +527,15 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct amdgpu_framebuffer *amdgpu_fb;
 	int ret;
+	struct amdgpu_device *adev = dev->dev_private;
+	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
+	int pitch = amdgpu_align_pitch(adev, mode_cmd->pitches[0], cpp, false);
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

