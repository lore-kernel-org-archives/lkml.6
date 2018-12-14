Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12739C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA86208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790478;
	bh=4DdKo9OghG245WKbQQCF0htv9Yf7Q1Mp/JI5+ylZsDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fwvj7KHcskx6qC5XFO2He4aCnPynR2WWgr2DTEuWwhc4PQydg24SCPUVOcoK11og/
	 hIJr+k33qv1mnpLj2qYJZpOgRARzuLJXKnlQQOO7h3br7K7GGpmN9jOJZzZKCsBMao
	 TzVqe3rLo1YUS7JuUPIC6GdTiUrX+KfqwSQd1EP0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA86208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbeLNM15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731707AbeLNMLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA6B2147D;
        Fri, 14 Dec 2018 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789466;
        bh=4DdKo9OghG245WKbQQCF0htv9Yf7Q1Mp/JI5+ylZsDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRUh+Z+BY3G4lYZ3+FXmlwhqhfvy4Tl4To9fxWXKQ5zgtOBJGCMAcKBEKl/4/sZI1
         VBc4riaV87vAbAwhorOvGHsJ7vyu3uYxWTKlKYlNNf/8qAxJ8IS+jie7WWniQM4G2D
         Uyq/xB0UfpAh17mpEzuaWlyMiiw+sKEECXzwYjgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, shaoyunl <shaoyun.liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 64/89] drm/amdgpu: Add delay after enable RLC ucode
Date:   Fri, 14 Dec 2018 13:00:17 +0100
Message-Id: <20181214115732.824043801@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
2.19.1



