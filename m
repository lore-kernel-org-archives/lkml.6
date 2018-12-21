Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BA5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A2421905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeSGlxjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbeLUDLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:11:12 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35761 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732931AbeLUDLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:11:11 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so4784246itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVA79DYVZGjAPTiYQY7DmNDV4w0iyvWD1MDEJ+YKub0=;
        b=IeSGlxjcI+TpjYCFxk147TXVKJ6dQAo/r1SVykZSPMRC/+hLQx/e3+kRL/qRGTRziR
         D57iE8nfffDLLTuCHE+QanvltxfhOGFHkG+okuXLGAm85pBceLPSnmZ87tIxRTZXTiqd
         P6c8diV5rzx5xrkPbI7RNtwE11NRn5lAKIxv0SQGbQEO1VbthIqvAzeEc1CCNVmKW7wb
         M6ybHVfOf3AK1nLHUYOTJr2Ote38tS51AC8iAPdn6MDrUt8Pm1XHF3dU4oyKMf1MMcYR
         WMKSc+o+TL3yfLKoHRtkQoJ5gsTWu80aBLVtXok9c8bTtSBULqqlJIqGnyGvpFrcR9zK
         ALSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVA79DYVZGjAPTiYQY7DmNDV4w0iyvWD1MDEJ+YKub0=;
        b=plUqdiKKeM/ED5wwlpgrVE6Xn/9kYrqaJ/kOJI2XDMFeRtoOkcnLqYczreFs5enDme
         z7wJusWg3WfX8YI1x3nDA1VSQkxypi8+Y22byNfom/WBF4r057JUx2CTeqD0RV0F25gn
         m8EYDgyKrK0BHM6BRPD5P0KGfAD/9YCXso9nrG9dEvR12uSwctTEtHfIPzdW4MS7f5sH
         LHI6KrFGgBkzvknJybCV780lCRS/QCyHU029590pRGS7SdwtBagbIChj+D/1LKdfNb50
         waaQA3bg2rXOg6Ilnnwx3HPFDGA7btL/ttrpXyRY0YSSepBCdE/JqCH56yMenRzm7mPW
         2OTg==
X-Gm-Message-State: AA+aEWbl2aMwK9lWQ6QBvfOOQ1vs4ZGZBQ7dtml8Hku8UkKvZNolSHMt
        t/ddYrlwyUfOa/HYGxcMhSbEqA==
X-Google-Smtp-Source: AFSGD/Wb1zz1L6dikxFAP2P19uZ8ZwOp9ieoLSAIff/lPxBGlEW/CpQOCnWgtzhARedVDipspgQZww==
X-Received: by 2002:a02:1dc8:: with SMTP id 191mr550671jaj.55.1545361870187;
        Thu, 20 Dec 2018 19:11:10 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id d133sm5425783itd.1.2018.12.20.19.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 19:11:09 -0800 (PST)
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
Subject: [PATCH 2/3] drm/amd: validate user pitch alignment
Date:   Thu, 20 Dec 2018 20:10:52 -0700
Message-Id: <20181221031053.240161-2-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181221031053.240161-1-yuzhao@google.com>
References: <20181221031053.240161-1-yuzhao@google.com>
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
index e309d26170db..755daa332f8a 100644
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
+		dev_err(&dev->pdev->dev, "Invalid pitch: expecting %d but got %d\n",
+			pitch, mode_cmd->pitches[0]);
+		return ERR_PTR(-EINVAL);
+	}
 
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (obj ==  NULL) {
-- 
2.20.1.415.g653613c723-goog

