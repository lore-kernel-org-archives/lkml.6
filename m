Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141DDC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32E321477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO2SZSUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32E321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeJEXQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbeJEXQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A6121480;
        Fri,  5 Oct 2018 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756215;
        bh=iUo+luNmZHi5RWFQXjKQeSLJr3rM+vLUKUXgue1kax4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JO2SZSUFM7SozsPb6FGL0C6MXBYFWWhDRaxIlXvMbbdj/gqDowXDRquQa/bnzzybH
         nYlewiYZxj1F7ihghKJ8zWfyQCZOW+oxLSnQJadlmu1yw/5tIackD5bRKabq+UfthQ
         bEO2s6BqEN9q4aGv8pgOVGsC4DJtLeCTTSe16/iA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Amber Lin <Amber.Lin@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 22/23] drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7
Date:   Fri,  5 Oct 2018 12:16:33 -0400
Message-Id: <20181005161634.20631-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161634.20631-1-sashal@kernel.org>
References: <20181005161634.20631-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amber Lin <Amber.Lin@amd.com>

[ Upstream commit caaa4c8a6be2a275bd14f2369ee364978ff74704 ]

A wrong register bit was examinated for checking SDMA status so it reports
false failures. This typo only appears on gfx_v7. gfx_v8 checks the correct
bit.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index bdabaa3399db..e2c0ff03f386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -576,7 +576,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
 
 	while (true) {
 		temp = RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATUS);
-		if (temp & SDMA0_STATUS_REG__RB_CMD_IDLE__SHIFT)
+		if (temp & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
 			break;
 		if (timeout <= 0)
 			return -ETIME;
-- 
2.17.1

