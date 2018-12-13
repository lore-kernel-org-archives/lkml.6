Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E1C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EA92080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676696;
	bh=PucmPDlw15LNfzkKgoSTqsGsPy4Wsd708bf38o3fgBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4+sGDwS33gOmZir0P1FZ0XlBvdUwSYPcQLqA7BEHLnqwMIWMpG6tMUdfxspQJ87T
	 KVH11UVf0SSSCaj7hEBCuxtHk+ykDtPBT9VYkUR8/QXJjmWCuEAs+LYhYp0+3GSOVU
	 WJqB28IxAVLqI2NpyTZC6/Snc3u3OgPYRWNGesdw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EA92080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeLMEve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:51:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbeLME3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A591F20849;
        Thu, 13 Dec 2018 04:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675348;
        bh=PucmPDlw15LNfzkKgoSTqsGsPy4Wsd708bf38o3fgBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPGDpefsT+YsJ8SfJN5qE5j7UftlVl5ckmWm4VujHI3InaTZHweF7SG7vZjK6CB1k
         pTNPpSlR6MhIIhKIlZcMnukudohPpkYptcyjSnMvAG3XfLePaaraXo6QfLLufEhI6R
         c7RRe95uK+1g+bC0UjI9ZaJcfPPH/4vbS9/qlGdw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 18/73] drm/amdgpu: wait for IB test on first device open
Date:   Wed, 12 Dec 2018 23:27:43 -0500
Message-Id: <20181213042838.75160-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 3bfa8897e4d08f822d1d58cf6cbbffbccef82e08 ]

Instead of delaying that to the first query. Otherwise we could try to use the
SDMA for VM updates before the IB tests are done.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bd98cc5fb97b..fd825d30edf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -292,9 +292,6 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 	if (!info->return_size || !info->return_pointer)
 		return -EINVAL;
 
-	/* Ensure IB tests are run on ring */
-	flush_delayed_work(&adev->late_init_work);
-
 	switch (info->query) {
 	case AMDGPU_INFO_ACCEL_WORKING:
 		ui32 = adev->accel_working;
@@ -861,6 +858,9 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	struct amdgpu_fpriv *fpriv;
 	int r, pasid;
 
+	/* Ensure IB tests are run on ring */
+	flush_delayed_work(&adev->late_init_work);
+
 	file_priv->driver_priv = NULL;
 
 	r = pm_runtime_get_sync(dev->dev);
-- 
2.19.1

