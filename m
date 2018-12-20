Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9142177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298163;
	bh=h2LAt1FA+3496s42OwqdmPmbeM6/Rk4SQMTzeV8C/50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W6oMzWvjTHLIa4c1te9hTQiHwY9j8/ld9YUjJyKP3MozNXmIKabX+5tBpJ7VcGUvv
	 hIJEYfw5CAPy9rGGBxZ0ShXtTf+t6RHVJoD0rjll+m0TI4N4ZWLis1ZcRWbcBnTe0R
	 v2G3zDbhYmDKWLRXKptTSEyAS7TRa5pAAyDa8Udc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbeLTJ3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732479AbeLTJ3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F34842177E;
        Thu, 20 Dec 2018 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298157;
        bh=h2LAt1FA+3496s42OwqdmPmbeM6/Rk4SQMTzeV8C/50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyvMD6iV4soaf1mA0+RFSMERepB6NWKnC0FSSOGMCMcQKUDU4BGrQGBR4/6JCfEaO
         yDuZWEAqDp/+Kp4Z2Yf0JhERO8RO8KMuNEGFOOSqfw2vrvXbPpJ3DzlRBQFRhNkfu5
         hUmqxph9VXhMTKRObdXm+cUdSxhhZysYrtZLLjmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/67] drm/amdgpu: wait for IB test on first device open
Date:   Thu, 20 Dec 2018 10:18:32 +0100
Message-Id: <20181220085904.352039174@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



