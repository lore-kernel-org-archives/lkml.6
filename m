Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3950BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BBC213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1UMVhvd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BBC213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbeK2RGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:06:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeK2RGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:06:10 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BEED2145D;
        Thu, 29 Nov 2018 06:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471318;
        bh=rUIqfbusQgf3I/LPeL1BJajUF/Q2apMAaVUEO6bWM+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1UMVhvd0VYvWdY5uyR8su/KlujNaIsp4mqlnhLi0uebuKL628ZbEVeZapjd/m8TW2
         91WGexjTjlPm9ZChup47Wyn4ylIQeuKJCcIJ0UWaICWBCa51A1qT7PGNtjyCh5SFUA
         OLjACZK0jpdlM6YogGvIJ8KUiiE5MSmKJzvzzQD0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/35] bnx2x: Assign unique DMAE channel number for FW DMAE transactions.
Date:   Thu, 29 Nov 2018 01:00:45 -0500
Message-Id: <20181129060110.159878-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
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
index 828e2e56b75e..1b7f4342dab9 100644
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
index 8baf9d3eb4b1..453bfd83a070 100644
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

