Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346DFC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3289204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3UnW30I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3289204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeKDXUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729579AbeKDXHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C3E2085A;
        Sun,  4 Nov 2018 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339553;
        bh=BWXeHip9G7PVX/2JvT6jA4f4vxb0MPwO+Er7pZkdPp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3UnW30IqhJej8KouM78wTz9fPPVBCw4JfVeD+DprvjOOSwx3aekNJHnzVjMKsdZ9
         yVXWrBd7KSBS4SZTXwThR66JwC0hvYI1s3Szo60o9TwU6SNly+XvHAya12jy9MMy/c
         Q3EXiVtu8miQf3MY7CFnK+7dI93j78RwZuZsRmGU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 49/57] drm/amdgpu: Fix SDMA TO after GPU reset v3
Date:   Sun,  4 Nov 2018 08:51:36 -0500
Message-Id: <20181104135144.88324-49-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

[ Upstream commit d8de8260a45aae8f74af77eae9a162bdc0ed48d2 ]

After GPU reset amdgpu_vm_clear_bo triggers VM flush
but job->vm_pd_addr is not set causing SDMA TO.

v2:
Per advise by Christian König avoid flushing VM for jobs where
job->vm_pd_addr wasn't explicitly set.

v3:
Shortcut vm_flush_needed early.

Fixes cbd5285 drm/amdgpu: move setting the GART addr into TTM.
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 391e2f7c03aa..f823d4baf044 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -66,6 +66,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 	amdgpu_sync_create(&(*job)->sync);
 	amdgpu_sync_create(&(*job)->sched_sync);
 	(*job)->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
+	(*job)->vm_pd_addr = AMDGPU_BO_INVALID_OFFSET;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b17771dd5ce7..6a84526e20e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -714,7 +714,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_
 	}
 
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
-	vm_flush_needed &= !!ring->funcs->emit_vm_flush;
+	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
+			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
 
-- 
2.17.1

