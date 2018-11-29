Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C441C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8C32145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9F8Yss1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8C32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbeK3Bib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732483AbeK3Bia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58962146D;
        Thu, 29 Nov 2018 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501977;
        bh=rV27G2XKB6sXoBsSLoZ+v5siD30qlU7214kLN5CHHbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9F8Yss1fibbIOA3JPscbVxDGAGygO5351L3dIySRE2XBoD+hlWXmmR+6pvHMUZiM
         SXo9MboTt3BoFrbEl4jymUL+5z4HUxk0wL/jpStZsJgooBtXvDTP0E4fqWDaraCEg8
         L8G0I1S3w/h285WcnWcVNdRLq+z5xrUSenEjkYnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 090/110] drm/amdgpu: fix bug with IH ring setup
Date:   Thu, 29 Nov 2018 15:13:01 +0100
Message-Id: <20181129135924.890209320@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
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



