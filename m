Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D0CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B7120989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBlQTtGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B7120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeLEJqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:46:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeLEJqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:46:15 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB5CD20878;
        Wed,  5 Dec 2018 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003174;
        bh=Iy/qJYwbFdfA19ArOPyAfZ+CCBW2cd6bQcPfI3OX3+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBlQTtGqN9dMcofe3PLVGhHfrCGVk2tQnBg+fmNnfhKUL5qZ8AsW8zfM0mybVWZx/
         TN3i9s/gnJh8Pj/bjYPnjo1xsqqULADFSFT2bcuxHVPj2+mYwT78yr28D9K+snI/jW
         5yIqUI/GJ6SFYQrNIllRV/jp5lnwTLlnl3Ffyjkk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaoyunl <shaoyun.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 53/69] drm/amdgpu: Add delay after enable RLC ucode
Date:   Wed,  5 Dec 2018 04:42:31 -0500
Message-Id: <20181205094247.6556-53-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shaoyunl <shaoyun.liu@amd.com>

[ Upstream commit ad97d9de45835b6a0f71983b0ae0cffd7306730a ]

Driver shouldn't try to access any GFX registers until RLC is idle.
During the test, it took 12 seconds for RLC to clear the BUSY bit
in RLC_GPM_STAT register which is un-acceptable for driver.
As per RLC engineer, it would take RLC Ucode less than 10,000 GFXCLK
cycles to finish its critical section. In a lowest 300M enginer clock
setting(default from vbios), 50 us delay is enough.

This commit fix the hang when RLC introduce the work around for XGMI
which requires more cycles to setup more registers than normal

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3981915e2311..b2eecfc9042e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1992,12 +1992,13 @@ static void gfx_v9_0_rlc_start(struct amdgpu_device *adev)
 #endif
 
 	WREG32_FIELD15(GC, 0, RLC_CNTL, RLC_ENABLE_F32, 1);
+	udelay(50);
 
 	/* carrizo do enable cp interrupt after cp inited */
-	if (!(adev->flags & AMD_IS_APU))
+	if (!(adev->flags & AMD_IS_APU)) {
 		gfx_v9_0_enable_gui_idle_interrupt(adev, true);
-
-	udelay(50);
+		udelay(50);
+	}
 
 #ifdef AMDGPU_RLC_DEBUG_RETRY
 	/* RLC_GPM_GENERAL_6 : RLC Ucode version */
-- 
2.17.1

