Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3934DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68A4214F0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789670;
	bh=mdI3vam0vBbZGBCUaBkmDM6kz2k5JDPdNDk9PbyrU2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lcdPvEGZWUV3LsZoWMuYoK1cnyN1PDre5vdteWVCFE9Rnq7aSBqdwdZ3HI5cUMZAL
	 +QmXBBPAW8iWdr1Y2wE8QXMY4s86uPDleuJYxL2cl1QVDWdpko+7PCPcLePy+tFHCZ
	 qlfc3P0CSn5yV4j6lPSFAMxIcYALVymYcc0VBz3M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68A4214F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeLNMO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732335AbeLNMOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2597214F0;
        Fri, 14 Dec 2018 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789664;
        bh=mdI3vam0vBbZGBCUaBkmDM6kz2k5JDPdNDk9PbyrU2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtDR6KtdAEwjPGfT5O3Wl2KGKUz7GFHK4Lsv4fxstYCyYgbuJZtFEkRZHSApCXlmd
         b2B7NdGQQD8WMk65nygLebCQ/I7V4H7Q9rpFQGfi0NuZmlsr1Ph+N+5jd2DHFjQ1bJ
         pEr6kFiJ40+pvpLGeKo4PvyJYR3D8NLLKJAS+lpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Elsasser <jelsasser@appneta.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 28/88] ixgbe: recognize 1000BaseLX SFP modules as 1Gbps
Date:   Fri, 14 Dec 2018 13:00:02 +0100
Message-Id: <20181214115704.369804274@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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
2.19.1



