Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5756EC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4362151B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw2aomnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4362151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeLEJqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbeLEJqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:46:01 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EA82087F;
        Wed,  5 Dec 2018 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003160;
        bh=fZcBIhQYS/YlV2/EjGve1gIEOQ+WjFEZX2MUdQ0Yrdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gw2aomnRsYHdy/6aZIk/pxDQJvlvHr5iqrD6ZTQPhLpSV3bwqYiKVMLxs9cTm65fk
         OsTnWlljVX2gH83iA09sQukh+J1Fql2qSaBuG1cb2Pa+5eD+W5X1VS3KHtqlNPFl1A
         X4DrsKaDA32a65DgHkUIW475VVbOFJkLw9RL4wrY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Josh Elsasser <jelsasser@appneta.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 49/69] ixgbe: recognize 1000BaseLX SFP modules as 1Gbps
Date:   Wed,  5 Dec 2018 04:42:27 -0500
Message-Id: <20181205094247.6556-49-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
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
index cf6a245db6d5..a37c951b0753 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2257,7 +2257,9 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
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

