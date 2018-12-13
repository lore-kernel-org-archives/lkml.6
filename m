Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A3CC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57A92087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675351;
	bh=q6EjXbBFZ7jJUEBFvP86MEQkDEGPnjuWDJ5PU9J5Z6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K/y1Y2rNLd4aHdzqn/qDEwVKi0sskciMzAJKQq9R4tKg8xqyF6jdW5K6IRUTdYxZ7
	 f2+gmMpuaCNVBM7WUF+pF4Oyh5WwdJc9MiL1Wbk8ObAgFqmZdsfkG6ujwsNCm2wvuz
	 GsFMkfRGazfBzZz+Zk/SyztJgjUzuSALDcYVa+XY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57A92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeLME3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbeLME26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:28:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1653420879;
        Thu, 13 Dec 2018 04:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675338;
        bh=q6EjXbBFZ7jJUEBFvP86MEQkDEGPnjuWDJ5PU9J5Z6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0N5/RlgOyr/0q1jq3RuaafYEgzjMrs26R/sj99bw0MoJTBdR3r/aoRtrCJToXylL
         kCL+tuZHhM76ebvlTgwKT21DP0h2rj1ad377xel/hjksITZGgvgWnPKk7mnx0AvYpo
         KkqYqMKOtCJz80Y+OxDcmRYoj1jp6OP5UMtugN+8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 13/73] drm/msm/gpu: Fix a couple memory leaks in debugfs
Date:   Wed, 12 Dec 2018 23:27:38 -0500
Message-Id: <20181213042838.75160-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 51270de91412b819f654b849db3bf92dac0a0855 ]

The msm_gpu_open() function should free "show_priv" on error or it
causes static checker warnings.

Fixes: 4f776f4511c7 ("drm/msm/gpu: Convert the GPU show function to use the GPU state")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index f0da0d3c8a80..d756436c1fcd 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -84,7 +84,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 
 	ret = mutex_lock_interruptible(&dev->struct_mutex);
 	if (ret)
-		return ret;
+		goto free_priv;
 
 	pm_runtime_get_sync(&gpu->pdev->dev);
 	show_priv->state = gpu->funcs->gpu_state_get(gpu);
@@ -94,13 +94,20 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 
 	if (IS_ERR(show_priv->state)) {
 		ret = PTR_ERR(show_priv->state);
-		kfree(show_priv);
-		return ret;
+		goto free_priv;
 	}
 
 	show_priv->dev = dev;
 
-	return single_open(file, msm_gpu_show, show_priv);
+	ret = single_open(file, msm_gpu_show, show_priv);
+	if (ret)
+		goto free_priv;
+
+	return 0;
+
+free_priv:
+	kfree(show_priv);
+	return ret;
 }
 
 static const struct file_operations msm_gpu_fops = {
-- 
2.19.1

