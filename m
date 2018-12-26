Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D6AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820AA214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864736;
	bh=IoPdRbhTwKt+d4vkvw3EWH5hZ3TB3HpljXLwbJExch8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FTqQR9smW2Rq9IwuVu4AwnTbKEkNIAKaNB2n4+PWr+9bziIb4aRTpmZeDfVXJFc7Z
	 bUFtf9xX3vhcAF1ueHG5gOMlrt5F7MuG7BXN8iVkuCeIZ0TmfHfngc93z7fvJ+aVlV
	 U2qPARUiEPGDVEdaYJ8DaRkP1wWSLWmOlZT9jWnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeLZWwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbeLZWhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC35218FE;
        Wed, 26 Dec 2018 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863820;
        bh=IoPdRbhTwKt+d4vkvw3EWH5hZ3TB3HpljXLwbJExch8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqZxgpo11fd3mWi2eW6ypyu34FF5vk9V5rjOlURzh9njJQoK4u0VLIH9pEuuT4dks
         jtfCCoixfJNM8ggfwfqXSmLrqLXbWYiDeDWa7H0Ht1ckY8Ogd3tedOT9Magi1aaCtN
         gwHFnGWu6pz4jfyL1+Zx+un0zzYrD8Un7p595hzU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 39/97] bnx2x: Remove configured vlans as part of unload sequence.
Date:   Wed, 26 Dec 2018 17:34:59 -0500
Message-Id: <20181226223557.149329-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

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
index b05c1d0f829b..20e5cda6555e 100644
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
@@ -13016,13 +13043,6 @@ static void bnx2x_vlan_configure(struct bnx2x *bp, bool set_rx_mode)
 
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

