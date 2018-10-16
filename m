Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E71C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA1020866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uloAZDj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeJPMCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbeJPMCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FC621486;
        Tue, 16 Oct 2018 04:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663223;
        bh=SQfSkljFETRZRMnoumTRa17TGcgTiSIivIxHUFdfF9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uloAZDj17/R8eBZ+xn5S2+SSe9H4tcnQoHUVEB+ByexEoBGXU4nriWqXb5Ljm+1sm
         GqtKYrPokUWBMNQU43adfgDuW9xdb3Hiz0RnNZsXziRDrG46KMKUdiI5wL3WfTRjTE
         BDUkEZ/JRuogtDexvE685atdy7CCoTUFxgQWZmsQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 085/100] bnxt_en: Fix VNIC reservations on the PF.
Date:   Tue, 16 Oct 2018 00:12:06 -0400
Message-Id: <20181016041221.135528-85-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit dbe80d446c859873820eedfff4abc61c71f1927b ]

The enables bit for VNIC was set wrong when calling the HWRM_FUNC_CFG
firmware call to reserve VNICs.  This has the effect that the firmware
will keep a large number of VNICs for the PF, and having very few for
VFs.  DPDK driver running on the VFs, which requires more VNICs, may not
work properly as a result.

Fixes: 674f50a5b026 ("bnxt_en: Implement new method to reserve rings.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bcb4a6731d76..84a96c277994 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4650,7 +4650,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct hwrm_func_cfg_input *req,
 				      FUNC_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
 		enables |= ring_grps ?
 			   FUNC_CFG_REQ_ENABLES_NUM_HW_RING_GRPS : 0;
-		enables |= vnics ? FUNC_VF_CFG_REQ_ENABLES_NUM_VNICS : 0;
+		enables |= vnics ? FUNC_CFG_REQ_ENABLES_NUM_VNICS : 0;
 
 		req->num_rx_rings = cpu_to_le16(rx_rings);
 		req->num_hw_ring_grps = cpu_to_le16(ring_grps);
-- 
2.17.1

