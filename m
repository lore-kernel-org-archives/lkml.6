Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2D52082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaVngIPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2D52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbeLEJxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeLEJxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:53:37 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED3520989;
        Wed,  5 Dec 2018 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003616;
        bh=0w3YJAwIvpozqDPOgErAUJR6N/+5lQFEohWwm0Ei6iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FaVngIPBTzn615o1bf15YzWGpju6eaaMbjLehoDAAQLVHXXSlZTzjKoehQ+zbfqdo
         SntLm2rN5VHx4tl2mHuLe1+D421GPMPRucg8hOwvH92L/3FlQBrYx2pYwHsZ0yzRV+
         TDi+42pG9T+8SojBhFN9bY8IVljg/fEFG/K6CgSs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Josh Elsasser <jelsasser@appneta.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 20/33] ixgbe: recognize 1000BaseLX SFP modules as 1Gbps
Date:   Wed,  5 Dec 2018 04:51:18 -0500
Message-Id: <20181205095131.7685-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Elsasser <jelsasser@appneta.com>

[ Upstream commit a8bf879af7b1999eba36303ce9cc60e0e7dd816c ]

Add the two 1000BaseLX enum values to the X550's check for 1Gbps modules,
allowing the core driver code to establish a link over this SFP type.

This is done by the out-of-tree driver but the fix wasn't in mainline.

Fixes: e23f33367882 ("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+”)
Fixes: 6a14ee0cfb19 ("ixgbe: Add X550 support function pointers")
Signed-off-by: Josh Elsasser <jelsasser@appneta.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index ffd2e74e5638..dcd718ce13d5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1429,7 +1429,9 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
 		*autoneg = false;
 
 		if (hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
-		    hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1) {
+		    hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1 ||
+		    hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core0 ||
+		    hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core1) {
 			*speed = IXGBE_LINK_SPEED_1GB_FULL;
 			return 0;
 		}
-- 
2.17.1

