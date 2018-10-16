Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB85B20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="th3JbHf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB85B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeJPMSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbeJPMCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B9302148D;
        Tue, 16 Oct 2018 04:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663223;
        bh=dxPFSoXv68evryyNrDeaDBIJOWbg622A+XgLF7jK6NI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=th3JbHf/mVCvetRcbtpEVn3b4pYgla4WbpryY5Qp1gO8o8m+D89zDC8+7arEYWoky
         R/cEObT1Ul2OvsZ3MtI84D2ptUsqSDK6hL8owVHW2+bTJm+8HdgeNqLsFPiuo+Abod
         MdaY2q0u2b/RmZlfiGyXDjSILNIeMwriI7/opF/w=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 086/100] bnxt_en: Fix enables field in HWRM_QUEUE_COS2BW_CFG request
Date:   Tue, 16 Oct 2018 00:12:07 -0400
Message-Id: <20181016041221.135528-86-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 5db0e0969af6501ad45fe0494039d3b9c797822b ]

In HWRM_QUEUE_COS2BW_CFG request, enables field should have the bits
set only for the queue ids which are having the valid parameters.

This causes firmware to return error when the TC to hardware CoS queue
mapping is not 1:1 during DCBNL ETS setup.

Fixes: 2e8ef77ee0ff ("bnxt_en: Add TC to hardware QoS queue mapping logic.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index d5bc72cecde3..3f896acc4ca8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -98,13 +98,13 @@ static int bnxt_hwrm_queue_cos2bw_cfg(struct bnxt *bp, struct ieee_ets *ets,
 
 	bnxt_hwrm_cmd_hdr_init(bp, &req, HWRM_QUEUE_COS2BW_CFG, -1, -1);
 	for (i = 0; i < max_tc; i++) {
-		u8 qidx;
+		u8 qidx = bp->tc_to_qidx[i];
 
 		req.enables |= cpu_to_le32(
-			QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID0_VALID << i);
+			QUEUE_COS2BW_CFG_REQ_ENABLES_COS_QUEUE_ID0_VALID <<
+			qidx);
 
 		memset(&cos2bw, 0, sizeof(cos2bw));
-		qidx = bp->tc_to_qidx[i];
 		cos2bw.queue_id = bp->q_info[qidx].queue_id;
 		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_STRICT) {
 			cos2bw.tsa =
-- 
2.17.1

