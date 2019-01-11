Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2962C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45892177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216851;
	bh=6k6VdfncHjJZY3jHVB8tLiUgm7Y5EIvdxnICTg5EiEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wukuXP0ogDvLM9q+WJuqMo7KiDBJ/6htoVZDMGtKJj2TKSDlEQseaTe4W6l3oxjRY
	 hPl0I+2J5RfR2wByqDaq7gukpo+i3lPkPrEdXY8PFIVjp3ahK00d6ehfDrNyVjCIYo
	 NUmfv/74xfl0hqvKvowRa/C5jwF+9H8LdcsrFRpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbfAKO1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:27:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388089AbfAKO12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:27:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AAB02177B;
        Fri, 11 Jan 2019 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216847;
        bh=6k6VdfncHjJZY3jHVB8tLiUgm7Y5EIvdxnICTg5EiEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcFfxSSfB3BePKAolcFb8px+a0VoIuCshsgScJr2NGwlB02k3RIU4AmM23Ix0nR3d
         gTsoxAxblqehPILQoY01FcwWv0XDwI94jpnqmeDOyrdUsg2UpogGDVGlBzLYV4C5jL
         HnLKrFHTU2MGYMz5eTIVgn9J88ZFDn159alIo1Rs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 13/63] bnx2x: Remove configured vlans as part of unload sequence.
Date:   Fri, 11 Jan 2019 15:14:16 +0100
Message-Id: <20190111131048.143317216@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 77f53e4122c3..4c412c52bcde 100644
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
@@ -13007,13 +13034,6 @@ static void bnx2x_vlan_configure(struct bnx2x *bp, bool set_rx_mode)
 
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



