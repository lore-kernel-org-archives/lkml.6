Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF37CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD1E2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217103;
	bh=Yr8z7pzxdCSuawOkgEeSgb70oiGiEYBRC3g1U5Oo7x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tdXC2u/uHtTnj4u1+B/V7R7mjHLPwd11+gDh2pl0QxH5fvPfX09qTw+JK/lZ+eqWQ
	 4FxI3+fn9AiN3RJqelayw8Nw749Bn+Bhh9P1Dgz5UOH8LLZ4hfb7LMMr9M+Yv1ZHDS
	 062fRT8AFLaAfZrPvUos+dR1GypdEMKPtpk9r6uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbfAKObn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731426AbfAKObj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 285D42063F;
        Fri, 11 Jan 2019 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217098;
        bh=Yr8z7pzxdCSuawOkgEeSgb70oiGiEYBRC3g1U5Oo7x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TuNiD95XH2a5rbhRs6BkGJlE1JDbdETHXR80VQk+QojbRfXW+zZ+QdekL7azwX0nI
         p6mBN1iwxBxZSILTL+asmFM6VdH6lzaLIFv03XxQp80+9Og2L1WNfVjGQwdikuGDxw
         zAmr8C3Zs/AWCCQwhIkFF41p4HQvxh0xn2dkDs6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 024/105] bnx2x: Remove configured vlans as part of unload sequence.
Date:   Fri, 11 Jan 2019 15:13:55 +0100
Message-Id: <20190111131105.377370861@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 04f05230c5c13b1384f66f5186a68d7499e34622 ]

Vlans are not getting removed when drivers are unloaded. The recent storm
firmware versions had added safeguards against re-configuring an already
configured vlan. As a result, PF inner reload flows (e.g., mtu change)
might trigger an assertion.
This change is going to remove vlans (same as we do for MACs) when doing
a chip cleanup during unload.

Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 34 +++++++++++++++----
 .../net/ethernet/broadcom/bnx2x/bnx2x_sp.h    |  4 ++-
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 688d84cd6187..433a7a37575d 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -8462,6 +8462,7 @@ int bnx2x_set_vlan_one(struct bnx2x *bp, u16 vlan,
 	/* Fill a user request section if needed */
 	if (!test_bit(RAMROD_CONT, ramrod_flags)) {
 		ramrod_param.user_req.u.vlan.vlan = vlan;
+		__set_bit(BNX2X_VLAN, &ramrod_param.user_req.vlan_mac_flags);
 		/* Set the command: ADD or DEL */
 		if (set)
 			ramrod_param.user_req.cmd = BNX2X_VLAN_MAC_ADD;
@@ -8482,6 +8483,27 @@ int bnx2x_set_vlan_one(struct bnx2x *bp, u16 vlan,
 	return rc;
 }
 
+static int bnx2x_del_all_vlans(struct bnx2x *bp)
+{
+	struct bnx2x_vlan_mac_obj *vlan_obj = &bp->sp_objs[0].vlan_obj;
+	unsigned long ramrod_flags = 0, vlan_flags = 0;
+	struct bnx2x_vlan_entry *vlan;
+	int rc;
+
+	__set_bit(RAMROD_COMP_WAIT, &ramrod_flags);
+	__set_bit(BNX2X_VLAN, &vlan_flags);
+	rc = vlan_obj->delete_all(bp, vlan_obj, &vlan_flags, &ramrod_flags);
+	if (rc)
+		return rc;
+
+	/* Mark that hw forgot all entries */
+	list_for_each_entry(vlan, &bp->vlan_reg, link)
+		vlan->hw = false;
+	bp->vlan_cnt = 0;
+
+	return 0;
+}
+
 int bnx2x_del_all_macs(struct bnx2x *bp,
 		       struct bnx2x_vlan_mac_obj *mac_obj,
 		       int mac_type, bool wait_for_comp)
@@ -9320,6 +9342,11 @@ void bnx2x_chip_cleanup(struct bnx2x *bp, int unload_mode, bool keep_link)
 		BNX2X_ERR("Failed to schedule DEL commands for UC MACs list: %d\n",
 			  rc);
 
+	/* Remove all currently configured VLANs */
+	rc = bnx2x_del_all_vlans(bp);
+	if (rc < 0)
+		BNX2X_ERR("Failed to delete all VLANs\n");
+
 	/* Disable LLH */
 	if (!CHIP_IS_E1(bp))
 		REG_WR(bp, NIG_REG_LLH0_FUNC_EN + port*8, 0);
@@ -13006,13 +13033,6 @@ static void bnx2x_vlan_configure(struct bnx2x *bp, bool set_rx_mode)
 
 int bnx2x_vlan_reconfigure_vid(struct bnx2x *bp)
 {
-	struct bnx2x_vlan_entry *vlan;
-
-	/* The hw forgot all entries after reload */
-	list_for_each_entry(vlan, &bp->vlan_reg, link)
-		vlan->hw = false;
-	bp->vlan_cnt = 0;
-
 	/* Don't set rx mode here. Our caller will do it. */
 	bnx2x_vlan_configure(bp, false);
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h
index 0bf2fd470819..7a6e82db4231 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h
@@ -265,6 +265,7 @@ enum {
 	BNX2X_ETH_MAC,
 	BNX2X_ISCSI_ETH_MAC,
 	BNX2X_NETQ_ETH_MAC,
+	BNX2X_VLAN,
 	BNX2X_DONT_CONSUME_CAM_CREDIT,
 	BNX2X_DONT_CONSUME_CAM_CREDIT_DEST,
 };
@@ -272,7 +273,8 @@ enum {
 #define BNX2X_VLAN_MAC_CMP_MASK	(1 << BNX2X_UC_LIST_MAC | \
 				 1 << BNX2X_ETH_MAC | \
 				 1 << BNX2X_ISCSI_ETH_MAC | \
-				 1 << BNX2X_NETQ_ETH_MAC)
+				 1 << BNX2X_NETQ_ETH_MAC | \
+				 1 << BNX2X_VLAN)
 #define BNX2X_VLAN_MAC_CMP_FLAGS(flags) \
 	((flags) & BNX2X_VLAN_MAC_CMP_MASK)
 
-- 
2.19.1



