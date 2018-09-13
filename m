Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C4C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E26320652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E26320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeIMTOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:14:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35460 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbeIMTOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:14:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0BC88D36;
        Thu, 13 Sep 2018 14:05:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.18 180/197] drm/amdgpu: fix incorrect use of drm_file->pid
Date:   Thu, 13 Sep 2018 15:32:09 +0200
Message-Id: <20180913131848.765589533@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit c4aed87630d41ee54e2ee23d4583c3dd423296dd upstream.

That's the PID of the creator of the file (usually the X server) and not
the end user of the file.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -55,7 +55,6 @@ static int amdgpu_sched_process_priority
 {
 	struct file *filp = fget(fd);
 	struct drm_file *file;
-	struct pid *pid;
 	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
@@ -63,20 +62,10 @@ static int amdgpu_sched_process_priority
 	if (!filp)
 		return -EINVAL;
 
-	pid = get_pid(((struct drm_file *)filp->private_data)->pid);
-
-	mutex_lock(&adev->ddev->filelist_mutex);
-	list_for_each_entry(file, &adev->ddev->filelist, lhead) {
-		if (file->pid != pid)
-			continue;
-
-		fpriv = file->driver_priv;
-		idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
-				amdgpu_ctx_priority_override(ctx, priority);
-	}
-	mutex_unlock(&adev->ddev->filelist_mutex);
-
-	put_pid(pid);
+	file = filp->private_data;
+	fpriv = file->driver_priv;
+	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
+		amdgpu_ctx_priority_override(ctx, priority);
 
 	fput(filp);
 


