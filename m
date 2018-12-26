Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9994C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979BF214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864779;
	bh=rv3sXcRDROwvtslbOD1IUBSFvoxGnplcZfx3qdBT2GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wl1iN337OGNxcZ9NlzGWJOl7xFFV8PiGL6iVQM+130aNk6Zj49hwc6WzATVPa5k8D
	 aXpIwlZupA3eRJitR6XA+9pEmFIRitok6N7N43b6yxt93rTWkL8YWyvXV+tAyW2M3i
	 khuZVAECe/ceURBwvrvrTXFej7cQVQCY7aClmx+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbeLZWgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbeLZWgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1567F21902;
        Wed, 26 Dec 2018 22:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863809;
        bh=rv3sXcRDROwvtslbOD1IUBSFvoxGnplcZfx3qdBT2GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBCmSV18RiL5ae2cQKSjPHcs8YHiAanzzK3UieDQwNkzWLpX/PihWo8EyjwgBJyTI
         xR6gUXqvv0EMbi5AKfnYMMkumuBfNiVU0G4ZufZO3eHHB+aL6NVWEa5L9she50eiof
         4W/JFMvShAk6Px2neU9X1do5sZQz+7XNuY3P1kOs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefan Assmann <sassmann@kpanic.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 32/97] i40e: fix mac filter delete when setting mac address
Date:   Wed, 26 Dec 2018 17:34:52 -0500
Message-Id: <20181226223557.149329-32-sashal@kernel.org>
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
index 3c342700bf5f..ed9d3fc4aaba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1539,17 +1539,17 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
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

