Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34820C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0478D21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCglu9mK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbeLUDLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:11:13 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33787 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbeLUDLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:11:12 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so2563706ioi.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tp6fuyIdxIj5Ms2sbaND085R8iXqyvUSEWVJBW3xrSM=;
        b=BCglu9mKTb2MvwVBc/z0ZX7RJO0f1OzqZFFUv1owJg7ftpLhroWY9O7+ydtC7l8pMr
         eW55dJvv8czgeCuIk7vyNLUBAGUKpp0Da6pMZDFcAeAOOmqvjXGAPqeia2KdIGPwlHbO
         s+c889Bx9lZsa4ZC2ExrGWVL381UXLDYxJbrVcocthyC3uqiqWWkxdc4GPv+wtKmd0Ez
         r3WrY6Uglp0AFg9b5MSl9uBusx35efszID5x525S/DOrPys2loapFbjxhOYGzfITY85f
         jIOEizb1W9oISSStwBi6/RVM32OsRz2owyiI7zzoysnovJlkuuH0fH04vVodXtHswZIO
         KFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tp6fuyIdxIj5Ms2sbaND085R8iXqyvUSEWVJBW3xrSM=;
        b=aNOBP8WhiKK3VmqprQ9hbuCgBEsOYK3ba9IdYS3I29F45Rf6BOHyMg/VSl1KwOZnaI
         BTUUM3GFL9OOuxTj/1M38y/aw3aPZ6obW4w/8Xi/gejE7xDsytMm4jdBb7FV8CJsW6e9
         3Fyj4syMEpHvhBQjFWDvCL3TGay1AslLGrZqoeJ428lQjxcbA3IP4w5YCLtldGsJlFeS
         cEayC2dKvmz8KRjGh9BPJAcaKS2jPo3WjGUJ3RSx1EGMAgyxcPZ1KyO4xUqQDVW7gPhM
         suqhEM+4gjqdy9EIJoPPnoV1Amj491ntTeZgTi+MDAOWJcCYy0dEi5dn9DP+vrIkhgud
         C9JQ==
X-Gm-Message-State: AJcUukdndGwN51aMB1zB85kPwwLOVTHz8iYk70ae6Ye/bGhR/phmbzFM
        7M15ciydbjh5rH9thJrKyo5YuA==
X-Google-Smtp-Source: ALg8bN5gbwo9bI2zq7eFUQuaehZTO0XLbBv6w7U2cHdlVKvsU4nlEFwlj3cRbmqAqdDKmkEi3UzhnA==
X-Received: by 2002:a6b:6111:: with SMTP id v17mr607267iob.107.1545361871460;
        Thu, 20 Dec 2018 19:11:11 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id d133sm5425783itd.1.2018.12.20.19.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 19:11:10 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     David Zhou <David1.Zhou@amd.com>, Samuel Li <Samuel.Li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: [PATCH 3/3] drm/amd: validate user GEM object size
Date:   Thu, 20 Dec 2018 20:10:53 -0700
Message-Id: <20181221031053.240161-3-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181221031053.240161-1-yuzhao@google.com>
References: <20181221031053.240161-1-yuzhao@google.com>
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
index 755daa332f8a..bb48b016cc68 100644
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
+		dev_err(&dev->pdev->dev, "Invalid GEM size: expecting %d but got %d\n",
+			pitch * height, obj->size);
+		return ERR_PTR(-EINVAL);
+	}
+
 	amdgpu_fb = kzalloc(sizeof(*amdgpu_fb), GFP_KERNEL);
 	if (amdgpu_fb == NULL) {
 		drm_gem_object_put_unlocked(obj);
-- 
2.20.1.415.g653613c723-goog

