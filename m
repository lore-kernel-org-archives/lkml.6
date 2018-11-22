Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97558C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5451520865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv11jj+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5451520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438633AbeKWGfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:35:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732755AbeKWGfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:35:10 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA2820864;
        Thu, 22 Nov 2018 19:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916458;
        bh=7TCG9l9zO+oYGKg+29TW+mE3VKG44KERBg+vLkmIcaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tv11jj+4pli16NXA1BLHQTf+hVWle8XVrI/jn4jIzBeEEeIgVWsSCl2udFajbfl6C
         ABUvcl2AqQLnR13sBMgd/F5IJuL7lWhuY47jfEIReFSYZtM/9H1FiCjWtjvt3SBd8x
         5b/79xLzjmCiihGvS3MV0U+WCt2pqb/LVbZxu/QI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Philip Yang <Philip.Yang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 28/36] drm/amdgpu: fix bug with IH ring setup
Date:   Thu, 22 Nov 2018 14:52:32 -0500
Message-Id: <20181122195240.13123-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195240.13123-1-sashal@kernel.org>
References: <20181122195240.13123-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit c837243ff4017f493c7d6f4ab57278d812a86859 ]

The bug limits the IH ring wptr address to 40bit. When the system memory
is bigger than 1TB, the bus address is more than 40bit, this causes the
interrupt cannot be handled and cleared correctly.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 5ae5ed2e62d6..21bc12e02311 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -129,7 +129,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	else
 		wptr_off = adev->wb.gpu_addr + (adev->irq.ih.wptr_offs * 4);
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO, lower_32_bits(wptr_off));
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI, upper_32_bits(wptr_off) & 0xFF);
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI, upper_32_bits(wptr_off) & 0xFFFF);
 
 	/* set rptr, wptr to 0 */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
-- 
2.17.1

