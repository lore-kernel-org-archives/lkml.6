Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3871C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902F0214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864349;
	bh=nqvZrES9MOYce66waIA8O7MhUKQB0rVn0Ke+rYblvOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V5Le8dUmyXT4y5L69MBp+lKCfkFIXCohXGfXGhJ4OoFBXgT2jRJgsZAMVygPYrMGb
	 0JpANgW8Ob+rltxxWDXu4aWliTsaWRJKzNt+yyEuO+OCJW6QaW3H4SlafBVroQVi37
	 pYj2cQ8YSdBzzRFrGE0blgTLVdSSu+G9nO+Uba80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeLZWpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbeLZWk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9580F2054F;
        Wed, 26 Dec 2018 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864027;
        bh=nqvZrES9MOYce66waIA8O7MhUKQB0rVn0Ke+rYblvOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bcjsa6t6frrjHGv6XhVfksMowqr902SRIfbQ90qixuUaZ27Wy+groIBUfLFw6jsvv
         4gojS77teK2ezM9fBncPo5mh6LmVPPyoVRGeoLK8l2R7Oj2VWivDHJe63nEHWmFtws
         zZMswMNyeIFTBUs+CUJUVSz6zQ/HtpsG8+nKlTQc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefan Assmann <sassmann@kpanic.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 20/59] i40e: fix mac filter delete when setting mac address
Date:   Wed, 26 Dec 2018 17:38:00 -0500
Message-Id: <20181226223839.150262-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Assmann <sassmann@kpanic.de>

[ Upstream commit 158daed16efb1170694e420ae06ba8ba954d82e5 ]

A previous commit moved the ether_addr_copy() in i40e_set_mac() before
the mac filter del/add to avoid a race. However it wasn't taken into
account that this alters the mac address being handed to
i40e_del_mac_filter().

Also changed i40e_add_mac_filter() to operate on netdev->dev_addr,
hopefully that makes the code easier to read.

Fixes: 458867b2ca0c ("i40e: don't remove netdev->dev_addr when syncing uc list")

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 176c99b8251d..904b42becd45 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1554,17 +1554,17 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 		netdev_info(netdev, "set new mac address %pM\n", addr->sa_data);
 
 	/* Copy the address first, so that we avoid a possible race with
-	 * .set_rx_mode(). If we copy after changing the address in the filter
-	 * list, we might open ourselves to a narrow race window where
-	 * .set_rx_mode could delete our dev_addr filter and prevent traffic
-	 * from passing.
+	 * .set_rx_mode().
+	 * - Remove old address from MAC filter
+	 * - Copy new address
+	 * - Add new address to MAC filter
 	 */
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
-
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	i40e_del_mac_filter(vsi, netdev->dev_addr);
-	i40e_add_mac_filter(vsi, addr->sa_data);
+	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+	i40e_add_mac_filter(vsi, netdev->dev_addr);
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
+
 	if (vsi->type == I40E_VSI_MAIN) {
 		i40e_status ret;
 
-- 
2.19.1

