Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A73C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E422063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217375;
	bh=kOCI8QV/tKkxDC7G/pDFdW097ACFVSuf2quEEqmhW5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pt3bRhFl/iWtZrvBNMF/LElS6VMLAciie28adQJaaRHOoTvTJH6EHPgtnkqAk2tCh
	 9eSLDx4NOr+CARLD3gBj9ff1P0WtZaEASBKHUNTb6ZEjjuldf54/oMYNLB+kGw/nwf
	 hPv9nSXu0GBYNI5Fics0zrZ9PsGWYYAcn1vLb5n4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390329AbfAKOgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389606AbfAKOgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7304F2063F;
        Fri, 11 Jan 2019 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217371;
        bh=kOCI8QV/tKkxDC7G/pDFdW097ACFVSuf2quEEqmhW5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otSGWzCo0g4DMTSOaECapBIjRvGF9QZ2gA3uCXXSZq94nsSEc3Tdit8EC8Q9gR5iH
         1JvNeQr6j6WT4b22/21FOqm/2ggteQq5WzUta0XZbqGl9yy3O+c4uvWh78pOPRhzIe
         Jd4ik5l2eOSpKbFt+ZAuDS+WS0QdCuMBPOU4ZWqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/148] bnx2x: Remove configured vlans as part of unload sequence.
Date:   Fri, 11 Jan 2019 15:13:35 +0100
Message-Id: <20190111131115.776758374@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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



