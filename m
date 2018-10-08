Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B875C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348E6214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXTbdaml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348E6214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbeJICFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbeJICFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63F02087D;
        Mon,  8 Oct 2018 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024722;
        bh=Br0KLunLTQatDHe+gk22IoDYJ5+Wq8Gc3JTP7ivKjyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXTbdamloD2XR0KNh+8+zSrcvdZ4RlLd/GzyvJhIpjzynPt8w5uPQQga5O1u46zh8
         tHXsfGtssOOcC6MbQIno7BzaKFZ8UdoWUgDB5rR+Dp8sEwUXV07nmY6nucmaUsCrnJ
         7f1byLra2rRWmojEPlNRALskCNrI5MMzLLgjM8+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tao Zhou <tao.zhou1@amd.com>,
        Yukun Li <yukun1.li@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 132/168] drm/amdgpu: Fix SDMA hang in prt mode v2
Date:   Mon,  8 Oct 2018 20:31:52 +0200
Message-Id: <20181008175625.062711084@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Tao Zhou <tao.zhou1@amd.com>

[ Upstream commit 68ebc13ea40656fddd3803735d621921a2d74a5e ]

Fix SDMA hang in prt mode, clear XNACK_WATERMARK in reg SDMA0_UTCL1_WATERMK to avoid the issue

Affected ASICs: VEGA10 VEGA12 RV1 RV2

v2: add reg clear for SDMA1

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Tested-by: Yukun Li <yukun1.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -67,6 +67,7 @@ static const struct soc15_reg_golden gol
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_IB_CNTL, 0x800f0100, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CLK_CTRL, 0xffffffff, 0x3f000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GFX_IB_CNTL, 0x800f0100, 0x00000100),
@@ -78,7 +79,8 @@ static const struct soc15_reg_golden gol
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_RLC0_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_RLC1_IB_CNTL, 0x800f0100, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_RLC1_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_PAGE, 0x000003ff, 0x000003c0)
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_WATERMK, 0xfc000000, 0x00000000)
 };
 
 static const struct soc15_reg_golden golden_settings_sdma_vg10[] = {
@@ -106,7 +108,8 @@ static const struct soc15_reg_golden gol
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0)
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)
 };
 
 static const struct soc15_reg_golden golden_settings_sdma_4_2[] =


