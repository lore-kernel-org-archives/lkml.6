Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFECC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0180D218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497563;
	bh=qmQZ8NTYvxWsyzkNu4E6aB8O7Slp/2tlaDX2eaEXgyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zn2DjFdUJGW0MPOtQHiiNRiYtNhZW6LKeDvFvAd0jxDrSFcwuZdr33siNCliAb84u
	 xO6kMdNJFoQXENnNL0eaMRnK+zcjbnNnqBNvtTuyYIyD/WIyrTvMAgL+Ovot4RTXtt
	 RtjsSrU3ilaGoHti5/FeLO8FxygANse7QYCLM60M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfBRNqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:46:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730711AbfBRNp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDA8B218FC;
        Mon, 18 Feb 2019 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497558;
        bh=qmQZ8NTYvxWsyzkNu4E6aB8O7Slp/2tlaDX2eaEXgyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdgYz0/EV9lFDZPPoLwqbj/sae+/Y5ovkTLV79MbDqS6b4zmS/N1yNLdaOG/eTUDi
         Q9sucsKP0D1zvRYhJQXU32bmRROJObZNl6niObWPrFdyg2yzcP5DvQN0VTsALCOHeL
         Fc42p0wesYcHgynKx2xiX+4AOckk0lwpJvyEGS48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tao Zhou <tao.zhou1@amd.com>,
        "Yukun.Li" <yukun1.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 29/92] drm/amdgpu: fix CPDMA hang in PRT mode for VEGA20
Date:   Mon, 18 Feb 2019 14:42:32 +0100
Message-Id: <20190218133457.464238605@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3e958fe67720b37d04ab8ef81b9d507a56a09bbc ]

Fix CPDMA hang in PRT mode for both VEGA10 and VEGA20

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Tested-by: Yukun.Li <yukun1.li@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 21363b2b2ee5..88ed064b3585 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -112,7 +112,10 @@ static const struct soc15_reg_golden golden_settings_gc_9_0[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CHAN_STEER_HI, 0xffffffff, 0x4a2c0e68),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CHAN_STEER_LO, 0xffffffff, 0xb5d3f197),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_CACHE_INVALIDATION, 0x3fff3af3, 0x19200000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000003ff)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000003ff),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_MEC1_F32_INT_DIS, 0x00000000, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_MEC2_F32_INT_DIS, 0x00000000, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_DEBUG, 0x00000000, 0x00008000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_9_0_vg10[] =
@@ -134,10 +137,7 @@ static const struct soc15_reg_golden golden_settings_gc_9_0_vg10[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_UTCL1_CNTL2, 0x00030000, 0x00020000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0x0000000f, 0x01000107),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTD_CNTL, 0x00001800, 0x00000800),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmWD_UTCL1_CNTL, 0x08000000, 0x08000080),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_MEC1_F32_INT_DIS, 0x00000000, 0x00000800),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_MEC2_F32_INT_DIS, 0x00000000, 0x00000800),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_DEBUG, 0x00000000, 0x00008000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmWD_UTCL1_CNTL, 0x08000000, 0x08000080)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_9_0_vg20[] =
-- 
2.19.1



