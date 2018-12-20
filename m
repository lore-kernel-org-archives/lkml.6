Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F24C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E4620989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298147;
	bh=cYrT/Jvx3dOB6ro5c2cgTzd/nzt+Se6pqW0YkKhGxNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bYPI0dN7N+gTg3u0vq2NFqGMxzCc539pIlFQHcqZyU2NvM1oVs7/uBdtt4VVrGhyQ
	 pDlK924xEngWTWyb73I/yJbPewYDbEZVfkByEn5x/WgmssBlasHcELjXWvZkpsuutK
	 AYH0q6dhL4Ckt1Rn3+0U9MN2Jvpw1Dg12/VQt1Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbeLTJ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732622AbeLTJ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF3FC2177E;
        Thu, 20 Dec 2018 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298142;
        bh=cYrT/Jvx3dOB6ro5c2cgTzd/nzt+Se6pqW0YkKhGxNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=affMaZGLOJ2degmDkV/CTVpeHZLBg5/hYJy6oqqvJqEzjqi0FWgG7McPoQuiwhnmW
         79Sml+C30mZSpMXfFhPPB0+7x8eVTcPkX3Q58CpzKXbP6B3Ssf4DA4UjWXGB2NOhaG
         6rN2DAjxXjhTwBNNzP9pU7lDY6Kbxj39WuDUdyMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/67] drm/msm/gpu: Fix a couple memory leaks in debugfs
Date:   Thu, 20 Dec 2018 10:18:27 +0100
Message-Id: <20181220085904.161561162@linuxfoundation.org>
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



