Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921B8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D20B208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeykQ2WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D20B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbeKTCzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbeKTCzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E18B208E3;
        Mon, 19 Nov 2018 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645098;
        bh=7HrvWo8fFXjOJOQ1iGRWP8Aq0IEvk+DCuQyQDVdsm+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeykQ2WClWuD1kf0RGU08ngs2DVhC/S7tPdCr6pv7PJjfdFuEswh2kaXN2CdCEMhN
         FfLr0VPex7Lp6RDm2mK9HfnRZCxIgWa2s/EZrEv9T+wLYEvAnFUyuRUlDkgyeFWvVk
         oTgoReXjxYDEDnmbqOWCz7Vf8h5opTxBETuT10Cg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/205] drm/amdgpu: Fix SDMA TO after GPU reset v3
Date:   Mon, 19 Nov 2018 17:25:43 +0100
Message-Id: <20181119162623.799077516@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -66,6 +66,7 @@ int amdgpu_job_alloc(struct amdgpu_devic
 	amdgpu_sync_create(&(*job)->sync);
 	amdgpu_sync_create(&(*job)->sched_sync);
 	(*job)->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
+	(*job)->vm_pd_addr = AMDGPU_BO_INVALID_OFFSET;
 
 	return 0;
 }
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -714,7 +714,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *
 	}
 
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
-	vm_flush_needed &= !!ring->funcs->emit_vm_flush;
+	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
+			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
 


