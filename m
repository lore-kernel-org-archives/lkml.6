Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA75C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C168C2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C168C2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeJBUOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbeJBUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:22 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E7C5EC2A;
        Tue,  2 Oct 2018 13:30:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Hang Zhou <hang.zhou@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 214/228] drm/amdgpu: Enable/disable gfx PG feature in rlc safe mode
Date:   Tue,  2 Oct 2018 06:25:11 -0700
Message-Id: <20181002132512.112555260@linuxfoundation.org>
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

From: Rex Zhu <Rex.Zhu@amd.com>

[ Upstream commit 8ef23364b654d44244400d79988e677e504b21ba ]

This is required by gfx hw and can fix the rlc hang when
do s3 stree test on Cz/St.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Hang Zhou <hang.zhou@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5614,6 +5614,11 @@ static int gfx_v8_0_set_powergating_stat
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_SMG |
+				AMD_PG_SUPPORT_RLC_SMU_HS |
+				AMD_PG_SUPPORT_CP |
+				AMD_PG_SUPPORT_GFX_DMG))
+		adev->gfx.rlc.funcs->enter_safe_mode(adev);
 	switch (adev->asic_type) {
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
@@ -5663,7 +5668,11 @@ static int gfx_v8_0_set_powergating_stat
 	default:
 		break;
 	}
-
+	if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_SMG |
+				AMD_PG_SUPPORT_RLC_SMU_HS |
+				AMD_PG_SUPPORT_CP |
+				AMD_PG_SUPPORT_GFX_DMG))
+		adev->gfx.rlc.funcs->exit_safe_mode(adev);
 	return 0;
 }
 


