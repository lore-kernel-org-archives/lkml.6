Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804A1C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4186C206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4186C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbeJBUNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbeJBUNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:54 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9801FC47;
        Tue,  2 Oct 2018 13:30:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Monk Liu <Monk.Liu@amd.com>,
        Emily Deng <Emily.Deng@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 188/228] amdgpu: fix multi-process hang issue
Date:   Tue,  2 Oct 2018 06:24:45 -0700
Message-Id: <20181002132510.930782462@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Emily Deng <Emily.Deng@amd.com>

[ Upstream commit 2f40c6eac74a2a60921cdec9e9a8a57e88e31434 ]

SWDEV-146499: hang during multi vulkan process testing

cause:
the second frame's PREAMBLE_IB have clear-state
and LOAD actions, those actions ruin the pipeline
that is still doing process in the previous frame's
work-load IB.

fix:
need insert pipeline sync if have context switch for
SRIOV (because only SRIOV will report PREEMPTION flag
to UMD)

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -164,8 +164,10 @@ int amdgpu_ib_schedule(struct amdgpu_rin
 		return r;
 	}
 
+	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
 	    ((tmp = amdgpu_sync_get_fence(&job->sched_sync, NULL)) ||
+	     (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
 	     amdgpu_vm_need_pipeline_sync(ring, job))) {
 		need_pipe_sync = true;
 		dma_fence_put(tmp);
@@ -196,7 +198,6 @@ int amdgpu_ib_schedule(struct amdgpu_rin
 	}
 
 	skip_preamble = ring->current_ctx == fence_ctx;
-	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (job && ring->funcs->emit_cntxcntl) {
 		if (need_ctx_switch)
 			status |= AMDGPU_HAVE_CTX_SWITCH;


