Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F24C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C00821486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789146;
	bh=9YJZtbeOXBuJrc0Be4rdbbvnCo733eV1LuTjT6xgluU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gz1BlywWJMO+S6o4o0fnDvfGvFncmlnV90Y6LufRnfIlmm9krN4OCEf3l46S6V1/2
	 xHafjsS8fvCPHwkNmzBLMlAy7ikd+TVgNJcYp5o9SjGKtEMAsEwf9fLletNcluF4M9
	 hKLHLhnLA7LTf7N7NgR2w+3NFI2l/kvqS21KsY9g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C00821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbeLNMFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeLNMFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4EA721486;
        Fri, 14 Dec 2018 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789141;
        bh=9YJZtbeOXBuJrc0Be4rdbbvnCo733eV1LuTjT6xgluU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nA8zvvqSvJdaP8IFe0HkbVYoL+Ix+FZP2AovoXl84SgFrRYoo9CwHJBAMNpIO+Eac
         SGUp/oJnNPYjY/J8/nC5dm/Nnms5gSiOqVlOTOha6uD05D2QXxskls5xJMBcryZCu/
         w7xzqpVjNSznpaCQn5wflkr+t8Nsdxa9HdbmfpDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, shaoyunl <shaoyun.liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 110/142] drm/amdgpu: Add delay after enable RLC ucode
Date:   Fri, 14 Dec 2018 12:59:55 +0100
Message-Id: <20181214115751.446179869@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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
index ef00d14f8645..325e2213cac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2243,12 +2243,13 @@ static void gfx_v9_0_rlc_start(struct amdgpu_device *adev)
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
2.19.1



