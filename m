Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B290C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BDE2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543229;
	bh=UcY9bugxz+DHqZpQVPXsVM+fY6aWZ+XYkvmPCkEqUBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ii1NSHFVs7yksidhtPLfgg3YAHubGlVdm4erRyxW68rL59G5XQDdJZ7kMDtJKu39k
	 IzUmgGdEOdT7aYc4fw/UpZDa58NHuon4HPJKz0ol3Ha3w9ymmfleVpymXLFJuClSzU
	 aaEZQV5R2fMQu2zje9Aj3xx9/02gnbtfP/Z/3Acw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BDE2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeLKPrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbeLKPrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3502133F;
        Tue, 11 Dec 2018 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543224;
        bh=UcY9bugxz+DHqZpQVPXsVM+fY6aWZ+XYkvmPCkEqUBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVaKUBw/CRkRzAYjHiWJWvPaw4hrqiZXEwCTqV+m2kL5kpXjD4jbwpiOpUS4X9pt0
         uw++BzhpX6kdpfxRd1P/g9EV1BJe/tH43KJi14F5Gz0KHCTzoRstdL3J/e4wGYBCHo
         drv/Dhqcm7TTOABUFUiiARKXWpjlZa1otCAyiJFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 61/91] bnx2x: Assign unique DMAE channel number for FW DMAE transactions.
Date:   Tue, 11 Dec 2018 16:41:20 +0100
Message-Id: <20181211151611.020726539@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 1ea068815419..2491cdc2535c 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -2291,6 +2291,13 @@ void bnx2x_igu_clear_sb_gen(struct bnx2x *bp, u8 func, u8 idu_sb_id,
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
index ff702a707a91..343e3366d751 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
@@ -5931,6 +5931,7 @@ static inline int bnx2x_func_send_start(struct bnx2x *bp,
 	rdata->sd_vlan_tag	= cpu_to_le16(start_params->sd_vlan_tag);
 	rdata->path_id		= BP_PATH(bp);
 	rdata->network_cos_mode	= start_params->network_cos_mode;
+	rdata->dmae_cmd_id	= BNX2X_FW_DMAE_C;
 
 	rdata->vxlan_dst_port	= cpu_to_le16(start_params->vxlan_dst_port);
 	rdata->geneve_dst_port	= cpu_to_le16(start_params->geneve_dst_port);
-- 
2.19.1



