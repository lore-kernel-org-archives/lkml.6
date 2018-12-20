Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53636C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2175621741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298257;
	bh=fHqD6xQ3T1HkVLT6OEV+vFP/3tcrOImvfNTt1XCESns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K8HkJTjoqH8D8xIAN+ILAyobmNW4YNaDi4lKXp/imORNu078vz/vTCIJp7xEwHjhH
	 rOGFjimHudRf7ccZ5zVg0QmzJLjUPaElijrfNozDC5vTuwL4zkHQFjcpNgo3p+CiBy
	 uQ9gmvC0+1DlAhl2gFmgVEr1Dk6JXjdScGkW/dts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbeLTJa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732324AbeLTJaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E9520656;
        Thu, 20 Dec 2018 09:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298251;
        bh=fHqD6xQ3T1HkVLT6OEV+vFP/3tcrOImvfNTt1XCESns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2s3I0ygo9PiXiaveZsFwaKi2zhblWdCHSAmwK6KAv5HDK5M+eFRV75y94K54WvzB
         tqYiJxp6rWnUQ1CWJGOGtHJlnSBIMWfIbCSPpL5ou6ZtQM1WUFH0ZqzqU/tBY+7ApQ
         i0QHvpXIRrxxKFGwUWq096c1PpcJ+/Li+UPBejKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Zhu <James.Zhu@amd.com>,
        Leo Liu <leo.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 54/67] drm/amdgpu/vcn: Update vcn.cur_state during suspend
Date:   Thu, 20 Dec 2018 10:19:06 +0100
Message-Id: <20181220085905.684761121@linuxfoundation.org>
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

[ Upstream commit 0a9b89b2e2e7b6d90f81ddc47e489be1043e01b1 ]

Replace vcn_v1_0_stop with vcn_v1_0_set_powergating_state during suspend,
to keep adev->vcn.cur_state update. It will fix VCN S3 hung issue.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 072371ef5975..4f8f3bb21832 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -43,6 +43,7 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_jpeg_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_jpeg_ring_set_patch_ring(struct amdgpu_ring *ring, uint32_t ptr);
+static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_state state);
 
 /**
  * vcn_v1_0_early_init - set function pointers
@@ -216,7 +217,7 @@ static int vcn_v1_0_hw_fini(void *handle)
 	struct amdgpu_ring *ring = &adev->vcn.ring_dec;
 
 	if (RREG32_SOC15(VCN, 0, mmUVD_STATUS))
-		vcn_v1_0_stop(adev);
+		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
 	ring->ready = false;
 
-- 
2.19.1



