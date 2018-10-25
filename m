Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AF2ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B582085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUENT0wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B582085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeJYWvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbeJYWvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:08 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4A220834;
        Thu, 25 Oct 2018 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477091;
        bh=XrMTcRXYTKE1V5+Cp2WbuAQ98boZq75maFD179dBbcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUENT0wyLISvq+rE6y5Xt/uOLEV3iQ85v+a033Znb9qTKFUp4cVtMYrblVXGuPcsB
         b0fVkoG51xgCqiLl7oSENTVHlVATl3nAOe7CDPbAZ76ocOsZO0qfE8ww3RxXRmLeD1
         C3POxgfAmz+vQ3X451Xshs0ip0ySVEXcd9MjcaxY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Rustad <mark.d.rustad@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 40/65] ixgbe: Correct X550EM_x revision check
Date:   Thu, 25 Oct 2018 10:16:40 -0400
Message-Id: <20181025141705.213937-40-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rustad <mark.d.rustad@intel.com>

[ Upstream commit 3ca2b2506ec9a3b1615930a6810d30ec9aba10a1 ]

The X550EM_x revision check needs to check a value, not just a bit.
Use a mask and check the value. Also remove the redundant check
inside the ixgbe_enter_lplu_t_x550em, because it can only be called
when both the mac type and revision check pass.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 995f03107eac..04bc4df82fa7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3508,7 +3508,7 @@ struct ixgbe_info {
 
 #define IXGBE_FUSES0_GROUP(_i)		(0x11158 + ((_i) * 4))
 #define IXGBE_FUSES0_300MHZ		BIT(5)
-#define IXGBE_FUSES0_REV1		BIT(6)
+#define IXGBE_FUSES0_REV_MASK		(3 << 6)
 
 #define IXGBE_KRM_PORT_CAR_GEN_CTRL(P)	((P) ? 0x8010 : 0x4010)
 #define IXGBE_KRM_LINK_CTRL_1(P)	((P) ? 0x820C : 0x420C)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index a75f2e3ce86f..ffd2e74e5638 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1873,10 +1873,6 @@ static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
 	u32 save_autoneg;
 	bool link_up;
 
-	/* SW LPLU not required on later HW revisions. */
-	if (IXGBE_FUSES0_REV1 & IXGBE_READ_REG(hw, IXGBE_FUSES0_GROUP(0)))
-		return 0;
-
 	/* If blocked by MNG FW, then don't restart AN */
 	if (ixgbe_check_reset_blocked(hw))
 		return 0;
@@ -2030,8 +2026,9 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 		}
 
 		/* setup SW LPLU only for first revision */
-		if (!(IXGBE_FUSES0_REV1 & IXGBE_READ_REG(hw,
-							IXGBE_FUSES0_GROUP(0))))
+		if (hw->mac.type == ixgbe_mac_X550EM_x &&
+		    !(IXGBE_READ_REG(hw, IXGBE_FUSES0_GROUP(0)) &
+		      IXGBE_FUSES0_REV_MASK))
 			phy->ops.enter_lplu = ixgbe_enter_lplu_t_x550em;
 
 		phy->ops.handle_lasi = ixgbe_handle_lasi_ext_t_x550em;
-- 
2.17.1

