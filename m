Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993FCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A71320874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219037;
	bh=/ic5ItVptzdmdFINa/UKt61bt8joxR08qHNuQupmn+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K2kimn8noWRlzIM8396uBArU11YV98qoAEzZUchxOx8txZYJmfXCVYAh1/ypkK3Iy
	 Gq/XN8ykKBE5a/Ul8uzjXheHh9grtPJ8Xh2ryiW0gG8WV+pSQk2Pgx7GSnAlJHmxRD
	 O/IFXX00orzVFbu8rvFEqeTmSrkqDcUFdoJJgFS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391845AbfAKPDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:03:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389000AbfAKOam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 177C921841;
        Fri, 11 Jan 2019 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217041;
        bh=/ic5ItVptzdmdFINa/UKt61bt8joxR08qHNuQupmn+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bf++eQbtg+KF2BG7SXTBTwnAfIAiG2Swovz1esXcFS4ehRlZwd5C2CGIhragL9ljc
         Jn/RfiUGS5a0fQYUExTX6qLI3elaJmIcUYF7Qv2ollRTioxVlLrOTTmglvHWj3eA34
         sHzfUbDwlDMdJpOFFZQFtUJ0Nll+SmMXAYMHKswY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Assmann <sassmann@kpanic.de>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 020/105] i40e: fix mac filter delete when setting mac address
Date:   Fri, 11 Jan 2019 15:13:51 +0100
Message-Id: <20190111131104.953808754@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



