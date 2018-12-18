Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873B2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D0121873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151406;
	bh=UBuslzNd7v3INW0ZFRzNMgqgxw4ruLoreWaV//tSies=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EWL19/5vCmBsASzCOv5h8NISN2UtGLZ3pBfhwgenhYmoigWawvNnY7hDPzNPjnA0D
	 vUhzATwamPQvmVjhSSD+jbDeKRrRGA/NP7zK9KxgPNaY7TE9qS7C1FBjF6iD6ovNuU
	 L8vZ5XMSzi72AKGgJmgxYsjQunlgNP8yUBxVqCBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeLRQnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbeLRQla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E67E821873;
        Tue, 18 Dec 2018 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151289;
        bh=UBuslzNd7v3INW0ZFRzNMgqgxw4ruLoreWaV//tSies=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXF2pBLYxYRSiT28+OJKQ6DEOqcVFMOldbvdsHFWECWuRQPeEMMDPEk7BRZ+gy/m9
         4oUO7Jxs30jva+suuUc6lGPCezeEvVPLBc/VTQ/he/6yHtl01xMlTESqps3APs99xb
         jn9DxjbheuO9+O44njIuB9RlCrZwV5yPqjWzrJos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 38/44] drm/amdgpu/powerplay: Apply avfs cks-off voltages on VI
Date:   Tue, 18 Dec 2018 17:39:50 +0100
Message-Id: <20181218163931.864429214@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

From: Kenneth Feng <kenneth.feng@amd.com>

commit cf4197ed5796234a53beb71228198c7d1e678947 upstream.

Instead of EVV cks-off voltages, avfs cks-off voltages can avoid
the overshoot voltages when switching sclk.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h          |    2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c |    6 ++++++
 2 files changed, 8 insertions(+)

--- a/drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h
@@ -386,6 +386,8 @@ typedef uint16_t PPSMC_Result;
 #define PPSMC_MSG_AgmResetPsm                 ((uint16_t) 0x403)
 #define PPSMC_MSG_ReadVftCell                 ((uint16_t) 0x404)
 
+#define PPSMC_MSG_ApplyAvfsCksOffVoltage      ((uint16_t) 0x415)
+
 #define PPSMC_MSG_GFX_CU_PG_ENABLE            ((uint16_t) 0x280)
 #define PPSMC_MSG_GFX_CU_PG_DISABLE           ((uint16_t) 0x281)
 #define PPSMC_MSG_GetCurrPkgPwr               ((uint16_t) 0x282)
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -1984,6 +1984,12 @@ int polaris10_thermal_avfs_enable(struct
 
 	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_EnableAvfs);
 
+	/* Apply avfs cks-off voltages to avoid the overshoot
+	 * when switching to the highest sclk frequency
+	 */
+	if (data->apply_avfs_cks_off_voltage)
+		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ApplyAvfsCksOffVoltage);
+
 	return 0;
 }
 


