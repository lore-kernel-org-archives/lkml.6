Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C187C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E7F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz7fcvz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E7F2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeJQBQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0E1C20658;
        Tue, 16 Oct 2018 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710678;
        bh=jZ0Fol55lggfKG4cJ7npJqBVE8pWNjUd3vxoH5ulQs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mz7fcvz5hW9EFwbzvtCTdy2P6dbz10DV1C5R04Y7jNXRApivyIstOTudhbOnyP2Ra
         07XO1J8cKwjpNtPSXvsd7YF9IH2yGTtxWldZpyDGw0fY65qaVcU1eDBdxO0Tt5Q2fs
         CiAzipszD/0Djc0M9Lm+JxWQu2nZvEzHXph5Zrm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Amber Lin <Amber.Lin@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 13/71] drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7
Date:   Tue, 16 Oct 2018 19:09:10 +0200
Message-Id: <20181016170540.060540688@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -505,7 +505,7 @@ static int kgd_hqd_sdma_destroy(struct k
 
 	while (true) {
 		temp = RREG32(sdma_base_addr + mmSDMA0_RLC0_CONTEXT_STATUS);
-		if (temp & SDMA0_STATUS_REG__RB_CMD_IDLE__SHIFT)
+		if (temp & SDMA0_RLC0_CONTEXT_STATUS__IDLE_MASK)
 			break;
 		if (timeout <= 0)
 			return -ETIME;


