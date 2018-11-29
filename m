Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD95C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFA220834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h30HVKWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFA220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbeK2RIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:08:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbeK2RIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:08:17 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC22420834;
        Thu, 29 Nov 2018 06:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471445;
        bh=P/DLjUPCesNdL07B/WG5GvGAZ6lP7az0j59adcdZIMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h30HVKWKlhHO1LK/7MgHf/C0pLkrO3oOMXkHhlMx4v3yBBojcATweZ88MUS1cXE7P
         jmpT6mVY7RIZacPHSEzVpoCEqoS6gKKeYVVkZ8xP80935YhR7oZxDQwNhm1qy4NlKL
         uGmumStqrobYH9z73DhWG3u0+nX8bUZBSQI1LT/U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 08/18] bnx2x: Assign unique DMAE channel number for FW DMAE transactions.
Date:   Thu, 29 Nov 2018 01:03:20 -0500
Message-Id: <20181129060331.160224-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060331.160224-1-sashal@kernel.org>
References: <20181129060331.160224-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 77e461d14ed141253573eeeb4d34eccc51e38328 ]

Driver assigns DMAE channel 0 for FW as part of START_RAMROD command. FW
uses this channel for DMAE operations (e.g., TIME_SYNC implementation).
Driver also uses the same channel 0 for DMAE operations for some of the PFs
(e.g., PF0 on Port0). This could lead to concurrent access to the DMAE
channel by FW and driver which is not legal. Hence need to assign unique
DMAE id for FW.
Currently following DMAE channels are used by the clients,
  MFW - OCBB/OCSD functionality uses DMAE channel 14/15
  Driver 0-3 and 8-11 (for PF dmae operations)
         4 and 12 (for stats requests)
Assigning unique dmae_id '13' to the FW.

Changes from previous version:
------------------------------
v2: Incorporated the review comments.

Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h    | 7 +++++++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index f3f2d66432ab..d5e4c42662b6 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -2187,6 +2187,13 @@ void bnx2x_igu_clear_sb_gen(struct bnx2x *bp, u8 func, u8 idu_sb_id,
 #define PMF_DMAE_C(bp)			(BP_PORT(bp) * MAX_DMAE_C_PER_PORT + \
 					 E1HVN_MAX)
 
+/* Following is the DMAE channel number allocation for the clients.
+ *   MFW: OCBB/OCSD implementations use DMAE channels 14/15 respectively.
+ *   Driver: 0-3 and 8-11 (for PF dmae operations)
+ *           4 and 12 (for stats requests)
+ */
+#define BNX2X_FW_DMAE_C                 13 /* Channel for FW DMAE operations */
+
 /* PCIE link and speed */
 #define PCICFG_LINK_WIDTH		0x1f00000
 #define PCICFG_LINK_WIDTH_SHIFT		20
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
index cea6bdcde33f..bf760c9cff6a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
@@ -6149,6 +6149,7 @@ static inline int bnx2x_func_send_start(struct bnx2x *bp,
 	rdata->sd_vlan_tag	= cpu_to_le16(start_params->sd_vlan_tag);
 	rdata->path_id		= BP_PATH(bp);
 	rdata->network_cos_mode	= start_params->network_cos_mode;
+	rdata->dmae_cmd_id	= BNX2X_FW_DMAE_C;
 
 	rdata->vxlan_dst_port	= cpu_to_le16(start_params->vxlan_dst_port);
 	rdata->geneve_dst_port	= cpu_to_le16(start_params->geneve_dst_port);
-- 
2.17.1

