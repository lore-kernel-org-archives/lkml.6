Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F969C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E03208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="efgwd80z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E03208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbeKOIk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeKOI3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:51 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3112252D;
        Wed, 14 Nov 2018 22:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234287;
        bh=ew1cr7Uq6csNW/ADg8NTYr3r3jbfPY1hr9koUgotBeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efgwd80zWh2iKJIVU5BkqSqjPWtyDMJqlRw0bD76DTI5UhCHfVy/71j+OX28OmrkN
         wg+jOjv49UekK2qBEheyOpBZUQ72e7BwXGUHeS1UGfliFHq8/lgn/nnGMNN6tsB2Xe
         54RML6Uw+xFruS0hwp1YStdSzd621fvYtzTbSSWU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 43/59] ice: Fix dead device link issue with flow control
Date:   Wed, 14 Nov 2018 17:23:15 -0500
Message-Id: <20181114222335.99339-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

[ Upstream commit 0f5d4c21a50716f8bd4e220544b82dca7408d113 ]

Setting Rx or Tx pause parameter currently results in link loss on the
interface, requiring the platform/host to be cold power cycled. Fix it.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c71a9b528d6d..0717d2e1ab67 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -786,10 +786,15 @@ ice_set_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 	}
 
 	if (!test_bit(__ICE_DOWN, pf->state)) {
-		/* Give it a little more time to try to come back */
+		/* Give it a little more time to try to come back. If still
+		 * down, restart autoneg link or reinitialize the interface.
+		 */
 		msleep(75);
 		if (!test_bit(__ICE_DOWN, pf->state))
 			return ice_nway_reset(netdev);
+
+		ice_down(vsi);
+		ice_up(vsi);
 	}
 
 	return err;
-- 
2.17.1

