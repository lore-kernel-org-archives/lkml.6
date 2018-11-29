Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8173621104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNqEgbqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8173621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeK2RBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:01:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeK2RBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:01:50 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A761721019;
        Thu, 29 Nov 2018 05:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471058;
        bh=vgQmSgV+wb0NGqLf2AARIVkM63knvmCl8wUg2/98gIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNqEgbqpuvHcUSoryy2OPpig02P1ZSDmJGnfjJOI9qKuaUzNIaY/mLvS3zlFExK0a
         XCKc6NYgNJ7GYL7M2ucNT8zke3iCejTIaRHQAZaPmOWVmHF5LpJnOxJFB3IRl3rv7W
         cEna0FLX4dXs7tQPkI9A6WB9NSxwpJ1R11vZW+rE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/68] bnx2x: Assign unique DMAE channel number for FW DMAE transactions.
Date:   Thu, 29 Nov 2018 00:55:08 -0500
Message-Id: <20181129055559.159228-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
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
index be1506169076..0de487a8f0eb 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -2191,6 +2191,13 @@ void bnx2x_igu_clear_sb_gen(struct bnx2x *bp, u8 func, u8 idu_sb_id,
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
index 3f4d2c8da21a..a9eaaf3e73a4 100644
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

